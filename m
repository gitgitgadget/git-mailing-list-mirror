Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E3B203C1
	for <e@80x24.org>; Wed, 24 Aug 2016 14:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755377AbcHXO21 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 10:28:27 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33298 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbcHXO2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 10:28:25 -0400
Received: by mail-ua0-f196.google.com with SMTP id u13so1382807uau.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=3Eb+xoP4IR/C/wUPb0C1kNLFC3HWWKyf7KHGwJdgIAE=;
        b=KyhhyqEhFuhIoQoBlGaaUyL6TIa/h4YI9MyMFToWgWBSbwdMlY6MQWLtSwQFY2IDTc
         +b86eeJYowP+Fj9HMdI7aSb/vDxrteYDjwvnYgQqRzVDh7pClaQbSKUT7FZ0A6qjfPyN
         gRMrro1OqzJ3H5gxCxluJjD8f4/rwovik9JnzGmdLhmc9jd3W7x8QLIdPI43bpMUIMj7
         N5G89AVkWOjt2fcvm9zjVbe6Xy90Kporsqsdx8ye9iwT9SsFWtR2BxScFqEBvfbHoRpx
         x/cw6/L9Wzo7loenKGrimHsWbkGzyvFIS59foJRYdeDhYKPELIGdkuApoOG4deSFrpZa
         rYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=3Eb+xoP4IR/C/wUPb0C1kNLFC3HWWKyf7KHGwJdgIAE=;
        b=FEeVG1uwCiNtXkF1fi1J0CnRIkaJ0MkYjQKhX+8Jsd8WouE1lk/YvQvgOeeCgTEvxm
         U4A2sXAgcd54hq9Zt/sKuS24V7gRjl90uXLjlnm9OrAbBTU3vo4eT43SPa4ykK3mwLCN
         TQBGiUEfoVOEY7PuTmUvUn75n48eAenuCtAUWTtrVnbXusuZw+V17OPN+L+vucXMBe5d
         GgcbLWRgBG4Iy0/L2lvHDvCwKwh/PYqxjZV9VIGkF4CI2bJwgjjEaTNCXvqjJHsplc2U
         6VKsAZbLa09DXxCTRHqyIrZqlJ4IhFKtPyXcu3BQWII88o3ICwgqUq1lKh+rB5axtS1N
         MXpg==
X-Gm-Message-State: AEkoouvka9+KjmYTcIvbIKnR6/NZVx0XtXsgOknGeYr8I9UZnyYAT8yahiilN8f9e5Ulw0RaQXf3NYwWfemOiw==
X-Received: by 10.31.130.144 with SMTP id e138mr1829707vkd.145.1472048904613;
 Wed, 24 Aug 2016 07:28:24 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.4.230 with HTTP; Wed, 24 Aug 2016 07:28:24 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 24 Aug 2016 09:28:24 -0500
X-Google-Sender-Auth: FQHS6TF0MtHdBej_uI3bt9nTLr8
Message-ID: <CAHd499DL2WiTgnk5A--qihUh-jF9m7aXDzHAQuW=bLRVW4Bniw@mail.gmail.com>
Subject: diff <commit> using 3-dot behavior
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to view the complete diff of my branch (topic) relative to its
parent branch (master). This should include cached/staged files and
unstaged working tree changes.

If I do this:

$ git diff master

This will include changes on master *since* my last merge, which I do
not want (I don't want to see changes on master, only on topic). I
tried this:

$ git diff master --not master

This didn't give me any output. If I do this:

$ git diff master...topic

This shows me only committed changes on topic, but excludes staged &
unstaged changes.

How can I get the results I want?
