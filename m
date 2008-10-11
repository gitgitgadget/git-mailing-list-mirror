From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] t9001: use older Getopt::Long boolean prefix '--no'
	rather than '--no-'
Date: Fri, 10 Oct 2008 17:24:31 -0700
Message-ID: <20081011002431.GK8203@spearce.org>
References: <zAKaSrh5XLrzXloxZrj-A1EletXL_wuSGpTQgLXMT3MZYK_o3tUBfA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Oct 11 02:25:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoSIh-0007es-L9
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 02:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbYJKAYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 20:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbYJKAYd
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 20:24:33 -0400
Received: from george.spearce.org ([209.20.77.23]:60368 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbYJKAYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 20:24:32 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E9E313835F; Sat, 11 Oct 2008 00:24:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <zAKaSrh5XLrzXloxZrj-A1EletXL_wuSGpTQgLXMT3MZYK_o3tUBfA@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97958>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Since dbf5e1e9, the '--no-validate' option is a Getopt::Long boolean
> option. The '--no-' prefix (as in --no-validate) for boolean options
> is not supported in Getopt::Long version 2.32 which was released with
> Perl 5.8.0. This version only supports '--no' as in '--novalidate'.
> More recent versions of Getopt::Long, such as version 2.34, support
> either prefix. So use the older form in the tests.

Ouch.

Should we update our docs?

Actually, if 2.32 doesn't support the --no-validate syntax than
this is a regression in Git.  Even if it is what many would call a
bug in Getopt::Long in Perl, I think Git 1.6.1 should still honor
--no-validate like it did in Git 1.6.0.
 
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index d098a01..561ae7d 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -109,7 +109,7 @@ test_expect_success 'allow long lines with --no-validate' '
>  		--from="Example <nobody@example.com>" \
>  		--to=nobody@example.com \
>  		--smtp-server="$(pwd)/fake.sendmail" \
> -		--no-validate \
> +		--novalidate \
>  		$patches longline.patch \
>  		2>errors
>  '

-- 
Shawn.
