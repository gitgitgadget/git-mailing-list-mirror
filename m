Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59BA620985
	for <e@80x24.org>; Mon, 12 Sep 2016 19:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbcILT2Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:28:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34826 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbcILT2X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:28:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id a6so15057225wmc.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=0rPT/glDjn7w+flKVIJ+vcXaaqLZ4jItZL7PthePJwg=;
        b=l8QwmBBxbVimyMTbl/YvnvToCnPv+y5+cYTW265UiX4axJAEAfRcQVPIJoMH//WiDr
         aGa6wDPxqsdTtfHL5WaaAuI/QOUv2WZaykBFeeQ+wODRrv9AGZ9mNkd4FzKuF157IoQC
         JsnvJyLh90jqXYJ6+coNedEOdiRcB295XyKivkiCSjTHV7XWDuyPJN4whfjSRuSACuJs
         T6I9B55Z63qgkZEmAUnCgUTinWuEgzRAyCw1OBJsvBwiVaDJ+M8tj1wvSWGBRRe7oKN4
         /IIilVjrpuCZysc3zWoilnrDCQhToTd5FhrExGz+1L/Xpa1RMYn2Vv9xBhcGQVVI+ufe
         U1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0rPT/glDjn7w+flKVIJ+vcXaaqLZ4jItZL7PthePJwg=;
        b=NJ+n5/r4CJDo8LoHLaZFXLr17ug1FjVyDO2n7jZ52h6p8P5gKB9cJGD07zm+ZVla+V
         1DVOSKEb9AvpQuV4GageoasSOGIWPOOT2OAxniEA+ngn/y6r4hQFYfUzsDempna2LZJK
         ArfnbONvLz2ssui76HzZ7F7WOPNFJ3YBKgTTrvqOSoGKiTd/YlXA6ry7O5pqHV1arURc
         v6SI4Ch8IXTir3zI9l3GTeEwK66t/OJDMKXGq+VVEeoPZa2y1GNmT6P8Sh48U3I5lFpq
         r2JDQHiPEu0BwddUBKh391ikiOWqh01x2MCrgVdvNUaB/284ZMbOiJATPGYV5W0p0eKA
         ySrg==
X-Gm-Message-State: AE9vXwP0Q+f46tCE2Gk65nHMHCAsDfFg77Equxm3V572rgIAygIRTAE7j9oS4TGZko1cw8f0ag2btpU25zaa9w==
X-Received: by 10.28.63.84 with SMTP id m81mr1555231wma.88.1473708501882; Mon,
 12 Sep 2016 12:28:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.85.12 with HTTP; Mon, 12 Sep 2016 12:28:21 -0700 (PDT)
From:   Michael Felt <aixtools@gmail.com>
Date:   Mon, 12 Sep 2016 21:28:21 +0200
Message-ID: <CANvxniXkbAKgjm+NZ0cyyCToEYp23Kd8s4yxSqUOsAUAHJSA7g@mail.gmail.com>
Subject: build issues on AIX - aka non-GNU environment, no gnu grep, no gcc
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had a couple of issues when packaging git for AIX
a) option -Wall by default - works fine with gcc I am sure, but not so
well when gcc is not your compiler
b) needs a special (GNU) grep argument (-a from memory). This I
resolved by downloading and packaging GNU grep. However, I hope this
has not introduced a new dependency.

FYI: as I recall, the last time I build git (2.6.4 I believe) I had
neither of these problems (although I did later find I had once upon a
time packaged, just never published grep-2.22)

Also, if you wish to add my aixtools as a place to get git packaged
for AIX - just get in touch and we can exchange details.

Michael
