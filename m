Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A6DC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352494AbiDZPtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352580AbiDZPtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:49:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B55CA0C7
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650987939;
        bh=bm6xmpF0x51jSR+sEd3S7AozOKow4oe4Z6IhhTh5cRM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aQSsvHY+K+VbUjkAjVX3dcDeegf3C6iqvdd8x4sZArPbM444pJd6NvsO/3OJ/n0WO
         O8AvjyxbQ41+IcIdbRceyn+gVeZa6NgJNoe3TAeDicgf9A1lA2B7CMv86306lCHjQP
         H7Kyf90t+rr0w3Dc0ZU14F9GWf7BY7ukfPZc7SAY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.146.35] ([89.1.215.71]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1nOHku3bvf-00VeFm; Tue, 26
 Apr 2022 17:45:39 +0200
Date:   Tue, 26 Apr 2022 17:45:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
In-Reply-To: <xmqqk0bf1i12.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2204261743590.355@tvgsbejvaqbjf.bet>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de> <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email> <xmqqczh73hns.fsf@gitster.g> <xmqqk0bf1i12.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Fr3elgSvcS3vVGDN2BisuSyL/9fUIQlenDHo6ZGToQRqUg6Fc62
 d+V7T8fi1gm2E/qq922SV1fzm8B2OCbqkFkFVXFfDwQlqdTQTWxu1i+c170RyNITDUvfH6p
 OhumxL2B6qlPkBMWfNGIT08t8jZGrrTfXgWQofAMfMnWgS/CtrFmCPgQ8OzOaYzs8eCvTOr
 Ut3hDvGhXjFaeKoMd8DJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/rUA+UR/6+M=:HNAczdtEU08fOK0HDR9xO3
 4OOqB10XV3uXNbxKuQjYdqFjcvOEoXywNx7AoCok+OGd10SjfEvM02H64+xr3sdT2iN4SU0uU
 jo1eW10mc0e8D6o5OoJvaF9dJwui/zNE1bFKm/dVOuFrIT2BgtIRDJgShNJ4UmEGAvPVqqUjT
 tPyXddi+BDCTsWxry2eKmEdxd4VGczHuSLr15Cju8cGWWxtXvO1fuhk9FFla+chir33EvvlIx
 xaI2V+lrUIRnr6/jYINWbndMO9dW+kMaLbHbl2EVlovYn+wMdVgElO9Z1tcN8VT44QEflrkYH
 h3x+IZCUt6wGFZPV4G3J4kiZAhjqy6gW7porjmKl9DZ9xNOQ3SrjEJP5bc34OV8kDQgXG9Gt2
 QqaXRhRVPaUwpdaBXJVfrtrLfLWdJVqgRs7gwmRYfHOl45h3ZpSm0ef5pkraROsPg4Spyu+Jm
 UXuUYytoXj5pPAGK8XjN8l/dv/BQy5BjEV5A4wzYqojBJvAK25O3xtEk2ozlDG89mRknufXFL
 wCVg8UssQpq6Ue7lSVMGsSIkY2dBGC5DedHYDoyGDLJfrxqBOCtUu5rvVA4Qf+ot1DysCpfqN
 IZMqluGSplWHhcE48jFA4/0xq44swUEU5nAdMtTjSOkDBCIg93n+w5LiuV0cJKsFMrtg9LJlB
 Uc804F1OwPzVOjefXiXi9q81fdR690t9G2kxd1syBmLMzMETYWXbpMkQ7cKU3YJwt7bsJdCqv
 YwmrMy9R1TnKdiFgNnL3yLl1mP2BBVBsnY/9KjL4NTZ1HKFK9fYpcDyxR9aZtjGI0FydhfVhz
 2ANBBW3/JTr3KQ1w/87kOmjsgpJlSRJQ8CWBgt6IO/d8wGxoCetZvgwGRf4RWTL7igLIjJYc4
 1TGMdIfvVOpMZSghw3rLqyYlaekHZOgo/XFfPHXUv79DMiM8s+YzFsQm0zl7zg3/Z3jdWP4zR
 l8N5zFD4LtVkBHqkILDvRyZADDctU/S4IRlfN87akGWySJ9q7KRQtVWEPEfmfyJvhv6eeLzbQ
 f9AnpqlU7M67BE8h+ZQ2Q3Wz0TEPKmX3Lqc0fyo/bQaMfUC0ZWNU3Y3eXbsz6mosu60J6QSgy
 I0txdA/qq2Aue8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 23 Apr 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Philip Oakley <philipoakley@iee.email> writes:
> >
> >>> guy@renard ~/Software/uncrustify $ sudo git describe --always --dirt=
y
> >> ...
> >> There has also been added an escape hatch of allowing "*" for the
> >> permitted safe directories. but do check the updated manuals, and the
> >> git mailing list archive (update the search in the above link).
> >
> > In this particular case, I do not think '*' is needed, but you need
> > to be careful here.  Whose configuration are you suggesting to add
> > such an entry?  Yourself?  ~root/.gitconfig?
> >
> > I wonder if we should loosen "the same owner" check somewhat to
> > cover this situation better.  I expect people also run the
> > installation in repositories they own with "sudo make install",
> > and complaining "euid does not own that repository" when it is
> > merely because they are running as root (and their real identity
> > is still in ruid) feels a bit too strict to be useful.
>
> Actually, not quite.  when "git" runs in "sudo git", the real
> identity has long lost, so the below would not help.  Sigh.

Could you help me understand what is going on exactly? How/when is `git`
running `sudo git`? I thought the problem was that `sudo make install`
transitively runs `git describe` with euid 0, but `getuid()` should still
return the non-admin user's ID, no?

Thanks,
Dscho

>
>  git-compat-util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git i/git-compat-util.h w/git-compat-util.h
> index 63ba89dd31..90dc1b17cd 100644
> --- i/git-compat-util.h
> +++ w/git-compat-util.h
> @@ -398,7 +398,7 @@ static inline int is_path_owned_by_current_uid(const=
 char *path)
>  	struct stat st;
>  	if (lstat(path, &st))
>  		return 0;
> -	return st.st_uid =3D=3D geteuid();
> +	return st.st_uid =3D=3D geteuid() || st.st_uid =3D=3D getuid();
>  }
>
>  #define is_path_owned_by_current_user is_path_owned_by_current_uid
>
