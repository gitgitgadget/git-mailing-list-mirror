Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47590C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144652067D
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="Iclv2IZM";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="VL91MTxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgERJoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:44:02 -0400
Received: from ns3309586.ip-5-135-160.eu ([5.135.160.121]:34552 "EHLO
        mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgERJoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:44:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id E9D454034B;
        Mon, 18 May 2020 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589795040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxl9SZT5yfsDpuxDDjyR9jo4QQR/CWlhw4Ek647yjfA=;
        b=Iclv2IZMkWyAv9ZXJHHX21iV3TeG9zcKQEpYu9QDmAnSKrWmVxlnGJodzM8VLdXd6Lwcfu
        rMpvFV211WiL8Gob7pY3p3gb6elvgAcZuhYyB0dcGej6vpyjLHljWTQOvMIpL3aZCXRDTJ
        AQ1gUaP7oPBqj/kvqbIuGWdW9o5anmA=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id A46CF3FFDA;
        Mon, 18 May 2020 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589795039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxl9SZT5yfsDpuxDDjyR9jo4QQR/CWlhw4Ek647yjfA=;
        b=VL91MTxu/EXF8cAgMF2BjywFt+Gc/+Js+QqyBMMw4GoxIyTlMPclyHIp+gVXZy8ZijQ8Zs
        B4Xtm8hkM5y6VgXYcRtsgYqo+eLHeV9TQFBicKZIpzMIAgAi933s3pp+Z/W+Ar+dx8VwOD
        0dEaqMR8mjpp/ROthYfldtR3II5fLIg=
Date:   Mon, 18 May 2020 11:43:59 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v4] diff: add config option relative
Message-ID: <20200518094359.GB2069@spk-laptop>
References: <20200515155706.GA1165062@spk-laptop>
 <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com>
 <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
 <20200516194033.GA2252@spk-laptop>
 <20200517021452.GA2114@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200517021452.GA2114@danh.dev>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Sun, May 17, 2020 at 09:14:52AM +0700, Đoàn Trần Công Danh wrote:
> Above comment also applied here.
> And remove this debug cat.

Oops thanks for the review I've submitted a v5 for review let me know if I
responded to all your feedbacks

-- 
Laurent
