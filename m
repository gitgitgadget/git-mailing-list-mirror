Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134121F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbeCPVoS (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:44:18 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35127 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPVoS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:44:18 -0400
Received: by mail-qt0-f175.google.com with SMTP id z14so12420533qti.2
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TpnF0AZxH/WVb/jBxFcUE1zb+lsxnH7Ey4lT+X39OYY=;
        b=Pzwzd+n7q4/BfMxLLnsyM9IrA6eSO4dZjhaaxbYurvf2ERo+nrGuNe7Jd0sVOlylvw
         F2mZbrTFbMRF9wHeKSDH9kVOkCab1+MTm3WxIXy7n0BJv4dGTBVWzjpADmfl7EagSYkS
         sfUOVY3IqHVqH6yM0u385TjtbWkXifFSwTSJ0oxCvNRxVpI+y8B5uZkkB7Xmcx7OBi3g
         7k6dOekQNnAK7TEehiq1ysxXDUu6C3OiXXiORije+aPZ3WDrCPgL6rmUk4/dYVjRHYQk
         pH06MZmo2gzhCRR40i0N0+bQqOlmz35kLK73AMDcjBoCaXHy2lxAVaJuLk+gtCfXbdW+
         SX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TpnF0AZxH/WVb/jBxFcUE1zb+lsxnH7Ey4lT+X39OYY=;
        b=KPw6FL5sX33azC3Sb4hWoWyTvcXu3fXaPQTHYHXoJn6AyEBtt4Xsdxv+6P+nUCxMGj
         DfbcQnhA4PdXufb8MQSvNqGdqPEgF/fAlXG3QljZkrjiVFS6tQDCwvxEfP11qg6kv+4T
         TNCgiSFwsdE7ltVVNyGXQTQdxpAf12B7ODAQtZwN2rk2cR5j9vtwvEvP7QqdKH78lX80
         mA7CmVgds4LPFLjKbh9mj3V5XoLJjT3sU4AmlZ9hHWl83FUygTNd5Glfh5v3AvFbgGqY
         ps/J9SrdSjiOO1/tLPLTHc/CVnfpAgHBP86WdewlNcXedaAqwoopB5IS4aZTh8vD/gCO
         TgQw==
X-Gm-Message-State: AElRT7Guiusv5C3+IM4tfpO4gUJG+t69ZbuveGkRIoNBEN1LWoBNEvxn
        Il7QYfB3lIWAaCiLPQtAiBsOi8BCGQkZkuyUvSA=
X-Google-Smtp-Source: AG47ELsg+QjRblXiSIfbFh+tKQMfks2M43dr8FTemf9BTa0/Pzs71o1M6zjDT8fZhO5GH4/cbimlHzgYW0UjEuzr5e8=
X-Received: by 10.200.10.200 with SMTP id g8mr5307928qti.121.1521236657179;
 Fri, 16 Mar 2018 14:44:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Fri, 16 Mar 2018 14:44:16 -0700 (PDT)
In-Reply-To: <20180316213323.GC2224@hank>
References: <1520366804-28233-1-git-send-email-eddy.petrisor@gmail.com>
 <20180306202149.GA160269@aiede.svl.corp.google.com> <CAK0XTWdY6rfKu_s8Am6dh9njcFHqSAz_54PhW6V09DuGwE-h0g@mail.gmail.com>
 <20180316213323.GC2224@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 16 Mar 2018 17:44:16 -0400
X-Google-Sender-Auth: WU9WBcl2-DpfFmetawfMaP3Of58
Message-ID: <CAPig+cR5ncp9eMZ8krgy19A6g1Uqjx9dXTkus4r1QimD5Uwk0A@mail.gmail.com>
Subject: Re: [RFC PATCH] git-submodule.sh:cmd_update: if submodule branch
 exists, fetch that instead of default
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 5:33 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Subject: [PATCH] SubmittingPatches: mention the git contacts command
>
> Instead of just mentioning 'git blame' and 'git shortlog', which make
> it harder than necessary for new contributors to pick out the
> appropriate list of people to cc on their patch series, mention the
> 'git contacts' utility, which should make it much easier to get a
> reasonable list of contacts for a change.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> @@ -260,8 +260,8 @@ that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
>  Send your patch with "To:" set to the mailing list, with "cc:" listing
> -people who are involved in the area you are touching (the output from
> -`git blame $path` and `git shortlog --no-merges $path` would help to
> +people who are involved in the area you are touching (the `git
> +contacts` command in `contrib/contacts/` can help to
>  identify them), to solicit comments and reviews.

It may be a disservice to remove mention of git-blame and git-shortlog
since git-contacts may not be suitable for everyone. Instead, perhaps
advertise git-contacts as a potentially simpler alternative to the
already-mentioned git-blamd & git-shortlog?

Also, would it make sense to mention Felipe's git-related[1] which is
the original (and now more configurable) script from which
git-contacts functionality was derived?

[1]: https://github.com/felipec/git-related
