Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9DBB21841
	for <e@80x24.org>; Tue,  1 May 2018 11:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeEALZv (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:25:51 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:45394 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbeEALZt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:25:49 -0400
Received: by mail-pf0-f182.google.com with SMTP id c10so8928640pfi.12
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=X5ZVJDuUwZSWhU/nI8is3y4WuG2bM62Py6IH6UV8pfE=;
        b=HeOJbPECXToi2HJSc1O1u/M/0K7pgDXvK1sStQu/mxctHUj3jWPAnlXg1jD6T9FOmj
         ymRl7z32nlASdD6SDNitz0bmU+uKQgBMimYfeZ3xJ5QHUlivwo5795/p0Xj2wQW77W85
         XjRXOkuvo/4uj4gPBhaFvtiAq3IpO4IlH/OqGaeYQZknwGkNUhEk+JQztJJecHns5VHb
         3I1uQNZuhOmQs1/HEf8kIMgN4LuyQUxmp39CzYD04O6zDrpjaIkJHj+5kx6NwCCRmZWL
         NoEacc5VXQgWUlrK1cG7kHuT3p4gLf8Yz3cnOlosCWpnUDyNhn3WN86LxlOdKuSX2NPx
         PoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=X5ZVJDuUwZSWhU/nI8is3y4WuG2bM62Py6IH6UV8pfE=;
        b=mKIr1EUOqapQTBChjgreyPsHRDLslpcPh+n/qShB3cIryMOXzWCvTtBHkU18r+D6tI
         GCE8zRuF7f96sZyF2Ax43w/+WXfCjAWCleTB7sSdI1jRhqKtlGgsSzX5Zh+ohklGzeuA
         GmmBo/bs5s8GLfyf7vVuUqOfyUGyv0JNJuDQx9fYrKArVa6/rdgzibK13P24GGIfJOL9
         rrVqmknmB5EgP/w7/hCr0q29BKHn0JwD3Le8RQjwAAz6r6k6Jyk7fx2xQ6dTwyJ07Hm8
         gcntAD7qLgUTMyC2TfaBe9JgUA8ZPpJSHWUTcHrYCpduuKvw3KeUJTlYnMPoO4ZK2JVI
         fnpg==
X-Gm-Message-State: ALQs6tAatgoouEtVER++6jjagJHt/5W3TT12l9LL3gU82dJ0D/tjHur0
        JZ8KqP5DaABn/bC2WrC0MFMuiPvu
X-Google-Smtp-Source: AB8JxZqDxnQmgUaRDPtSYCdIroueFWun4yb2vPkObUybugYE/JZHHi6icwMk0fmfufbEHdc5zgixGA==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17-v6mr16117128plo.182.1525173948923;
        Tue, 01 May 2018 04:25:48 -0700 (PDT)
Received: from [192.168.206.101] ([117.251.224.161])
        by smtp.gmail.com with ESMTPSA id z62sm20689639pff.57.2018.05.01.04.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 04:25:47 -0700 (PDT)
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
To:     Johannes Sixt <j6t@kdbg.org>, phillip.wood@dunelm.org.uk,
        Git Mailing List <git@vger.kernel.org>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
 <36d622ac-f07d-7fd9-65dd-94f88b0e2f56@talktalk.net>
 <523dfe75-45a2-d780-2581-1bdc076dd659@kdbg.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <96c519e7-b05f-a883-a536-425b4b341cb8@gmail.com>
Date:   Tue, 1 May 2018 16:55:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <523dfe75-45a2-d780-2581-1bdc076dd659@kdbg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d7DG5RXmekZgl5b0zc5VsSanWuOS7il98"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d7DG5RXmekZgl5b0zc5VsSanWuOS7il98
Content-Type: multipart/mixed; boundary="VeQnHJskpkX2bY0R2ijnQqzRBHYLBQsH7";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>, phillip.wood@dunelm.org.uk,
 Git Mailing List <git@vger.kernel.org>
Message-ID: <96c519e7-b05f-a883-a536-425b4b341cb8@gmail.com>
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
 <36d622ac-f07d-7fd9-65dd-94f88b0e2f56@talktalk.net>
 <523dfe75-45a2-d780-2581-1bdc076dd659@kdbg.org>
In-Reply-To: <523dfe75-45a2-d780-2581-1bdc076dd659@kdbg.org>

--VeQnHJskpkX2bY0R2ijnQqzRBHYLBQsH7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Thursday 26 April 2018 01:01 AM, Johannes Sixt wrote:
>=20
> Right. But I have LESS=3DRS because I do *not* want it to remain on scr=
een
> by default.
>=20

In that case how about updating the commit message to be more clear
about it. How about,

	It is possible to configure 'less', the pager, to use an
	alternate screen to show the content. When it is closed in this
	case, it switches back to the original screen, and all content
	is gone.

--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky

KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--VeQnHJskpkX2bY0R2ijnQqzRBHYLBQsH7--

--d7DG5RXmekZgl5b0zc5VsSanWuOS7il98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlroTrMACgkQveda2sPW
GWlXRw//SXgErS5zrgFcZQ5yFXyZZr7QTWCV7fFIHAqm8uzD82ctuiF9/ZjljiUO
nTlIwnsVZBnNdmnOqaX3KnLasCZ1pLMBgpRJIkaauZaX1MXqhyHNnNdL/+6bj6P8
trZZEuDCj3tGmHHWFhsGyKGXs6PvDalPVsXQKLtT8xrsVF0dXkh2xybXiCk7zLZ3
CyArpy2aWNY7Rhec5dQh2S1mJcp1Uz9UkFBPKYhFE0loQ+392eTRYsUPCn/GqAvU
uqMYgN7e81Vly4itetzYn7hWpKf67APqbbynDuTr4tM4M11QGwSanFFnek/Ic0XV
3w668B8lF4hl8hidT72lYHd1Yxv/gmRUJxROWd3jeHOoF4dVGDLrMhsRTjsCitqF
7Q+swT+rqndEEX/EaQUeW1mqhlPXp/aG0mgTKM+ekJZl8vuSbPnfxda1Sowqw/Cf
DYVRTCl7khTKsQHM93HebltLoPZTXJcg67dwRMaxP06tcnzsQyrCrSuCzhlui3V6
Ofi2m2Loiict8MM2o/MJ05DsjkLSA948p1i8wbb0HeFvvPRjwuY3R/NRfBDZh0v6
Gd0F8TTVNOfvo7Fn5nERuFLXVxyB8t0Ur87bX9zh70ZLEd6tbSZRak17wd/+7sU3
U6okoFjr9YpD1+MfWBLntELKYC6uvTktZlVANv0apqFumWXD+zs=
=iH5d
-----END PGP SIGNATURE-----

--d7DG5RXmekZgl5b0zc5VsSanWuOS7il98--
