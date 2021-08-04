Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B059C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8E860F10
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhHDOUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbhHDOUB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 10:20:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34997C06179A
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 07:19:49 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o185so2969394oih.13
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=excilys-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=xjYP7u2ExOW4CC5iDXlmKIKm5RGfaqjQwSnT3IHWm7c=;
        b=l8CqgLUmfLJ6KlH5nxpLB1MHFN7WGfgsqDcazOz0d7HAVMKuDLwE7VtkBp+bIVuY5S
         mz7cx2xYB/zdEvsDKpfl4EKiTizLxWol7g1Xv/nWi3qfHM0UdMOGe7XBaD5q7Rl2pAZJ
         G6gRm0dwmfUSP/pSdvmYQnFHeB8yoXO/cpP37lsS2sJuz/Kb4iM+F4DaerqlWm7yvbGb
         PotByb5qeC5jNnfsPVu5R1UWnTQiOLH2otQ/l3a93+EIkimTyFhJ5oPrhUKSG219p/Ne
         k6hyIlYxbrupmql4CXQO5nx2qVtgljDAhgza8xbcex2lY9WEOMYviP6xeQUfGX793YTs
         Vd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xjYP7u2ExOW4CC5iDXlmKIKm5RGfaqjQwSnT3IHWm7c=;
        b=IBN/Kdc1wfl+07ilSZy4B8gAlaCx6DkEG09ZjFMSoe7LqIaeduNc585nQGUrk2ks67
         FMScyRcPb7b/t8/Gx/NULdF5kbUCfkbG9/dauY7ETE2PsdsFLfPJqKOYz1JEKC3HwIeU
         sNiBsq7ndPA9Hu2tyF0J55Adlosx1zePamPurSO64/tTLgq9BbSHWE3rqVJTCi2EiowH
         zgjIVdhV/jXMW6aDj/R3uWQOZveM3+f3tOhbXb300KV3OdEGMbNqwtCsNsNj2bh42RD2
         hxmGYvJi9zWocYKyaofHJKAlCMOKZu02Hec2inahUHKB2dc/aWDCzp9iRXCjyNqCo9XX
         YYzw==
X-Gm-Message-State: AOAM5333AJiWiw331Yf8vg24Webu1gGA81AYnGpOAtex2vU5qCi7zF8z
        6jVMBzvqV28CpC9ma4QqJtFznWcMnxCqKmiSjM3SLf3MqfdB7g==
X-Google-Smtp-Source: ABdhPJxCGykc2e8qqf5stIpPgyLOdxfezpPkhvfwNHLl9Uvh1iCKrw9JzHqVML7Dr8yAQfKj0eLmOjAR2k6NeZTzEeo=
X-Received: by 2002:aca:c693:: with SMTP id w141mr2205212oif.47.1628086788474;
 Wed, 04 Aug 2021 07:19:48 -0700 (PDT)
MIME-Version: 1.0
From:   Victor Gambier <vgambier@excilys.com>
Date:   Wed, 4 Aug 2021 16:19:12 +0200
Message-ID: <CAMsiUYDD3jTyP-pK7PiydECkUAJspzosc8mWNSFpcLru70zXbQ@mail.gmail.com>
Subject: commit following rebase has unexpected commit message
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b12ab405c8bc7edb"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000b12ab405c8bc7edb
Content-Type: text/plain; charset="UTF-8"



