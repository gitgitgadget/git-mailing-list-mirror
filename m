Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B782BC4332B
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 23:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6272076C
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 23:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWF8eGx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCRXoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:44:30 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:43118 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgCRXoa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 19:44:30 -0400
Received: by mail-io1-f46.google.com with SMTP id n21so358436ioo.10
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=+phoxOMSL3YlI0aFnPeYE95QzXE+r+eoY3FpMpnxUl8=;
        b=cWF8eGx3xkUZIX68c1GxOXdmWa9D7mHtZ9DDjYajTeUF40c+F2Ha58BSDKudCdMqyT
         1H+iJwH2kf2KS3dI61W2tbe23FPZ6/2AL1LEkKLl88pculGVreHDJlOVhnOvGMnhTCSI
         PvpiyoB/OKjhFph1UY74M53TBt6Av0cWY9QHtVMc1bvRMQL9P6ynZMs5HgSl8BmerzfC
         2py/CNf0zR/SxTvXVKxinRh4KR7xkpGAnkLBtfh0DMlWqdsMMjoeKp3Br+YYc8YpkHuv
         t+e0YERO4CcR7Vu4RLIKnZsIPo24sOBP6VofCwxpfXitdiDHFqx6GgNwQEAlASiye4BW
         YTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=+phoxOMSL3YlI0aFnPeYE95QzXE+r+eoY3FpMpnxUl8=;
        b=l/dlHU7RU5KoqdQ7MjVA4yZNSNOP/IIRzteMBXKuVkiuNFUZg6O0u05vG1B0hWy3ft
         FnEtthbfmRebpbKda7cNfcAA2gVN8fxuj2TfdclZsJ28HN7M3EMbnZHDY0tAWWQd7KQ+
         4jyStzBcrDXpSounN8gQzzhnlhzhSTib6f+0izyReWSOf/9OkiLqo39ze6bIhsQs7AXu
         DjII7AkhHHwhaN9SMzGbO7b3zcXEUUEMFgLvRtuo1qkPTNvAVhwh2em6hJEnaQUmKxOW
         iUGiXqASAyppRyp/+H/Nxzu57SGNiKe5PlARQR4gk4+W8YOUl+g+Gpugg5icD34rc4Ap
         7SeA==
X-Gm-Message-State: ANhLgQ0tXbTRFehC29F5imzbwWMjHlIaRDrIQUvjdj+H0Fy+OF3BvJGM
        yhHbfjwawlRVnBZ9Pd87Yb+mc50DjEZtbA9pxAh5Bq0v
X-Google-Smtp-Source: ADFU+vsqB1/P+/lFuKNB3tzYA6799x0uOkLw7tmpj62gTA9EpNVycnKUrcPquT00SZEwI0rodqFV+kU649HPUXMQhRM=
X-Received: by 2002:a02:6596:: with SMTP id u144mr587194jab.27.1584575069288;
 Wed, 18 Mar 2020 16:44:29 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 18 Mar 2020 19:44:18 -0400
Message-ID: <CAH8yC8mn+c_v85eMTqLEZS1=OgetOKe9uX3MoPDmRZEyfENuTQ@mail.gmail.com>
Subject: Test results for GNU HURD
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

Here are test results for GNU HURD built from the 2.25.1 release
tarball. HURD is the JAN 2020 image, and fully updated with apt-get.

I may be missing something for testing.

*** t5562-http-backend-content-length.sh ***
ok 1 - setup
ok 2 - setup, compression related
ok 3 - fetch plain
ok 4 - fetch plain truncated
ok 5 - fetch plain empty
ok 6 - fetch gzipped
ok 7 - fetch gzipped truncated
ok 8 - fetch gzipped empty
ok 9 - push plain
ok 10 - push plain truncated
ok 11 - push plain empty
ok 12 - push gzipped
not ok 13 - push gzipped truncated
#
#        test_env HTTP_CONTENT_ENCODING="gzip" test_http_env receive
push_body.gz.trunc &&
#        ! verify_http_result "200 OK"
#
not ok 14 - push gzipped empty
#
#        test_env HTTP_CONTENT_ENCODING="gzip" test_http_env receive
empty_body &&
#        ! verify_http_result "200 OK"
#
ok 15 - CONTENT_LENGTH overflow ssite_t
ok 16 - empty CONTENT_LENGTH
# failed 2 among 16 test(s)
1..16
Makefile:56: recipe for target 't5562-http-backend-content-length.sh' failed
