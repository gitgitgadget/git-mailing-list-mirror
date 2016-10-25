Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B175D2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 21:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755284AbcJYVsq (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 17:48:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40905 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbcJYVsp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 17:48:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id b80so2137857wme.7
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=busXe2Nocd8SgWeLEkvxvi4YVcBU9KxBD1OFQtaiKlo=;
        b=vfe75uMo5n08o+i9wB1h2Xo8MyYxX7jz6w6i45Hfe32Ardr/aNuytMRA3CmOKIQU5G
         gCRVX+vSi/tHDeD5Qjh3MXDQ7GzaUOBSVsPuiBriHNTdJONARPj/rVUYe58SzK2VmIG6
         JKAuthjt+Yk7jaNHSthwxah7H7fpnaE8gDhDm09qdcxXz4UlZ4UDc3tpGhwc5EsTuEMV
         gpE1BTw+K0OCcNIxYtW35AAQ0SewMvG2HWVne73vPMJcg9fSksR+dj6Xe4wQs6HSVEJs
         Kb61OCZtM7FRgF1+ogI8wObSzN5eKKpJzDaLnHGwF22YTz9gZwg0HxXKSL9F5fCYgKFB
         c1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=busXe2Nocd8SgWeLEkvxvi4YVcBU9KxBD1OFQtaiKlo=;
        b=i7owG9tdOjfqiZlJbaiu9Pt2Bwd0wktOlGWA1atH+barvJUBFTif5Dk0sqVCncQUnf
         0jfHsioDcZE5MsouHH3bMDUni+OKxtsjUp9e6CrEvtLRIGbFedDej89p/apKKVBVtGG1
         HuG+SJGeLTMOOBw2b1qNKBX9nR2xouqsgls+Iwl2FzzV1NwtuTxPSIMNpVknEk+ZkVLV
         cnxQsCsXiYcDH/j+qi0wDLfr6jt50NsoPI5fDgdJqlXUF2OleNOPLiQEBiEoKXaVnc+Y
         qybFnpCFyqWanaNCo+0TkzDQ76V/wJderKSuZcPk3RYSeW5uoMfKO8TR+zbDfUagOyUe
         eMow==
X-Gm-Message-State: ABUngvdiO+z3J1H2n0m2nBSkCuJr8p8+vLQ3eOoMKEvWqu4kwbZ6sjmB7bN5uf4wNOaHFQ==
X-Received: by 10.28.24.80 with SMTP id 77mr5540263wmy.74.1477432124285;
        Tue, 25 Oct 2016 14:48:44 -0700 (PDT)
Received: from neu9p9lyz1.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id au8sm27196942wjc.12.2016.10.25.14.48.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Oct 2016 14:48:43 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 0/3] quick reroll of Lars's git_open() w/ O_CLOEXEC
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161025181621.4201-1-gitster@pobox.com>
Date:   Tue, 25 Oct 2016 23:48:42 +0200
Cc:     git <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6C42931-835D-42FD-B4D9-7F84921909E2@gmail.com>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox> <20161025181621.4201-1-gitster@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Oct 2016, at 20:16, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Here is to make sure everybody is on the same page regarding the
> series.  The patches are adjusted for comments from Eric and Dscho.

Thank you, Junio! Your v3 looks good to me and I compiled and tested
it on Windows.

There is one catch though:
I ran the tests multiple times on Windows and I noticed that the
following test seems flaky:
t0021 `required process filter should be used only for "clean" operation =
only'

This flaky-ness was not introduced by your v3. I was able to reproduce
the same behavior for v2. I wonder why I did not noticed that before.=20
The only difference to before is that my Windows machines does some=20
heavy CPU/network task in the background now (I can't/don't want to
stop that ATM).

Here is the relevant part of the log:

++ rm -f rot13-filter.log
++ git checkout --quiet --no-progress .
+ test_eval_ret_=3D255
+ want_trace
+ test t =3D t
+ test t =3D t
+ set +x
error: last command exited with $?=3D255

Looks like Git exists with 255. Any idea why that might happen?

@Dscho/Johannes: Can you try this on your Windows machines?

Thanks,
Lars


