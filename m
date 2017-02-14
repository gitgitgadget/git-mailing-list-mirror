Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876E11FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 23:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750923AbdBNXbW (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 18:31:22 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36608 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdBNXbW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 18:31:22 -0500
Received: by mail-it0-f67.google.com with SMTP id f200so7938850itf.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 15:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mSXJDhALL/JFE3M9P2k9NQnb0QKwERhEvYTZ8GCKt38=;
        b=N/uiy5AXklL+TTy0883nXb0xjbtOA0QOsMqOJB4B4eNExDZQ3Q37QHbpDIxGhOVZrM
         4byFVEjQUSXKQFYMPqdoHvYbXKLhJdg4fU+gRtVoSKqTEj7caVcKiU2ZhHjvSd99abaC
         sihIEIKj9NCBYrXdQkEGCMxYvvaqZkt2rUWnLrsnqiRwSN5kjz4ruZyUs8zzefqMIARB
         jJjrFwgGY8MVRGmWAdhyLmeg2y/h+HRYjGLI32yvycksKsPYAXxAEY9DGLoExRi2Iykj
         RXmKjOg/mFvp3a/1ZtHcFFsfRECFiia6Cbpsx2bGXNuDCO4XumH7TWw2+9wXMcMUmEZA
         xtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mSXJDhALL/JFE3M9P2k9NQnb0QKwERhEvYTZ8GCKt38=;
        b=RLipf4ODdcx0yhbV2GJUkkhcSF6osxjyF9URv8AwDDPHFsF4YoxlIMTXkMylLmHldx
         BSA7AqxkNce05u8T2um9kfar7Tsm5OpwJSDLqIduXFmqcptchBcfdhZOKDdWQb5KFXhP
         8R2V7lbEI33L/YKvujaJy2UfNaPCoNGJA1u46ZPy+r6bp0Y1ZRRxe09vv4QQH6PeojMT
         Yj09eLiCGv7l8aiKkX6z4ZDBLkT/wbdkQyhquCBznCyY/8XEPzdVLejX+MdIxQ0GpdBB
         TptEMAfG94UKs/RfA13en1TiT6RIZETmSWojYWeTv4aQsSV6/7b1e5q1Q2+cJoCrAls2
         XnHg==
X-Gm-Message-State: AMke39kut/8o0kdH8nipW2f+wkskKPFHUUTIjzQDmfgB6rg1D62T02Qz4R7YIPQ7O18H8A==
X-Received: by 10.84.198.164 with SMTP id p33mr39215789pld.85.1487115081017;
        Tue, 14 Feb 2017 15:31:21 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id u78sm3169284pfa.101.2017.02.14.15.31.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 15:31:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC-PATCHv2] submodules: add a background story
References: <20170209020855.23486-1-sbeller@google.com>
        <xmqqo9yblz33.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb2jZ9fgct6gncDqmWFsbY4MRiboFXPvw7AMcU2KanyfQ@mail.gmail.com>
        <xmqq4lzw8mim.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbjSLaUsJH_KuT6EiC+Kt-87+GjONt08hCytXULecMijA@mail.gmail.com>
        <xmqqmvdo76yw.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaeVrW3_kUWWxBMztOPuWY_V6XP2SUDyw8mmQ6peFZwdw@mail.gmail.com>
Date:   Tue, 14 Feb 2017 15:31:19 -0800
In-Reply-To: <CAGZ79kaeVrW3_kUWWxBMztOPuWY_V6XP2SUDyw8mmQ6peFZwdw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 14 Feb 2017 14:24:48 -0800")
Message-ID: <xmqqwpcs5ozc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I claim that the exposure into .gitmodules combined with
> the extreme similarity to its path is confusing. Maybe this
> can be fixed by a different default name.

I think that this may be worth thinking about it further.

The names are something the end users are not supposed to change,
and one way to ensure that is to make .gitmodules file a binary
black box that can only be updated with a specialized tool---as long
as the tool does not allow updating the "name" field, you wouldn't
risk them mucking with it.  Limiting the update to a specialized
tool also would give us a single place to ensure that it is globally
unique across the history of the project (well, at least the part of
the history that is visible to your repository).

Of course, being "one way" to do so does not mean it is the only
way, or it is the best way.  Keeping the information in a text file
lets you merge them more easily when you add a submodule B while I
added a submodule C, for example, and having a human readble name
lets us learn from the output of "git log -p .gitmodules" that the
repository of the "linux-kernel" submodule we use in our appliance
used to live at linux-2.6.git but has moved to linux.git over time
(for the latter use case to work well, we cannot change the name to
something unreadable by humans like uuid---discouraging people from
modifying and making them unreadble are two different things).
