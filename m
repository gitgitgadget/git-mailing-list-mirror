From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] config.txt: update branch.<name>.merge documentation
Date: Sat, 3 Feb 2007 16:56:52 +0100
Message-ID: <20070203155652.GL5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <87irejgsyj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 16:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDNGx-0004mo-If
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 16:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992428AbXBCP5t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 10:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946479AbXBCP5s
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 10:57:48 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:60813 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946478AbXBCP5s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 10:57:48 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 2F88F27988;
	Sat,  3 Feb 2007 16:57:47 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id DBDD51F080; Sat,  3 Feb 2007 16:56:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87irejgsyj.fsf@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38568>

On Sat, Feb 03, 2007 at 04:29:40PM +0100, Santi B=E9jar wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e5e019f..f129de9 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -233,11 +233,12 @@ branch.<name>.remote::
>  branch.<name>.merge::
>  	When in branch <name>, it tells `git fetch` the default refspec to
>  	be marked for merging in FETCH_HEAD. The value has exactly to match
> -	a remote part of one of the refspecs which are fetched from the rem=
ote
> -	given by "branch.<name>.remote".
> +	the remote or local part of one of the refspecs which are fetched
> +	from the remote given by "branch.<name>.remote".

Since both local and remote refs are allowed, it would be useful to
know how git-fetch decides how to handle them.  Looks like the 1st
fetch refspec with that ref on either side is selected.

git-parser-remote also looks branch.*.merge with --get-all, so it is
interesting to know what happens for multiple values (if git-fetch
just marks them all, how does git-pull react ?).  That's also useful
to know for porcelain writers wanting to parse FETCH_HEAD.

Best regards,
--=20
Yann.
