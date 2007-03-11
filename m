From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 20:27:02 +0700
Message-ID: <fcaeb9bf0703110627r6500d621rf6710c58e9e8d65b@mail.gmail.com>
References: <20070311043250.GA21331@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Matthias Lederhofer" <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 14:27:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQO56-0001Xx-0l
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 14:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbXCKN1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 09:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXCKN1H
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 09:27:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:48763 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbXCKN1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 09:27:05 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1898563uga
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 06:27:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lLMXW2MR8nVF/3elfRoocaie0JsyLyP+Qg3v6ENcG1X25SVzBcMOEIRhemFvXWch/lXUhJBDmO+TjHQxjHDrUah2Y2on31WQnWDU/j7Mxgbco9RZ1D0K42wAD0nd0pz6IymiFJIjn+RUIGocKmwa2Q54ALy1SZ3cg/98nLcvhrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rUFmbTXoq5VVFjRDT6YzcjlC5NQ5YawJ4qRDDm5/0XXttOm6ibD77qNxsuvBvANLyW+EYeD0km0hOdIGTm5Kp20l9gn3e2hqiq9Cazze99NVpC0PeUH2gMZlOTiuKYcagq2aW8O7+KFl8pfSRtHbWPVoqhCJQVh1e3YZI3IoDeY=
Received: by 10.114.12.9 with SMTP id 9mr813805wal.1173619622691;
        Sun, 11 Mar 2007 06:27:02 -0700 (PDT)
Received: by 10.115.19.15 with HTTP; Sun, 11 Mar 2007 06:27:02 -0700 (PDT)
In-Reply-To: <20070311043250.GA21331@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41922>

On 3/11/07, Matthias Lederhofer <matled@gmx.net> wrote:
> diff --git a/environment.c b/environment.c
> index 0151ad0..5c30c9b 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -61,6 +61,8 @@ int is_bare_repository(void)
>         const char *dir, *s;
>         if (0 <= is_bare_repository_cfg)
>                 return is_bare_repository_cfg;
> +       if (0 <= has_working_directory)
> +               return !has_working_directory;
>
>         dir = get_git_dir();
>         if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))

Um.. git-sh-setup.sh may need special treatment because its
is_bare_directory doesn't call this function.
-- 
Duy
