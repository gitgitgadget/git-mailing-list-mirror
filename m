From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sat, 24 Mar 2007 19:15:50 +0100
Message-ID: <38b2ab8a0703241115q39dc298clb15357268288b49e@mail.gmail.com>
References: <200703231022.00189.andyparkins@gmail.com>
	 <38b2ab8a0703240743t3ca2b091w12072046ee03dd5@mail.gmail.com>
	 <200703241548.13775.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 19:16:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVAmg-0000tK-DJ
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 19:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbXCXSPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 14:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbXCXSPx
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 14:15:53 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:12265 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbXCXSPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 14:15:52 -0400
Received: by an-out-0708.google.com with SMTP id b33so1814203ana
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 11:15:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pRlhtYByzWvqPm6lWEAh9P0K4jW4nkcMLxvDWn3d91J7mknDgKCiIt1E8ZFmc5KXSND2Qc8wAIv6LnsP/PB/V4T2QSipYvkaz5652tuRHA6ysYV4zpt2t0eLJ52oZLbOa+yfbDC3lfzlgXDzxxJdhATWPaCR+UKBkjmOFiLnVac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h5es2IYnrdVOl/pVGC18oK51lNwxR3MqT2NBbV2kM+66cBceXGjg4bU7471gjPypf+hIXDQc6NNngGR53DImmrfuzPM4NM5nrCW8huMzUBC+iX+KFE0Hav9xOOg+jRpHsrNYUIIqRLu7q4XgC5aD5i9g4o9EB2OoxhGLuMWTz0o=
Received: by 10.114.152.17 with SMTP id z17mr1790837wad.1174760150590;
        Sat, 24 Mar 2007 11:15:50 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Sat, 24 Mar 2007 11:15:50 -0700 (PDT)
In-Reply-To: <200703241548.13775.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43010>

On 3/24/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Saturday 2007, March 24, Francis Moreau wrote:
>
> > Are there any simple ways to enable this behaviour from your hooks ?
>
> Yes; have a look near the bottom of the post receive hook (update to
> come today, so don't use it yet), but you'll see:
>
>  while read oldrev newrev refname
>  do
>   generate_email $oldrev $newrev $refname | /usr/sbin/sendmail -t
>  done
>
> That pipe to send mail could be anything you want, say
>
>  generate_email >> /var/www/update-announcements.txt
>
> Would that suit you?
>

yes that almost would do the thing. But instead of hacking the hook,
it would be great to have a trivial setup at the begining of the
script to choose this config.

Maybe a local config in the repo through the command `git config`
could do the job ?

$ git config hook.update.path "/var/www/"

And if the config is to write the message to a file, skip the email
stuffs generation (header, foorter...).

thanks
-- 
Francis
