From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Changed gitweb.remote_heads config key name to gitweb.remoteHeads.
Date: Thu, 7 Jul 2011 22:36:50 +0200
Message-ID: <201107072236.51183.jnareb@gmail.com>
References: <1310061739-4441-1-git-send-email-marcnarc@xiplink.com> <201107072056.25417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 22:37:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QevJt-0006ov-Eq
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 22:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986Ab1GGUhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 16:37:01 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:62331 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab1GGUhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 16:37:01 -0400
Received: by fxd18 with SMTP id 18so1401017fxd.11
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Zo9jCFwII7cPthVDuStp6gxw6yAelgno+vWRczlNJbE=;
        b=WKSN2IME7ClIyzE3KCg0O13sDR6DnhWeivr+oVbfRKvhiOnnEPb5oT6FMi0TYMoY0G
         fkVT04XZAdgSz98gQIfdPfBnjbgDmxxPePfhVBLKH3g6prKSfWGCRSxeBtrr0BwDy+iS
         gZbzOVZTas2Hz+5yvezZngENKGHhhnbqpdaZo=
Received: by 10.223.97.66 with SMTP id k2mr1844201fan.45.1310071019899;
        Thu, 07 Jul 2011 13:36:59 -0700 (PDT)
Received: from [192.168.1.15] (abwq132.neoplus.adsl.tpnet.pl [83.8.240.132])
        by mx.google.com with ESMTPS id l26sm6923708fah.38.2011.07.07.13.36.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 13:36:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201107072056.25417.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176779>

> -- >8 --
> From: Jakub Narebski <jnareb@gmail.com>
> Date: Thu, 7 Jul 2011 20:48:50 +0200
> Subject: [PATCH] gitweb: Make git config search case insensitive

I should have probably add here the following:

  The section and key part of fully qualified name of config variable
  are case insensitive in git.  "git config --list -z" that gitweb uses
  returns them lowercased.
 
> Gitweb does not (yet?) use git config variables with subsection, so we
> can simply lowercase $key in git_get_project_config: section name and
> key name are case insensitive (only subsection name is case
> sensitive).
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---

Yet another case where commit message is longer than fix... ;-)

>  gitweb/gitweb.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 589c85b..59147b6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2526,6 +2526,7 @@ sub git_get_project_config {
>  
>  	# key sanity check
>  	return unless ($key);
> +	$key = lc($key); # assuming there is no subsection
>  	$key =~ s/^gitweb\.//;
>  	return if ($key =~ m/\W/);
>  
> -- 
> 1.7.5
> 
> 

-- 
Jakub Narebski
Poland
