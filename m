Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBDBD207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756223AbdD0ShW (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 14:37:22 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35889 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756199AbdD0ShU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 14:37:20 -0400
Received: by mail-it0-f47.google.com with SMTP id g66so21012573ite.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DdxM5LCtm2SUWBvB8/x5L7JOBMBl/aJGJZihBrDPs+8=;
        b=HI7ISVAUIYbbcWlWnMX58o0vPXlES1k6H6KVnzwPSI0ESJPXnaC4f+8RNHzX2P23di
         NeLE9sUiSSb087HDYuryZB46kzr62uJF8KsnBIWYleKi/IH/Z7BlE7lq+quKlUeZC1YW
         Bl8ep+Hs/VceG9/qoTJHhXbJtvvxpEIKgeHlqoPh6B3n8Zxj9EiJ19BdNIXrcHpeJ0rI
         mkXCg/Z9WPSM/zYjLTsU4/2fYGMm6+yKM9DasYB2snz3CfPqetY70pi8fH836RoTZpAT
         1+K8GTV8ibe0+MRR5FgSEHRif5bidsMGyzhiMVOgGD1SiUi4tLdJDP1l8Z8WPVOuLtY2
         qCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DdxM5LCtm2SUWBvB8/x5L7JOBMBl/aJGJZihBrDPs+8=;
        b=I2eQ048uObsqKr8V9T1ex4wTD+RZP2+Bsb/5Artmu/vTcSfeJWzry+07qlW5AcxBfO
         8wjd/0e6JsC3J+MBuZPlhH7fd107GqZ9nQdgCqW38KSyA/1Yaq5WZhvnM0RQL/tld/aw
         SNr5AMrIKDIGO4uCQBlKXojbAf5T9+5tl+RWiBnzqmB56rMPI68LgC6LKKe0q0OA82oE
         Bs0p525qk/iAc9MF5SUwxzHb9w07lghNQK3Cd2eioNbnwwNI/Bqi+AQa0cuqxuJfv69A
         +auDvJl5UbVAd/jBlh7tBVFjPWPAFQu4hjogVr0h6cIuz569G0Wb+3Q3NYhP0W2fFoRY
         2IRQ==
X-Gm-Message-State: AN3rC/4jQNuZiiS4e2ij0W03BmK/Lcxc5+/GRl5Yhb789YVCoLqXZU1r
        Bg3BUy7j6XFaVPI4zBKx4Aw/Ix1EMIzeqrE=
X-Received: by 10.202.207.145 with SMTP id f139mr2987537oig.55.1493318239811;
 Thu, 27 Apr 2017 11:37:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.136.13 with HTTP; Thu, 27 Apr 2017 11:37:19 -0700 (PDT)
From:   Andrew Watson <andwatsresearch@gmail.com>
Date:   Thu, 27 Apr 2017 14:37:19 -0400
Message-ID: <CAH6sfJUn99ezs-uZuYVj15qOeMv79ji7r0Ldvoreef0z3LzG8Q@mail.gmail.com>
Subject: push fails with return code 22
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm trying to setup git with Smart HTTP so we can move off of SVN.

I've used the blog post: https://git-scm.com/blog/2010/03/04/smart-http.html

I'm getting "error: Cannot access URL ... return code 22" when I try
to push. Clone works fine.

I verified authentication by replacing my LDAP stuff, which looks to
work according to Apache logs, with Require all granted.

Done a lot of googling and posted on stackoverflow at this point.

My system is CentOS 7 which reports git version 1.8.3.1 and Apache
2.4.6. I also tried on Ubuntu 16.04 with git 2.7.4 and Apache 2.4.18.

Using GIT_CURL_VERBOSE I can see it fail after a PROPFIND.

My stackoverflow post with all the debug info I could think of is
here: http://stackoverflow.com/questions/43643152/git-push-results-in-return-code-22

I'll re-post whatever is requested here if needed.

Really hoping to get this working.
