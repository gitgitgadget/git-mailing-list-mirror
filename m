Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC5520966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754615AbdDENq5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:46:57 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32777 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754592AbdDENqu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 09:46:50 -0400
Received: by mail-oi0-f43.google.com with SMTP id b187so15623733oif.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PKI/BuF73/D+3Ac5v9/BVkVv4r4ZLyj3uu8cgMQOIWg=;
        b=CrYuzw4xIVmKX9j4UpzBAUWyPFAkTYJUtnno7Hgn0AuDHa8LIiZydmwKFZ42EevepH
         9gGkFYAqdWQmE0toeoq2hUbke5pw/8gr78/UPzvsEo470GtH5AmPNxB9f4xz8lofSIoN
         X25zawxDG29H5hgbxAK41WfaEWq6VpQU6emb0+X16IZRWcpYO8Xo80Hg5xm5GqjztK5y
         LVesJJXjT5NrOiwMfk4LbvKSufBRR1ek2VAIlHIIGbpzrPCLRbxcXidG5tHnTFGK7HBU
         E92aWRMOgXY/dn+Zi8LvmaQyvp0XexP5YNipU8rXOaM3xCQ4bpbE3RyWoqt8MttxKltz
         Vn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PKI/BuF73/D+3Ac5v9/BVkVv4r4ZLyj3uu8cgMQOIWg=;
        b=cIaaIMnYwkzRfEp6ytG5ALRoiRzoE01VDaUkR9aMMJiVI74TF6uW7PjCBR4M/X7v1T
         SDxBRLs+fJIYtkoIpnQQb0pk7pnMIqSpDdvHPxJKuE7FhR8g/3keojnAeZWMtwJE7hB9
         +S41y1BeBIvcIwgPAOgCXWCD0HLBa+vziYYAyKvtiztjIpbF45zKitbaG1lJ1YSJJp5i
         zZYWbDmrDE/xzSnvadqzrlq11xLdrluxdBFoWXI/Fu0En9opnHhFxuGUeB4is+fP5OB2
         o3FaiMKF4AcwzvXKW5GIxpmEowWczz4OEN944AVtEkJiM4mo1oIo8rrsDGOU1RMovi/d
         EP3w==
X-Gm-Message-State: AFeK/H1WSaZVXCYnlL5JDmo72i0ZiLzFGBAnJIjCEmgy2+uFVAiCA+KIFITI4q6My75L60RTdmJ2tVDh00nu0A==
X-Received: by 10.202.104.133 with SMTP id o5mr4352077oik.146.1491400009478;
 Wed, 05 Apr 2017 06:46:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 5 Apr 2017 06:46:19 -0700 (PDT)
In-Reply-To: <20170404163909.GA189807@google.com>
References: <4650e1396a5ad006b2b4f355685e3c59efd554d6.1491297393.git.ps@pks.im>
 <20170404163909.GA189807@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Apr 2017 20:46:19 +0700
Message-ID: <CACsJy8AeZWmGuvEqoA4y6rM-kiz6_7r31Q4kqor7+sHSwgZ1sQ@mail.gmail.com>
Subject: Re: [PATCH v2] pathspec: honor `PATHSPEC_PREFIX_ORIGIN` with empty prefix
To:     Brandon Williams <bmwill@google.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 11:39 PM, Brandon Williams <bmwill@google.com> wrote:
>> This is the second version of [1]. It fixes a bug catched by
>> Brandon when the pathspec is resolved to the empty string and
>> improves the test a bit to actually catch this issue.
>
> This version looks good to me.  Thanks for fixing that small issue!

Looks good to me too (I didn't see this when I read v1, too much mails)
-- 
Duy
