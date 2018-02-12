Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5234E1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbeBLVoM (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:44:12 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39868 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeBLVoL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:44:11 -0500
Received: by mail-wr0-f193.google.com with SMTP id w77so2191954wrc.6;
        Mon, 12 Feb 2018 13:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EjnoQXyHqRJiq7mAL5/+p+qhHjUon9mUH9stNjmjFf8=;
        b=vY2DSy3wztAdrThldmw9UK1HfKlf5TGDj/osHyOvcIU1wYnumJfNKIRusRsMWipYhe
         T70vkk7ztwXMQh2qM2ct76PB8T6ox+gIj/P5YaEp89IN/CQ6HnB9Xsvj/oCT2lwXjxiW
         zqb39t3yPzAbVMnWmArF2/TLNcA1TolR44taQEqNp+FlJM7zXo80+UpVjwPXMOuXWaRJ
         cmfWZg4hI7rXhLMes4kFbwoAVTobjLPUv2JrtzJrfJFqg8EghyljOeAe9VY5ts2jKvUU
         Y5y97zCGGytI3OVQAtF4ZncTdXXomsMCVsJ/KSMLP5Zp3ei0DF94AnqSdqN/cEgU3Ctt
         Vy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EjnoQXyHqRJiq7mAL5/+p+qhHjUon9mUH9stNjmjFf8=;
        b=B9Knh2O20ru2/v6Bz/qWK8ZfiVC1fkgBnf/9mrKNJzrWpN/0hjMKJBfCJnm1udEPHk
         mkmY4lqZRpI+qNxaUabmvulX7yxUs7SZWSESGAW8k0j4ObaoP4eN1bYHVeFfB5inZ/cp
         bVXMCemf4NQ61mCNM6YADxX3fZe3ye3o0gwXNm06WawlKiXeTL+DlpSg3lnzjU7F6Czy
         8S/0Wt/8xLiHph87voESS3v2dv+nIhot7wHQXd/6dBY3nigzsFHQ+lFSjZVHqYBOKOhd
         ylfqD2eP/cfjRhrNKalulmoGImMpDLuSY44JkLFofW+WgnSyXBWh5+s32DfOynDjFtJX
         aH3w==
X-Gm-Message-State: APf1xPCcimgcPXD9hwUJj+kvAUCXgEPlsSTF1Gj8lm/UPoi26a8KWmwa
        7tkVrwGG/U1fvpEDcdrppqU=
X-Google-Smtp-Source: AH8x224EoGAsrZb2VmYeWwL9Xvhr1YW8rsDXw1vkHv1qSH+S5Yq2Tmct6GqBXcWCNKNgk7VvXK+AyA==
X-Received: by 10.223.135.18 with SMTP id a18mr10638968wra.126.1518471849173;
        Mon, 12 Feb 2018 13:44:09 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k125sm14648453wmd.48.2018.02.12.13.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 13:44:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
Date:   Mon, 12 Feb 2018 13:44:07 -0800
In-Reply-To: <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 12 Feb 2018 13:37:04 -0800")
Message-ID: <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Maybe we could just tell people to have something like
>
>        git config --global alias.update pull --ff-only
>
> and use that for "try to update to upstream".

I guess our mails crossed.  I admit that I indeed wondered why you
were not giving your usual "downstream shouldn't do pointless pull
from upstream" briefly but focused too much on how to tweak the
default without thinking through.

But I wonder why "update to upstream" is merging a signed tag in the
first place.  Wouldn't downstream's "try to keep up with" pull be
grabbing from branch tips, not tags?




