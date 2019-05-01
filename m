Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4A71F488
	for <e@80x24.org>; Wed,  1 May 2019 21:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEAV5l (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 17:57:41 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:38357 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfEAV5k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 17:57:40 -0400
Received: by mail-it1-f182.google.com with SMTP id q19so4016itk.3
        for <git@vger.kernel.org>; Wed, 01 May 2019 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=TWGretORS+Pi5Ezouvpbm5/pUN14v5E+xVOmJR2e2/U=;
        b=AknOpE2XMdlawds11d7Vn5GyGQLoAl1N8xvilHPspXKcZVjHki4aMDH1yOKE4WXWns
         RU5oXtgqMDOnz/IITJ3L6tTsg37/BtSDc7ArDC+cIgBLDPLAFt7gKSrAb4MnguL/Qn5H
         AOJQSE87XmWK+Y0rJV9Y48Z69+YFVCDHdqrfJyOARuz6gxi516mgSQtRLGYg0i53czNo
         xXynoqlqmSEr5hdbJ7orN+KN2wnk5V+fp7xJZ618LgUQykZF4Ogj0uxFLiMrUHXBzeyJ
         kzF3+fVFA9N+NElnJ/49DSTK/dco+ZpNcrqSGOsXqQ+xTeRKzy5QWJVM8B1QixtcjGCp
         V5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=TWGretORS+Pi5Ezouvpbm5/pUN14v5E+xVOmJR2e2/U=;
        b=VCsqqYnbZanbI406oMtXsNV7nPn1lCMeDzeIBzVGO99U7ful9iOCLncXL9QwM3wbMO
         410mRz/AiN7s2nSglcP6hQmw5Q1Q47W6jxpUuGdGiNuRFVgNHAnJPtjP7s2oEbzMn2ST
         rkfhlnG8Vv2MNpoqdENIDadCPsQXllpZxwvZmVejgyYnOxEwAwa8YuKHBpusubEooJdh
         /nvUGnZKcQaEESk6UFKS55YNGPnO/Av/SUbwTLO2XsMJJzprrdP5RS+iLBtj+U1gqaw7
         cpgw4qpybkQVLUPaucM7cW5YtKl7e/g83OhPzV51Bc2LKlNQV/JRPKhpS+XjwjoSSPse
         X4xw==
X-Gm-Message-State: APjAAAWkFR+m4xM7VGdqnTEek6UsCZD0/mFHZQ9/j2MDxdWCbNMktkIt
        z0dik5PIpN2YqjYh0ho5zhp4tzcpUl39PpxBLqoFsXQc
X-Google-Smtp-Source: APXvYqxQ+Mz2jbafBfGBnBM+ec9FEYYhmImc4phwGs+pN9j2NVgdviLLhn+ezisghIREjYFmojB+GVjavmQs9WyFnSs=
X-Received: by 2002:a24:1104:: with SMTP id 4mr3301154itf.10.1556747860115;
 Wed, 01 May 2019 14:57:40 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 1 May 2019 17:57:24 -0400
Message-ID: <CAH8yC8kec2N0fkt6cWChOEGtGkrOE5S+QuZnQnDP1eM9mg_EOQ@mail.gmail.com>
Subject: 
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm attempting to install Git 2.21.0 on Solaris 11.3 x86_64.
/usr/gnu/bin is on-path.

'make' was OK, 'make check' had a few failures. 'make install' has troubles.

$ sudo gmake install
...

gmake -C gitweb install
gmake[1]: Entering directory `/export/home/build/git-2.21.0/gitw
eb'
gmake[2]: Entering directory `/export/home/build/git-2.21.0'
gmake[2]: `GIT-VERSION-FILE' is up to date.
gmake[2]: Leaving directory `/export/home/build/git-2.21.0'
    GEN gitweb.cgi
    GEN static/gitweb.js
install -d -m 755 '/usr/local/share/gitweb'
directory /usr/local/share/gitweb created
install -m 755 gitweb.cgi '/usr/local/share/gitweb'
find: cycle detected for /lib/secure/32/
find: cycle detected for /lib/32/
find: cycle detected for /lib/crypto/32/
find: cycle detected for /usr/lib/locale/en_US.UTF-8/LO_LTYPE/32/
find: cycle detected for /usr/lib/locale/en_US.UTF-8/32/
find: cycle detected for /usr/lib/locale/en_US.UTF-8/LC_CTYPE/32/
find: cycle detected for /usr/lib/32/
find: cycle detected for /usr/lib/security/32/
find: cycle detected for /usr/lib/link_audit/32/
find: cycle detected for /usr/lib/rad/client/c/32/
find: cycle detected for /usr/lib/secure/32/
find: cycle detected for /usr/lib/fm/topo/plugins/32/
find: cycle detected for /usr/lib/lwp/32/
find: cycle detected for /usr/lib/pool/32/
find: cycle detected for /usr/lib/brand/solaris10/32/
find: cycle detected for /usr/lib/elfedit/32/
find: cycle detected for /usr/lib/gss/32/
install: gitweb.cgi was not found anywhere!
gmake[1]: *** [install] Error 2
gmake[1]: Leaving directory `/export/home/build/git-2.21.0/gitweb'
gmake: *** [install] Error 2

Jeff
