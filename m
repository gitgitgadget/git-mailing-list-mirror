Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5EA20323
	for <e@80x24.org>; Thu, 16 Mar 2017 19:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbdCPTXT (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 15:23:19 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36315 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdCPTXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 15:23:18 -0400
Received: by mail-it0-f51.google.com with SMTP id w124so81630663itb.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=xlp5WjJ0ZSYnDN2UpW5kj08XXUjiUiP+AY094Qa/fhs=;
        b=W3wuY1vZRftBWGlMcZljxl49ONlCflFBBip8O2rU/aVerARMJDOAl6vQR1l8DOwSFd
         OvaZzBinVJRCP3CEuuHRHLEw4fzUEaEln3E9SoLjUY1e0/d9v6Hveevcm7Ru1m3YjDDh
         /nFGFeeX3Pv+MP5qWqfBmUL5stUo6ltL0ayQ23SaI+xMBjQEzdCGhobC43XXT0gFO1et
         DDWKAbSDHAvN5aUDX9DP/4UgMD04HbupSBkEcvWvn4GcQ7FIxx8q8ZZ6j7QNnNt3i5Oj
         aFU/9SJTC1m7nEIWVTTOgYMu8VVtmh8/JEY8Bjy8GxrKMou/dFV30H89jLyacaLiXYil
         xPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=xlp5WjJ0ZSYnDN2UpW5kj08XXUjiUiP+AY094Qa/fhs=;
        b=j5AozPYt+oJ0QxhV4ZXnXN7Qt/i67BN5dTXXVjhed82JzHfrsum485NjDF78v0t74D
         Z+EM9oa1s5X7H0XSy5IN4aS7UKrB1cJxfuDsutHNE6vmP1gSwjDOp6meFr/7Z7FOIoJC
         4i7qjEJIJp1yPpklslJCCKJfuEwQQvPCV4IQjlc1MgHCF9d3xKtAx/HCLu5k3WcnM3TZ
         lQ7AfSvlJNg1cnEOlEe0YMIbbL9VF3PHnizpLIQQ78lNtTz2G/Pj9rKDNSTVFDdWaTkU
         +vJcmgvRyQwBHO7Se+A8SLZGlncEZ78IUzUdn8fyOvcOp4jJDUcarFm4xFI9SQ7jD+D8
         M2xQ==
X-Gm-Message-State: AFeK/H2qi9Kc5LzTMhu+ApUg3penorn2eW+loPAcbF7En8acyVgPwaS7DV/hVC1NWAyrGX12kD5iFbp/ZZjuhQ==
X-Received: by 10.107.178.137 with SMTP id b131mr10994886iof.50.1489692121225;
 Thu, 16 Mar 2017 12:22:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Thu, 16 Mar 2017 12:22:00 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Mar 2017 12:22:00 -0700
X-Google-Sender-Auth: g8XgEvehDxMYsHeGmkKLa4Pg6b4
Message-ID: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
Subject: USE_SHA1DC is broken in pu
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a114c98b4b636e1054addf96b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a114c98b4b636e1054addf96b
Content-Type: text/plain; charset=UTF-8

I think there's a semantic merge error and it clashes with
f18f816cb158 ("hash.h: move SHA-1 implementation selection into a
header file").

Suggested possible merge resolution attached.

                   Linus

--001a114c98b4b636e1054addf96b
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0cs7xtp0

IE1ha2VmaWxlIHwgMiArLQogaGFzaC5oICAgfCAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZp
bGUKaW5kZXggOWQxZDk1OGJkLi4xODZjZTE3ZjIgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBi
L01ha2VmaWxlCkBAIC0xMzg4LDkgKzEzODgsOSBAQCBpZmRlZiBBUFBMRV9DT01NT05fQ1JZUFRP
CiBlbmRpZgogCiBpZmRlZiBVU0VfU0hBMURDCi0JU0hBMV9IRUFERVIgPSAic2hhMWRjL3NoYTEu
aCIKIAlMSUJfT0JKUyArPSBzaGExZGMvc2hhMS5vCiAJTElCX09CSlMgKz0gc2hhMWRjL3ViY19j
aGVjay5vCisJQkFTSUNfQ0ZMQUdTICs9IC1EU0hBMURDCiBlbHNlCiBpZmRlZiBCTEtfU0hBMQog
CUxJQl9PQkpTICs9IGJsb2NrLXNoYTEvc2hhMS5vCmRpZmYgLS1naXQgYS9oYXNoLmggYi9oYXNo
LmgKaW5kZXggZjBkOWRkZDBjLi5iN2Y0ZjFmZDggMTAwNjQ0Ci0tLSBhL2hhc2guaAorKysgYi9o
YXNoLmgKQEAgLTcsNiArNyw4IEBACiAjaW5jbHVkZSA8Q29tbW9uQ3J5cHRvL0NvbW1vbkRpZ2Vz
dC5oPgogI2VsaWYgZGVmaW5lZChTSEExX09QRU5TU0wpCiAjaW5jbHVkZSA8b3BlbnNzbC9zaGEu
aD4KKyNlbGlmIGRlZmluZWQoU0hBMURDKQorI2luY2x1ZGUgInNoYTFkYy9zaGExLmgiCiAjZWxz
ZSAvKiBTSEExX0JMSyAqLwogI2luY2x1ZGUgImJsb2NrLXNoYTEvc2hhMS5oIgogI2VuZGlmCg==
--001a114c98b4b636e1054addf96b--
