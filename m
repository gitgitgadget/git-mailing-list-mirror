Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C131F42E
	for <e@80x24.org>; Mon,  7 May 2018 10:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEGKJu (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 06:09:50 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39004 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEGKJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 06:09:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id a22so8384749pfn.6
        for <git@vger.kernel.org>; Mon, 07 May 2018 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=xzzHqZ3VUH9qJKELp6/BYfeuA68fNbVl4747NN8lDe4=;
        b=kxRRe/vDyTEWfQe7W0Lzujyse/+7JVxFtduMKna5Y+J57SkIrelbeWI4daG9FJBwn0
         a1TUFFWd8i5sSAwy3swKGZoGSc5gMtR8CpM5F0mSBUwTTy4bEDRZjEvA9G0S1yasKb6g
         KHOpB8X9ilRm6nNMv+SheRwLqjOqpuab0x7UkIpyfH2QzU6LZ8Sj4hsquNd5GKXO0Vik
         adANovKgYcT0sT3+BqObeILyn5QHvUVONueSjwjDz2RP+p8wn/WHiqEY3YRIQAD3mM+1
         1o3z8mPXW6rrvPAzTjn/klS/0g/KCzZPons8j3PbPK8hBVogiCEEerTH9dNd3cwq6OWj
         VyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=xzzHqZ3VUH9qJKELp6/BYfeuA68fNbVl4747NN8lDe4=;
        b=CNeg0cPb3cQdbwn2Nf3sn74W2bWYCDOdu1vJjMwkoukAos47TmKNQ86E4SgI/7hozM
         XqB25641XhQogOBasqCj+ilj5+PgkdGa+KQ5knXzxCIztYsY869iJLCy89g34mlDGm00
         42YqgOb9kSgQ8hnmU1q+dy14fMarGNG7FkJNw+GlzQLFQ51xTvSfnpIPkrj3vZ7U3WlT
         5kgZ3STC+fRE+558k5f3c1v/XkxJU+lQY35GPKeTjVMYlk5LVfyoQ1YLLR79vhsUEUDa
         Sq5uqodFo6BaTn5anQaqyNM6QEGJegjMwg+Q1a2g7BzRM8oD8n5uYvIptGEHLEm5XQ+7
         3b+g==
X-Gm-Message-State: ALQs6tCyZaS10JgLEWYm0ouujX8Tc0ooTMZr0TAHaV8kNZ6DMJkPIeg0
        y7/QCDwhcmg8h4Ku4WcU5rw=
X-Google-Smtp-Source: AB8JxZo+OEMwfvaL5cj6hcTR9k8zCQAtNhBGz4a6AHP4lbFZsvjQUN4xsQffXbsl7azU2Yff66G+Lg==
X-Received: by 2002:a63:69c4:: with SMTP id e187-v6mr29710289pgc.415.1525687788050;
        Mon, 07 May 2018 03:09:48 -0700 (PDT)
Received: from [192.168.206.100] ([117.251.233.201])
        by smtp.gmail.com with ESMTPSA id m72sm23591615pfk.110.2018.05.07.03.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 03:09:47 -0700 (PDT)
Subject: Re: [PATCH 3/8] push tests: add more testing for forced tag pushing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jeff King <peff@peff.net>
References: <20180429202100.32353-1-avarab@gmail.com>
 <20180429202100.32353-4-avarab@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFnvIZcBEACjJC0cawLgzPXd2EGPtDQ+HvmrUSLd9TrbUabqiT/YeXGgkYaP3DHwauNe
 LR0cfJhw20cyftoCq7qU6cDtCXcmBb5JzttvrT+4y6RcvoxTsw22i5TYxzZ/O2d9AVov0Jj8
 JH/L00wZfHExhXok8Qlr9wyU70z9N8GLjaABWevzqrN2eNdV6vdNv7wJFZBTNz4SnNNnHQhA
 f2ypBgTFQGzQe8Dq5S8YxOZQm6TMFKjXgK6fQy3AuoIk1yOIXkv5tc7LzOIEoiMAnQZ4u8Bm
 OgyXW7s4Uvw+j9yuhXGEdqfU4Sfd6EaRNHIPXueEXmsErqamBaQ2anomRdVbroife/jILhxh
 VYRnkGe+PzJa98csS7aDXWAYxiHJHYJdlcqSre5XpfqM0Tqf1CWiEEitNCoKciWywa+EC3bA
 0cEug/ckF8YcLO9C9sRCg+20e9PMg1Aa3lhftJBQSG3oQ15bvMVZ7Vx4/H9LUJL/j5+iMRK8
 H0Zrg2m5Bxx/JRzBn0wzdmsEaP+1J0NYRqt56dPNULRIsHdGTP22Ma/irqNxTX7nBTb+vwXe
 bz6PHiO1gm1wu46tosOI0tfFvAvf/2HsgaYUUffltNcTh21IQVtbCjF2TYcYRVeT/rcZ4WpU
 cIE8MP9Y+GIRffveumBm3ymBv8527BKpUdIkUktD823bFUEUgQARAQABzS1LYWFydGljIFNp
 dmFyYWFtIDxrYWFydGljLnNpdmFyYWFtQGdtYWlsLmNvbT7CwZEEEwEIADsCGwMFCwkIBwIG
 FQgJCgsCBBYCAwECHgECF4ACGQEWIQSaunlPpC6CxtSc3Q2951raw9YZaQUCWfnypwAKCRC9
 51raw9YZaX7sD/470YpgttrXPvjhg/kQTu4AGQrLkWLqWXPWLHD5U4eeE/P8N3w0jsM+B2tC
 RDiA41VFWR9yRfVSksQLOlTiHlA5fdmqX0Aho8ZcCW6y3i6TSlSF5ug+AjuEnAVRur7LNCah
 3oPkZpPhQr96EYXYmY+J+fA57MaQk/7BWqxWo/cdZaXu7XfSeFJ3/uxZcmbUXjiBxCZT49CN
 4pN0GcfL+hFKNcv78S3HlDR5/2xdSbRbpxcwwUsx+V4jxI3gQiuu6fxHak5060IJTJ4uX5ck
 fEQo7Md4tgZu3mrHOqojHywHIogOoZ0udmLqmLYBOi7H1aWCi0xhEIvXp3wFlWG4Cs+Zm9e9
 xpwVP/lPe9+LBBfO6FytUI3hrAhVhUwFjfOsugykFJsBKrAXaxkM1fy+ip74NgbEsE6gRTm8
 Ek41lazPOQ0pQOZ6SPX1VNaFV6vz2HWlaCiRLmlsret7U3yMBpcc++PR2gdRUdv2l3krA4ZJ
 LrZITKKKDLplb7GTmkUlbZ/bpuszjjf40+t/0whyhnoqWuquYUsm2Xv6xasAaImloeOkMZJJ
 1Ly20sdSCh8rOzqDFAdwu9JHlu4mUSClwEr8iRzO9yn5bJiFNPNqbBiCtVP2wFrWxRdz6rrk
 /vjTU2lZsIwO4CJZ6ACQsybzhiwNJXOi++mLMMEFyGMT7bQxIc7BTQRZ7yGXARAA4Dll9pMQ
 Ua47gquU+blPhhlqrW4UjGzWe+gjKkxTp1emUaG2fIPfW9ymmDAXQhC8q/eYyHoEmnJ5lyrN
 bzxxcNzd9ugFd70aZBQTtW3qlzfUBeMV3wyCtMkNnE702ZtYJkvzNJxmEem5vPlCW9gLsNuN
 Fwo358lG9iKBIR+oachlikxsN0+tocqe4XG+KAh08FenIAjyWidFoX2LQUvuSXX7O0brUg9V
 bMKTHSTWuZEUqELJUFPjQVV8NlgvLRSgz8xTNI+QVybbay1ZNUrI6hKG6GavRibPuAhtEsJ+
 SMS8lYRk4FkyFOZfpJhKv4uuIbUSO4MBffIsj92qAWw0Xt400NaKwh/UOXYS5Rs8o0MCM/Vx
 a9AYbP5UvhYVb4W4/JDAZXy5o/1myNUqpDw8JG4uXYYtxUpo+OaogdJhWT3n3sb7xwFEod/T
 0Zgttlh3PVnEiXuUsrB+Z0JYZw3/nZXw8rBmh1fC735v4t+U9s5YLKVePWvHr12TSV31aTUb
 ZuHDL6fRi93uEqm96VghmkMbSziv3iX+v8RkM93l+w7pd0rYUy6H3cUDV9q29DLo9BOFCUzR
 9enskWQA4ezSx4AV3boNuVFMsFhxgdDqkyqkm+qsSq/wYnsIT2uvcg2lqgNyIER4CezzPgXj
 7sNcXfvFedyAmsiOARt+oIIFjykAEQEAAcLBfAQYAQgAJhYhBJq6eU+kLoLG1JzdDb3nWtrD
 1hlpBQJZ7yGXAhsMBQkFucBRAAoJEL3nWtrD1hlpPfsP/j4ewvV1q6ZuBx+IAzHCFpZ60+yy
 JmHRlwwxlFjjFe9pV+r1/Zb4WxUNbTSyAP65zlTsOXK8nlR0AKXhtjdnI2mUrMuHcZgug4vz
 3NCDgWVeBy70n1kunQJpNc+FEFYZEdRbPpNGWfaMnr5wVtr/O4aPq4sTxs1IV6/MUL+tyuqD
 pzAnpj3deZ/RsiVHjNNwD0hs6nkRoHOjgmi5rUgrebNbJxxTMhJk8OfLcsxx/FPY+6Myjnis
 3dxFCFR37vjSjm9GSRRTxlI5Mq+jGgvag9Ww/nueTxFMUgXWQ6m/aws/FnXBImA8EC9MNjH8
 ZGUN2oThrnbzlBpBnfkCzriCtKxBjxP1ZeDeBuWoI1eZzeXIa+yx1EbLoRcnNCNVFE2dHgYb
 dhFFzR+lvJOOI0BdvO/wWS6zZRi5vLE0EQJX81Glsj6aY4+sIc83NsTaNpaIqIbYIzp/wNN4
 uUzah6XcnVQCm3OtfhW+scjdqUhvihDeWlf684OUTf7huTfYbWOE+DzAT+hrs0oaEXuVlUBB
 YkZ4Hv7M8LuQGn64pFrm4grbF/wxkmvgeyBTQA/A9WNWndlinlFYiZGmDoiZUAcSKA9oBTPc
 4jXwW/YIfNYwd7SlatiwKjF1QxuL1X0QMMPstR/UoVc3sbiabb4Km5jS2oU9q6KpeikRshMI
 IZ7P/DJ/
Message-ID: <a5125d8f-62df-feab-4154-99da7e84af9b@gmail.com>
Date:   Mon, 7 May 2018 15:39:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180429202100.32353-4-avarab@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HeRk5h8bViAfFNxzBMZLCxNuHCJzyg9Nb"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HeRk5h8bViAfFNxzBMZLCxNuHCJzyg9Nb
Content-Type: multipart/mixed; boundary="UwuJQTcypM1zUC6byVAmfQZ6bjelgKFfd";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 git@vger.kernel.org
Cc: Wink Saville <wink@saville.com>, Jacob Keller <jacob.keller@gmail.com>,
 Bryan Turner <bturner@atlassian.com>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Jeff King <peff@peff.net>
Message-ID: <a5125d8f-62df-feab-4154-99da7e84af9b@gmail.com>
Subject: Re: [PATCH 3/8] push tests: add more testing for forced tag pushing
References: <20180429202100.32353-1-avarab@gmail.com>
 <20180429202100.32353-4-avarab@gmail.com>
In-Reply-To: <20180429202100.32353-4-avarab@gmail.com>

--UwuJQTcypM1zUC6byVAmfQZ6bjelgKFfd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On Monday 30 April 2018 01:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 15c8d5a734..c9a2011915 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -981,7 +981,17 @@ test_expect_success 'push requires --force to upda=
te lightweight tag' '

I think the test description has become misleading now that it's testing
for 'force pushing' in general and not just the '--force' option. So, a
better description is needed. Probably, "force pushing required to
update lightweight tag".


>  		git push --force ../child2 Tag &&
>  		git tag -f Tag HEAD~ &&
>  		test_must_fail git push ../child2 Tag &&
> -		git push --force ../child2 Tag
> +		git push --force ../child2 Tag &&
> +		git tag -f Tag &&
> +		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
> +		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
> +		git tag -f Tag HEAD~ &&
> +		git push ../child2 "+refs/tags/*:refs/tags/*" &&

> +		git tag -f Tag &&
> +		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&

This test shouldn't hiding within the tests about force pushing. It
seems to warrant a separate test case to clearly note the behavior that
the "+" in refspec overrides "--no-force". This would help in easily
identifying if this particular behavior is broken or not.


--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky


Sivaraam?

You possibly might have noticed that my signature recently changed from
'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
new signature to be better for several reasons one of which is that the
former signature has a lot of ambiguities in the place I live as it is a
common name (NOTE: it's not a common spelling, just a common name). So,
I switched signatures before it's too late.

That said, I won't mind you calling me 'Kaartic' if you like it [of
course ;-)]. You can always call me using either of the names.


KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--UwuJQTcypM1zUC6byVAmfQZ6bjelgKFfd--

--HeRk5h8bViAfFNxzBMZLCxNuHCJzyg9Nb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrwJeMACgkQveda2sPW
GWmqVw//SUzlMwFIl/6iDSlqkLPx1YNZks7yRUG79Zci4wCb+zWrp81TTrNtm5T7
cD33SWjOKkITKYADsHElzOhMF2ee30KEZiydkPlRa9UXqRzyNJtuB2VdYURmsMv/
59hVdKBBdTp1SPw8iJgl6OxbiA0pZwfXASnEgTX5ausRYJsp/5ThT9T0QHYA/Ee+
xrQ6/Jor2u3/WnciNwQYozW+jngNJi+0m/b5Q0nAnv+hN9oOqMFW/x7e7qccqk6H
OZcjXcx3QHMbM8hsLDNNN6MrLQAXoH0WS9WMD1Lh42XfkFUxIKkJOkx5wnGpH57b
QY8OD2TtQn9oCQiOYCywYwX3qVJ9CtbENXLRCmSKyESA+82toG947igkPOE3P1OQ
nx14u+n5LWDpjNCbAnpn5+5yQ+Se3uA02sd4vZ43v0WcfCCTjWs3FPkQ2w+O1Cfn
EpHWiGnW3pNvQBDRKIMw+z0MNInh034ctjtIrZqC78yTlfqRuinwS2rMpAndKzdK
mbaC+pnFlDVNXBkfEVmm2YeTbVypR70gS3iZYtOwheDrYg+dsCC8tJPwOl7BbmVq
es/TPvAQxECoFGRIcxELP5jzPnoZ43QSrIT6VCSGthDGq3pIo96FrWPw5Bu/Iqmy
Nah5kFpHkVqyfMvQvioVkQqQmFpm/Yq7RbAssy9+J9fNzWfpi5Y=
=vPWH
-----END PGP SIGNATURE-----

--HeRk5h8bViAfFNxzBMZLCxNuHCJzyg9Nb--
