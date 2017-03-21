Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE3572095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933924AbdCUTe6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:34:58 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:33954 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756886AbdCUTeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:34:13 -0400
Received: by mail-it0-f52.google.com with SMTP id y18so3294425itc.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xHSR2YJoSq+yxvsQTIixplPCq5XDaUb2RjoPLj0Ygq8=;
        b=F8WpPY7KnRGWhbi7pAE5TYTV62AMQXmXnVMlmc01x3nSYk5lfl5hnCIYD4Jamoear+
         zMy7vp1+Ifpmnls46d1BfqZsdthZtnHvluZLyVb6dYZuw4NgcotiPUE3o1yoOGp3mBaO
         KPD2lhvx7p51HIlfv6wrFG09c61dwFJR1pV64woEFCC2J0G6iWyK9Sr7Bs8pCex2sDW0
         Nh0G4SFHEPo99cxnof7vuE0/9qIEGcCxlSU6fMIGoQADG3E2TARgjSbuKtvWMJaQEVw0
         DBr8U1HK8sAGFknZAfPRy0KEaqforrhlm4EL930ETNsAcEvXk3oy/kCmrJ9YMlbgyLMb
         iFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xHSR2YJoSq+yxvsQTIixplPCq5XDaUb2RjoPLj0Ygq8=;
        b=PiOE5WVwzLDhtOJHybDrmMcQoOVSS8ua5gJqLKvmGTlLu/NqncIGtNMOGpFHwvnTeM
         WGlJgRHd97jXXsMnRNYwyAM/Xymtl7Joqv15p1KUjenrPZ/+O124gih8MJeqPCZRm3fe
         SSy9HUg4/JLeBXyuKhX++PZovlIjoK8JlkfszAFbaWBhPK9hGLQhIgqHCAFzYNG0Krw9
         Bte722q+zqusL/PJlj2eyrzgq4iTV1KkSYXgQV677mszx5I5B5ElmrUGfnSDHjJsitMX
         hj78fWTLVGkcy9uCiDyLallfbHtJkzSzavKb61qD8sXPV1MgzrbH49uAdWNQUHc5Byu0
         GOBg==
X-Gm-Message-State: AFeK/H1MweTrjx/GB2xEPylI943F4xtrWIu7YhND8hcrNXJhDKq/C96A7RGCRazQc7TzHeu9w6JxE5+rE6W0sQ==
X-Received: by 10.36.116.71 with SMTP id o68mr4730774itc.60.1490124851484;
 Tue, 21 Mar 2017 12:34:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 21 Mar 2017 12:33:50 -0700 (PDT)
In-Reply-To: <xmqqtw6mo2l2.fsf@gitster.mtv.corp.google.com>
References: <20170321125901.10652-1-avarab@gmail.com> <20170321125901.10652-16-avarab@gmail.com>
 <xmqq37e6piae.fsf@gitster.mtv.corp.google.com> <CACBZZX7yRRTQpcFZ9eO2_+HdB979p6URE+jsXJakxw7jpnOvmA@mail.gmail.com>
 <xmqqtw6mo2l2.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 21 Mar 2017 20:33:50 +0100
Message-ID: <CACBZZX6Ak0JOd7Fh5Z2p0md_P8vG__N_gOkfoNueERVF=jVyBg@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] tag: implicitly supply --list given the -n option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 8:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Yeah I see now that this is rather badly explained. I'll fix this up
>> for v3. All of this worked already:
>>
>>     $ ./git tag 100
>>     $ ./git tag -n -l 100
>>     100             tag: add tests for --with and --without
>>     $ ./git tag -l -n 100
>>     100             tag: add tests for --with and --without
>>
>> So actually thinking about it again it doesn't add any more ambiguity
>> than we had before. The change is just strictly getting rid of the
>> need for -l for consistency with --contains, --points-at etc.
>>
>> I see now that the whole thing that led me down this golden path was
>> that I was removing the failing "git tag -n 100" test,...
>
> Wait a minute.  I do not think I would agree with the behaviour of
> the last one, if "tag -l -n 100" is taking 100 as a pattern, not a
> numerical argument to "-n".  That sounds utterly broken.
>
> Is it because we use it OPT_OPTARG, which requires it to be spelled
> as "-n100" or "-n=3D100" or somesuch?
>
> In any case, it is not a new confusion this series introduces, so
> let's include it in the series, but I'd prefer to see it kept as a
> separate patch, at least for now.  Maybe somebody else have an idea
> to resolve this apparent confusion in a cleaner way.

Yup, that's why. This:

diff --git a/builtin/tag.c b/builtin/tag.c
index dbc6f5b74b..1346341413 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -403,7 +403,7 @@ int cmd_tag(int argc, const char **argv, const char *pr=
efix)
                OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l=
'),
                { OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
                                N_("print <n> lines of each tag message"),
-                               PARSE_OPT_OPTARG, NULL, 1 },
+                               0, NULL, 1 },
                OPT_CMDMODE('d', "delete", &cmdmode, N_("delete tags"), 'd'=
),
                OPT_CMDMODE('v', "verify", &cmdmode, N_("verify tags"), 'v'=
),

Changes it so that "git tag -n 100 '*1.6.6*rc*'" does what "git tag
-n100 '*1.6.6*rc*'" does. But that breaks a bunch of tests / possibly
some scripts in the wild, especially because "git tag -n '*1.6.6*rc*'"
now becomes an error, i.e. we'll try to treat the pattern as the
numeric argument.
