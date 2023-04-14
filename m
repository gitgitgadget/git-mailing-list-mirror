Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C227AC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 08:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDNIaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjDNI3w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 04:29:52 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF4F901D
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 01:29:34 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id mb2so1082423qvb.10
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681460972; x=1684052972;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLUI9YlzqQO86ZI5zNo3VRTX+JioyZ8RjeyaguOLuik=;
        b=XC1YxTGAF3Fbc3MJ+ELngiCbZmQ3WG7BlhVgH/ZLw/PGfd8UgLuagTtAi6Maq6v437
         rv64+kk6leI9tQJIUaaGJr0OsbNY6yY+f9MwFzVQJoxFdDIBa5IB+bgqbxsO6ojdY4c+
         E9RtbMefcYBs8xS/Y00JUt6Lu3+VbW8FAnHIEENaZ+1SgKQbeA3HS0r3wzXQaG28SW+O
         UKCAf160TQGE0GZmWPELys307zz0d47s9YDTzsZFKNrhePhT/qh8lpdzOVjfxR5y69tE
         EAua/X/BI3gGEEg40k0cEq2qswSp7VXLvHyEIG5a7HNr4Vwbs9evTkI+vj+cxYZ6/I4w
         02Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460972; x=1684052972;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLUI9YlzqQO86ZI5zNo3VRTX+JioyZ8RjeyaguOLuik=;
        b=Jg660Puw//JRcoy8Df391XjXZ5H/0sNUyeGBI7useR+CLBs9aTKZje5vyfUVclh610
         BPL8nGQrX6BZqoP6qN01/zxWl2ri1NBu42yJek7tFvEawJaFXKftJMU8hkPizlw3c4yv
         90G4c54So7J0BE4/0ASISIApWoHtvGdkGPktM52OFPx2KI5axTjlPJjuVPaUcP+jHj4o
         Hs/lvbsM/uy+8BLDTdtcAXy+W88uojqnDrUpY3Py3I2pLBPLutpOjnVVAhu8PZHcsf7E
         2M1b4jdtOI/MGdjZO0mz9GNLTsvA533Nt45I6JCDBbENkuD5v9bglbOWPEG+rSRFOwM/
         snKw==
X-Gm-Message-State: AAQBX9eECip2QDJQb0bppVNXkYdr626EDmpVww1HWP3ekgoXydF7NFgX
        2DAZaCAsfZBnosNPdtAsu3L97x2HQGoqGWfcFUapbk0amCJv7A==
X-Google-Smtp-Source: AKy350ahDBIglyowIT7mgHdfm2i1rwfkCwsR7Ylg4zcQvDPCzey/hWBeZ/YIwk1KbytjBLn3HtxYhAkbOCdR+99N7I4=
X-Received: by 2002:a05:6214:412:b0:5e0:ad80:6846 with SMTP id
 z18-20020a056214041200b005e0ad806846mr2437405qvx.0.1681460972037; Fri, 14 Apr
 2023 01:29:32 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel Furstenheim Milerud <furstenheim@gmail.com>
Date:   Fri, 14 Apr 2023 10:29:21 +0200
Message-ID: <CAJN3DWqbR-9sNGT=Njei5PNSGKVKSOgrY4K=FXVjUKEFQ27bWg@mail.gmail.com>
Subject: Git bug.
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f1d04305f947a391"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000f1d04305f947a391
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Sorry if this is not the right address to report bugs. I'm following
https://stackoverflow.com/questions/10728104/where-can-i-report-a-git-bug/1=
0733251#10733251

Cheers
Gabriel F=C3=BCrstenheim

--000000000000f1d04305f947a391
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2023-04-14-1018.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2023-04-14-1018.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lggafoxo0>
X-Attachment-Id: f_lggafoxo0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCj4gcmVwb3NpdG9yeSBpbiBicmFuY2ggQQpnaXQgbmFtZS1yZXYg
JChnaXQgcmV2LXBhcnNlIEhFQUQpIC0tbmFtZS1vbmx5Cj4gcmV0dXJucyBBCmdpdCBjaGVja291
dCBCCmdpdCBuYW1lLXJldiAkKGdpdCByZXYtcGFyc2UgSEVBRCkgLS1uYW1lLW9ubHkKCgoKV2hh
dCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBiZWhhdmlvcikKSXQgc2hvdWxk
IHJldHVybiBCCgpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpCkl0IHJl
dHVybnMgQQoKV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3
aGF0IGFjdHVhbGx5IGhhcHBlbmVkPwpnaXQgcmV2LXBhcnNlIGRvZXMgbm90IHNlZW0gdG8gdXBk
YXRlLiBTYW1lIGlzIGhhcHBlbm5pbmcgd2l0aCBnaXQgcmV2LXBhcnNlIEB7LTF9CgpBbnl0aGlu
ZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoKZ2l0IHZlcnNpb24gMi4zNC4xCgpJIHJlY2VudGx5IG1p
Z3JhdGVkIHRvIHVidW50dSAyMi4gSW4gdWJ1bnR1IDE4IHdpdGggcHJldmlvdXMgZ2l0IHZlcnNp
b24gaXMgd2FzIHdvcmtpbmcgYXMgZXhwZWN0ZWQuCgpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9m
IHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0
IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJbmZvXQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24g
Mi4zNC4xCmNwdTogeDg2XzY0Cm5vIGNvbW1pdCBhc3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZApz
aXplb2YtbG9uZzogOApzaXplb2Ytc2l6ZV90OiA4CnNoZWxsLXBhdGg6IC9iaW4vc2gKdW5hbWU6
IExpbnV4IDUuMTkuMC0zOC1nZW5lcmljICMzOX4yMi4wNC4xLVVidW50dSBTTVAgUFJFRU1QVF9E
WU5BTUlDIEZyaSBNYXIgMTcgMjE6MTY6MTUgVVRDIDIgeDg2XzY0CmNvbXBpbGVyIGluZm86IGdu
dWM6IDExLjMKbGliYyBpbmZvOiBnbGliYzogMi4zNQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJh
Y3RpdmUgc2hlbGwpOiAvYmluL2Jhc2gKCgpbRW5hYmxlZCBIb29rc10K
--000000000000f1d04305f947a391--
