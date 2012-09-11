From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 2/2] build: don't duplicate substitution of make variables
Date: Tue, 11 Sep 2012 22:17:55 +0200
Message-ID: <504F9C73.1040409@gmail.com>
References: <1be62f9a7bbe728e6422e668d982ddf313d016eb.1347378209.git.stefano.lattarini@gmail.com> <1c54b744c0ec6987f7987a41853ab0ae00513d03.1347378210.git.stefano.lattarini@gmail.com> <7vtxv4h3lh.fsf@alter.siamese.dyndns.org> <504F824F.3050903@gmail.com> <7vd31sgww4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 22:18:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBWun-0001IT-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 22:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab2IKUSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 16:18:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34948 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2IKUSA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 16:18:00 -0400
Received: by eaac11 with SMTP id c11so475103eaa.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=DQL2HBUBcPa4qHCe3T4af88vIPiIlfGBnWuXdVLjUJQ=;
        b=HWRcvxpr8kXlrLEQumXYhNqrycqkrvsyeCbrh+PqjbSLVi1rHpDu5Wreb0PLqOg6zS
         +5yvlppnvkMHVGtd3c0NrBcgW89n6f3mPRZ2uGop2B3htkjWc363ZNseScEtDdmTF91E
         pAR7I1IcD5UjVC8lwFsyW/GobNQe2y4+PAR3gDLZdev7pWLe/RXIqLxOVobespaVEwGw
         yqryZ3R/KRsFyZvz5/Iq0REKyjODEMiqNeudwN5o3cKxnJkTmT0geBItYdc1M/YE2WC7
         NqCbsrv/agBfzZaQziOxWSDdneAOxxsPYQETvCi8xMaPxww/hL5vuCY1uZbxvu7/yrlS
         4BzQ==
Received: by 10.204.154.73 with SMTP id n9mr5304372bkw.113.1347394679264;
        Tue, 11 Sep 2012 13:17:59 -0700 (PDT)
Received: from [192.168.178.21] (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id j9sm10627108bkv.0.2012.09.11.13.17.57
        (version=SSLv3 cipher=OTHER);
        Tue, 11 Sep 2012 13:17:58 -0700 (PDT)
In-Reply-To: <7vd31sgww4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205263>

On 09/11/2012 09:52 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> On 09/11/2012 07:27 PM, Junio C Hamano wrote:
>>
>>> These two hunks suggest that you may be favoring spaces, but other
>>> places you seem to use tabs, so...
>>>
>> I can convert the new tabs to spaces if you prefer (that would have been
>> my preference too, but thought trying to follow the "Git preferences"
>> was more important).  No big deal either way for me.
> 
> If this were other parts of the system, my preference would be to
> use tabs, but because I do not help very much in the autoconf part
> myself, I do not have a particular preference.  If it is more common
> to indent the configure.ac script with spaces,
>
There is no general standard about it that I know of; it's just that
GNU projects tend to prefer space-based indentation over tab-based one,
and since I mostly touch configure.ac files from GNU projects, I've
picked up the habit.

> that would be more
> familiar to the folks who work on it, and I do not have much against
> choosing and sticking to space indented configure.ac file if that is
> the policy.
> 
Then I might send a patch that normalize indentation in configure.ac
to "spaces only", if that's OK with you.  But that's obviously for a
separated thread.

> But if this patch is not about cleaning up the style to make it
> conform to a policy (whichever it is), I would have preferred to see
> a clean-up patch as a separate step, not mixed together with this.
>
The reason those few clean-ups are mixed into this patch is that the
pre-existing strange indentation style was actually making it more
difficult for me to grasp the code flow; that is, I didn't see them
as a cosmetic change, but as a way to make it easier for me and the
reader to see that my changes were correct and sensible.

> That's all; either way, no big deal.
> 
OK.  Just let me know if you'd still prefer to have the indentation
cleanups done by a preparatory patch, and I'll send a re-roll.

Thanks,
  Stefano
