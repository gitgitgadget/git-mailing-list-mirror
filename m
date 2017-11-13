Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31F71F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 19:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755029AbdKMTkP (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 14:40:15 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:54955 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755023AbdKMTkN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 14:40:13 -0500
Received: by mail-io0-f174.google.com with SMTP id w127so4469079iow.11
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 11:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jEcs8HMsGdAzgUNSeZXhWD/NamKxEfZ3qBU/VZoOA8I=;
        b=eaxfI/sH0h6jPWQ09CKqbkG8wnW+rwnTPCxSNbYoISroW5bk74L88jcUlmNbmAp1xR
         0B++bSsGIe2lIcemeBcT+uQwVDD7jgt7gc5t3v3ytTNsphLgDOfJjN5Wh+ui79qXYpYn
         uNe6EucVV4FmlKdQzf7BWK6m/ZwECsYIFcPFUsbJLNElkpnFa9Jsp1Z100Fa7zUtROHd
         eucgANKjgbdtg4tm26ocJYL8oUo/VCoxZmWOr4Z4W5vPf7nfSz9onNGJrfYIIT8kQzMB
         NDayJUvgfadhZ9ufOQ9jeEpVkXwl1J1zRN7PkmGJnfwXB2gq1OmSItKPGQzZOqY2mJkQ
         mrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jEcs8HMsGdAzgUNSeZXhWD/NamKxEfZ3qBU/VZoOA8I=;
        b=PvzjB25nNSsiQs//4GT14ZdEBxhUy8FW1xSYl9vYv1dOs4niEwJkvIi0ojq6Y+qMIC
         WNeso8ZkJiQYDVfJiMKE79MJQvPodffOxY9yGP1BphHuinb4oEzq9/eMx1ZO+IqvTvwi
         b9OU6ksnfCGlDgU4zpHsEfWzOkmS+zsEJIXh/Gbe+4dGaRcqRjnVTMOaMXlzXqaaHKxk
         lfW4TAx9qjhm2Q5pam/DUCfAK/G4IZf1Hy7tYn9C8y4a4fd++9x5Ort4zmu5MU4WcbWO
         ffVGrXmx1Xnsw+BEsnilF/rio8Hw6Ev7m8m1B4jzaNaU484v34E/EfynUCQlb65iKti6
         wxsQ==
X-Gm-Message-State: AJaThX5sx4nJWnKoLimu3Mf+Niq4TrhbVQVPYiVFXoUato2MG2WVAXF1
        UahcW6g8HrbXKV5I0Sf2YxK9pQ==
X-Google-Smtp-Source: AGs4zMbWOLZlpDMxzy0b9D3Z7MsPhpvJHM0l+c8XIkDEuQUxMKVukP/vZ3vxqA1Dc+B+PLwPYF0qzg==
X-Received: by 10.107.25.18 with SMTP id 18mr11239024ioz.11.1510602012910;
        Mon, 13 Nov 2017 11:40:12 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:b1aa:4028:e6df:d3e])
        by smtp.gmail.com with ESMTPSA id 8sm7693330iob.32.2017.11.13.11.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 11:40:11 -0800 (PST)
Date:   Mon, 13 Nov 2017 11:40:10 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 0/3] Add support for --cover-at-tip
Message-Id: <20171113114010.0d4acb09a7a133f4baee9076@google.com>
In-Reply-To: <ab9dde24-bd1f-37b6-5fb4-247937e13432@suse.de>
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
        <ab9dde24-bd1f-37b6-5fb4-247937e13432@suse.de>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Nov 2017 18:13:27 +0100
Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> wrote:

> v2:
> - Enhance mailinfo to parse patch series id from subject
> - Detect cover using mailinfo parsed ids in git am

I noticed that this was done in the patch set by searching for "PATCH" -
that is probably quite error-prone as not all patches will have a
subject line of that form. It may be better to search for "0/" and
ensure that it is immediately followed by an integer.

Also, it might be worth checking the message IDs to ensure that the
PATCH M/Ns all indeed are replies to PATCH 0/N.

> - Support multiple patch series in a single run

Is this done? I would have expected that some buffering of messages
would be necessary, since you're writing a series of messages of the
form <cover><patch 1>...<patch N> to the commits <patch 1>...<patch
N><cover>.

> TODO:
> - Add doc/comments
> - Add tests
> - Add a new "seperator" at the end of a cover letter.
>   Right now I added a triple dash to all cover letter (manual or cover-at-tip) before shortlog/diff stat
>   This allows manually written cover letters to be handle by git am --cover-at-tip without including the shortlog/diffstat but
>   breaks compat with older git am as it is seen has a malformed patch. A new separator would solve that.

I think the triple dash works. I tried "git am" with a cover letter with
no triple dash, and it complains that the commit is empty anyway, so
compatibility with older git am might not be such a big issue. (With the
triple dash, it indeed complains about a malformed patch, as you
describe.)
