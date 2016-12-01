Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7FCE1FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 01:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbcLABXi (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 20:23:38 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:35791 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933259AbcLABXh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 20:23:37 -0500
Received: by mail-io0-f171.google.com with SMTP id a124so386254594ioe.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 17:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=yy3PMTaCADv5WvHCZ4CHtsW27Gs8Cg1Glg6/e4GNrwI=;
        b=Bt3He5DzFaxhffL4nmYgt6FD9x5WDe9myKdoFrHkW4FVCLZQ2eHTLtzHdrfkYYeoDQ
         IC9n4BU+i/sC//K0poEn7gDal5a4qgemYllnegi/OSKMicoD2cm4/+GN8j0c9w4ROhGV
         d3f59WiXBRfBa3RZWZfXOplSZ0LtGjBiVPmLiTRk5tC+tA+SAZfEIXHhsX5hX/+/KrxK
         zmiWSBeMz4YT3K4I113oOrLxv9bVDez6qZlSvKO8DGtx5CtXZpHlBkiks2kPPm2MMR3d
         idC4EJ6Yn8NOBaHgCK7s3lrblNBxlXiT0DIjByaVPCB3BRAW7UtbFiTttH9zjJ4ubXbA
         yhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yy3PMTaCADv5WvHCZ4CHtsW27Gs8Cg1Glg6/e4GNrwI=;
        b=VRm9BOr3I6X22NuBvLOZQDJOkVwxrFgG0gDXsuoXr5oPcPYI5gvqAP9p9pF6pG8nM5
         RSbY+Oa8YvLujEmHoKAFBMqIsD/sLGKiVzach+zZ2yYEd48JKtfkHtUyi2UPn3qzZleZ
         uoOX1NzgL0c8NzV3B0dRvZRHSZPb/e5G7jmFZ47UIJ1SMpFnCakzs+yAXoCD1rdzxDMV
         J28Dq0p5+6X9R4pgfte1vaCPErZ/gBMyfAAkkPVtZl9DuJSrAuMxptoS6XuQmyNo++B1
         TBuNrtkqP6z+0fnEXtLbva6iq3qZv4S9bIgEG9TI5Wy9Les8kVvQyPWshxvZdg9xsRGF
         9pcQ==
X-Gm-Message-State: AKaTC03ZR1RPv0JzKZzIetJHiI27mfUi2pEXhvWOal6WabkTE1Rg7OjCU/12FwNYLxeeTTgpKcGzXQELrBBm4A==
X-Received: by 10.36.25.211 with SMTP id b202mr31096964itb.77.1480555416729;
 Wed, 30 Nov 2016 17:23:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.196 with HTTP; Wed, 30 Nov 2016 17:22:56 -0800 (PST)
From:   Austin English <austinenglish@gmail.com>
Date:   Wed, 30 Nov 2016 19:22:56 -0600
Message-ID: <CACC5Q1eFM_G4wKopkbxabLEu8+nbt66wF1jKSoTuL1vnS5Tb4Q@mail.gmail.com>
Subject: [PATCH] Documentation/install-webdoc.sh: quote a potentially unsafe
 shell expansion
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a1144b958af6a1d05428eab31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1144b958af6a1d05428eab31
Content-Type: text/plain; charset=UTF-8

Found via shellcheck

In Documentation/install-webdoc.sh line 21:
mkdir -p $(dirname "$T/$h")
                         ^-- SC2046: Quote this to prevent word splitting.

-- 
-Austin
GPG: 14FB D7EA A041 937B

--001a1144b958af6a1d05428eab31
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Documentation-install-webdoc.sh-quote-a-potentially-.patch"
Content-Disposition: attachment; 
	filename="0001-Documentation-install-webdoc.sh-quote-a-potentially-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iw5ofmvo0

RnJvbSAxMDUwNTM4ZjI1MmQyMjMxMTE4NTA2NWFiODgzN2M3MWIxNzAwM2ZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBdXN0aW4gRW5nbGlzaCA8YXVzdGluZW5nbGlzaEBnbWFpbC5j
b20+CkRhdGU6IFdlZCwgMzAgTm92IDIwMTYgMTk6MjE6MjUgLTA2MDAKU3ViamVjdDogW1BBVENI
XSBEb2N1bWVudGF0aW9uL2luc3RhbGwtd2ViZG9jLnNoOiBxdW90ZSBhIHBvdGVudGlhbGx5IHVu
c2FmZQogc2hlbGwgZXhwYW5zaW9uCgpTaWduZWQtb2ZmLWJ5OiBBdXN0aW4gRW5nbGlzaCA8YXVz
dGluZW5nbGlzaEBnbWFpbC5jb20+Ci0tLQogRG9jdW1lbnRhdGlvbi9pbnN0YWxsLXdlYmRvYy5z
aCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vaW5zdGFsbC13ZWJkb2Muc2ggYi9Eb2N1bWVudGF0
aW9uL2luc3RhbGwtd2ViZG9jLnNoCmluZGV4IGVkOGI0ZmYuLjVmYjJkYzUgMTAwNzU1Ci0tLSBh
L0RvY3VtZW50YXRpb24vaW5zdGFsbC13ZWJkb2Muc2gKKysrIGIvRG9jdW1lbnRhdGlvbi9pbnN0
YWxsLXdlYmRvYy5zaApAQCAtMTgsNyArMTgsNyBAQCBkbwogCWVsc2UKIAkJZWNobyA+JjIgIiMg
aW5zdGFsbCAkaCAkVC8kaCIKIAkJcm0gLWYgIiRULyRoIgotCQlta2RpciAtcCAkKGRpcm5hbWUg
IiRULyRoIikKKwkJbWtkaXIgLXAgIiQoZGlybmFtZSAiJFQvJGgiKSIKIAkJY3AgIiRoIiAiJFQv
JGgiCiAJZmkKIGRvbmUKLS0gCjIuNy4zCgo=
--001a1144b958af6a1d05428eab31--
