Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9DF81F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 23:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdGYXRo (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 19:17:44 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:37996 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdGYXRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 19:17:43 -0400
Received: by mail-pg0-f41.google.com with SMTP id k190so10636357pgk.5
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=njSHdCeVv4/1wPCfiXWvBZwYhZjZoZ+GeqjyjwQvte4=;
        b=PCwghScyzbUk+yiOH8G7ePgQ2qBH9axSbn2/3Iq715UGjg2W+VUEP3RakHtSfsrjj4
         czoZG5/4iowhvbo6jLPGhftFIVjdoGmvpb+DA5GmWZkRkXPdVOt2hwyov33oIUtndDTt
         34/6t3fopVlvj4o1wyaH0e799REnidleFx7qObfuGAWFeBgGlGIWjm+G81eoM7VrXKxM
         kP5j/3uVa2mpYl9WsIbjc0vsnktkSQNLUr4B+SArSfl57WDqhDfyqgVp24RX5g4PriEO
         qMH8M5vUodff+suybcVGVO6R0YPcBaNeP0kp4ixYfmeRQH60OmgixPNOtgSD+MAo7J/q
         1IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=njSHdCeVv4/1wPCfiXWvBZwYhZjZoZ+GeqjyjwQvte4=;
        b=rrn9Wec1yzsLkElXX3OM3bflv9Y9z3cMcosuQCGi96H3SdtrOI1Ejep8llXuqdKrm9
         cz3+Rxa7A3PE8e5yHHSza5OkDMsg6Icvr5XhPZs7AggHhw043RKOHSs54hqqPdwzkLsR
         oKHLK3VOt8i6snw20gjJWn1XB2oYv+6UvclAjdGaVVGHRwWjdipu0Rmdq7BFnP+eVpkc
         lpd4789+r3UYdGGStUir8DhErEd4c0AC8T/OkUAvh9D/7d7Kqn8BGPA+aLHgsyAf+fQS
         gEsdWu7kx+Xhe7kd2/h9IxfRGIa9JbbHQuQDUuD0QAKZrZJsHa/xO2lzDpnSFqKDxgp/
         60pw==
X-Gm-Message-State: AIVw113kD2bYdvO6g+fC3TrtYqOOyLju8qd6MA1VhafRyqXYtwfLpxwP
        PNCSAZiaMIgVcPZUk7W+A/Lus/3d48Tr
X-Received: by 10.84.210.169 with SMTP id a38mr22814952pli.388.1501024663268;
 Tue, 25 Jul 2017 16:17:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Tue, 25 Jul 2017 16:17:42 -0700 (PDT)
In-Reply-To: <20170725213928.125998-3-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com> <20170725213928.125998-3-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Jul 2017 16:17:42 -0700
Message-ID: <CAGZ79kY9Pdk5C8=k-AQpCPwo3q9Jzfg9A93UQxGyyf_OyrMS_Q@mail.gmail.com>
Subject: Re: [PATCH 02/15] submodule: don't use submodule_from_name
To:     Brandon Williams <bmwill@google.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> The function 'submodule_from_name()' is being used incorrectly here as a
> submodule path is being used instead of a submodule name.  Since the
> correct function to use with a path to a submodule is already being used
> ('submodule_from_path()') let's remove the call to
> 'submodule_from_name()'.

This blames to 851e18c385 (submodule: use new config API for worktree
configurations, 2015-08-17), but that is a refactoring. The issue of using
the path instead of a name was there before that. The actual issue
was introduced in 7dce19d374 (fetch/pull: Add the
--recurse-submodules option, 2010-11-12).

+     name = ce->name;
+     name_for_path =
unsorted_string_list_lookup(&config_name_for_path, ce->name);
+     if (name_for_path)
+         name = name_for_path->util;

Rereading the archives, there was quite some discussion on the design
of these patches, but these lines of code did not get any attention

    https://public-inbox.org/git/4CDB3063.5010801@web.de/

I cc'd Jens in the hope of him having a good memory why he
wrote the code that way. :)

Note that this is the last caller of submodule_from_name being
removed, so I would expect removal of submodule_from_name from
the t/helper/test-submodule-config.c as well as
Documentation/technical/api-submodule-config.txt
in a later part of this series. (Well technically it could go outside
of the series, but in the mean time we'd document and test
dead code)

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  submodule.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 7e87e4698..fd391aea6 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1177,8 +1177,6 @@ static int get_next_submodule(struct child_process *cp,
>                         continue;
>
>                 submodule = submodule_from_path(&null_oid, ce->name);
> -               if (!submodule)
> -                       submodule = submodule_from_name(&null_oid, ce->name);
>
>                 default_argv = "yes";
>                 if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> --
> 2.14.0.rc0.400.g1c36432dff-goog
>
