Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389E920441
	for <e@80x24.org>; Wed, 28 Dec 2016 18:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbcL1Svl (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 13:51:41 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34066 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbcL1Svl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 13:51:41 -0500
Received: by mail-qk0-f176.google.com with SMTP id h201so113355662qke.1
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 10:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8HBKnKG/LcIyphzifICFxCIAcC5WlFBWVq50KhqbIq0=;
        b=ivUqcsBZylMwISUMnvb9Tg9uzbcJDcCtyQfsfN2PmWWQg9hGu7IVq4+UbImj2Q/W/3
         7edJ9piOPZJ/DlAVTClt+HFSbYHxMVzEjZSL1iZMgxEOtXWJ9SggHMIOkBGWGxTttRM1
         IBs1tb8omqxgR/qPEMaAbquzlDBPX54qnsGnyW057P4GjDpL7YeuE+d8RqLNuvcD59K5
         Yy4fJrtWarp8YKbhpDoOfKmfrK37a2S1WdmnGwHx2XQEFMhJ/mAUfFOwL/afXnM978aw
         oAvoGW8XMYxlHKVMTVKrRnHKCk7aPFSzKVx49g2Zi8Q3dDjhyQX1J/docHm89QlBtf1y
         8Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8HBKnKG/LcIyphzifICFxCIAcC5WlFBWVq50KhqbIq0=;
        b=dovwI5Sy9EobuYmztJ6QYkficojVvLHez1HBYqa9PXtJA9uacXmANZiFIiRNh2SfF8
         9Uzpz7iuI16XtLObzlPMO/k9qeZ28v4zqCrVpFnW3KDmgIhRn+UgbgbIoFvKOAXbgRzC
         /0vSgVWbM1XIvu/kJG2csJN0wrU3y1i/I3g44sP72kZv9mzLGMcymreipqWReNOlSPIU
         UwyJM87WRbsS9Gh8ow/RnZAz/oJ3DRoJT0GmpNU/qeLaUSVfFCMxBwD4IQgQr7E0xWEW
         t/YPAaAuENHm6s9/sNfqmz/RpVFlW+y8iCgrTYpTtES29Yq7N+8hntI7YmK6JGfwhLli
         U+cQ==
X-Gm-Message-State: AIkVDXKvWhvoSKeqy9fDzdcbSDOTl/XIpdgxaWQwOVH7T2QhjM4e/wZCJwxxTzzUvn8JRaJvbOVnIux2MuWk0sMV
X-Received: by 10.55.105.129 with SMTP id e123mr39472282qkc.173.1482951088905;
 Wed, 28 Dec 2016 10:51:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Wed, 28 Dec 2016 10:51:28 -0800 (PST)
In-Reply-To: <20161228183501.15068-1-ehabkost@redhat.com>
References: <20161228183501.15068-1-ehabkost@redhat.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Dec 2016 10:51:28 -0800
Message-ID: <CAGZ79kaBpC5ym2N_fMZHDmL4gGpU8pFAsupCE4aTdENh+=z72g@mail.gmail.com>
Subject: Re: [PATCH v2] am: add am.signoff add config variable
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 10:35 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> git-am has options to enable --message-id and --3way by default,
> but no option to enable --signoff by default. Add a "am.signoff"
> config option.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Added documentation to Documentation/git-am.txt and
>   Documentation/config.txt
> * Added test cases to t4150-am.sh

Thanks!
Documentation and code looks good to me, for the test a small nit below.

> +test_expect_success '--no-signoff overrides am.signoff' '
> +       rm -fr .git/rebase-apply &&
> +       git reset --hard first &&
> +       test_config am.signoff true &&
> +       git am --no-signoff <patch2 &&
> +       printf "%s\n" "$signoff" >expected &&

"expected" is never read in this test, so we can omit this line?

> +       git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&

So we check if the previous commit is not tampered with,

> +       test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0

and then we check if the top most commit has zero occurrences
for lines grepped for sign off. That certainly works, but took me a
while to understand (TIL about -c in grep :).

Another way that to write this check, that Git regulars may be more used to is:

    git cat-file commit HEAD | grep "Signed-off-by:" >actual
    test_must_be_empty actual

I would have suggested to grep for $signoff instead of "Signed-off-by:",
but it turns out being fuzzy here is better and would also catch e.g.
a broken sign off.

> +test_expect_success 'am.signoff adds Signed-off-by: line' '
> +       rm -fr .git/rebase-apply &&
> +       git reset --hard first &&
> +       test_config am.signoff true &&
> +       git am <patch2 &&
> +       printf "%s\n" "$signoff" >expected &&
> +       echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >>expected &&
> +       git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
> +       test_cmp expected actual &&
> +       echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
> +       git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
> +       test_cmp expected actual
> +'

This test looks good to me,

Thanks,
Stefan
