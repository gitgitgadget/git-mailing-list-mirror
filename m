Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D8620281
	for <e@80x24.org>; Tue, 23 May 2017 18:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762820AbdEWSw2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 14:52:28 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34017 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762444AbdEWSw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 14:52:27 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so122905086pfj.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9w2XLCWEot8rtjRj7c8gBbp6VFFTPoxHtvbyTI+EJNo=;
        b=O+0AgQWoHlKDcezZhy+wYVYILxWoeQTQoJECBpHD3glDuIH7FFIs4cDmzk8hVgh84F
         wtArn8FUAO0wTV+sx4mkcsAdP809dtIvP1MI+wLCqI+g3BhQ58c0Q7rtK8xTZ5CjxXlW
         TZYIo18xjt7fvNH1YEGeshpDd1KsLjrAewrpgVHy9l1mt1ftCza66QoyoycUadgZTgUq
         +9w8ju0pZeZhvWcdhepsoyR6P4KP3MaBEVm+4gu2WP4VN/np902ywteGtI6y6Fl8Lkpd
         nFCz9ycIQ+4c2sTD7dRe27pRV29hf/vk8160fVOUQ+FfQoDNFzkBjjzSuU/oc02wzqeZ
         JihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9w2XLCWEot8rtjRj7c8gBbp6VFFTPoxHtvbyTI+EJNo=;
        b=opRkUQ0kmRlaUBaChxR4CiJan5tENl/7SLsZwK/pz9qodR2bE9Qdsqw1b7zWrqmIls
         AFR4roZXhkcf1Yp+qfJXniHowGyHkShoCIHryaUMQN1jlcYeTHeImCqtvoLeVKnHl7QU
         Q5sBu8C0mvUY9Hl/nIg5l80TuhjzDIoeTnUgPAOQehTrdvLb2bFHK8quk0FIKXC67XJT
         txnYN2DUxTJFZorRIUA4tf3NHOTheDG+mnT70UI3yJtBj/4/x+X+3BJfBgjza7N9tMRH
         gilyYxBsKM0R9FYIglcYtmMgRejzIn00Op3y9eZ6Zv3pIJdRfdbWo9wwhcAnxPbMkaX/
         agvg==
X-Gm-Message-State: AODbwcD8j23YCMTYU3i/3L/5Ta/9ayNhgdW2mUFq2AjHxNrXgX0phqNB
        7xC8HB2JBbyIGZZ5Fosxe9WyYHmthbG1
X-Received: by 10.84.142.133 with SMTP id 5mr38276607plx.52.1495565546728;
 Tue, 23 May 2017 11:52:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 23 May 2017 11:52:26 -0700 (PDT)
In-Reply-To: <20170523184026.GD115919@google.com>
References: <20170522194806.13568-1-sbeller@google.com> <20170522194806.13568-2-sbeller@google.com>
 <20170523184026.GD115919@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 May 2017 11:52:26 -0700
Message-ID: <CAGZ79kYhTVG4uCZuPj9fWRF=cKbjPXEdE3ukwD3DgzbnOuwMTw@mail.gmail.com>
Subject: Re: [PATCHv2 1/6] submodule.c: add has_submodules to check if we have
 any submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 11:40 AM, Brandon Williams <bmwill@google.com> wrote:
> It doesn't look like any patches actually use this helper, is this
> intended?

It was needed for
https://public-inbox.org/git/20170411194616.4963-1-sbeller@google.com/
which we do not have in this series any more. Will drop this patch.
