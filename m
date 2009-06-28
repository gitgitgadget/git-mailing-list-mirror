From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Sun, 28 Jun 2009 15:44:48 -0700
Message-ID: <20090628224447.GB1951@gmail.com>
References: <Pine.LNX.4.64.0906272248570.11453@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Unknown <borg@uu3.net>
X-From: git-owner@vger.kernel.org Mon Jun 29 00:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML39F-0001Qi-DV
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 00:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbZF1Wos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 18:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbZF1Wos
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 18:44:48 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:36624 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbZF1Wor (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 18:44:47 -0400
Received: by pxi28 with SMTP id 28so3017812pxi.33
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tGwosXg6x9VuOX6EPLiok4eRlQLcGdrCCSwA8zZ7Bgc=;
        b=U5jcFXTu0Qg1aQ3lWKHGUq5IJw8Hxwjf/ca0/P4sZRTDCxn6AH09fnoc8T0kJaEiqk
         5jFHHgBkwrVu1co9g/JSdQYpwx5d0kwdBiFSMeswncougOBxRNTVm9dJSQJy5c9n+mlO
         crhou9rxPT6thMxlWlSAypIEsLz3FjbWSWM2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JqegGlHXV+eT86toHj/jrivI1KSmXvXEgK4LWUkbZ6GyTgr0u7R6UOdYrisAexWKOC
         qTST4Qkey7z5mqxfHVRkgnDyi9PyX2+W3ZVy+sTCNmN2VcaJZ+b61uAgZRll/+S02dW0
         JaZz/2kLXKSrhlh7tZ/jf4trbH8sWjFnbvEC0=
Received: by 10.115.93.18 with SMTP id v18mr10543220wal.100.1246229090610;
        Sun, 28 Jun 2009 15:44:50 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l37sm10644213waf.40.2009.06.28.15.44.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 15:44:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0906272248570.11453@cube>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122426>

On Sat, Jun 27, 2009 at 10:57:13PM +0200, Unknown wrote:
> Here is a tiny patch adding -q option to git status.
> It means -uno (Show no untracked files).
>
> Not sure where to add that in documentation.
> Maybe in git-commit man just below -u:
> -q (for git-status only, equals to -uno).
> Or something like this?
>
> Regards,
> Borg


Hello

Please take a look at Documentation/SubmittingPatches
(all of the documentation lives in Documentation/).

It doesn't seem like this patch was generated with
git format-patch.  You'll also want to submit your patch using
git send-email, as we require inline patches instead of
attachments.

You'll need to include a signed-off-by line (which you can do
by using `git commit -s`) and it seems like you need to
introduce yourself to git:

http://book.git-scm.com/2_setup_and_initialization.html

Sorry, we cannot accept patches from "Unknown" for a number
of reasons.


Thanks for your help and we look forward to hearing your
response to the rest of the feedback received in this thread.


> diff --git a/builtin-commit.c b/builtin-commit.c
> index 41e222d..e4e0074 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -826,6 +826,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  		diff_use_color_default = git_use_color_default;
>  
>  	argc = parse_and_validate_options(argc, argv, builtin_status_usage, prefix);
> +	if(quiet)
> +		show_untracked_files = SHOW_NO_UNTRACKED_FILES;
>  
>  	index_file = prepare_index(argc, argv, prefix);
>  


-- 

	David
