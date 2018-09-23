Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3EF1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 22:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeIXElD (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 00:41:03 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36359 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbeIXElC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Sep 2018 00:41:02 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B2E1730D
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 18:41:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 23 Sep 2018 18:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=YqGMKA4hVwTj3aSX1Lto/NSqGSIMzS4HDKQp7N58TyE=; b=FLa+GU1R
        qZiTznEswsZYfX8AQWgk23rlnZuVERAPSve1ZntG+HNOyWcyYq21C25ym08Zy3Q+
        u6y8Ph3T/qiPa5MAUZK60JVpwhC5HcbwPcU7pIYzCGPG41M6zqOI9SdZ54oUmZmB
        87TU4UYNJ8OJAVbeT179+5oBeqCZ1qc2gPY/FiNYP0g2qWXFdp17v5rOR49WZk5P
        KsuwwkFdAjbRyOG1/HrMhzYiXfNfVlwjM4gm5vqxU5bQLYNU9etyRNMuwkgb+CpJ
        A9d2v23frhEHON+PqVcaWDJrbXaz6AqiRf10olMLtjBm/pj61AOrXTz1FH8BW29M
        eee3xyXgAyKUcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=YqGMKA4hVwTj3aSX1Lto/NSqGSIMz
        S4HDKQp7N58TyE=; b=SADHhS+Li6/KNWZNJ80sIr3I7ISa0qPvjMZtLRxE2Ba3l
        ZVSYVTTeQa8PFrOODmejugdK1m8wZIDSCoSeSXJtklF4D9b0gLD7qT0nosv29KWR
        cB2yox4q7le1IbjeUGJnaSE9LKikOmhhOiajapLabR1e8345i2zlorBOkgOIOj2z
        NzX6p3ycEzVviMF3kcdlmbsgY9h6pRMColEkeF8pT6hh/lstMJMAKvzlYg7zlMHd
        rqEhZ315gz3q1l/tVfuAJJ7ae/P+oCh2NV4baDD8QRmees3WMkJCjPxfRaXdwZ/a
        8ThcFBuPsLzxlL1A6aQB0BYzcG4fTU/1qxDG6Kf+g==
X-ME-Proxy: <xmx:rBaoW6_SNWuFPgJOglYfDFrKjcnHY2RRheuypktsviKXku7wOVxVVg>
    <xmx:rBaoW0-Mw7bpm50pIfNriNmv-i0rXbnxyhGI1kCzSQ1Wt9jLyg5YKQ>
    <xmx:rBaoWxyGJ0mG2klQIcSdVCdLzTdzmJgRbEghskuKykCHDGa17hkInA>
    <xmx:rBaoW3CHR30jV2EH-WRtBPNJ6AvFmQGSDF8X8vy0JhzMzrjnA__Pnw>
    <xmx:rBaoWyLskQvrf8fYzLeIYTUK5loaEv9lhsSIHpEiTDZIBGCgnGhOHw>
    <xmx:rBaoWxHdg7ExCdvswTK31lhigCuIiTE_jfgIj6dRIFsYmsdtdelkOA>
X-ME-Sender: <xms:qxaoWxTpajzztD2zS0Dl9VbcmKW-YxN-XcYuICG1aTgEumVyrSsp3w>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id A4E6A102D6
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 18:41:47 -0400 (EDT)
To:     Git Mailing List <git@vger.kernel.org>
From:   Stas Bekman <stas@stason.org>
Subject: git diff-tree ignores --textconv
Organization: Hope, Humanized
Message-ID: <41cd358c-d900-2996-b78a-b9d897a2ba2b@stason.org>
Date:   Sun, 23 Sep 2018 15:41:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm using a 3rd party application that internally uses 'git diff-tree'
instead of 'git diff'. I'm trying to add filter and it works with 'git
diff' but it gets ignored with 'git diff-tree' despite having --textconv.

I was able to reproduce the problem with the following much more
simplified setup:


$ git check-attr diff test/test.ipynb
test/test.ipynb: diff: jupyternotebook


$ git config --get diff.jupyternotebook.command
git-nbdiffdriver diff


$ GIT_TRACE=1 git diff test/test.ipynb
[...]
run_command: GIT_DIFF_PATH_COUNTER=1 GIT_DIFF_PATH_TOTAL=1
'git-nbdiffdriver diff'
[...]
<shows nbdiff output as desired>


$ GIT_TRACE=1 git diff-tree -p HEAD --textconv test/test.ipynb
<shows normal diff, ignoring nbdiff>

Git tracing shows nothing relevant as in the command above.

According to https://git-scm.com/docs/git-diff-tree adding --textconv
should have respected the configured diff filter, but it does nothing.

Is this a bug or do I have something misconfigured?

Thank you.

git version 2.17.1

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
