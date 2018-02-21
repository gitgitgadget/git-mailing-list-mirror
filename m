Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3831F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeBUS3k (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:29:40 -0500
Received: from mail-pl0-f42.google.com ([209.85.160.42]:35844 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeBUS3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:29:38 -0500
Received: by mail-pl0-f42.google.com with SMTP id v3so1390355plg.3
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 10:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=9Vo7/w2bSZ2oxtRnzdxRABfCdqKNJ2xmCWh/yRLpciU=;
        b=h7guvpvWIu4i35OsrHPbfr3zS0yVGCZVtIjlVI+f9AyqP3iZ4zR3siWN90cRrzPWPu
         mH1rrvmuAMDDuyLOYj4Z01P3e0O93WKerNVMPfJWw6IPNzEKoJC//fkD/+YhgyeCuUIV
         TC4c+Nfxb6z7UXsgG/CnFmJokTU24OpeqF2Tb9s8nylSNMhkcCjb0jlEunNp5GVG9fyM
         hi8RusbNQ+aFzqteQiHH4DbDUqxgxyKyF3VtKWXLonW/HnVVgAB/FsqesOaHxyKORmz9
         MIpKjSzPHhpdNLBzBC9CcGMPEfZ+bvkxwei4BI7M/gfBT6jQymPNEZcZTardSkbAALdx
         /PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=9Vo7/w2bSZ2oxtRnzdxRABfCdqKNJ2xmCWh/yRLpciU=;
        b=GfwxiHen2R+VxNSMglUt8qW0rz42YX+pENKSYgLRACdZdNp4heJfGaz4jzerGJUgX+
         HXyyhoHxt/7DQLofNzTgdRA6QihNWcg4lQgNnvnA4etqoOuN+PBqZlKQehy97OpVeNik
         hsWy/1Hi+ISBTsyWK6jU2LIhW2dlS/ZDNSVsM19Nq8A/2ZO6cNzVxr6LU/Df6WFW1OrK
         WXfPMqjGn3KeyRN7qPO0W5eqh3Nb6Atzvip8eQ1SKry1/ty32oBEFT7qVKB+jCFNWIE4
         cwlbpg51bCs7KKgx6eA5ebQFOYL6KgbxfM+8FHrTcYiLYgczl9jXNmizEYPU2grC1w4Y
         QrLg==
X-Gm-Message-State: APf1xPDdZJj21jE70ec8JXDp7LWU/OuGasMDfl8E+23FXAINfkZITBrS
        c8q9DlGHD3X7IQmRy47YZ+xhxpGX
X-Google-Smtp-Source: AH8x225RIMZQi78Q+iojQ8WvNNb1bmrYQtEvhqKnOYJXO3/3Ti/iRhuYctdwF3ftQoQWAb6qYXOSzg==
X-Received: by 2002:a17:902:5a88:: with SMTP id r8-v6mr4080417pli.426.1519237777499;
        Wed, 21 Feb 2018 10:29:37 -0800 (PST)
Received: from pants.nat.office.privatealpha.com ([198.47.44.221])
        by smtp.gmail.com with ESMTPSA id 66sm9281641pfh.96.2018.02.21.10.29.36
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Feb 2018 10:29:36 -0800 (PST)
From:   Dorian Taylor <dorian.taylor.lists@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: bug in HTTP protocol spec
Message-Id: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
Date:   Wed, 21 Feb 2018 10:29:35 -0800
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello list,

I had been banging my head all morning trying to figure out why I =
couldn=E2=80=99t get a little HTTP implementation to clone/push via the =
smart protocol (just wrapping git-receive-pack/git-upload-pack). I kept =
getting the following (likely familiar to some) error:

```
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

I didn=E2=80=99t get an insight until I ran with GIT_TRACE_PACKET=3Dtrue =
on a known-good remote (i.e. GitHub), that the null packet-line `0000` =
has to follow the service line. This is not reflected in the example =
here:

=
https://github.com/git/git/blob/6464679d9620d91b639e2681b9cc6473f3856d09/D=
ocumentation/technical/http-protocol.txt#L216

It is also not reflected in the BNF:

=
https://github.com/git/git/blob/6464679d9620d91b639e2681b9cc6473f3856d09/D=
ocumentation/technical/http-protocol.txt#L279

(Note these links are from the most recent commit of this file as of =
this writing.)

Just thought somebody would like to know.

Regards,

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com

