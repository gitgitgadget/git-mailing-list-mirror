Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E8321847
	for <e@80x24.org>; Wed,  2 May 2018 04:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbeEBEh2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 00:37:28 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36564 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbeEBEh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 00:37:28 -0400
Received: by mail-wr0-f169.google.com with SMTP id f2-v6so662478wrm.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 21:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t98dh6+zyHSBckSgPsVvAN55jH7YlNm3Zf3E7JLU9kc=;
        b=UqVfj7JYJ3BSpVwbMGx5CxCdaCIJ6ChM3VXQY8vdExbRhjmtJEsrwnHNA30AVcCCOM
         IvNYskVmR8fmwYmUq8CQB4Zsu2bsZ/c+S4TvEp+w6UKir7kvcIasX+Ok85jSM6PXlVQN
         QpUb+i2oNnhcJSPwl/GyLSRGTxbLWs451XdwpsaE+eEW+ma8m5npM9gKfKCFIJ1NbmNl
         3ysDrFovFjDP2uzBcMflKMQ4sdxB/6FrIC69AdmESHKwGbTlyRLt7rfMn3gklPbUIwml
         5C+4I68OM22NXpAbW9vl+u3DV4g9RfE+G6Une+094z2qyAg28vlfn36YTlMZt5DMoIZz
         XwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=t98dh6+zyHSBckSgPsVvAN55jH7YlNm3Zf3E7JLU9kc=;
        b=Hu+RVzBxMGud2UnX+uianhW4Vej/pYgtUVNxom7yQmeZocQoIK5LTqtZIDzQDyI02a
         c/pC60fm2UkR4om4DLBnu8VOQTA0zq5IA8V8+OrEmpyT5Or6nBdvVVSpmzc0jac2IluL
         vig6CLvjYA0NqWAv5Cf+NzdyJMjLHug4Abz5+suLWVDQsKhcrFn26V6KcPSiguyeFrwN
         BCAjw9z12k0yeS8XavzJnSWeN19UMiPgdTT8Fv2zKv1wLdIVKgnnczfl36K6/TkBv2Sz
         7G3clfDXm7lNz4RtRONhX0RXraDnWeDF23ZvAAom6Dq4B708LbC9uKIWgy26Hy0+oU3T
         tecg==
X-Gm-Message-State: ALQs6tD+lp6Ts50NdRcjhpEMNXA8dWElLtmX9fAjZyf1POSD0pzCMWx8
        i46WWYqpK0bcDLZU9RAMp0k=
X-Google-Smtp-Source: AB8JxZo8bHU6RfjF6XwMsdPik7xliaIymhTJYcUlzUGFKbIsanRg97d+9MQw0qkiZlJlu7soPRo8JA==
X-Received: by 2002:adf:8703:: with SMTP id a3-v6mr11527533wra.178.1525235846632;
        Tue, 01 May 2018 21:37:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x63sm4384279wma.25.2018.05.01.21.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 21:37:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Casey Fitzpatrick <kcghost@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH 0/3] Add --progress and --dissociate to git submodule
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
        <20180502005528.19740-1-kcghost@gmail.com>
Date:   Wed, 02 May 2018 13:37:25 +0900
In-Reply-To: <20180502005528.19740-1-kcghost@gmail.com> (Casey Fitzpatrick's
        message of "Tue, 1 May 2018 20:55:25 -0400")
Message-ID: <xmqqefiuwu4a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Casey Fitzpatrick <kcghost@gmail.com> writes:

> These patches add --progress and --dissociate options to git submodule.
>
> The --progress option existed beforehand, but only for the update command and
> it was left undocumented.
>
> Both add and update submodule commands supported --reference, but not its pair
> option --dissociate which allows for independent clones rather than depending
> on the reference.
>
> This is a resubmission with comments from Stefan Beller and Eric Sunshine
> addressed.

Readers would really appreciate it if these are prepared with
format-patch with -v$N option.  Unless they read faster than you
post patches, they will find a few messages identically titled, all
unread in their mailbox, and it is not always easy to tell which
ones are the latest.

Thanks.
