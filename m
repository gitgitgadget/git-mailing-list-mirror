From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Thu, 20 May 2010 18:17:04 +0100
Message-ID: <201005201817.05593.andyparkins@gmail.com>
References: <ht3194$1vc$1@dough.gmane.org> <7vy6fe7ldo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 20 19:15:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF9LS-0001Vy-FE
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 19:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556Ab0ETRPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 13:15:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58927 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab0ETRPg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 13:15:36 -0400
Received: by wyg36 with SMTP id 36so33386wyg.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=FStjzDcVL4i66UgFfSgwvvOr7RbK1waCNGp240+/sD0=;
        b=ufYQxcptu3038sbcZoux+k2HiD16jlaqmPEhSFOExmAzf6cIy9O8Dwm17HPdIRTN6Z
         ZHKSN5Qp6ry6ugqqLh3S5theJwrDw53eQFx+/IQjo0Xo7gqfgkHoS+GwlVeJsEdy7ssy
         5kXwAMyFTZ0jfbgvOzXoiciZxyk6ZquA/pTuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=gUNNhNh+V2U7AoqWriz838kqN8j0QjhFkRY9eGzjZGXlB/G2188f335HznFga4vfHT
         wIQZtCjAnr6N6hE76RLW3QwWyk0+Q7aRTmNr85gQ4vH9h8sJ5BZuiQFTWx/tlNXF4BJj
         lP8/ZPjQHQgrTjXZvq/KYoobOWmv+nL/tOvRY=
Received: by 10.227.135.134 with SMTP id n6mr228363wbt.88.1274375735050;
        Thu, 20 May 2010 10:15:35 -0700 (PDT)
Received: from grissom.localnet ([91.84.15.31])
        by mx.google.com with ESMTPS id t20sm630294wbc.22.2010.05.20.10.15.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 10:15:33 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.32-trunk-686; KDE/4.4.3; i686; ; )
In-Reply-To: <7vy6fe7ldo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147398>

On Thursday 20 May 2010 14:28:35 Junio C Hamano wrote:

> > One additional small point: why do untracked files in a submodule make
> > the module dirty?  I've often got a few "temp.ps" or "debug.log" or
> > "backtrace.log" files lying around -- inappropriate to add to an
> > ignore file, but they don't make my working directory dirty.
> 
> "They don't make my working directory dirty" is something only you can
> decide, until you tell git about that fact, isn't it?

Perhaps I've misunderstood then; I have always understood that "dirty" was 
the name we give to the state when tracked files have changes in the working 
directory.  If not, then what word should be used to distinguish between 
tracked files unchecked in and untracked files?

Anyhoo; I don't mind.  Me starting a semantics debate isn't helpful is it?

> The way to tell git about them is to use the ignore/exclude mechanism.
> Why are they "inappropriate to add to an ignore file"?  At least you
> could have "*.log" in your personal exclude $GIT_DIR/info/exclude, no?

I think you've taken me too literally; I was trying to get across the idea 
that they are files that are made on the fly, and when I notice them they 
just get deleted.

Also, I don't want *.log, or *.ps -- neither of them is guaranteed to be an 
ignore pattern.  These throw away files have all sorts of names, made up on 
the spot as I'm working, adding them to an ignore file is overkill from my 
point of view.



Andy
-- 
Dr Andy Parkins
andyparkins@gmail.com
