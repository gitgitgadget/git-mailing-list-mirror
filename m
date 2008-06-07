From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix missing "HEAD" in the RewriteRule
Date: Sat, 7 Jun 2008 12:06:27 +0200
Organization: glandium.org
Message-ID: <20080607100627.GA990@glandium.org>
References: <1212823166-25098-1-git-send-email-ask@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ask =?iso-8859-15?Q?Bj=F8rn?= Hansen <ask@develooper.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 12:08:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4vLL-00083w-89
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 12:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509AbYFGKHW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 06:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755400AbYFGKHV
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 06:07:21 -0400
Received: from vuizook.err.no ([194.24.252.247]:42230 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409AbYFGKHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 06:07:21 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K4vKJ-00041x-5Q; Sat, 07 Jun 2008 12:07:18 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K4vJb-00014f-7n; Sat, 07 Jun 2008 12:06:27 +0200
Content-Disposition: inline
In-Reply-To: <1212823166-25098-1-git-send-email-ask@develooper.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84196>

On Sat, Jun 07, 2008 at 12:19:26AM -0700, Ask Bj=F8rn Hansen wrote:
> Also add a few more hints for how to setup and configure gitweb as de=
scribed
> ---
>  gitweb/README |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
>=20
> The important change is to add HEAD into the regexp, everything else =
is
> optional...
>=20
> diff --git a/gitweb/README b/gitweb/README
> index 8f7ea36..b96834b 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -255,12 +255,15 @@ Webserver configuration
>  If you want to have one URL for both gitweb and your http://
>  repositories, you can configure apache like this:
> =20
> -<VirtualHost www:80>
> -    ServerName git.domain.org
> +<VirtualHost *:80>
> +    ServerName git.example.org
>      DocumentRoot /pub/git
> -    RewriteEngine on
> -    RewriteRule ^/(.*\.git/(?!/?(info|objects|refs)).*)?$ /cgi-bin/g=
itweb.cgi%{REQUEST_URI}  [L,PT]
>      SetEnv	GITWEB_CONFIG	/etc/gitweb.conf
> +    RewriteEngine on
> +    # make the front page an internal rewrite to the gitweb script=20
> +    RewriteEngine ^/$  /cgi-bin/gitweb.cgi

You meant RewriteRule, right ?

Mike
