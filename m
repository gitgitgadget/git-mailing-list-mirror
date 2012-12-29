From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 19/19] Add git-check-ignore sub-command
Date: Sat, 29 Dec 2012 03:32:27 +0000
Message-ID: <20121229033227.GA13848@gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-20-git-send-email-git@adamspiers.org>
 <7vtxr5ho01.fsf@alter.siamese.dyndns.org>
 <20121229012352.GA20379@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 04:37:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TonEq-0002rp-Pa
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 04:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078Ab2L2Dca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 22:32:30 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:56497 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab2L2Dc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 22:32:29 -0500
Received: from localhost (4.1.1.e.a.b.1.2.1.7.9.8.4.4.8.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d844:8971:21ba:e114])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 009CF2E5D3
	for <git@vger.kernel.org>; Sat, 29 Dec 2012 03:32:27 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20121229012352.GA20379@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212285>

On Sat, Dec 29, 2012 at 01:23:52AM +0000, Adam Spiers wrote:
> FYI, attached is the diff between check-ignore-v3 and my current
> check-ignore, which is available at github:
> 
>     https://github.com/aspiers/git/commits/check-ignore

[snipped]

> diff --git a/pathspec.c b/pathspec.c
> index 6724121..3789b14 100644
> --- a/pathspec.c
> +++ b/pathspec.c

[snipped]

> -void validate_path(const char *path, const char *prefix)
> +void die_if_path_beyond_symlink(const char *path, const char *prefix)

[snipped]

> diff --git a/pathspec.h b/pathspec.h
> index c251441..1961b19 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -1,6 +1,11 @@
> +#ifndef PATHSPEC_H
> +#define PATHSPEC_H
> +
>  extern char *find_used_pathspec(const char **pathspec);
>  extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
>  extern const char *treat_gitlink(const char *path);
>  extern void treat_gitlinks(const char **pathspec);
>  extern void validate_path(const char *path, const char *prefix);
               ^^^^^^^^^^^^^
I forgot to rename this one.  Will be fixed in v4.
