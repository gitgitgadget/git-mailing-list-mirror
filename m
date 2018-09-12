Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787F71F404
	for <e@80x24.org>; Wed, 12 Sep 2018 12:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeILRsY (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 13:48:24 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35023 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILRsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 13:48:23 -0400
Received: by mail-oi0-f45.google.com with SMTP id m11-v6so3403041oic.2
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=JTQ3h2dGGGiYQr8xxKyJBTXAIm1HEgXv47Xc3DvVD1Y=;
        b=AVdGLZzBpZptt4tuk5nZash4ZzJSu2fT3UQu4wC4pDjZN5vmxOObRMGG9NLuhOf/wp
         5LpcsOVEDZxgNnm8eEF/oZVMizCkHXX73W1CVuilo9lrULr3DlNTOal3tSKUXiFDB6Zt
         Dhn4VfFm5IsQbkEup/cGtfjNooJOZ0gZAHMpxYYXMa6+9K1mHuG7bHFLusSZGXAgzRSq
         9UQEyUJ8sIdtZhlKUoheF8KbSMmvOnKyAGy0J4RjINVVzmgNqimKbIaZxlHNrpKZIzr9
         5G7pqnAUA9EttGQxWXOj+U9b6Hf895h5gKzMUpuFi4A9VG3TfdzPoEL8I/ttPvWW3Avn
         o/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JTQ3h2dGGGiYQr8xxKyJBTXAIm1HEgXv47Xc3DvVD1Y=;
        b=jCSLhq5apo0N0+WIdZTnB1ArVae/kgMYlSgxLGQMU+9C8YabIz5RmczJ9owOXzAh8K
         rOLrFn2+j5PYdf1hVB3WUYznpbB0RNIWTBc7g1HWEF7bWLM3Uvc/JFUlZdJSpIkLJK12
         mRhzd5K2Xp+Iw4VNxQdJRfRQaAui4fGE+ZVI5lG8KW3MvlUnbr9J5NkZh/i6vT9HgZ/0
         SYr6tPWl53ErA0H8FgvxFg8fWK//hIiCmuSTGv0krGOsX0AOlvnqu58XfYrhNMcMFOu9
         p1HjDff0XuN8dH2hAwSeLWddylTFTVlrNSGHPHargEh3FjWwV1ytOhsNOHS5JbQ8wkxK
         W3Qg==
X-Gm-Message-State: APzg51Ccww6DLcSMHKT+00UExo/5L5MQIjtotK3P4pvE+G1EMWM3TVUI
        Il/eQBirICkZSj/p6uxnRfuP6RGNDtOaK8VN5E5PIIYvfn0=
X-Google-Smtp-Source: ANB0VdbdVY1P9UJrwSWoVfa5/UkCsc+1r7ws3pVN6gX1xKu9jlG4WzshJWtfE1VSHK7k9JDWHYv5z7n+lJsuoUi+Vfg=
X-Received: by 2002:a54:448b:: with SMTP id v11-v6mr1978374oiv.208.1536756241749;
 Wed, 12 Sep 2018 05:44:01 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Jolly <paul@myitcv.io>
Date:   Wed, 12 Sep 2018 13:43:51 +0100
Message-ID: <CACoUkn4Q_tJW=Gn7i_fSbwm9sw2Me_KPv_Pq4eUD+cOXd1tnqQ@mail.gmail.com>
Subject: git-credential-libsecret not prompting to unlock keyring
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

For some reason today, after an apt update, my combination of GNOME
keyring and git-credential-libsecret stopped working. Stopped working
in so far as I am no longer prompted by GNOME keyring to unlock my
keyring, instead I get prompted for the password that git is looking
for.

Trace output below; would appreciate any pointers.

Many thanks

==========

$ GIT_CURL_VERBOSE=1 GIT_TRACE=1 git push
13:38:59.324799 git.c:415               trace: built-in: git push
13:38:59.325070 run-command.c:637       trace: run_command:
GIT_DIR=.git git-remote-https origin
https://github.com/myitcv/go-modules-by-example
* Couldn't find host github.com in the .netrc file; using defaults
*   Trying 192.30.253.113...
* TCP_NODELAY set
* Connected to github.com (192.30.253.113) port 443 (#0)
* found 133 certificates in /etc/ssl/certs/ca-certificates.crt
* found 399 certificates in /etc/ssl/certs
* ALPN, offering http/1.1
* SSL connection using TLS1.2 / ECDHE_RSA_AES_128_GCM_SHA256
*        server certificate verification OK
*        server certificate status verification SKIPPED
*        common name: github.com (matched)
*        server certificate expiration date OK
*        server certificate activation date OK
*        certificate public key: RSA
*        certificate version: #3
*        subject: businessCategory=Private
Organization,jurisdictionOfIncorporationCountryName=US,jurisdictionOfIncorporationStateOrProvinceName=Delaware,serialNumber=5157550,C=US,ST=California,L=San
Francisco,O=GitHub\, Inc.,CN=github.com
*        start date: Tue, 08 May 2018 00:00:00 GMT
*        expire date: Wed, 03 Jun 2020 12:00:00 GMT
*        issuer: C=US,O=DigiCert Inc,OU=www.digicert.com,CN=DigiCert
SHA2 Extended Validation Server CA
*        compression: NULL
* ALPN, server accepted to use http/1.1
> GET /myitcv/go-modules-by-example/info/refs?service=git-receive-pack HTTP/1.1
Host: github.com
User-Agent: git/2.19.0
Accept: */*
Accept-Encoding: deflate, gzip
Accept-Language: en-GB, *;q=0.9
Pragma: no-cache

< HTTP/1.1 401 Authorization Required
< Server: GitHub Babel 2.0
< Content-Type: text/plain
< Content-Length: 60
< WWW-Authenticate: Basic realm="GitHub"
< X-GitHub-Request-Id: EF1E:073A:6C8091:C2DB67:5B9908E8
< X-Frame-Options: DENY
<
* Connection #0 to host github.com left intact
13:39:05.084588 run-command.c:637       trace: run_command:
'/home/myitcv/dev/git/contrib/credential/libsecret/git-credential-libsecret
get'
Password for 'https://myitcv@github.com':
