Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB4020372
	for <e@80x24.org>; Mon,  9 Oct 2017 16:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755218AbdJIQra (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 12:47:30 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:53786 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755201AbdJIQr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 12:47:27 -0400
Received: by mail-qk0-f178.google.com with SMTP id w63so24165485qkd.10
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=liet7VqFxZMEjcgQHckjF9BQxrn50SCvwiCPR5RxgZM=;
        b=vioNDBwPM/khTX5Ekrd7TMxuMWU7V0n+eOrFCUbMKl68m0asljlQX+qSbN9aYzwHLG
         HRHN579Fr+QyoXTxd2Yd0bEbsnCNmkTVFH861rQQ1Fl8SptW98Yhhonrnf4BzpySXVxf
         tVtrHRRgy/p95KkNJktQmd2STKOU6UusbQamNuoMO1a5lh573ySeo4zlHD2BlEsfWrP8
         RMkgUkgs9vX62XrMnz+2aGwYk1l4H7N0fPxHYwlUMB22EenDhCaT7klulGz1JOWH4zQG
         H4JWC/R/Ei/GkJU4p3nKMHnDPsLAPhz0d1RK8rBCeLoEJHyXI7UKAMLRc2M0stHwgO5s
         PWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=liet7VqFxZMEjcgQHckjF9BQxrn50SCvwiCPR5RxgZM=;
        b=XeVQC1DhJZZqiIpm/gtXvbk3NHuTPsuKcNjQeYRZzwm7IPBoVVJ7s6+IzttwhLDcyJ
         wIvJm9xFtuc61DdDtBFOseixlHivZZHCGmA20A/SCQBQ9vnkaCGX7r9WiAAEBcR8II8K
         1wG0L5IYgKYfnN9lcvfq6xNi3y+KH9HcXGXEW3k/gPYoau6QHQmu6UcIEXRnt2VcsGhN
         QjwIZVbX+JdB0Ut3BmNEx2nZTDhV9QNS/D/zVMOmf292B7/sRAV0ndRcydakQ7+pP3aV
         GVGUVlgw1r0uvE9LAQoJKUkfdTUIU0six8nc5dwq9QyJS8fKc08AvfAfyYFYuWSjzi0q
         THug==
X-Gm-Message-State: AMCzsaVJuS1RRan5/MJBWxj+6nRuYMvcluCUL95SgqDD5aDHnUWV8JLl
        iYxatVYBdWslbkmROlnHGcINitJLaXEweu6tmQrHag==
X-Google-Smtp-Source: AOwi7QCQxXv1VpTZY4Az64jl1QDvRtix+3C/uKFXR+yyjZHsHPmgQ8QBF5geUCk+q3UXe2GuFRee6AO30ub5FzsAXhE=
X-Received: by 10.55.90.199 with SMTP id o190mr10962053qkb.180.1507567646963;
 Mon, 09 Oct 2017 09:47:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 9 Oct 2017 09:47:26 -0700 (PDT)
In-Reply-To: <CAN0heSqFSiev8BeZVu3KBA5vswsbQrrOH=tYYOSs_h_eq=8-3Q@mail.gmail.com>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
 <20171008084824.5331-1-martin.agren@gmail.com> <8686C1FA80EF45099730B50235CAFF6F@PhilipOakley>
 <20171009005137.4qwvkpedjslvbkca@genre.crustytoothpaste.net>
 <CAPc5daVk+sPLmw4G_AghOVFeO5myKTADQjKr823U3xaQZK+43g@mail.gmail.com> <CAN0heSqFSiev8BeZVu3KBA5vswsbQrrOH=tYYOSs_h_eq=8-3Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Oct 2017 09:47:26 -0700
Message-ID: <CAGZ79ka7xo96MHaAUbkDuFjWMQaaD4j2UrRndcinAg6uzaP6Kw@mail.gmail.com>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 8, 2017 at 9:14 PM, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
> In this particular case, we could have three specific messages plus one d=
efault
> message (which at the time shouldn't ever occur). Or we have one specific
> message for the "tag"-case, which seems to have been Stefan's original
> motivation, and a generic message for the other cases.

I think the original patch is an improvement for the translations,
but I'd really want to deliver as much information to the user,
(it's an error message after all, so tell as much as possible that can
be helpful,)
which is why I would prefer to keep `typename(type)` in there.

I always assumed that translators are aware of these issues and sort of
work around this somehow, maybe like this:

  "submodule entry '%s' (%s) is not a commit. It is of type %s"

Thanks,
Stefan
