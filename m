From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Tests with broken && chains in pu
Date: Sun, 4 Apr 2010 15:15:27 -0500
Message-ID: <v2yfabb9a1e1004041315x999376f6m7dd689b529ce33d8@mail.gmail.com>
References: <201004042208.58939.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Webb <chris@arachsys.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 22:15:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyWEc-0000IX-9F
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 22:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab0DDUPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 16:15:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44823 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab0DDUPs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 16:15:48 -0400
Received: by gwb19 with SMTP id 19so910450gwb.19
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HCT/t9vxZQI3BzNXPkXv9fEYZbsII7xfEUTWs5qVIww=;
        b=NjzDwoSq9Ih+50xot9gVhDF3O3fXnpYREY45MP1At0CLnuBqk8wD3HHw2dxul3lvew
         qJeZdgHRuoaR3cGJJv1Tz9xXfQs154UXI3p594G59tc+T6YEtq85og5clv6u5/KoCb4v
         DRWQQlhxiw+u34Gne4j+zYCFzdrDFERu386JU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IFY5vU65NLSIHynJaHfO/mHTfytdtiKi1NLGYn2o+q5djCYhcMIEdt4MptTh3mKNJH
         nmRZS5DoJp/00rMPf8RdH/TuFX+TxL2aiuSq+/VfTFzakN+Ecrx8OTV9Phk7pM1zwCwQ
         O08v/+406AuLajwmeX+ckuAtCiChSBtMNeVO4=
Received: by 10.100.206.13 with HTTP; Sun, 4 Apr 2010 13:15:27 -0700 (PDT)
In-Reply-To: <201004042208.58939.j6t@kdbg.org>
Received: by 10.100.25.2 with SMTP id 2mr11133357any.117.1270412147258; Sun, 
	04 Apr 2010 13:15:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143943>

Heya,

On Sun, Apr 4, 2010 at 15:08, Johannes Sixt <j6t@kdbg.org> wrote:
> two commits in pu currently add tests with broken && chains:

> diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
> index 33f546b..eb31709 100755
> --- a/t/t5800-remote-helpers.sh
> +++ b/t/t5800-remote-helpers.sh
> @@ -9,7 +9,7 @@ test_description=3D'Test remote-helper import and exp=
ort commands'
>
> =A0test_expect_success 'setup repository' '
> =A0 =A0 =A0 =A0git init --bare server/.git &&
> - =A0 =A0 =A0 git clone server public
> + =A0 =A0 =A0 git clone server public &&
> =A0 =A0 =A0 =A0(cd public &&
> =A0 =A0 =A0 =A0 echo content >file &&
> =A0 =A0 =A0 =A0 git add file &&
> @@ -18,7 +18,7 @@ test_expect_success 'setup repository' '
> =A0'
>
> =A0test_expect_success 'cloning from local repo' '
> - =A0 =A0 =A0 git clone "testgit::${PWD}/server" localclone
> + =A0 =A0 =A0 git clone "testgit::${PWD}/server" localclone &&
> =A0 =A0 =A0 =A0test_cmp public/file localclone/file
> =A0'

Thanks for noticing, may I ask how you noticed? Do you have a script
or was it manual review?

--=20
Cheers,

Sverre Rabbelier
