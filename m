Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E7AEB64DD
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 16:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjGLQXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGLQXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 12:23:16 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B0630EC
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 09:22:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a412653352so2179675b6e.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689178935; x=1691770935;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jd26vOvRFmO3TM9UsXBd10g58sMV/h7qOS1LLztT6q0=;
        b=ds1kDppzOk1Y/b+rnsk9yOs2lK/EQNUtQj+YbNzw0XRneTkTalPXMyaj2xdwHt9iOX
         4vG8jnk5BEBgMr1rEMpkRCM1MyQ4ywWsfM2wnnkaUcEHIu4KUlpWNvEXW3iek+2S6l9t
         FyjZFyogihUbFyixVZ8tNY6cR42BMi7k3cG0Mm+hNHs6hFN1vt0kW55Y8vDKFmU42BC4
         Aef9zw9GLwi5X9fjW5fk2VW6PdgrXo2gzfhGLWDFOAwCOT3MnJOK0gpKTxexZjJax9RC
         mmUZuy+n/KP+KLPPXdN288NbM+TKrApI1ZTztSiRLULMrQZ2MzTZ5pRKzok58qIv/rqW
         VR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689178935; x=1691770935;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jd26vOvRFmO3TM9UsXBd10g58sMV/h7qOS1LLztT6q0=;
        b=d0WMd4AS7vie+G0uLBko6P8MzEN+rU2+MDkCBiegj21Doq38+t98iRcETcdmemPlOo
         t3mEl5sZOmc1bKQxN3tCyvWtSkMXkwCXwBGX0bkxSZPtWd4l4Q/gjAaQjyKvz5y3T106
         Lqtoy6yEmEsGsujfAF7IsncA4jzKoRDIadgLJCremDVaiEmRtr2pXUSuVqA9PbKQsySo
         RcDlVAZ4cZodxoFY2zt84ExCRzS3y2lhuCQJpGsKtS+JRbE7TCwPT6aVfgxkZBdZcGj2
         9PjtGqJyTg91sY2XSr2a1BZM63K78EWCQEyHRSdr6xOBQ5Q5QE2Pn9AdV6D+4FwPFTpQ
         2H+g==
X-Gm-Message-State: ABy/qLZ15JakDU56mL6myQ7GdMUWUbHR6jBRsZavC30jlj7ikZLsozVk
        k1sED5/RFOQYzZUvr1mLOSqj2/Eh3GGyqlL+iw+yszBY
X-Google-Smtp-Source: APBJJlFGQpAFLzCm6sNrDXqABo2YcDosyLGd5s+YRDQ+y1X1qh+brmO5kh49RBdy27HPnJpVsMpSqjD2ChbaruwD3Ck=
X-Received: by 2002:a05:6808:220c:b0:39c:4553:964b with SMTP id
 bd12-20020a056808220c00b0039c4553964bmr19446434oib.50.1689178935457; Wed, 12
 Jul 2023 09:22:15 -0700 (PDT)
MIME-Version: 1.0
From:   Juan M Uys <opyate@gmail.com>
Date:   Wed, 12 Jul 2023 17:21:38 +0100
Message-ID: <CADfPAEbgfvnS6JTwa5Y1Zt7gQ31GRUyjjjpX9mmpcwxsaTLPGw@mail.gmail.com>
Subject: bug report: cloning private repo to absolute path doesn't work if
 gitconfig has includeIf directives
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000690e4906004c9e60"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000690e4906004c9e60
Content-Type: text/plain; charset="UTF-8"

The entire description is in the attachment.

