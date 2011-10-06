From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Merge seems to overwrite unstaged local changes
Date: Thu, 06 Oct 2011 15:27:40 +0200
Message-ID: <4E8DACCC.2050302@gmail.com>
References: <j5v9r7$fi1$1@dough.gmane.org> <7vaa9o1yf7.fsf@alter.siamese.dyndns.org> <CAHGBnuNrhtyq1tfok3p9YHAVbfo9T7BO3ZOUy+8YvNE9Mmhjhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Oct 06 15:29:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBo0l-0002tu-2B
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897Ab1JFN3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 09:29:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64765 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935837Ab1JFN3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 09:29:13 -0400
Received: by bkbzt4 with SMTP id zt4so3449680bkb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mkqn/QqDls4j3Bbdy4+Q5reebcYX9P7y2FLVYtf/W0M=;
        b=VPmpzeTAMgWoVzNTr1UQfV0FcBbXmdHPGW5efkfZdOD31tqSFhb9hgmHbVnxWKnsSq
         5MIV98RgWF0NbfmC5rtsn1CZtdC4BLY+7HOIx1bcMHgZf9lIW2beyJW+6ayO87vIICD9
         xzsK6raxmKpPwbQIDR5eWBwZlSVjo6NqayAIM=
Received: by 10.204.157.22 with SMTP id z22mr586489bkw.55.1317907752529;
        Thu, 06 Oct 2011 06:29:12 -0700 (PDT)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id b17sm5559064bkd.8.2011.10.06.06.29.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 06:29:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAHGBnuNrhtyq1tfok3p9YHAVbfo9T7BO3ZOUy+8YvNE9Mmhjhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182948>

On 29.09.2011 15:07, Sebastian Schuberth wrote:

>> There recently have been quite a change in merge-recursive implementation
>> and it would be really nice if you can try this again with the tip of
>> 'master' before 1.7.7 final ships.
>
> The unstaged changes do not seem to get lost during the merge anymore
> when using git version 1.7.7.rc3.4.g8d714 on Linux. I guess that
> somewhat confirms that there's a bug in git<  1.7.7. I'll write a word
> of warning to our in-house git users that they should always commit
> before merging ...

It seems I'm not the only one who lost code due to this bug. For a more 
detailed analysis see this blog post:

http://benno.id.au/blog/2011/10/01/git-recursive-merge-broken

As it turns out, my use case also involves a rename of the file in which 
changes were lost. And just like for the blog's author it somewhat 
concerns me and shakes my confidence in Git for how long this severe bug 
slipped through undetected.

-- 
Sebastian Schuberth
