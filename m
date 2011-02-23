From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH v2 5/8] git-p4: reinterpret confusing p4 message
Date: Wed, 23 Feb 2011 09:26:34 +0100
Message-ID: <AANLkTinbmqMfOTAqdG9Mdecpody2uy3wZOdaWbv25ph2@mail.gmail.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
	<1298121481-7005-6-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 09:31:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsA8N-00011o-9M
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 09:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080Ab1BWIbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 03:31:38 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:40847 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab1BWIbh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 03:31:37 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Feb 2011 03:31:37 EST
Received: by gxk19 with SMTP id 19so1993396gxk.11
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 00:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zox3R3w5jktmo2P4MZ41MJhFW8j9g4vOJEWOhaV6Fvg=;
        b=YC+19x9HOa945hLIx+PPN2Q3T08vfVHniHYTsmaTw/0UgUX3ejkD7acORXcuj5tC8G
         JMoPDaIs6teIHYP/X/jrRNjP4IkXNK0m/9CfVd+E5e7gtpcUuwebwaCDeOpFTgKSwpKx
         5bsSftjIYfCTlQ7JcXRtUhPPtxHJz2DKYf78s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kOMe5ux44GTzHEX8A9AitiA0MKGmuFxA/7rFjsKDVg1qFIKkYBdZGNgtECazr2ve01
         dTYK5jjhjUmXBafKgkc96rl3eNjJuISC6+423NOc1tIy1Uoy2DWS4yNR3nKMm31zJVq/
         HrUcKSYml9IVqENpEb6az6aZTQivLRlE1BWPs=
Received: by 10.90.54.14 with SMTP id c14mr4907773aga.14.1298449594966; Wed,
 23 Feb 2011 00:26:34 -0800 (PST)
Received: by 10.90.54.1 with HTTP; Wed, 23 Feb 2011 00:26:34 -0800 (PST)
In-Reply-To: <1298121481-7005-6-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167678>

On Sat, Feb 19, 2011 at 2:17 PM, Pete Wyckoff <pw@padd.com> wrote:
> Error output will look like this:
>
> glom$ git p4 clone //deopt
> Importing from //deopt into .
> Reinitialized existing Git repository in /tmp/x/.git/
> Doing initial import of //deopt from revision #head into refs/remotes=
/p4/master
> p4 returned an error: //deopt/... - must refer to client glom.
>
> This particular p4 error is misleading.
> Perhaps the depot path was misspelled.
> Depot path: =C2=A0//deopt
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>

Acked-by: Tor Arvid Lund <torarvid@gmail.com>

:-)

> ---
> =C2=A0contrib/fast-import/git-p4 | =C2=A0 =C2=A04 ++++
> =C2=A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index db19b17..6b847c4 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1445,6 +1445,10 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if 'code' in info and info[=
'code'] =3D=3D 'error':
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.stderr.wr=
ite("p4 returned an error: %s\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% info['data'])
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if info['dat=
a'].find("must refer to client") >=3D 0:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
sys.stderr.write("This particular p4 error is misleading.\n")
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
sys.stderr.write("Perhaps the depot path was misspelled.\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
sys.stderr.write("Depot path: =C2=A0%s\n" % " ".join(self.depotPaths))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if 'p4ExitCode' in info:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.stderr.wr=
ite("p4 exitcode: %s\n" % info['p4ExitCode'])
> --
> 1.7.4.1
>
>
