From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] test: some testcases failed if cwd is on a symlink
Date: Tue, 24 Jul 2012 10:24:56 +0200
Message-ID: <500E5BD8.5050404@gmail.com>
References: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 10:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StaQh-0003Uf-Ee
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 10:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671Ab2GXIZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jul 2012 04:25:12 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42588 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab2GXIZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 04:25:08 -0400
Received: by lbbgm6 with SMTP id gm6so8823284lbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 01:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=fgHdyzNt7zpqOXn81cJfH3xxYHALp1wtW1ZXWAccwf0=;
        b=uy0vX+aa2wkf+dyd2wlD6AtKxW0Ya8vysJTTUkFoGDRhEJzBklbgSjS5GCpv++qLkM
         zHxku2gbjpNIpogX3EhzuAEMaBkiWTsMTd25itjVB/zL4rGjxl2bTG92kqW2JbeI8OS6
         BbqBcKKMquYRoJ1e8YrxuHrvNFNsbfBb3Ga6RHDmddyG4XsHdrb7zcXumG6k8a5pC+g1
         oeVHqu5XiBywvoJaJA3WuE1JT4eFCpXsNtlP8JNCSkxBdqwOIXFWlrbYmyGLrCTWTA4G
         eD0gN42sCjv6STFzqtvxUKlbZzHmA3nVV5qzMojj4StL2tbTPjcTCqHZVUxmhzjlZivx
         o7Bg==
Received: by 10.152.127.98 with SMTP id nf2mr20854243lab.4.1343118306530;
        Tue, 24 Jul 2012 01:25:06 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id n7sm3593512lbk.10.2012.07.24.01.25.04
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 01:25:05 -0700 (PDT)
In-Reply-To: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202021>

Some grammatical nits about the commit message.  I hope this doesn't
come across as too picky/annoying ...  And you might want to wait for
a native to confirm whether these nits are actually all warranted.

On 07/24/2012 10:00 AM, Jiang Xin wrote:
> Run
>
s/Run/Running/

> command 'git rev-parse --git-dir' under subdir
>
s/under subdir/under a subdir/.  Or even better IMHO,
s/under subdir/in a subdir/

> will return realpath
>
s/realpath/the realpath/

> of '.git' directory.
>
s/of/of the/

> Some test scripts compare this realpath against
> "$TRASH_DIRECTORY", they are not equal
>
s/they are not/but they are not/

> if current working directory is on a symlink.
>
s/current/the current/

> In this fix, get realpath
>
s/realpath/the realpath/

> of "$TRASH_DIRECTORY", store it in
> "$TRASH_REALPATH" variable, and use it when necessary.
>=20
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  t/t4035-diff-quiet.sh  |  8 +++++---
>  t/t9903-bash-prompt.sh | 13 +++++++------
>  2 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9=EF=BC=8C=E6=
=8F=92=E5=85=A5 12 =E8=A1=8C(+)=EF=BC=8C=E5=88=A0=E9=99=A4 9 =E8=A1=8C(=
-)
>=20
> diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
> index 23141..5855 100755
> --- a/t/t4035-diff-quiet.sh
> +++ b/t/t4035-diff-quiet.sh
> @@ -4,6 +4,8 @@ test_description=3D'Return value of diffs'
> =20
>  . ./test-lib.sh
> =20
> +TRASH_REALPATH=3D"$(cd "$TRASH_DIRECTORY"; pwd -P)"
> +
BTW, the outer quotes are not needed; this is enough:

    TRASH_REALPATH=3D$(cd "$TRASH_DIRECTORY"; pwd -P)

Regards,
  Stefano