--000000000000690e4906004c9e60
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2023-07-12-1644.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2023-07-12-1644.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ljzxgzf40>
X-Attachment-Id: f_ljzxgzf40

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVj
dGVkIGJlaGF2aW9yKQoKSSB3YW50IHRvIGNsb25lIGEgcHJpdmF0ZSByZXBvIHRvIGFuIGFic29s
dXRlIHBhdGggKHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB0aGUgcGF0aCBleGlzdHMgb3Igbm90KSwg
YW5kIGl0IGRvZXNuJ3Qgd29yay4gRS5nLgoKV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFs
IGJlaGF2aW9yKQoKYGBgCiUgZ2l0IGNsb25lIC0tZGVwdGg9MSAnZ2l0QGdpdGh1Yi5jb206bXlv
cmcvbXlwcml2YXRlcmVwby5naXQnICcvdG1wL3NvbWUtbmV3LWZvbGRlcicKQ2xvbmluZyBpbnRv
ICcvdG1wL3NvbWUtbmV3LWZvbGRlcicuLi4KRVJST1I6IFJlcG9zaXRvcnkgbm90IGZvdW5kLgpm
YXRhbDogQ291bGQgbm90IHJlYWQgZnJvbSByZW1vdGUgcmVwb3NpdG9yeS4KClBsZWFzZSBtYWtl
IHN1cmUgeW91IGhhdmUgdGhlIGNvcnJlY3QgYWNjZXNzIHJpZ2h0cwphbmQgdGhlIHJlcG9zaXRv
cnkgZXhpc3RzLgpgYGAKCkhvd2V2ZXIsIGlmIEkgcmVtb3ZlIHRoZSBsYXN0IGFyZ3VtZW50LCBp
dCB3b3JrcywgYW5kIGNsb25lcyB0byB0aGUgY3VycmVudCBkaXJlY3Rvcnk6CgpgYGAKJSBnaXQg
Y2xvbmUgLS1kZXB0aD0xICdnaXRAZ2l0aHViLmNvbTpteW9yZy9teXByaXZhdGVyZXBvLmdpdCcK
Q2xvbmluZyBpbnRvICdteXByaXZhdGVyZXBvJy4uLgpyZW1vdGU6IEVudW1lcmF0aW5nIG9iamVj
dHM6IDk5LCBkb25lLgpyZW1vdGU6IENvdW50aW5nIG9iamVjdHM6IDEwMCUgKDk5Lzk5KSwgZG9u
ZS4KcmVtb3RlOiBDb21wcmVzc2luZyBvYmplY3RzOiAxMDAlICg4Ny84NyksIGRvbmUuCnJlbW90
ZTogVG90YWwgOTkgKGRlbHRhIDcpLCByZXVzZWQgNzcgKGRlbHRhIDcpLCBwYWNrLXJldXNlZCAw
ClJlY2VpdmluZyBvYmplY3RzOiAxMDAlICg5OS85OSksIDUuNjYgTWlCIHwgNC43MSBNaUIvcywg
ZG9uZS4KUmVzb2x2aW5nIGRlbHRhczogMTAwJSAoNy83KSwgZG9uZS4KYGBgCgpQdWJsaWMgcmVw
b3Mgd29yayBpZiBJIHNwZWNpZnkgYW4gYWJzb2x1dGUgcGF0aCBhcyB0aGUgZGVzdGluYXRpb24g
ZGlyZWN0b3J5LCBlLmcuOgoKYGBgCiUgZ2l0IGNsb25lIC0tZGVwdGg9MSAnaHR0cHM6Ly9naXRo
dWIuY29tL2dpdC9odG1sZG9jcy5naXQnICcvdG1wL2dpdC1odG1sLWRvY3MnCkNsb25pbmcgaW50
byAnL3RtcC9naXQtaHRtbC1kb2NzJy4uLgpyZW1vdGU6IEVudW1lcmF0aW5nIG9iamVjdHM6IDEw
MjgsIGRvbmUuCnJlbW90ZTogQ291bnRpbmcgb2JqZWN0czogMTAwJSAoMTAyOC8xMDI4KSwgZG9u
ZS4KcmVtb3RlOiBDb21wcmVzc2luZyBvYmplY3RzOiAxMDAlICg5MjAvOTIwKSwgZG9uZS4KcmVt
b3RlOiBUb3RhbCAxMDI4IChkZWx0YSAzMTIpLCByZXVzZWQgNDU1IChkZWx0YSAxMDcpLCBwYWNr
LXJldXNlZCAwClJlY2VpdmluZyBvYmplY3RzOiAxMDAlICgxMDI4LzEwMjgpLCAzLjI0IE1pQiB8
IDQuMTMgTWlCL3MsIGRvbmUuClJlc29sdmluZyBkZWx0YXM6IDEwMCUgKDMxMi8zMTIpLCBkb25l
LgpgYGAKCldoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hh
dCBhY3R1YWxseSBoYXBwZW5lZD8KCkknbSBnZXR0aW5nIGFuICJhY2Nlc3MgcmlnaHRzIiBlcnJv
ciwgaW5zdGVhZCBvZiBteSByZXBvIGJlaW5nIGNsb25lZC4KCkFueXRoaW5nIGVsc2UgeW91IHdh
bnQgdG8gYWRkOgoKSSBzZXBhcmF0ZSBteSBnaXQgb3JnYW5pc2F0aW9ucyB3aXRoIGRpZmZlcmVu
dCBTU0gga2V5cyB3aXRoIHRoZSBoZWxwIG9mIGEgZ2xvYmFsIGdpdCBjb25maWc6CgpgYGAKaW5p
dF0KICAgICAgICBkZWZhdWx0QnJhbmNoID0gbWFpbgpbdXNlcl0KICAgICAgICBlbWFpbCA9IG9w
eWF0ZUBnbWFpbC5jb20KICAgICAgICBuYW1lID0gSnVhbiBVeXMKW2NvcmVdCiAgICAgICAgZXhj
bHVkZXNmaWxlID0gL2hvbWUvb3B5YXRlLy5naXRpZ25vcmUKICAgICAgICBlZGl0b3IgPSB2aW0K
ICAgICAgICBwYWdlciA9IGxlc3MgLUZSWAoKW2luY2x1ZGVJZiAiZ2l0ZGlyOi9ob21lL29weWF0
ZS9Eb2N1bWVudHMvY29kZS9vcmcxLyJdCiAgICAgICAgcGF0aCA9IC9ob21lL29weWF0ZS9Eb2N1
bWVudHMvY29kZS9vcmcxL2dpdGNvbmZpZwpbaW5jbHVkZUlmICJnaXRkaXI6L2hvbWUvb3B5YXRl
L0RvY3VtZW50cy9jb2RlL29yZzIvIl0KICAgICAgICBwYXRoID0gL2hvbWUvb3B5YXRlL0RvY3Vt
ZW50cy9jb2RlL29yZzIvZ2l0Y29uZmlnCltmaWx0ZXIgImxmcyJdCiAgICAgICAgY2xlYW4gPSBn
aXQtbGZzIGNsZWFuIC0tICVmCiAgICAgICAgc211ZGdlID0gZ2l0LWxmcyBzbXVkZ2UgLS0gJWYK
ICAgICAgICBwcm9jZXNzID0gZ2l0LWxmcyBmaWx0ZXItcHJvY2VzcwogICAgICAgIHJlcXVpcmVk
ID0gdHJ1ZQpgYGAKCkFuZCB0aGVuIGVhY2ggb3JnJ3MgZ2l0Y29uZmlnIHR5cGljYWxseSBsb29r
cyBsaWtlOgoKYGBgClt1c2VyXQogICAgICAgIG5hbWUgPSBKdWFuIFV5cwogICAgICAgIGVtYWls
ID0ganVhbi51eXNAb3JnMS5jb20KCgpbY29yZV0KICAgICAgICBzc2hDb21tYW5kID0gInNzaCAt
aSB+Ly5zc2gvb3JnMS9pZF9lZDI1NTE5IgpgYGAKCgpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9m
IHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0
IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJbmZvXQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24g
Mi40MS4wCmNwdTogeDg2XzY0Cm5vIGNvbW1pdCBhc3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZApz
aXplb2YtbG9uZzogOApzaXplb2Ytc2l6ZV90OiA4CnNoZWxsLXBhdGg6IC9iaW4vc2gKdW5hbWU6
IExpbnV4IDUuMTUuMC03Ni1nZW5lcmljICM4M34yMC4wNC4xLVVidW50dSBTTVAgV2VkIEp1biAy
MSAyMDoyMzozMSBVVEMgMjAyMyB4ODZfNjQKY29tcGlsZXIgaW5mbzogZ251YzogOS40CmxpYmMg
aW5mbzogZ2xpYmM6IDIuMzEKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTog
L3Vzci9iaW4venNoCgoKW0VuYWJsZWQgSG9va3NdCm5vdCBydW4gZnJvbSBhIGdpdCByZXBvc2l0
b3J5IC0gbm8gaG9va3MgdG8gc2hvdwo=
--000000000000690e4906004c9e60--
