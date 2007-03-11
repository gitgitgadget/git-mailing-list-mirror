From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 20:46:24 +0700
Message-ID: <fcaeb9bf0703110646p5417048bx27f119679c01e988@mail.gmail.com>
References: <20070311043250.GA21331@moooo.ath.cx>
	 <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com>
	 <20070311133350.GA12553@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Matthias Lederhofer" <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 14:46:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQONa-0001Vf-Vw
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 14:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbXCKNq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 09:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbXCKNq2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 09:46:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:7807 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbXCKNq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 09:46:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1902309uga
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 06:46:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ol7grwOC72LwlrO9AX0771ohosxg5gTivgT4XvbUgH5QU+m+Fh5hWye7N4S4TysThJfIWj+XFy8WduvbSDNbhfoU83ywBpQix/pjRpg4zSuKzua/38HmJ/Xix0fj9QwIQpQoIFtx8N1oYsXTyN+g8Jg3tDaEs4GQWH4NeA+gDWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BytknaH8r8ruflG3kZ/rY36RjFs0lUoDutKdQpWRnWBMDlg6qzHF5X+pLxVjVE/SyN6CIOTcssIVCJ2VtVBF6ftMaPGE69ddE4YpzjwrcrmpD17Yv7mx5KhgJhvh+GZ8rrGViJwkz++NCyf2oEvE/zWVwS2vG1Fg05mVpqDWxcc=
Received: by 10.114.25.3 with SMTP id 3mr813191way.1173620785250;
        Sun, 11 Mar 2007 06:46:25 -0700 (PDT)
Received: by 10.115.19.15 with HTTP; Sun, 11 Mar 2007 06:46:24 -0700 (PDT)
In-Reply-To: <20070311133350.GA12553@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41924>

On 3/11/07, Matthias Lederhofer <matled@gmx.net> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > My case seems a bit complicated than usual. The working directory
> > (/home/pclouds/blog/data) was not a prefix of cwd (/home/pclouds/blog)
> > so the code failed silently at this line. If I replace
> > "has_working_directory = 0; return NULL;" with "strcpy(cwd,gitwd);c =
> > 0;break;", it may work but see below
>
> If you're outside the specifed working directory the
> is_bare_repository will return true, just as if you don't have a
> working directory.  Do you expect anything else or doesn't this work?

Yes I expected it to move the specified working directory as described
in the previous mail (copied/pasted below). However the patch requires
me to be in workdir somewhere already (which is fine if that is your
expectation). If that's the case, maybe you should tell users
something about GIT_WORK_DIR not applicable.

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > By the way, is it plausible to add --git-workdir option to specify
> > working directory? With that option, I won't need to _chdir_ to the
> > working directory, run git commands and _chdir back_.
>
> http://article.gmane.org/gmane.comp.version-control.git/38382
> Since I did not need this feature that much and no one replied that
> there is any interest I did not look any further into it.

-- 
Duy
