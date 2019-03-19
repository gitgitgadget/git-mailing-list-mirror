Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MISSING_SUBJECT,PI_EMPTY_SUBJ,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B9820248
	for <e@80x24.org>; Tue, 19 Mar 2019 04:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfCSEQ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 00:16:58 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52825 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSEQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 00:16:58 -0400
Received: by mail-wm1-f44.google.com with SMTP id a184so1154625wma.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 21:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:mime-version:content-transfer-encoding;
        bh=5DZ+53cPfkSM0JebVyixQ2ugrHJkJo+ee3jAN3u8drU=;
        b=exDlGwfra8yC6HNFT3ZRPvvYyxD7gHKN1r0Jc2s/v2hvyAjadqObaTzEOwLt5bVN7v
         goMIF1kd0fabbO7XGC9AetNT8NwDvG2e4zyjyQacQaTjCPA+qVsDkFvVfFz+8r92+Jcv
         yRYVckm4eY3jFBk1eP9zQgFTbVn4MuqSCanBPZ/soXAYqZ7JgLcsaAsBYkUOaGMEC5c6
         /P9Yf9u7NLt3ZmVfcJm+hFs7Xc/FiIRBj1iBq+d99BTCysV0y4rZM0vzCX5PTM37c9Ka
         589D3TTqFkq9WcsXQiXeftynaXNWKKF20lZ6aOZj1D01ku6nW5aWDQFR8SZfbWLiPxCN
         X0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:mime-version
         :content-transfer-encoding;
        bh=5DZ+53cPfkSM0JebVyixQ2ugrHJkJo+ee3jAN3u8drU=;
        b=Nos/cQrBllNbcB5V+FNXlFjdyNKf4JG5yGsejuJgcY0YI1ccE4ltxjeVBZT5IZk9VL
         +x8TrE1IInbaRUmqMcg9A/IscECc5ABL4UXv1Bua/FNtN65gfnqdSAFvT9P+ynKFnwqd
         ByBpEX0KNWfqA1i3FNEMkvsS6bdkhJLmWGWUda64UITCYMbBFHb/HExecorsAxVeDHHn
         tGEiPJ61PmwlV16hrKcSS4Kn0EkxANAzdM0oz87y8gTF+PisaE5ldvdTbEzKMiGsUVU5
         FPfAm0FbQ/ZhMqRaA+IG/ZGrAuAjZ2jNf7quGlJ1Pnn/zSEffOuKXKUOFTnrqrGef7K9
         dbOA==
X-Gm-Message-State: APjAAAXJ4NK2NEfPJljbvvxPUVdFBXt1GRVx4PBmSK3BsOAz/yM+ks7s
        ECrQoLdxHxi8TVA845hblFfz9VU8SdP/
X-Google-Smtp-Source: APXvYqzebZvt6MGxogOtIJ0+t22Xqz7EG4HXyoyPS/RF05VCWx8Ou/JjZWXASomAB7me/sCZI+WKSw==
X-Received: by 2002:a1c:9ad3:: with SMTP id c202mr1543914wme.83.1552969016003;
        Mon, 18 Mar 2019 21:16:56 -0700 (PDT)
Received: from [10.245.64.238] ([95.184.64.238])
        by smtp.gmail.com with ESMTPSA id 26sm919955wmg.42.2019.03.18.21.16.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 21:16:55 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:16:52 +0300
X-Priority: 3
Message-ID: <-potul3h9iywxth7zw8-4aal8p-wg88th-bcter6-bftk8c-you1szm5fo5vaj5uxnoif7ns-usqs3q-4nifud-ei80sfbtjt4gq8foxrw9vcp0ki9fxn9wpd3nwzkju6vf0i2jyg0s62tup95b-oe92pp.1552969012418@email.android.com>
From:   =?UTF-8?B?2K3ZhdivINin2YTYudmI2YrYsw==?= <hmoode.1413.90@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgrZhdmP2LHYs9mEINmF2YYg2YfYp9iq2YEgSHVhd2VpINin2YTYrtin2LUg2KjZig==

