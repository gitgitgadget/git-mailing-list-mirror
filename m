From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: t4015 broken on pu
Date: Mon, 3 Jun 2013 21:11:38 +0200
Message-ID: <20130603191138.GA16172@blizzard>
References: <51ACE819.3010704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 03 21:11:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjaAY-0003AN-W9
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 21:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758097Ab3FCTLp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 15:11:45 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:40144 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128Ab3FCTLn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 15:11:43 -0400
Received: from localhost (p5B2C6B5B.dip0.t-ipconnect.de [91.44.107.91]);
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 6cfcc412;
	TLS version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO;
	Mon, 3 Jun 2013 21:11:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51ACE819.3010704@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226269>

On Mon, Jun 03, 2013 at 09:01:45PM +0200, Torsten B=F6gershausen wrote:
> The new 4015 does not pass under Mac OS:
>=20
> a) The seq command, does not exits (we can use printf)
> [...]
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index b3c4fcc..f00d20b 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -143,18 +143,18 @@ git diff --ignore-space-at-eol > out
>  test_expect_success 'another test, with --ignore-space-at-eol' 'test=
_cmp expect out'
> =20
>  test_expect_success 'ignore-blank-lines: only new lines' '
> -       seq 5 >x &&
> +       printf "1\n2\n3\n4\n5\n" >x &&

I'd rather use test_seq here.

>         git update-index x &&
> -       seq 5 | sed "/3/i \\\\" >x &&
> +       printf "1\n2\n3\n4\n5\n" | sed "/3/i \\\\" >x &&
>         git diff --ignore-blank-lines >out &&
> [...]
