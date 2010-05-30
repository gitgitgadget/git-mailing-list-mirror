From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/7] Add cpp macro implementation of treaps
Date: Sun, 30 May 2010 11:33:37 +0200
Message-ID: <AANLkTikrLDwwOg3CmjVGqILW8oH1-sY19WOnkUey1RaB@mail.gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com> 
	<1274650832-7411-3-git-send-email-artagnon@gmail.com> <20100529071811.GA6648@progeny.tock> 
	<AANLkTilHgXD1mzrTE0PQKeLWM7uheNmZ62ZJGGxuh-7E@mail.gmail.com> 
	<20100530093151.GB5513@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jason Evans <jasone@canonware.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 11:34:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIeuE-0002Dw-2P
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 11:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab0E3JeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 05:34:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42273 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0E3Jd7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 05:33:59 -0400
Received: by vws11 with SMTP id 11so907518vws.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EhCO/8NtGyM2qTedgg92kPdo0b+kfdlGZvjbPyLzeQk=;
        b=ExAxP5R8GhtJ9/o8nUjPBSv65cDcvkkee0BMIY9NaEJ7nRBb78n0gI8KKb+m9wPz18
         Ihxpa0dqHiNzlUhj2EuI57Q1AWvMMScwxgDxnDTWuaw90PRuyICiBj2J53V/oPIuTnH1
         Dl1HzksHo7K+N1cEztZ9WdLB4nTZIDJzOYgK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=L6Vpd2Q7MZJXNEeOZOtPY7ygtLvrSwkKzp17T+sIlqFK3jr2OELEx27N0koqw/L1h6
         BLY3XT60f9nSyd6eLiHf7Jfo1Xf3uE2eKu5/tUNiuVI4OHsndBj+EPUODjhth8wntJwF
         CFUgF/TjMJttSFgsxxO16/RrSMjOlVvUfV4l4=
Received: by 10.224.59.132 with SMTP id l4mr1085387qah.241.1275212037115; Sun, 
	30 May 2010 02:33:57 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Sun, 30 May 2010 02:33:37 -0700 (PDT)
In-Reply-To: <20100530093151.GB5513@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147994>

Hi Jonathan,

Jonathan Nieder <jrnieder@gmail.com> wrote:
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A01 +
> =C2=A0t/t0070-fundamental.sh | =C2=A0 =C2=A04 ++++
> =C2=A0test-treap.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
8 ++++++++
> =C2=A03 files changed, 13 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 test-treap.c
>
> diff --git a/Makefile b/Makefile
> index 2f5d631..a26bceb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -403,6 +403,7 @@ TEST_PROGRAMS_NEED_X +=3D test-path-utils
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-run-command
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-sha1
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-sigchain
> +TEST_PROGRAMS_NEED_X +=3D test-treap
> =C2=A0TEST_PROGRAMS_NEED_X +=3D test-index-version
>
> =C2=A0TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
> diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
> index 680d7d6..7522bdc 100755
> --- a/t/t0070-fundamental.sh
> +++ b/t/t0070-fundamental.sh
> @@ -12,4 +12,8 @@ test_expect_success 'character classes (isspace, is=
alpha etc.)' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test-ctype
> =C2=A0'
>
> +test_expect_success 'treap data structure' '
> + =C2=A0 =C2=A0 =C2=A0 test-treap
> +'
> +
> =C2=A0test_done
> diff --git a/test-treap.c b/test-treap.c
> new file mode 100644
> index 0000000..f94a931
> --- /dev/null
> +++ b/test-treap.c
> @@ -0,0 +1,8 @@
> +#include "git-compat-util.h"
> +#include "vcs-svn/trp.h"
> +#include "vcs-svn/obj_pool.h"
> +
> +#define NNODES 32
> +#define NSETS 200
> +
> +tests go here
> --
> 1.7.1

Thanks for the template. I'll start writing tests right away.

-- Ram
