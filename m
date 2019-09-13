Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67A31F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbfIMUYU (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:24:20 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:36645 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfIMUYU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:24:20 -0400
Received: by mail-lj1-f173.google.com with SMTP id v24so682211ljj.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ATgzim+iWWwYT6Irn9zYVNZz8tO1wYPV1l+wmbhf//8=;
        b=FhmNSdA9eqeUus2tnl/WsCS/yXVPh002npHjKPQ+20BTF/pdjrK3S76w2j7K0JFXW0
         18jfU/Ctin5iw3D4CfVVPrxiq8xD/SMEYfgPnqo63T18w8/a+q/JdwOBR5GtFwivr5md
         x3V9rTyr1F4h4avKW4+LoT6RjqG0sTmsgOipONnhiGOYgpqYH9GH9WqiEcYcLGYmpYbu
         Qm+i1UjKixwIBc/lL+BTKl7TIvUahKzmZLB9BnrRV1sEgBMYYvaYvPOS1rDiKI+YvJ0X
         F+zJbhoSVfxZQnQTyBwLezTTHAT1Yhj3M5z91SzJSPi+b3CN2bAFeiJf95pBeyrZntgj
         Oxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ATgzim+iWWwYT6Irn9zYVNZz8tO1wYPV1l+wmbhf//8=;
        b=r32K+Hvi22r3Rvlk2Y5n/CE0CvpXxB/AAilYLXdZW7wmt55Q3+nfqwYE7IcGycDK7Q
         kOgHnff7hmC8BC/6m5PGX9uPZFqOA+Vc47xupPdDPa+V8RiCf1gH5wWAvoG+uHG1mSC8
         6gFeurny9bC4WYHLcu48E3MB8j7QEnlmA6eBYyiKF+vEsRL1fTr7yo3uUUYHlKvgxPTE
         9st/Z07yPW2Rhy6Wktm4lxt+rRhOkkZ8EUa6g2StHh7e9eZd07DsnLiFiuNyZgkC37w8
         meUOexVlJzAgyxVXhYu+PWDCX8tdf5l0kqbT2hCliN7IvIsgyMVIA/Hqx84WJbWLSmja
         fv5A==
X-Gm-Message-State: APjAAAUXJ4HR7jb8uhr1xJ/yHDi2PDVbNHl3/k+nUN+7miqXwvcmc5sT
        euBaasqWXYLhw5JZGg2fi48hSuFfOY03Fu0CgQ4V579o
X-Google-Smtp-Source: APXvYqxDlX4Pfe0BykBnjmDfzcZnOvH9OlopYrC0KDXzzVzFNSvdyI7dnQvnd+qiK7YmApA0phmKiIAPAdivdrVUmhg=
X-Received: by 2002:a2e:1b08:: with SMTP id b8mr31852012ljb.241.1568406258019;
 Fri, 13 Sep 2019 13:24:18 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 13 Sep 2019 15:24:06 -0500
X-Google-Sender-Auth: PqtMLw08K3Aws6S5A6ocDydzwRM
Message-ID: <CAHd499BT35jvPtsuD9gfJB0HJ=NxtzyQOaiD7-=sHJbFYhphpg@mail.gmail.com>
Subject: diff.renames not working?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using Git version 2.23. I have the `diff.renames` setting set to
`copies`. My code base has a file named `JniPaymentManager.hpp` (and
`cpp`) that had too much code in it, so I refactored this file by
splitting out a significant portion of the code in it to another file,
named `ZPayClient.hpp` (and `cpp`). When I diff the topic branch
against the mainline, it shows it as a copy with a percentage:

```
$ git diff --name-status master...topic
C055    Jni/JniPaymentManager.cpp    ZPay/ZPayClient.cpp
C070    Jni/JniPaymentManager.hpp    ZPay/ZPayClient.hpp
```

Now my goal is to diff `ZPayClient.hpp` and see the changes to the
moved-out portion of code as it relates to the original state of that
code in `JniPaymentManager.hpp`. To do this, I tried this command:

```
$ git diff master...topic -- ZPay/ZPayClient.hpp
```

The unified diff header I got back is:

```
diff --git ZPay/ZPayClient.hpp ZPay/ZPayClient.hpp
new file mode 100644
index 00000000..6ebc2a9a
--- /dev/null
+++ ZPay/ZPayClient.hpp
```

Hmm, it's treating it as a new file. Even though I have `diff.renames`
set to `copies`? Even though `diff --name-status` acknowledges the
relationship with the original file for the code on `master`? This is
confusing...

Out of curiosity, I thought I'd try this command:

```
git diff --follow master...topic -- ZPay/ZPayClient.hpp
```

And I get this unified diff header:

```
diff --git Jni/JniPaymentManager.hpp ZPay/ZPayClient.hpp
similarity index 70%
copy from Jni/JniPaymentManager.hpp
copy to ZPay/ZPayClient.hpp
index fc18e2d2..6ebc2a9a 100644
--- Jni/JniPaymentManager.hpp
+++ ZPay/ZPayClient.hpp
```

Now this looks more like it. I can actually see a useful diff here,
instead of everything looking like a new file. But there is a lot of
confusion here:

1. `diff --follow` is not a documented[1] option. Why does it work?
2. `diff -M` doesn't actually work either. It should, though. In fact,
I expected it to work as `--follow` does. But it doesn't.
3. The `diff.renames` config doesn't seem to be working here, when it should.

Can someone explain the behavior I'm seeing? I really am confused
about all this...

[1]: https://git-scm.com/docs/git-diff
