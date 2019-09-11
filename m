Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5EE51F463
	for <e@80x24.org>; Wed, 11 Sep 2019 21:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfIKV2p (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 17:28:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:47525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbfIKV2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 17:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568237320;
        bh=GNfcqMa8UxaxTIugd0yl4e35r8yAx/xWVj8d2+n6fBo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TVRBj2hEZEGHrDBBkdAPw81cdJmGUuMRCOVsUlznqJ2xu2FSRw5PpHuIp0gCQKiwM
         j6gvU2UpUFmPpVPXXRTqFcnlpc/2Cx5tlPioKlnyfgaQMNiUpKDXF9tv7jgTsew7aJ
         aEUJral9N3QENbDtvF90qbQe3gu54HuYauxIvBBI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M54L0-1iKtvi1KZS-00zGIo; Wed, 11
 Sep 2019 23:28:40 +0200
Date:   Wed, 11 Sep 2019 23:28:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Dominic Winkler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dominic Winkler <d.winkler@flexarts.at>
Subject: Re: [PATCH 1/1] Fix perl error "unescaped left brace in regex" for
 paranoid update hook
In-Reply-To: <2743caa22e60c5ddc04d388f21a04500d7bcac1f.1568097573.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909112326490.5377@tvgsbejvaqbjf.bet>
References: <pull.335.git.gitgitgadget@gmail.com> <2743caa22e60c5ddc04d388f21a04500d7bcac1f.1568097573.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:blqDdOdb91W+43vuxDPe6+srCHVVOYI6rhuO7TEw9DC8HQVZ1Wm
 5WVCSe8LBCqkW+Q4pCDjUO0c3i3xGrSJRCpls1fxcWcbYIT92fI8WZHIAeyunq861M9Ao5e
 +/BVgea6mQx7JBHXK7khFdxRdyoyTnluOFQmfYHDXZhPGt/rB9/6XDkUPY40L6znMWEEpMH
 IxasF6Q8jMMv4QWibY6tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OmELSEXMEnY=:HajLpOmT+73ibqQVNGTTAV
 Opb4XwqrfuqwNuyszBIYemSLR3F/yZyHZSDdTIUjlKPsmmr3EPEoWfStnmJcVcjHHu737W7T0
 PbU9mjISHewVQUW+P2RddXAou04vuAjCbOUnSH3FbTQO7w0P+Zh4MZ+hBWrnXqPQOXf4s8HAz
 YVaKrCGOU5nHAsumktdEKAe2YXOCuoSFeS/CF6t0jqXo/PtQvikVnHZdFodQMQvZ0gbAI9HcZ
 krMd1ihOePV6hNPxo6y/kigx7a/eWk/hI0Ob8M/7dIRJEJxrDR8cF1DStVQczCMIzXXTub7V+
 lLrRfWuRR4I4MyZx53lptGRnZ7i1ACOaqHqr9clPG0LvVvkYzq5AHIPpvz1/uKpfl5ZCqY+gv
 09S3F/Y5vRw7Z+fklmYvf8huIrdTYkL+uvfawiTxpKCsoMHndcl7cUoWwgCt3bJ820nTHP6eW
 ZTVxwX7gOkgBW19pNgYiE8sBI2zjcqAUTI6SKlvfHlNvwEicf0Wr7kgDuXc2UiaC+Uz79YbuJ
 +J18bgDhfeEvZIYoM67q9ZcTpsPc61U5CA6L9hj19F71w65Q0FQuQ3xsTVL+XI+u3hLNVAfC8
 TwYEmRuzGk92V4SBW7Z11/CL3eSLizJNjvO9UC2DIiz+WWzEYOoI7b/n2Fvrx0e0xewYjx55U
 AVlkOQ++I4UWenSuHXfxVdSJng3dSsaX/OmHBiaeO+iGVYu9AYq9Dzvw+M1njBOB2bQKdshVG
 BBn47E905x3l3cg7vz+b2cSeY7A03hW/uOo7RzIlwrvZXqCAWEs1/eeXUbHXlecJ4Z+/kMsJk
 Atjpr0ErN0/1LX/Qnc0aawbgmlDY0jxiE2CNPZjlOlj33o7iC2OXrcTzjq3MSZ5EkPDAVEcD8
 hUORBURkvE/oAB2b/rxhiwM+odqyzjrTZ6Y2qMaXfn8zur685OnWLXWzBfG3q4UNClJMegyN0
 T525LXQY2hFGCqlnObtyiKkYRYXDzPZ/L4uHef2FOWf39qmiZ6QExwQ3TPjX4eZehB4pfOcBf
 g/3OWYpSQaM1fQ8pbKHUeLEt4+m5r/gZs54ZZQuuHZKOP2UPE77GpGRevMk5tNtCICpCY3hrB
 8DJZnb4Mp6+sDWyAaWXIF1YTI7+BVSsZyYDMOA+hsM+bN2XBKSWoG7vBpQ5GldcDbWDqnj2Zk
 O6vFFWcA1EQIVBCSiUbyBsbGX/wlLvO5U3ya/GzUpxWHVp2gM9QThbC029HUy52tkG8s57Opv
 A7fGE3U3tBRokG3IQ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dominic,

all looks good, with one exception: the Subject should start with
`<area>:`, i.e. in this instance something like this would be better:

contrib/hooks: escape left brace in regex in the paranoid update hook

Ciao,
Johannes

On Mon, 9 Sep 2019, Dominic Winkler via GitGitGadget wrote:

> From: Dominic Winkler <d.winkler@flexarts.at>
>
> A literal "{" should now be escaped in a pattern starting from perl
> versions >=3D v5.26. In perl v5.22, using a literal { in a regular
> expression was deprecated, and will emit a warning if it isn't escaped: =
\{.
> In v5.26, this won't just warn, it'll cause a syntax error.
>
> (see https://metacpan.org/pod/release/RJBS/perl-5.22.0/pod/perldelta.pod=
)
>
> Signed-off-by: Dominic Winkler <d.winkler@flexarts.at>
> ---
>  contrib/hooks/update-paranoid | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-parano=
id
> index d18b317b2f..fc0a242a4e 100755
> --- a/contrib/hooks/update-paranoid
> +++ b/contrib/hooks/update-paranoid
> @@ -302,13 +302,13 @@ $op =3D 'U' if ($op eq 'R'
>
>  RULE:
>  	foreach (@$rules) {
> -		while (/\${user\.([a-z][a-zA-Z0-9]+)}/) {
> +		while (/\$\{user\.([a-z][a-zA-Z0-9]+)}/) {
>  			my $k =3D lc $1;
>  			my $v =3D $data{"user.$k"};
>  			next RULE unless defined $v;
>  			next RULE if @$v !=3D 1;
>  			next RULE unless defined $v->[0];
> -			s/\${user\.$k}/$v->[0]/g;
> +			s/\$\{user\.$k}/$v->[0]/g;
>  		}
>
>  		if (/^([AMD ]+)\s+of\s+([^\s]+)\s+for\s+([^\s]+)\s+diff\s+([^\s]+)$/)=
 {
> --
> gitgitgadget
>