--000000000000b12ab405c8bc7edb
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2021-08-04-1558.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2021-08-04-1558.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_krxks0560>
X-Attachment-Id: f_krxks0560

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgpnaXQgc3dpdGNoIC1jIGZpcnN0CmdpdCBzd2l0Y2ggLWMgc2Vj
b25kClttb2RpZnkgYSBmaWxlXQpnaXQgY29tbWl0IC1hbSAiZm9vIgpnaXQgc3dpdGNoIGZpcnN0
Clttb2RpZnkgdGhlIHNhbWUgZmlsZSBpbiBhIGNvbmZsaWN0aW5nIHdheV0KZ2l0IGNvbW1pdCAt
YW0gImJhciIKZ2l0IHJlYmFzZSBzZWNvbmQKZ2l0IHJlc3RvcmUgLS1zdGFnZWQgLgpnaXQgcmVz
dG9yZSAuCmdpdCByZWJhc2UgLS1jb250aW51ZQpbbW9kaWZ5IGFueSBmaWxlIC0gY2FuIGJlIHRo
ZSBzYW1lIGZpbGUgYWdhaW5dCmdpdCBjb21taXQgLWEKCldoYXQgZGlkIHlvdSBleHBlY3QgdG8g
aGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpCgpUaGUgdGV4dCBlZGl0b3Igc2hvdWxkIHBvcCB1
cCBhbmQgdGhlIGZpcnN0IGxpbmUgc2hvdWxkIGJlIGJsYW5rIChubyBkZWZhdWx0IGNvbW1pdCBt
ZXNzYWdlKS4KCldoYXQgaGFwcGVuZWQgaW5zdGVhZD8gKEFjdHVhbCBiZWhhdmlvcikKClRoZSB0
ZXh0IGVkaXRvciBwb3BzIHVwLCBhbmQgdGhlIGZpcnN0IGZvdXIgbGluZXMgb2YgdGhlIGRlZmF1
bHQgY29tbWl0IG1lc3NhZ2Ugc2VlbSB0byBwZXJ0YWluIHRvIHRoZSByZWJhc2U6CgoJYmFyCgkK
CSMgQ29uZmxpY3RzOgoJIwlmcm9udGVuZC9zcmMvc3R5bGluZy9yb3VuZHMudHMKCQpFdmVuIHRo
b3VnaCB0aGUgY29udGVudHMgb2YgdGhlIGNvbW1pdCBjb3JyZWN0bHkgcGVydGFpbiB0byB0aGUg
dmVyeSBsYXN0IGNoYW5nZXMgYW5kIGFyZSB1bnJlbGF0ZWQgdG8gdGhlIHJlYmFzZS4KCldoYXQn
cyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1YWxseSBo
YXBwZW5lZD8KClRoZSBkZWZhdWx0IGNvbW1pdCBtZXNzYWdlLgoKQW55dGhpbmcgZWxzZSB5b3Ug
d2FudCB0byBhZGQ6CgpBIHNlY29uZCBhbm9tYWx5IGlzIHRoYXQgaWYgeW91IHJlcGxhY2UgdGhl
IGxhc3QgY29tbWFuZCB3aXRoIGdpdCBjb21taXQgLWEgLS1uby1lZGl0LCB0aGUgdHdvIGxpbmVz
IHN0YXJ0aW5nIHdpdGggJyMnIGFyZSBOT1QgaWdub3JlZCBhbmQgd2lsbCBiZSBwcmVzZW50IGlu
IHRoZSBmaW5hbCBjb21taXQgbWVzc2FnZS4KClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhl
IGJ1ZyByZXBvcnQgYmVsb3cuCllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lz
aCB0byBzaGFyZS4KCgpbU3lzdGVtIEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjMw
LjAud2luZG93cy4yCmNwdTogeDg2XzY0CmJ1aWx0IGZyb20gY29tbWl0OiBmOGNiYzg0NGI4MWJm
NmI5ZTcyMTc4YmJlODkxYTg2YzhiZjVlOWU3CnNpemVvZi1sb25nOiA0CnNpemVvZi1zaXplX3Q6
IDgKc2hlbGwtcGF0aDogL2Jpbi9zaAp1bmFtZTogV2luZG93cyAxMC4wIDE4MzYzIApjb21waWxl
ciBpbmZvOiBnbnVjOiAxMC4yCmxpYmMgaW5mbzogbm8gbGliYyBpbmZvcm1hdGlvbiBhdmFpbGFi
bGUKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogQzpcUHJvZ3JhbSBGaWxl
c1xHaXRcdXNyXGJpblxiYXNoLmV4ZQoKCltFbmFibGVkIEhvb2tzXQo=
--000000000000b12ab405c8bc7edb--
