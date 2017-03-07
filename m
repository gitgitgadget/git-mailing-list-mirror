Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C551FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 00:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdCHAOm (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 19:14:42 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34960 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756506AbdCHAOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 19:14:39 -0500
Received: by mail-pf0-f180.google.com with SMTP id j5so6894173pfb.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 16:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=za1ewV8u+qjbKeE/14reC4Gj46JJ09Yf1BZXzjwi1LA=;
        b=n1Fsp1a0p9Ba218R8n3dLsxlJa7PI8iRp/BLQ9HUapKl3qHZY7n7U+Bh6WtW2EkyMq
         oSurz+XmnY7rjoJ3V1O6x7SzhUr/fpyMpo8pD/pWN92RFNG2hgnr3h7l50fpv/btrkjU
         SVYiIob8DMMnDXHlYPJQoqm4nDRuSzV/OnWj3DYP7RIdMEazJKN5P/XhUUWRcIecpzGB
         ejOFIWHM5V7nH8cBf20nWgc/2USxladH5Uc55i/jqOeyxQhuHt5BobfsgwDQjjNylxaT
         DOhqnqERAGifrU5iwI4o4Ngi/K00vcsus+wwOy5ML5J9XxFzcnKYNJBfsMEjlPICxwrP
         uaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=za1ewV8u+qjbKeE/14reC4Gj46JJ09Yf1BZXzjwi1LA=;
        b=hxFrNFnpG+sHCMMmNMRE2otc2klUoZzQ635+Y6ePnroDqOrMZFqijQriDUiw0WHCHX
         8Suuf+IuXQtKszeAmTaqMmWW3gt8pXiEWpnMV3QVSMHn+BP+El/XUFxDK9ABCHDApS/O
         6fhDYa6L5cFqdthseDVOi+h71FreAR9fc7uaiiqkl1HkO3CCRgsdHKNbRiC2Us4WWwDP
         GMpbUQsXFx8/NyrKv+lMIxXlcNFU1uzme3pvq69TIvLkFfEGJDcvkeKB54OcwEq/aSuT
         cWVio92qH/CSQDpivo4znYXgmR7K3VxpafqdjRw4IIt8rZTAL65HrtCT6VcMBF9EbhXf
         tO1g==
X-Gm-Message-State: AMke39ksomL0ItXkdVzzutYaBIq+E+CsCNaADsYdpBlcsq8+R7gW3ONAs7ARtlGtgc2X8nFxeZCXVTh2ed6cU5cd
X-Received: by 10.98.91.131 with SMTP id p125mr2960599pfb.165.1488925159971;
 Tue, 07 Mar 2017 14:19:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 14:19:19 -0800 (PST)
In-Reply-To: <20170307092353.ibirvitsxhzn3apz@sigill.intra.peff.net>
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
 <20170307092353.ibirvitsxhzn3apz@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 14:19:19 -0800
Message-ID: <CAGZ79kb=ZwaMeGAu_R1Bjt4KyxKHYnP4U-RgA1of7F05E5CCQg@mail.gmail.com>
Subject: Re: [Request for Documentation] Differentiate signed (commits/tags/pushes)
To:     Jeff King <peff@peff.net>
Cc:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 1:23 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 06, 2017 at 11:59:24AM -0800, Stefan Beller wrote:
>
>> What is the difference between signed commits and tags?
>> (Not from a technical perspective, but for the end user)
>
> I think git has never really tried to assign any _meaning_ to the
> signatures. It implements the technical bits and leaves it up to the
> user and their workflows to decide what a given signature means.

That is a nihilistic approach? ;)

As a user I would like to know what I can do with such a signed commit.
And I happen to be an experienced user in the sense that I know
about git tag --sign as well as git verify-tag; further reading of
these two man pages tells me I can even use git-tag to verify a
tag. So looking for the verify option in git-commit for signed commits...
well, no.  Ah! git-verify-commit it is.

I assumed to have most discussion in git-tag or at least a pointer
from there to further reading.

In an ideal world we might have a manpage git-trust-model(7),
that explains different workflows and when certain signing
mechanisms make sense and what they protect us from.
I might write such a man page (after I get the gitmodules
page done).

Off list I was told
"just look at Documentation/technical/signature-format.txt;
it explains all different things that you can sign or have signed
stuff". But as an end user I refuse to look at that. ;)

>
> People generally seem to take tag signatures to mean one (or both) of:
>
>   1. Certifying that the tree contents at that tag are the official,
>      signed release contents (i.e., this is version 1.0, and I'm the
>      maintainer, so believe me).
>
>   2. Certifying that all the history leading up to that tag is
>      "official" in some sense (i.e., I'm the maintainer, and this was
>      the tip of my git tree at the time I tagged the release).
>
> Signing individual commits _could_ convey meaning (2), but "all history
> leading up" part is unlikely to be something that the signer needs to
> enforce on every commit.

I was told signed commits could act as a poor mans
push certificate (again off list :/).

> In my opinion, the most useful meaning for commit-signing is simply to
> cryptographically certify the identity of the committer. We don't
> compare the GPG key ident to the "committer" field, but IMHO that would
> be a reasonable optional feature for verify-commit (I say optional
> because we're starting to assign semantics now).

So the signed commit focuses on the committer instead of the content
(which is what tags are rather used for) ?

> I think one of the reasons kernel (and git) developers aren't that
> interested in signed commits is that they're not really that interesting
> in a patch workflow. You're verifying the committer, who in this project
> is invariably Junio, and we just take his word that whatever is in the
> "author" field is reasonable.

Well in such a workflow Junio could also sign the tip-commits of
pu/next before pushing, such that we can trust it was really him doing
the maintenance work and not his evil twin.

> But for a project whose workflow is based around pushing and pulling
> commits, I think it does make sense. The author field may not always
> match the committer (e.g., in a cherry-pick), but it still lets you
> trace that attestation of the author back to the committer. And it's up
> to UI to make that distinction clear (e.g., if you push a signed
> cherry-pick to GitHub, the commit is labeled with something like "A U
> Thor committed with C O Mitter", and then you get a little "Verified"
> tag for C O Mitter that gives you more information about the signature).
>
> So I don't think it's just a checkbox feature. It's a useful thing for
> certain workflows that really want to be able to attribute individual
> commits with cryptographic strength.

"certain workflows". :(

See, I really like reading e.g. the "On Re-tagging" section of git-tag
as it doesn't hand wave around the decisions to make.

Now as a user I may already have a workflow that I like. And I might
want to "bring in more security". Then I have to figure out possible
attack scenarios and which sort of signing can prevent such an attack.

And each organisation has to do that themselves, but we as the provider
of the tool might have this knowledge because we implemented all
these shiny "sign here, please" parts.

Thanks for the lively discussion,
Stefan
