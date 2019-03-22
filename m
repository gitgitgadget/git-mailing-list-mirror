Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C470202BB
	for <e@80x24.org>; Fri, 22 Mar 2019 06:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfCVGC6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 02:02:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:53381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfCVGC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 02:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553234567;
        bh=vWwxELJXqaBjLqx/+vzgGNein7liI3BSOMNRHIlYYgY=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=izDdCUI1Sb3il8H+GW7IbZd3a9eHsQEFCaE8FteZo9EOUn1Vt9weYUU6vqrfAI3aX
         0v9V4eRnBtwIFeZjRI/Eg+4jPb77ampMg2WB2K8cGcs6oGVjxIzo/usFNaSKcVdQo8
         SxQi4DH17RxiRxXjC/xN2n6yDuaxFM2KJODulqWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.67] ([84.118.159.3]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoVvG-1gWTTY3rzO-00gUe7; Fri, 22
 Mar 2019 07:02:47 +0100
Subject: [BUG] Cloning with git HEAD fails for some repositories
Cc:     Takahiro Akashi <takahiro.akashi@linaro.org>,
        Wolfgang Denk <wd@denx.de>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de>
 <20190322005107.GL9937@linaro.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
To:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
Date:   Fri, 22 Mar 2019 07:02:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322005107.GL9937@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:aO21zqdEQuvKyNw5quKLpXAl2CeFlcJSmHto+SHNKmXffo1IeSd
 N8sJ/CDczXhjweGeMmYCCqrbC7QpY6hxasw3fIAXKsp8OB0xA8p1IICK5GWfTMfMZm0Rmgs
 iwCi8KBTASF63mwcWLW/RvpwkKQ7eosz8MbZbzS/RYP2VNLtfmp/1Faw3gQdSqls2PZphqG
 BbVUqt+qA3jvokT1DRDcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zGYkG5A7+QM=:NF0QdKBb3hriWqKVbj0wba
 LEZsskoLIzua9VLW+U8ugI6b9BuxyusPGzx3zMMIq1Gw05bsRuTivJIo0NyC3keHEwoPdsddD
 7h+hRaR/3C+I0Hw7TNzCh0UB2fT6LmsffhXX9iB5NIKunqa1FMEWENcOqTwi+XR05kxV1y9vU
 Nu3D/JZO1Yhjhiolfy1jDJ3ErpY1rpTB+QDO3bNyzNuOyUgS5J26p6nMpztas8VWvUZtIjHJT
 qUfo0ET7JY9atLEgx7WL+iYbSRcm/5cnVkmujfJ0Kd2BXQMh28Fnguv4ePLZcJNCXpLfAZu0h
 dgiBe8Y84M0Pq2oSl0ZX/VrmdJKed5NX2m3QM0YYVR3sQYLupSqnuqSx2WRtMaIk0OLwzEvzE
 DSAKNDJbRA1Dw4JOK5+oKTDDp1Gjf+ZFd03ssoClExezV4hzlFze8dSJXdKHTDyFMZvyEvkXu
 8F6MFILV15bllm4TNi6QOOPbxpn5Sn5IJACLY9gzXP1xcgy02er505YbnRhVY4rsjPeYrRu8F
 pH4xV7l2haMgVpb9eSbgYjLFLkEp/TrKvbcWvzdoy2RyjGcR+6kCa89RF5+o3vibuTLFQQOw9
 4pHVJuDjMcKkQpgRLI4OFk1RwQzvXFIyfqYUl1/qaJS8MeB5VcZNBCnZdlP9aghnLzcXOupU3
 GIqLBumqOUEew3BDMNe+WZ3LLgwSPE4BuMzk+3lDYj9DBJnnq1Vle2P2i22K383U7pX49C3qe
 n66vsqKl5l2UZXxHtFpR9gmlD15pmVyz5knzNohiwtkQF0o44pFCOTZKwXJXokbR6zHEeraAT
 k2a/cfdW4GLGpWxXeJSw71PL77yczpPg6l/svfWhJGgrSm96aOCunSmIjHZ7WtSm3AI6Mqk58
 zN/BC/uwamjOjxgNRnLFjFXrKd2d/ruk0sPOyoJcCaVncqLUNio+1z9vJK0Fylbd6imzzpx2t
 7ciTYF2BsFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initial cloning via

    git clone http://git.denx.de/u-boot-efi.git

fails with git version 2.21.0.196.g041f5ea1cf

git version 2.1.4 works fine.

Bisection points to this first bad commit:
17966c0a63d25b1cc2dd1e98d30873e643bd581f
http: avoid disconnecting on 404s for loose objects

Please, fix the regression.

$ git clone http://git.denx.de/u-boot-efi.git
Cloning into 'u-boot-efi'...
warning: alternate disabled by http.followRedirects:
http://git.denx.de/u-boot.git/
error: Unable to find a00d15757d7a513e410f15f2f910cb52333361a3 under
http://git.denx.de/u-boot-efi.git
Cannot obtain needed object a00d15757d7a513e410f15f2f910cb52333361a3
error: fetch failed.
$ git clone git://git.denx.de/u-boot-efi.git
Cloning into 'u-boot-efi'...
remote: Counting objects: 602001, done.
remote: Compressing objects: 100% (96111/96111), done.
remote: Total 602001 (delta 498315), reused 600868 (delta 497450)
Receiving objects: 100% (602001/602001), 120.33 MiB | 11.28 MiB/s, done.
Resolving deltas: 100% (498315/498315), done.
$ cd u-boot-efi/
/u-boot-efi$ git remote remove origin
/u-boot-efi$ git remote add origin http://git.denx.de/u-boot-efi.git
/u-boot-efi$ git fetch
From http://git.denx.de/u-boot-efi
 * [new branch]            efi-2019-04 -> origin/efi-2019-04
 * [new branch]            efi-2019-07 -> origin/efi-2019-07
 * [new branch]            master      -> origin/master
/u-boot-efi$

Setting

    git config --global \
    http.http://git.denx.de/u-boot-efi.git.followRedirects true

avoids the warning but does not solve the problem:

$ git clone http://git.denx.de/u-boot-efi.git
Cloning into 'u-boot-efi'...
warning: adding alternate object store: http://git.denx.de/u-boot.git/
error: Unable to find a00d15757d7a513e410f15f2f910cb52333361a3 under
http://git.denx.de/u-boot-efi.git
Cannot obtain needed object a00d15757d7a513e410f15f2f910cb52333361a3
error: fetch failed.

Best regards

Heinrich
