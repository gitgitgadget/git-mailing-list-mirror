Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F89C433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698BC60FA0
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 12:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhIRMYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 08:24:35 -0400
Received: from gourmet.spamgourmet.com ([216.75.62.102]:35709 "EHLO
        gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230470AbhIRMYe (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Sep 2021 08:24:34 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.94.2)
        (envelope-from <test.bentolor@xoxy.net>)
        id 1mRZN8-0004ww-KF
        for git@vger.kernel.org; Sat, 18 Sep 2021 12:23:10 +0000
Received: from mout.gmx.net ([212.227.15.19])
        by gourmet7.spamgourmet.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <test.bentolor@xoxy.net>)
        id 1mRZN8-0004wZ-1a; Sat, 18 Sep 2021 12:23:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631967788;
        bh=3odZG+VWiamPDCQxQm2q9glfnxovTWDIhdFkTouBQQQ=;
        h=X-UI-Sender-Class:From:Subject:Reply-To:To:Cc:Date;
        b=JagzPj1CjXNiWdIRYXf9pUYjbuybg23aJHge7wm7zfLjsPxMI+xY5NQ+1tWuhG/7F
         DAsB2WKzwfne81LKXsGtnf3LBIgLZrutPlE9vLL56H6frBAgszw2eJiuFIL4UwEhBR
         z067o+gm3ItnoaebGxzilgP2RmRga5sHnOP8SPiI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.8.8] ([92.117.171.27]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1nAHlx0J1Z-00lpu8; Sat, 18
 Sep 2021 14:23:08 +0200
From:   test.bentolor@xoxy.net
Subject: Test der CC
Reply-To:  test.bentolor@xoxy.net
To:     git@vger.kernel.org
Cc:     vger.git@vger.kernel.org
Message-ID: <01d71649-456a-a4ff-e34d-3340bdc4ff42@gmx.net>
Date:   Sat, 18 Sep 2021 14:23:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i5mwXZRDyeqs+8VNJbkj4eAGQVOzYOvzHoT/3dh/t5y5CK2PNv1
 pxc4rwQAKULrq4Cp18cCYofnXQtmtKISmXuYx+wSZ9qrSYiV7zTjM3ftJQbs9sCEunRb9s7
 MaV6ba6DJ+Rbk+6nN2B9LzoaFT0mURyvWuyAe3ouZFGunkYnggW89yaw4HrTNjqiPMs9gBH
 2H5BxC72KRqqxyuTlVXwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OXIjvawOVWE=:jgbfSYA+1K1Usygwe2yZkH
 UeTYJmjxiMDFU4nqms2CsfEheNJqqI0grCbL+VJp+sB0K6cyZR4hzd6HZVrCNstV1ww1NbUVR
 VURyrBJ5vnfe8aaHV60vwe8eCIYBrF0fMa264DimEH7C6/6oZS/NssssX2koTXdsQXm5eRUZg
 6rdE1n0zarlO+ZEAjzhKrkcMvwyrrmQVSvxxG9VECuzA9aJ/GvnYXxnP7ut48OhmdP/3GUiO5
 7Nioe91DExSi3yqpKgWSg+xRXqvbg4E4B+7g67HOeTV1Lq6LMm4dTr0Hg8TmLd/3bwbjEypTG
 FKBXYjnhASdrZc9d6pwWc6XsBuUQd3NvmMeHTOlqBNsmnEKTNzt2eICFov9c2R1THXucrCxIv
 yPyWaiVO49ZjotgtpbOqKGuDaz2s24v7NOU5+eJajp+c9dwq0xgVTk1FJRSMbOy/0hZWofVz0
 /EVE+pNkJOU+2fLb4PAnVnbkx6sAYmgg5tpOXHe0uKIyl41fa3/yRx5ZnQ14946d34EMrto3H
 9gB0WHKoGaFOOsTIBf3TMjJgbKvRT4dlo6f5FTyAxtFFVApyKUU3m6lKxPj8u5eKNmNuw5TWx
 Mu/N+v/TQVnA6aVCwoSw5SATLfjijtwek28g5Ud/1ZucA9eBoiaprlOXCmTEkuTbt+awAlmwW
 0vqEcwCnCnUTZWKVL6vBGeKVyIhcRvLRVIAY0GErOD3k1wkJJnhUA47Q3uxhgmMlS74HLY8Io
 lgeut2FjdhT0R3WzTKzH6h37fRdGH3dsP+/w3CpUuDZUy0+D7w/FQsI0Y0aIqPEt0TcjifvGD
 je1gIs5+7xUvSPv1GhzRqzR711o3dWc0EVePINip5BJNPw0REtXqYRB2QD3CB9QAwpLYcXe2C
 zBmGXeULij11THK7wFwxgFxTl4wYCT/110oGXe8atnu+DlZ2I8HUHct6OAIb2QWD7f8Ns1U+I
 eY9GRpzJhE2ZujrLQXLJ/MvI2LvWRYy/tRpCfNKHq+qj+1u1ePz3jsXfDSQCC7rajmivfdRvr
 WtI2AcnIjDbYaozA80B9+4V6ZHPVcoB5Qe5lv/SGgjXc6qSVD90y7eB8hkvE4OsmkbsbT/osm
 UPgG/ioRjpeAcw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



    They can include slash / for hierarchical (directory) grouping, but
no slash-separated component can begin with a dot . or end with the
sequence .lock.

    They must contain at least one /. This enforces the presence of a
category like heads/, tags/ etc. but the actual names are not
restricted. If the --allow-onelevel option is used, this rule is waived.

    They cannot have two consecutive dots .. anywhere.

    They cannot have ASCII control characters (i.e. bytes whose values
are lower than \040, or \177 DEL), space, tilde ~, caret ^, or colon :
anywhere.

    They cannot have question-mark ?, asterisk *, or open bracket [
anywhere. See the --refspec-pattern option below for an exception to
this rule.

    They cannot begin or end with a slash / or contain multiple
consecutive slashes (see the --normalize option below for an exception
to this rule)

    They cannot end with a dot ..

    They cannot contain a sequence @{.

    They cannot be the single character @.

    They cannot contain a \.


