Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F2D205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 13:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759730AbdAENxd (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 08:53:33 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35265 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdAENxc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 08:53:32 -0500
Received: by mail-qt0-f174.google.com with SMTP id c47so519272131qtc.2
        for <git@vger.kernel.org>; Thu, 05 Jan 2017 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rf2coeqVwIaaAvMpaw4OvDG9Zy4zSO5WVlai5Fmf06w=;
        b=p/LQcZwNmoMpSyMfifmXFxITCLb+FvLBkAUxIOL60qhSn13BkDsluzr/OqBcAveUE6
         XlM87em4/xT3ezqSpZRZlQtBLdo64DPol3RtrX36Ev5jVJsyn88c3ZjNZGv/+XZt/2RB
         EEG8aXwNb9KTah9kOYfij88Q9lp54vztzgCLBhylSPXWGG4E0I0yRtT8gUnQAXZaDdso
         KVNSIY6Ne5aWyQSUEC8khXVkrrZjne5S5DSM9dqdxPgsqbRihxKarlH3GkJflNVSOrcG
         JN/eiUwF9TrsW4xwD0hOJMcjQ35E6kl3z2zGcyB3cwINjs2YuHSD5A3VlxRVWDjfhVdo
         VVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rf2coeqVwIaaAvMpaw4OvDG9Zy4zSO5WVlai5Fmf06w=;
        b=Cu47U2kf6keYIKdAilQO+kUM2FUikQ0q8BtIw/6kg20OCykx2n+PHgoZ0PIaH9R80C
         nXn2cSmiFoQ+3jgnBzEHEQzD9n4rNMRFUrzN9VptDgAB75nbmBS1GuQcbVwpueUzAVtA
         x4eH8rwXRTEK9cI2i0WUmc7VIlhxnObNDx9Iu3GuPn7dQ6yKwlIcL1MQNPix4+N5GbqJ
         nJOvhoM0OId7cuwBITM/B/1O+1Z2kR77/7thP+QMNSNlLu6tedfacBEn79lGi41MHyWJ
         aRLSm449vhg64km9KV8llhsBSoA2By2fLrqT5vr7pIDLxgLZclgWCgqtcE1AX7COBPkO
         lxTA==
X-Gm-Message-State: AIkVDXIh8V09khzbdCErSTxTsFsgLjswg5tcfdCIvLxZmCETnsUrg1PPrYSXPjiDHSuXFF68HEnsh+oHKO3vzyja
X-Received: by 10.200.50.147 with SMTP id z19mr61952585qta.207.1483624411101;
 Thu, 05 Jan 2017 05:53:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Thu, 5 Jan 2017 05:53:30 -0800 (PST)
In-Reply-To: <17f2724d-7001-203e-f0b5-cf586703a41a@boxbox.org>
References: <17f2724d-7001-203e-f0b5-cf586703a41a@boxbox.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Jan 2017 05:53:30 -0800
Message-ID: <CAGZ79kb8TTaJBmVCWK3jnr4RvGjmfmsj3-ieT87wzyFLYi5frQ@mail.gmail.com>
Subject: Re: core.sshCommand and url.*.insteadOf for submodules
To:     Stefan Schindler <stsch@boxbox.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 5, 2017 at 2:09 AM, Stefan Schindler <stsch@boxbox.org> wrote:
> Hello mailing list,
>
> it seems like that the `core.sshCommand` and `url.*.insteadOf`
> configuration settings do not apply to `git submodule update --init`
> (and probably related) calls.
>
> Is this intentional?

The original design of submodules was to have a submodule to be a
standalone repository, such that e.g. its options are read from its own
config file. So the original vision was to decouple the init and clone of the
submodule to allow the user to change the settings:

    git submodule init
    # copies the submodule.<name>.URL from .gitmodules to .git/config
    # user realizes that the URL is not a good idea, such that
    git  config submodule.<name>.url http://${company-mirror}/submodule
    # now the url is fixed so
    git submodule update

I guess it could be a good idea to propagate some settings from the
superproject to the submodules when they are cloned.

>
> My scenario is as follows: I use 2 SSH keys for GitHub, for private and
> work-related repositories. My default key is my private key. So when I
> clone a work repository and try getting the submodules, `git submodule
> update --init` fails. This is also the case when setting
> `core.sshCommand` and `url.*.insteadOf` (useful for substituting
> "github.com" by some ~/.ssh/config'ured host).
>

which is why e.g.
git config --global url.https://github.com/.insteadOf git://github.com/
is not your preferred way here.

There was some discussion a couple of weeks ago, which settings
should be kept when recursing into submodules, Jacob and Jeff cc'd.

> Greetings,
> Stefan Schindler
