From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH RFC GSoC] gitweb: Use -M option while using format-patch
Date: Mon, 10 May 2010 18:41:35 +0200
Message-ID: <201005101841.40011.jnareb@gmail.com>
References: <4BE82F8D.8060205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 18:42:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBW3L-0006c1-Bo
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 18:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab0EJQly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 12:41:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44385 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0EJQlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 12:41:52 -0400
Received: by fxm7 with SMTP id 7so285297fxm.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=t8T0QrtGCK/8H3378Q+Qpqg9gIECuP1086MJOjNfxmE=;
        b=isx6/WM6lif+kr96EcbDyeLRN7IT1bFhYVcH+xnaYvjWCHdLrmOIvr9v5NCqiZEHyP
         akDaKme+9jJVTy18TSb61XLLobOvQiYFBQX6/yWKAeCEQ+uchfkHxcLgrpn8ZpfIFeeE
         +hIdtiLj4p1UFYmfCIdCWGbupW/wsMvE4cWew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ITy+0s6xTnDXn6bxj6rS70wAsUMaHC+sUNxPhSblWReXPmMYSMGtgI6Os3M9rrKuKM
         wUJScq84igfleATeFcdELWOBUz5RNMIo3uZRG7jqDY+NeacFgDO1Pz31vGJ3H531Wv4y
         5Br13R8Y71EYsV+OMgAJNrpS1eYTQjoK/lKAU=
Received: by 10.223.25.74 with SMTP id y10mr4633813fab.81.1273509710804;
        Mon, 10 May 2010 09:41:50 -0700 (PDT)
Received: from [192.168.1.13] (abwb94.neoplus.adsl.tpnet.pl [83.8.225.94])
        by mx.google.com with ESMTPS id j23sm22230379faa.2.2010.05.10.09.41.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 09:41:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BE82F8D.8060205@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146824>

CC-ed Guiseppe Bilotta, author of 'patch' and 'patches' views
(you can find this information using "git blame" or "git log --grep").

On Mon, 10 May 2010, Pavan Kumar Sunkara wrote:

> Add option '-M' to use with format-patch whcih detects
> renames in the commit.

  Subject: [PATCH RFC GSoC] gitweb: Use @diff_opts while using format-patch

  Make git-format-patch (used by 'patch' and 'patches' views) use the
  same rename detection options that git-diff and git-diff-tree (used
  by 'commitdiff', 'blobdiff', etc.) use.


Note that I am not sure if it is really a good change, as it might
create patches that (currently) can be applied only with git.

> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---
> 
>   gitweb/gitweb.perl |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c356e95..0184de5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6117,7 +6117,7 @@ sub git_commitdiff {
>                          }
>                          push @commit_spec, '--root', $hash;
>                  }
> -               open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
> +               open $fd, "-|", git_cmd(), "format-patch", '-M', '--encoding=utf8',

  +               open $fd, "-|", git_cmd(), "format-patch", @diff_opts, '--encoding=utf8',


or

  -               open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
  -                        '--stdout', @commit_spec
  +               open $fd, "-|", git_cmd(), "format-patch", @diff_opts,
  +                         '--encoding=utf8', '--stdout', @commit_spec

This patsh is both line-wrapped and whitespace-damaged (tabs replaced
by spacess)

>                          '--stdout', @commit_spec
>                          or die_error(500, "Open git-format-patch failed");
>          } else {
> -- 

-- >8 --
Subject: [PATCH RFC GSoC] gitweb: Use @diff_opts while using format-patch

Make git-format-patch (used by 'patch' and 'patches' views) use the
same rename detection options that git-diff and git-diff-tree (used
by 'commitdiff', 'blobdiff', etc.) use.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Acked-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git i/gitweb/gitweb.perl w/gitweb/gitweb.perl
index 225f404..d983ce5 100755
--- i/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -6295,8 +6295,8 @@ sub git_commitdiff {
 			}
 			push @commit_spec, '--root', $hash;
 		}
-		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
-			'--stdout', @commit_spec
+		open $fd, "-|", git_cmd(), "format-patch", @diff_opts,
+			'--encoding=utf8', '--stdout', @commit_spec
 			or die_error(500, "Open git-format-patch failed");
 	} else {
 		die_error(400, "Unknown commitdiff format");
