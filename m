From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout.txt: Explain --orphan without
 introducing an undefined "orphan branch"
Date: Thu, 29 Sep 2011 19:02:14 +0000
Message-ID: <CAMOZ1Btx24SmvmwONvOAz_rGTOiipqDND+9LUpngOrJhdis48g@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <7v39fftbt0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 21:02:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Lsg-0007lo-J5
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 21:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900Ab1I2TCp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 15:02:45 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48466 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab1I2TCo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 15:02:44 -0400
Received: by yxl31 with SMTP id 31so897668yxl.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MH4GYZWEkSklScBpOJs80mTmMioM1vTQlj3a3m+4PXw=;
        b=Sw9okqh0b0qxNom25XwVCcJqAYVm0w8idlsF3TqZGQYmkcTH1wlo1cmUFtDVCkR9pb
         iZnYiyffb+R6TLJnYDwzlEVQKEAnl2Na4kVxEYX7JyTpDq1vrjd+++h6ncU23YMOpLe5
         vjdK6OEnu/axrUupgYk51M1GQz9jfi6387Xv4=
Received: by 10.42.28.133 with SMTP id n5mr1290302icc.77.1317322964068; Thu,
 29 Sep 2011 12:02:44 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 29 Sep 2011 12:02:14 -0700 (PDT)
In-Reply-To: <7v39fftbt0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182424>

On Thu, Sep 29, 2011 at 18:59, Junio C Hamano <gitster@pobox.com> wrote=
:
> The name of the `--orphan` option to `checkout` is meant to express t=
hat
> the next commit made on the branch does not have any parent (specific=
ally,
> it will not be a child of the current nor start_point commit), but th=
e
> glossary calls such a commit 'a root commit'. The explanation however=
 used
> an undefined term 'orphan branch', adding mental burden to the first =
time
> readers.
>
> Reword the description to clarify what it does without introducing a =
new
> term, stressing that it is similar to what happens to the "master' br=
anch
> in a brand new repository created by `git init`. Also explain that it=
 is
> OK to tweak the index and the working tree before creating a commit.
>
> Also mildly discourage the users from using this to originate a new r=
oot
> commit that tracks material that is unrelated to the main branches in=
 a
> single repository with a working tree, and hint a better way of start=
ing
> an unrelated history, as it seems to be a common abuse of this option=
=2E
>
> We may want to give a synonym `--new-root` to this option and eventua=
lly
> deprecate the `--orphan` option, as "parent vs orphan" might not
> immediately "click" to non native speakers of English (like myself), =
but
> that is a separate topic.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> =C2=A0* I am inclined to suggest doing something like this instead.
>
> =C2=A0Documentation/git-checkout.txt | =C2=A0 26 ++++++++++++++------=
------
> =C2=A01 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index c0a96e6..63d164e 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -125,16 +125,16 @@ explicitly give a name with '-b' in such a case=
=2E
> =C2=A0 =C2=A0 =C2=A0 =C2=A0below for details.
>
> =C2=A0--orphan::
> - =C2=A0 =C2=A0 =C2=A0 Create a new 'orphan' branch, named <new_branc=
h>, started from
> - =C2=A0 =C2=A0 =C2=A0 <start_point> and switch to it. =C2=A0The firs=
t commit made on this
> - =C2=A0 =C2=A0 =C2=A0 new branch will have no parents and it will be=
 the root of a new
> - =C2=A0 =C2=A0 =C2=A0 history totally disconnected from all the othe=
r branches and
> - =C2=A0 =C2=A0 =C2=A0 commits.
> + =C2=A0 =C2=A0 =C2=A0 Adjust the working tree and the index as if yo=
u checked out the
> + =C2=A0 =C2=A0 =C2=A0 <start_point>. The next commit begins a histor=
y that is not connected
> + =C2=A0 =C2=A0 =C2=A0 to any other branches, as if you ran `git init=
` in a new repository,
> + =C2=A0 =C2=A0 =C2=A0 except that the commit will be made on the <ne=
w_branch> branch, not on
> + =C2=A0 =C2=A0 =C2=A0 the "master" branch.
> =C2=A0+
> -The index and the working tree are adjusted as if you had previously=
 run
> -"git checkout <start_point>". =C2=A0This allows you to start a new h=
istory
> -that records a set of paths similar to <start_point> by easily runni=
ng
> -"git commit -a" to make the root commit.
> +Running "git commit" immediately after doing this will record a root=
 commit
> +with a tree that is the same as the tree of the <start_point>. You m=
ay
> +manipulate the index before creating the commit to record a tree tha=
t is
> +different from that of the <start_point>.
> =C2=A0+
> =C2=A0This can be useful when you want to publish the tree from a com=
mit
> =C2=A0without exposing its full history. You might want to do this to=
 publish
> @@ -143,11 +143,13 @@ whose full history contains proprietary or othe=
rwise encumbered bits of
> =C2=A0code.
> =C2=A0+
> =C2=A0If you want to start a disconnected history that records a set =
of paths
> -that is totally different from the one of <start_point>, then you sh=
ould
> -clear the index and the working tree right after creating the orphan
> -branch by running "git rm -rf ." from the top level of the working t=
ree.
> +that is totally different from the one of <start_point>, you could
> +clear the index and the working tree right after "git checkout --orp=
han"
> +by running "git rm -rf ." from the top level of the working tree.
> =C2=A0Afterwards you will be ready to prepare your new files, repopul=
ating the
> =C2=A0working tree, by copying them from elsewhere, extracting a tarb=
all, etc.
> +However, such a use case to keep track of a history that is unrelate=
d to
> +the main project is better done by starting a new, separate reposito=
ry.
>
> =C2=A0-m::
> =C2=A0--merge::
>

=46sck-you-by: Michael Witten <mfwitten@gmail.com>
