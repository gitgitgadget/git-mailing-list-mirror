Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33E0F1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 18:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCMS0O (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 14:26:14 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:38948 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeCMS0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 14:26:11 -0400
Received: by mail-pg0-f45.google.com with SMTP id e3so221971pga.6
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=6NrNqUlT4ZWcNeSzCaAaYhl0QHi+yFgFrHpqGsalEr8=;
        b=oI5otIy4kjXfohrRtfvbc3XMIMV1/RdFPchkSR1mQoOC9zwyxYVKN2uGki4svi3DTn
         9gdgsOgwCV1/DvZ7i2FNfNX4thY2qHFxY4KTKREAfwS5NdBA3Ty0+vJ6sgutCdToo2zx
         VUIgvzbKO7VfLaR9A6KUbC2DCgzIfjKhWAJrWt3tAKoCvCGw3oPDp3bmL4Uv/a89O7at
         eTBBWG+pjPAN5c1hqlN37d0cVWmT5dc5+VAylMaZvxA448I8rbnJJcjR25WUCQg7yc4w
         0A68vgmiCCP43vp8pv1HGFaVEfsTAEnAgkmd5kYkvXL0attQLFjS94QnHBYuQmVep3ug
         PMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=6NrNqUlT4ZWcNeSzCaAaYhl0QHi+yFgFrHpqGsalEr8=;
        b=WzrcNXC7O9RwN9CSLf7/T/iRP7PZGL9Ak+wrDWpVctuROwI3IKgkziOiuAEtQhllvz
         b9wmGnKUCuQrfsR7onQYEx7RgQJU+MzATnYAyuDKv0795DWT1UiAqE4Bk1W8LhbYrvGZ
         fXR7e9gC07T26ncOrcNpzhQ2X+eIN6FPuVgiFCpn9cZNxoJQHz3l1BDTyEsOgXZNUzdu
         U89r12GzuInDvqcT98/ituw5sWxT/ps1d0W3DyIo7/s0rW9aBlDTFLNEPrZViZwnkM84
         rQXwRFer/4hs8fdgYx0c4ZaqZ55f4D7poHsoQkzlp8RF/bY/YFFBlhd7dlS6aUEeefA4
         30RQ==
X-Gm-Message-State: AElRT7Ex/fuH0xjg0vyT6eYwBMGXJke6sVjmIpH9+L8zwH3cwIFvTKSz
        GZf1SpIV3BMcTxgxb0fqtFRJzUTw
X-Google-Smtp-Source: AG47ELtS3BpWb4TnGAz6qCYY6UcTf3YDBQ31YY5cw2RTIHnXlXnwHn9dS31c0kqMaXkL98cBaKNtLA==
X-Received: by 10.101.81.135 with SMTP id h7mr1270400pgq.121.1520965570974;
        Tue, 13 Mar 2018 11:26:10 -0700 (PDT)
Received: from [192.168.206.100] ([117.209.160.202])
        by smtp.gmail.com with ESMTPSA id j19sm1520422pfh.26.2018.03.13.11.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 11:26:09 -0700 (PDT)
Subject: Re: Bug, git rebase -i does not abort correctly
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CACsJy8Dzh5E8JUDkwFmYTwS6KgqGc_1rJBVsDCoC9EpcSShN2Q@mail.gmail.com>
 <1516953056.8886.3.camel@gmail.com>
 <CACsJy8DjXBv_HMbRFPjCLuYt-bk=Ec3VPKorXJ_SBJN8pDu=PQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <4305648a-9579-b961-6435-dde9c6fd3ba1@gmail.com>
Date:   Tue, 13 Mar 2018 23:56:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DjXBv_HMbRFPjCLuYt-bk=Ec3VPKorXJ_SBJN8pDu=PQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NAGGUAWeqlydYaYnwmTOeBc67Saj0vC33"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NAGGUAWeqlydYaYnwmTOeBc67Saj0vC33
Content-Type: multipart/mixed; boundary="5ZWZX9NI02GOZXfdKdYYL07EbFlOs2E5p";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Message-ID: <4305648a-9579-b961-6435-dde9c6fd3ba1@gmail.com>
Subject: Re: Bug, git rebase -i does not abort correctly
References: <CACsJy8Dzh5E8JUDkwFmYTwS6KgqGc_1rJBVsDCoC9EpcSShN2Q@mail.gmail.com>
 <1516953056.8886.3.camel@gmail.com>
 <CACsJy8DjXBv_HMbRFPjCLuYt-bk=Ec3VPKorXJ_SBJN8pDu=PQ@mail.gmail.com>
In-Reply-To: <CACsJy8DjXBv_HMbRFPjCLuYt-bk=Ec3VPKorXJ_SBJN8pDu=PQ@mail.gmail.com>

--5ZWZX9NI02GOZXfdKdYYL07EbFlOs2E5p
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Friday 26 January 2018 02:54 PM, Duy Nguyen wrote:
>=20
> Sort of. It smells bad design to me when a mistake can easily become a
> feature. But with your help, I think I should be able to disable this
> feature on my local build. Thanks.
>=20

In case you're still facing this issue, it just struck me recently that
you could have a different alias for 'git rebase -i --onto'. In which
case you could possibly avoid falling prey to the syntax issue ;-)
Something like,

	$ git config alias.rio 'rebase -i --onto'



--=20
Kaartic

QUOTE
---

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky


--5ZWZX9NI02GOZXfdKdYYL07EbFlOs2E5p--

--NAGGUAWeqlydYaYnwmTOeBc67Saj0vC33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlqoF70bHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlp0dQQAIwXPEdj+04P6isk46T2
OuFhN+l6eot/b36lv0B9ndTNZg71CEhpGbH5m0KbQ7AE0D75hUpIAN8PJE09ONHF
5t91Rw/SJuwCJHwtupmY61MnT1R6oywjMpH5nE9bqE79k8Rbr5heNhAbst+H0LjD
VGijdY8z/2sJB9adHOWIS/bDKzvS9Xhto3QtiX3DcTgxVHtChys0+p0mkkDyG7iO
76lWw2EYJsmsbgP/EMrV0sIV0gvhjG2tG3b0ilIMFd1/SxHpiowg6Q+xVOtpxCjB
kLoAHQtiMKuZQ4O/0r+YpgUKFVIoiQEKdkgcY58jzXfFpmQzbkMqFZEGLwuk7h9q
TvNjwENjWdYng94yCcgXCqp6r9X+eXFtpTpkPI5mQTuPVoaFXjO18KOMQfToRapB
ct+pvcFkrLihqd5YDneTy2z0xHwQtA8xCO/3gB3ZBOynhE0Zlb6pEgKBaxi9EQR/
eSM0UFynYjLxTcH6LXk5RlUm7VBqaJJ6mChQfHMAFspXnQdvQ1sW10kClk1BMn/z
IKcGvbKWroYkiA4NMAIrnLQhHMxeE3fJ0BWCnZdSxpQR71DghooLpPSyStMbZ4oI
2ZDfEtDWMORQmk6z7UcTThry48Eu4ygK6g41RYPzmwQwzrRmhB0TM7h5rMWUR+Um
2FLdDunz4CiAMAOu9GHxHd/m
=dQP3
-----END PGP SIGNATURE-----

--NAGGUAWeqlydYaYnwmTOeBc67Saj0vC33--
