From: Paul Mackerras <paulus@samba.org>
Subject: Re: [gitk PATCH] gitk: Disable log.decorate config
Date: Sat, 20 Mar 2010 16:10:55 +1100
Message-ID: <20100320051055.GA3855@brick.ozlabs.ibm.com>
References: <1269038663-11025-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Mar 20 06:11:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsqxv-0008Kd-Iz
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 06:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab0CTFLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 01:11:04 -0400
Received: from ozlabs.org ([203.10.76.45]:60295 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab0CTFLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 01:11:00 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 39983B7D53; Sat, 20 Mar 2010 16:10:59 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1269038663-11025-1-git-send-email-santi@agolina.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142683>

On Fri, Mar 19, 2010 at 11:44:23PM +0100, Santi B=E9jar wrote:

> Since eb73445 (Add `log.decorate' configuration variable., 2010-02-17=
)
> the log output changes if log.decorate is set. Gitk is unable to
> understand the new output (it returns the error: "Can't parse git log
> output: {commit $sha1 $sha2...}), so disable it with --no-decorate.
>=20
> Signed-off-by: Santi B=E9jar <santi@agolina.net>
> ---
>  gitk |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitk b/gitk
> index 1f36a3e..aca44b7 100755
> --- a/gitk
> +++ b/gitk
> @@ -362,7 +362,7 @@ proc start_rev_list {view} {
> =20
>      if {[catch {
>  	set fd [open [concat | git log --no-color -z --pretty=3Draw --paren=
ts \
> -			 --boundary $args "--" $files] r]
> +			 --boundary --no-decorate $args "--" $files] r]

We'll need to make that conditional on the git version, since we want
gitk to continue to work on older git installations.

Paul.
