Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F373CC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E9564F6C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhCPAwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:52:31 -0400
Received: from out2.migadu.com ([188.165.223.204]:43971 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231921AbhCPAwK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:52:10 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1615855922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JN4OKnllvXJx3bZoSPRWgro7UjF3/PV9BZ/FoxNc2Tw=;
        b=aIgcCB5QZad4Lnx/hZeTKQHSVi8Q/x0O7B/h4nrw/Iskpc8DamKPDtRhvKt/0lFU30NwNx
        Snj1Dhf8ncC2pKWDlGI1mQX54YfVLkBzoKsmRlTS/1fUX3wLeFY1p4YhMcLjp7qVvMNwXD
        wE8VKkktNhZHzuFPX8+NULf/zr/VPH1B5ng539wujFLUbH5qX3lZlsQoTf/iF33tm6kpPq
        E+sveR5PDjAMzsJ3NQCzJwYZmdowOQxWbHF949JQe99z7aphUjVFpYH/g8Sr0fvBlCA2sd
        IsSXokPX9l8QDBo7kTJKw2Vkad01v8Mo0gjxOBbE9eTJaERcd4/IsS9i+28ZvQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 15 Mar 2021 20:52:01 -0400
Message-Id: <C9YD4AEUH84L.29FP64NJJ1BPU@taiga>
Cc:     "Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
In-Reply-To: <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Mar 15, 2021 at 6:01 PM EDT, brian m. carlson wrote:
> But you can't find whether a URL is useful for a particular purpose in
> general. For example, if I see an HTTPS URL, that tells me nothing
> about the resources that one might find at that URL.
>
> In addition, it's possible that the data you want exists, but is not
> suitable for you in whatever way (not in a language you understand, in
> an unsuitable format, is illegal or offensive, etc.), or you are not
> authorized to access it. You can't know any of this without making some
> sort of request.
>
> All a URL can tell you is literally where a resource is located. Even
> if we saw a URL that used the hypothetical https+git as the scheme, we
> couldn't determine whether we could access the data, whether the data
> even still exists, or, even if we knew all of those things, whether it
> was using the smart or dumb protocol, without making a request.

What we know is that we can pass it to git to deal with, and then git
will determine the next steps. It will negotiate dumb or smart HTTP
in-band, deal with errors that arise, and so on. It signals that git is
the tool best equipped to deal with the situation, and without that we'd
end up guessing.

> So I don't think this is a thing we can do, simply because in general
> URLs aren't suitable for sharing this kind of information.

That's simply not true. They are quite capable at this task, and are
fulfilling this duty for a wide varitety of applications today.

I don't really understand the disconnect here. No, URLs are not magic,
but they are perfectly sufficient for this use-case.
