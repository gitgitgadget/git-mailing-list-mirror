Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AAA1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 04:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeDIEyf (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 00:54:35 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:54168 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeDIEye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 00:54:34 -0400
Received: by mail-wm0-f50.google.com with SMTP id 66so9442142wmd.3
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TgaQGytMbIALdqB/cESSMKvbJIqTGzxyFX0FQ5jk7aw=;
        b=O06gQddXW4ruudxC7BABN0sfl2kbsEMEX0mOk5sxxKw/CfbqiFA9cs/AuTToQaplu7
         sitAVOXldjGrSng+Zognj2VanyK5njJY6luvDD/YJkA36RivCNpYmngxax+hK8uBLtpQ
         aH4aACA23OJ+240SQ6JswOpZkbaJ9niNObQrHHzktgbQ+yPd+BCW6gwTLDeViLt/1Yy+
         kKGukrrhlmddChWGrth8VCR2YQ5RjPG9kkUlxWI/xK8gh4HtrrsqB7d/nLKLq0dfnxBX
         Jvo1jeGouAE9N96IVn6JTuQW82FpTU/RFi6GepX9mhK+WdYr6Tm2zOgDuvQOLfwBxMtz
         qROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TgaQGytMbIALdqB/cESSMKvbJIqTGzxyFX0FQ5jk7aw=;
        b=HBZbN1Nx/p7XFBCwJImrb8n7Fb+DnIv3ErqZKpZ5o0SW/AjGzyAqX/Vadf5KPgPaDN
         /JywOpfo8TVZ/CDqig9BYI/fjbH1dgYW6VskqC9zf5PskZLGb/LJUBrfry1AUZU7eT0S
         FrdKGyhr6jbAo5bfR00ZnD0+dkzjBBMHeN+kHlE9Z+ALFnWzd8wRiTpTXodnXKZIznMT
         Jp4cyQioHM0TwqvPJnOVFHfFexLITtsOx9EH1x1VZ2FOReyoUMGQF9eSezMTTFSsUWai
         0SI0bvLSdF7Yw1a4sDTsCFhVi3jv626ZWV7IFyCuiIupiy1wlYiycpFX7jRtVX2alpy2
         BbjQ==
X-Gm-Message-State: AElRT7FTAjI3q+IvdMn0K8yg236YsnaGSyRPFmeLpOy+k1huYDuYfDlP
        FaJByWyHTpK+S+LUjk8S+ic=
X-Google-Smtp-Source: AIpwx48EjRQKnSEFz0zN9gahcE/LS4XbAI3wK2+Lv1hB2kIGX5JOpgOl+mOu9Y54J93V0zTAQv1F5A==
X-Received: by 10.28.145.205 with SMTP id t196mr17037317wmd.110.1523249672948;
        Sun, 08 Apr 2018 21:54:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p128sm8023367wmd.45.2018.04.08.21.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 21:54:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Christian Hesse <mail@eworm.de>,
        Git Mailing List <git@vger.kernel.org>,
        Dan Jacques <dnj@chromium.org>
Subject: Re: [PATCH 1/1] perl: fix installing modules from contrib
References: <20180403092008.26892-1-mail@eworm.de>
        <87tvssva2c.fsf@evledraar.gmail.com>
Date:   Mon, 09 Apr 2018 13:54:31 +0900
In-Reply-To: <87tvssva2c.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 03 Apr 2018 12:49:47 +0200")
Message-ID: <xmqqpo39569k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>
>> +perllibdir:
>> +	@echo $(perllibdir_SQ)

This use of _SQ variant is fishy, isn't it?  Judging from the output
of 

    $ git grep _SQ Makefile

e.g.

    Makefile:	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
    Makefile:	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
    Makefile:	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'

I'd expect that any _SQ variant must be referenced inside a single
quote pair.  In fact, that is why a single quote (and nothing else)
in the base variable is replaced with the magic "'\''" sequence,
first stepping out of the current sq context, append a single sq
(escaped with a backslash from the shell), and then stepping back
into another sq context.

I think nobody saw breakage only because they do not have two
consecutive SPs (or any single quote) in their path to $perllibdir.
If we depend on such limitation, there is no point using _SQ
variant, but we already have _SQ variant, let's use it correctly.

