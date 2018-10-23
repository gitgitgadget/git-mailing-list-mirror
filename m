Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6A41F453
	for <e@80x24.org>; Tue, 23 Oct 2018 21:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeJXF3Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 01:29:25 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:34206 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJXF3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 01:29:25 -0400
Received: by mail-ed1-f50.google.com with SMTP id w19-v6so3010274eds.1
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hMgaOIo5rXeN89f8lUF6BdDvamEAPd1/D18oDuL+1pc=;
        b=Gd1sYYi/udoZ5BQCdjiMETuT9LiEJKK0kp5VDkH3krhxf5YFBkmwi36ccOR7l782qG
         gOLEbfK2clr73sX25DLqdzPNNVvY8JGAKgfhQ9NqRk+b2/9z7IoXrA8TsWz+IYl/07cf
         +chXxOUrIpgXGfrqBJ/J7RToJfFejJs1lXsyk/YUsFW1WA7S+f+z/bAIT0G+TeTfwr9l
         NvLdNOLPZSgNDZ01xoAZ5edexjKt+zVySTyCqfWv5zh1ux8HA184DAv6Theu9o7xpeEB
         AhqnQPyKli52acxzndDFd8d0A940mRDbhpM6Aizv0a5G79wf5uizrky3GvepLKbMxjE5
         ESpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hMgaOIo5rXeN89f8lUF6BdDvamEAPd1/D18oDuL+1pc=;
        b=bbeSlJ1Y1MKP9U5Z61eHltGSIbKKXRoYukWBL91+QFIZKvwr1Aljor+aNwx16qyElx
         X4XLrFgOq0LGQDXXIk8K8gfZGCsFQ1V1YCyPzvNkdJJMc3NlQQToBaJvcH6DExsDELPW
         RhMOWVWMCWhzOngKLOzVxbdiRxQsebSHh3U4JQTmmxpJuS6a/swzVwErqexOaKYMEHjM
         Ldg65Ev8rqQ/c301Esq9EsfAXCAxdo3dc38QoEDtvz2v735a0mTKwBzHdAmWOLZj1cNz
         GuoJphREbLc7+QmG0cK+WJa2iSTjT9zjc4/t6d5bq+qT8H1vuGS0GC19F6nyyksv/jQK
         bGKw==
X-Gm-Message-State: ABuFfojDyYJyjFaSU2zm48o+BFbCkWNT4ruYLcoVJyTfzVbtGkgRCFnW
        X2gXNftg+1GuQtAdQ8CCtqGjtsf6HtCtkwms8vUnI4/2
X-Google-Smtp-Source: ACcGV62It+WrE1FMprRhtcLyNBElg+B6kyI66ehSjQ+Y2yyfAXpYVypVdFlm/Wm+3s4Rc24nhu5E1O0FKBOG4DAN9gM=
X-Received: by 2002:a17:906:6054:: with SMTP id p20-v6mr38900841ejj.40.1540328657974;
 Tue, 23 Oct 2018 14:04:17 -0700 (PDT)
MIME-Version: 1.0
From:   Tommi Vainikainen <tvainika@gmail.com>
Date:   Wed, 24 Oct 2018 00:04:06 +0300
Message-ID: <CAGshahkvn3fcyuqtD-WQE9tn+7rSad84+mtA_cfkz+t42xqPdw@mail.gmail.com>
Subject: git pull defaults for recursesubmodules
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007f12160578ebb6d7"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000007f12160578ebb6d7
Content-Type: text/plain; charset="UTF-8"

I configured my local git to fetch with recurseSubmodules = on-demand,
which I found the most convenient setting. However then I noticed that
I mostly use git pull actually to fetch from remotes, but git pull
does not utilize any recurseSubmoddules setting now, or at least I
could not find such.

I would expect that if git-config has fetch.recurseSubmodules set,
also git pull should use this setting, or at least similar option such
as pull.recurseSubmodules should be available. I'd prefer sharing
fetch.recurseSubmodules setting here.

I've attached a minimal patch, which I believe implements this
configuration usage, and a test case to show my expected behavior for
git pull.

--
Tommi Vainikainen

--0000000000007f12160578ebb6d7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-pull-obey-fetch.recurseSubmodules-when-fetching.patch"
Content-Disposition: attachment; 
	filename="0001-pull-obey-fetch.recurseSubmodules-when-fetching.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jnm7vb4p0>
X-Attachment-Id: f_jnm7vb4p0

