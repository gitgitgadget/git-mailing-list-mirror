Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27217202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 18:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbdGIS56 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 14:57:58 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35022 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdGIS55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 14:57:57 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so10176855pgc.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=reE2mDbyPZP5GjkewtEr+wbKFpNwko+6z0tEWAT+TZM=;
        b=UWm/R1LdAlcPPk4sPGGdhM1tbJOLxmgbDcQldetEgEnwXkiJQF7En+Ltd4Aww5yxHK
         b3Hqyx8r3u/+Xzv6kA8XpWATSYYdEZ0QwShHu0sniUxbYd2DD0JvRKyDuWGd8Twum2Gs
         qtfWN+aa1slRw1xq0ZdgIb1UtDtlWPwsdJEKtKyLL7xv2cj73kmLdAoSsTIsKgTozrbd
         YDwkKp3xQKDbhlJOafU8jWNWP1d/cS2U7rWJ4HrbiDuT1v1smM8VKp3iS0co1UwoyHzD
         FpGSrrbUWpLptEGyfDfY6AVPBUlxn58znEE3jzFv3gUfbO49HpLJnmk+HA3og8c1owAu
         zVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=reE2mDbyPZP5GjkewtEr+wbKFpNwko+6z0tEWAT+TZM=;
        b=Iq+DW8IV/zA+R/Pi0CY03p+YuCHMuASTTeqP0XA+2Vx7iGVdcRtw2I+rMDqn90URy2
         Q48vqahZoutXmBIM6jVv9X+MB8GdpMKvES4mOBfzh0+nHyfUBEAoau0i1xOYfs6q7JuM
         a80kBDObx4dbGLMEB+SFl/UcmsYUsjppbw5KZFXvPc/GatPnKY8MrCE3Qse3+Ny2ZOG9
         BnCoHcfQEnm9M/UHxoykhpjZ20NbkJMEo7Fm5G7QsGarP15AgX6418WjbcItUXD6r62u
         BecFSATzapaJouUAQic38VChfzbvbglkCqQCOM7ymEeYPARSYieIuNBaf/QPs8ObtBG3
         PAxA==
X-Gm-Message-State: AIVw111hLE7ch/jnufGBTPhDtbIzuSVsitERjdPXbeE4zmSe4oSeQEpy
        nx/V088Zd6Ld+Q==
X-Received: by 10.84.138.131 with SMTP id 3mr14306441plp.293.1499626676700;
        Sun, 09 Jul 2017 11:57:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:dc1e:60e1:7751:9c92])
        by smtp.gmail.com with ESMTPSA id w125sm7152727pfb.117.2017.07.09.11.57.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 11:57:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "Branch exists" error while trying to rename a non-existing branch to an existing one
References: <1499624859.8552.9.camel@gmail.com>
Date:   Sun, 09 Jul 2017 11:57:55 -0700
In-Reply-To: <1499624859.8552.9.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sun, 09 Jul 2017 23:57:39 +0530")
Message-ID: <xmqqd1998mks.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> I recently got the following error message by change as a result of the
> command,
>
>     $ git branch -m no-branch master
>     fatal: A branch named 'master' already exists.
>
> Note: no-branch is an hypothetical branch that doesn't exist.
>
> Shouldn't I get a 'no-branch' doesn't exist before that?

This is borderline "meh" at least to me.  An argument against a
hypothetical version of Git that "fixes" your issue would be that no
matter what the source of renaming is, as long as 'master' exists,
"branch -m" shouldn't overwrite it, and it is a good thing to remind
the user that 'master' exists and the user meant to rename it to
something else.

Of course you can make the error message three-way, but I do not
think it is worth it.
