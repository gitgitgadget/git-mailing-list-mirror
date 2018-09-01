Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22ED31F404
	for <e@80x24.org>; Sat,  1 Sep 2018 04:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeIAIox (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 04:44:53 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34768 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeIAIox (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 04:44:53 -0400
Received: by mail-pg1-f173.google.com with SMTP id d19-v6so6300712pgv.1
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 21:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=00Hc1tUyuoSDOgu6FbCYB34PJaZ46JFq2y0Yq+2PcaQ=;
        b=ac4MiB/JPoE+tTHH2pa7Kw3PZmFO4pwpLy32cSBleIOCFh1lyy8yVAmUNx3XH0RKQy
         WXkMZSNeehCHIbEgzlI+4lLGfRdhISfGzBh+osEFaa6o140tuItstvpyBz1hVPOKP7dY
         lKn+VUSRryFwC3/wsbKNWs4VIgF+Y34FIVsat1be9TcJ8wRiYOpb3hasAaEMGG/+KRVX
         TXvJz0HgtG1CQI2qIKGdQMNOMuYHbGXWbBzD6IAlh8kfvgIjqoFdvdC6BDayxg6cNYtr
         y0Uksv1rZc+MkZdd8psJbo520cUISvSLYxjZltOlJ3ZVdLz4IGGkQDJJmxM/vqi12XzL
         1Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:autocrypt:subject:to:cc:from
         :message-id;
        bh=00Hc1tUyuoSDOgu6FbCYB34PJaZ46JFq2y0Yq+2PcaQ=;
        b=iclfbxNyQf1E5/zXvOcfbYCURblNbpI72iak5FEaY+91+veGFURwerZuZsyED6DbDp
         DcrQP0uno98I8sUHSDeri2ZReWFLDX0l3Y7EkwtnT+VDb62oR5lGebL9UwEFrciImUwe
         awwGXwy4337k9Kj1j7YJXxM1oGjXoisPq57XIMCgKMv79DVGtxN47Kw8dXSOY63mggeY
         vVMZLUBDiW+XhePODrqBqs+WKqsiwjrcO49qTvpDWagSW7pW7t3HUDYEgNvlTN84RyFs
         rWBXiWpx2unnk28bnxxfy4fuf6DPVsS/CcledKPrV/EPaVKgBWpuPF9lfSqw69OT4qbt
         9atQ==
X-Gm-Message-State: APzg51A0moCDlRHsXa15SJSfCj6XoTSaF4k0cDxSwZmjFz5UYajx+6qm
        7oOEwKW/d52sINFPHJG6DwA=
X-Google-Smtp-Source: ANB0VdZdrhJfJDGKnIWY7tRPRrOB3+rpaVXUJ9g4lqQLRFesXCLAR1YiVNrFAbjl6mma/0gKUZ5WCw==
X-Received: by 2002:a62:411a:: with SMTP id o26-v6mr19364137pfa.111.1535776458170;
        Fri, 31 Aug 2018 21:34:18 -0700 (PDT)
Received: from [100.122.255.26] ([27.62.46.37])
        by smtp.gmail.com with ESMTPSA id k8-v6sm32099682pga.80.2018.08.31.21.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 21:34:17 -0700 (PDT)
Date:   Sat, 01 Sep 2018 10:02:09 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <CABPp-BE43kFwRZ90-EWB9Em6xk-T=QfNXCepY=0O5OYYZe-qAg@mail.gmail.com>
References: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com> <CABPp-BG1VCmCMHe=5qayS0G_Z_=e8aVQ121LWuo-OBuiUxiCYg@mail.gmail.com> <xmqqzhx36er2.fsf@gitster-ct.c.googlers.com> <CABPp-BE43kFwRZ90-EWB9Em6xk-T=QfNXCepY=0O5OYYZe-qAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=kaartic.sivaraam@gmail.com; keydata=mQINBFnvIZcBEACjJC0cawLg
 zPXd2EGPtDQ+HvmrUSLd9TrbUabqiT/YeXGgkYaP3DHwauNeLR0cfJhw20cyftoCq7qU6cDtCXcm
 Bb5JzttvrT+4y6RcvoxTsw22i5TYxzZ/O2d9AVov0Jj8JH/L00wZfHExhXok8Qlr9wyU70z9N8GL
 jaABWevzqrN2eNdV6vdNv7wJFZBTNz4SnNNnHQhAf2ypBgTFQGzQe8Dq5S8YxOZQm6TMFKjXgK6f
 Qy3AuoIk1yOIXkv5tc7LzOIEoiMAnQZ4u8BmOgyXW7s4Uvw+j9yuhXGEdqfU4Sfd6EaRNHIPXueE
 XmsErqamBaQ2anomRdVbroife/jILhxhVYRnkGe+PzJa98csS7aDXWAYxiHJHYJdlcqSre5XpfqM
 0Tqf1CWiEEitNCoKciWywa+EC3bA0cEug/ckF8YcLO9C9sRCg+20e9PMg1Aa3lhftJBQSG3oQ15b
 vMVZ7Vx4/H9LUJL/j5+iMRK8H0Zrg2m5Bxx/JRzBn0wzdmsEaP+1J0NYRqt56dPNULRIsHdGTP22
 Ma/irqNxTX7nBTb+vwXebz6PHiO1gm1wu46tosOI0tfFvAvf/2HsgaYUUffltNcTh21IQVtbCjF2
 TYcYRVeT/rcZ4WpUcIE8MP9Y+GIRffveumBm3ymBv8527BKpUdIkUktD823bFUEUgQARAQABtC1L
 YWFydGljIFNpdmFyYWFtIDxrYWFydGljLnNpdmFyYWFtQGdtYWlsLmNvbT6JAlEEEwEIADsCGwMF
 CwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSaunlPpC6CxtSc3Q2951raw9YZaQUCWfnypwAK
 CRC951raw9YZaX7sD/470YpgttrXPvjhg/kQTu4AGQrLkWLqWXPWLHD5U4eeE/P8N3w0jsM+B2tC
 RDiA41VFWR9yRfVSksQLOlTiHlA5fdmqX0Aho8ZcCW6y3i6TSlSF5ug+AjuEnAVRur7LNCah3oPk
 ZpPhQr96EYXYmY+J+fA57MaQk/7BWqxWo/cdZaXu7XfSeFJ3/uxZcmbUXjiBxCZT49CN4pN0GcfL
 +hFKNcv78S3HlDR5/2xdSbRbpxcwwUsx+V4jxI3gQiuu6fxHak5060IJTJ4uX5ckfEQo7Md4tgZu
 3mrHOqojHywHIogOoZ0udmLqmLYBOi7H1aWCi0xhEIvXp3wFlWG4Cs+Zm9e9xpwVP/lPe9+LBBfO
 6FytUI3hrAhVhUwFjfOsugykFJsBKrAXaxkM1fy+ip74NgbEsE6gRTm8Ek41lazPOQ0pQOZ6SPX1
 VNaFV6vz2HWlaCiRLmlsret7U3yMBpcc++PR2gdRUdv2l3krA4ZJLrZITKKKDLplb7GTmkUlbZ/b
 puszjjf40+t/0whyhnoqWuquYUsm2Xv6xasAaImloeOkMZJJ1Ly20sdSCh8rOzqDFAdwu9JHlu4m
 USClwEr8iRzO9yn5bJiFNPNqbBiCtVP2wFrWxRdz6rrk/vjTU2lZsIwO4CJZ6ACQsybzhiwNJXOi
 ++mLMMEFyGMT7bQxIbkCDQRZ7yGXARAA4Dll9pMQUa47gquU+blPhhlqrW4UjGzWe+gjKkxTp1em
 UaG2fIPfW9ymmDAXQhC8q/eYyHoEmnJ5lyrNbzxxcNzd9ugFd70aZBQTtW3qlzfUBeMV3wyCtMkN
 nE702ZtYJkvzNJxmEem5vPlCW9gLsNuNFwo358lG9iKBIR+oachlikxsN0+tocqe4XG+KAh08Fen
 IAjyWidFoX2LQUvuSXX7O0brUg9VbMKTHSTWuZEUqELJUFPjQVV8NlgvLRSgz8xTNI+QVybbay1Z
 NUrI6hKG6GavRibPuAhtEsJ+SMS8lYRk4FkyFOZfpJhKv4uuIbUSO4MBffIsj92qAWw0Xt400NaK
 wh/UOXYS5Rs8o0MCM/Vxa9AYbP5UvhYVb4W4/JDAZXy5o/1myNUqpDw8JG4uXYYtxUpo+OaogdJh
 WT3n3sb7xwFEod/T0Zgttlh3PVnEiXuUsrB+Z0JYZw3/nZXw8rBmh1fC735v4t+U9s5YLKVePWvH
 r12TSV31aTUbZuHDL6fRi93uEqm96VghmkMbSziv3iX+v8RkM93l+w7pd0rYUy6H3cUDV9q29DLo
 9BOFCUzR9enskWQA4ezSx4AV3boNuVFMsFhxgdDqkyqkm+qsSq/wYnsIT2uvcg2lqgNyIER4Cezz
 PgXj7sNcXfvFedyAmsiOARt+oIIFjykAEQEAAYkCPAQYAQgAJhYhBJq6eU+kLoLG1JzdDb3nWtrD
 1hlpBQJZ7yGXAhsMBQkFucBRAAoJEL3nWtrD1hlpPfsP/j4ewvV1q6ZuBx+IAzHCFpZ60+yyJmHR
 lwwxlFjjFe9pV+r1/Zb4WxUNbTSyAP65zlTsOXK8nlR0AKXhtjdnI2mUrMuHcZgug4vz3NCDgWVe
 By70n1kunQJpNc+FEFYZEdRbPpNGWfaMnr5wVtr/O4aPq4sTxs1IV6/MUL+tyuqDpzAnpj3deZ/R
 siVHjNNwD0hs6nkRoHOjgmi5rUgrebNbJxxTMhJk8OfLcsxx/FPY+6Myjnis3dxFCFR37vjSjm9G
 SRRTxlI5Mq+jGgvag9Ww/nueTxFMUgXWQ6m/aws/FnXBImA8EC9MNjH8ZGUN2oThrnbzlBpBnfkC
 zriCtKxBjxP1ZeDeBuWoI1eZzeXIa+yx1EbLoRcnNCNVFE2dHgYbdhFFzR+lvJOOI0BdvO/wWS6z
 ZRi5vLE0EQJX81Glsj6aY4+sIc83NsTaNpaIqIbYIzp/wNN4uUzah6XcnVQCm3OtfhW+scjdqUhv
 ihDeWlf684OUTf7huTfYbWOE+DzAT+hrs0oaEXuVlUBBYkZ4Hv7M8LuQGn64pFrm4grbF/wxkmvg
 eyBTQA/A9WNWndlinlFYiZGmDoiZUAcSKA9oBTPc4jXwW/YIfNYwd7SlatiwKjF1QxuL1X0QMMPs
 tR/UoVc3sbiabb4Km5jS2oU9q6KpeikRshMIIZ7P/DJ/
Subject: Re: What's cooking in git.git (Aug 2018, #06; Wed, 29)
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     Git Mailing List <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <9C8E369D-CC7C-4030-B02A-287F4CCD6712@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30 August 2018 21:41:35 GMT+05:30, Elijah Newren <newren@gmail=2Ecom> w=
rote:
>That makes sense=2E  I'm not sure I can concisely convey all the right
>points, but here's a stab at rewording:
>
>Recent addition of "directory rename" heuristics to the
>merge-recursive backend makes the command susceptible to false
>positives and false negatives=2E  In the context of "git am -3", which
>does not know about surrounding unmodified paths and thus cannot
>inform the merge machinery about the full trees involved, this risk is
>particularly severe=2E  As such, the heuristic is disabled for "git am
>-3" to keep the machinery "more stupid but predictable"=2E

FWIW, this sounds better to me than the original=2E
--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