RnJvbSBlNDQ4M2VjNWIzZDljMzhhNmUzMGFhMGFiOWZhNTIxY2JhNTgyMzQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUb21taSBWYWluaWthaW5lbiA8dGh2QGlraS5maT4KRGF0ZTog
VHVlLCAyMyBPY3QgMjAxOCAyMzo0Nzo1OCArMDMwMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSBwdWxs
OiBvYmV5IGZldGNoLnJlY3Vyc2VTdWJtb2R1bGVzIHdoZW4gZmV0Y2hpbmcKCiJnaXQgcHVsbCIg
bm93IHVzZXMgc2FtZSByZWN1cnNlLXN1Ym1vZHVsZXMgY29uZmlnIGZvciBmZXRjaGluZyBhcyAi
Z2l0CmZldGNoIiBieSBkZWZhdWx0IGlmIG5vdCBvdmVycmlkZGVuIGZyb20gY29tbWFuZCBsaW5l
LjEKLS0tCiBidWlsdGluL3B1bGwuYyAgICAgICAgICAgIHwgIDMgKysrCiB0L3Q1NTcyLXB1bGwt
c3VibW9kdWxlLnNoIHwgMTEgKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4vcHVsbC5jIGIvYnVpbHRpbi9wdWxsLmMKaW5k
ZXggNzk4ZWNmN2ZhZi4uZWQzOWIwZThlZCAxMDA2NDQKLS0tIGEvYnVpbHRpbi9wdWxsLmMKKysr
IGIvYnVpbHRpbi9wdWxsLmMKQEAgLTM0Nyw2ICszNDcsOSBAQCBzdGF0aWMgaW50IGdpdF9wdWxs
X2NvbmZpZyhjb25zdCBjaGFyICp2YXIsIGNvbnN0IGNoYXIgKnZhbHVlLCB2b2lkICpjYikKIAkJ
cmVjdXJzZV9zdWJtb2R1bGVzID0gZ2l0X2NvbmZpZ19ib29sKHZhciwgdmFsdWUpID8KIAkJCVJF
Q1VSU0VfU1VCTU9EVUxFU19PTiA6IFJFQ1VSU0VfU1VCTU9EVUxFU19PRkY7CiAJCXJldHVybiAw
OworCX0gZWxzZSBpZiAoIXN0cmNtcCh2YXIsICJmZXRjaC5yZWN1cnNlc3VibW9kdWxlcyIpKSB7
CisJCXJlY3Vyc2Vfc3VibW9kdWxlcyA9IHBhcnNlX2ZldGNoX3JlY3Vyc2Vfc3VibW9kdWxlc19h
cmcodmFyLCB2YWx1ZSk7CisJCXJldHVybiAwOwogCX0KIAlyZXR1cm4gZ2l0X2RlZmF1bHRfY29u
ZmlnKHZhciwgdmFsdWUsIGNiKTsKIH0KZGlmZiAtLWdpdCBhL3QvdDU1NzItcHVsbC1zdWJtb2R1
bGUuc2ggYi90L3Q1NTcyLXB1bGwtc3VibW9kdWxlLnNoCmluZGV4IGY5MTY3MjlhMTIuLjU3OWFl
NWMzNzQgMTAwNzU1Ci0tLSBhL3QvdDU1NzItcHVsbC1zdWJtb2R1bGUuc2gKKysrIGIvdC90NTU3
Mi1wdWxsLXN1Ym1vZHVsZS5zaApAQCAtNzUsNiArNzUsMTcgQEAgdGVzdF9leHBlY3Rfc3VjY2Vz
cyAic3VibW9kdWxlLnJlY3Vyc2Ugb3B0aW9uIHRyaWdnZXJzIHJlY3Vyc2l2ZSBwdWxsIiAnCiAJ
dGVzdF9wYXRoX2lzX2ZpbGUgc3VwZXIvc3ViL21lcmdlX3N0cmF0ZWd5XzIudAogJwogCit0ZXN0
X2V4cGVjdF9zdWNjZXNzICJmZXRjaC5yZWN1cnNlU3VibW9kdWxlcz10cnVlIHRyaWdnZXJzIHJl
Y3Vyc2l2ZSBwdWxsIiAnCisJdGVzdF9jb21taXQgLUMgY2hpbGQgZmV0Y2hfcmVjdXJzZV9zdWJt
b2R1bGVzICYmCisJZ2l0IC1DIHBhcmVudCBzdWJtb2R1bGUgdXBkYXRlIC0tcmVtb3RlICYmCisJ
Z2l0IC1DIHBhcmVudCBhZGQgc3ViICYmCisJZ2l0IC1DIHBhcmVudCBjb21taXQgLW0gInVwZGF0
ZSBzdWJtb2R1bGUiICYmCisKKwlnaXQgLUMgc3VwZXIgY29uZmlnIGZldGNoLnJlY3Vyc2VTdWJt
b2R1bGVzIHRydWUgJiYKKwlnaXQgLUMgc3VwZXIgcHVsbCAtLW5vLXJlYmFzZSAmJgorCXRlc3Rf
cGF0aF9pc19maWxlIHN1cGVyL3N1Yi9mZXRjaF9yZWN1cnNlX3N1Ym1vZHVsZXMudAorJworCiB0
ZXN0X2V4cGVjdF9zdWNjZXNzICIgLS1bbm8tXXJlY3Vyc2Utc3VibW9kdWxlIGFuZCBzdWJtb2R1
bGUucmVjdXJzZSIgJwogCXRlc3RfY29tbWl0IC1DIGNoaWxkIG1lcmdlX3N0cmF0ZWd5XzMgJiYK
IAlnaXQgLUMgcGFyZW50IHN1Ym1vZHVsZSB1cGRhdGUgLS1yZW1vdGUgJiYKLS0gCjIuMTkuMQoK
--0000000000007f12160578ebb6d7--
