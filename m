Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4992027C
	for <e@80x24.org>; Mon, 29 May 2017 11:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdE2LXp (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 07:23:45 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35542 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdE2LXo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:23:44 -0400
Received: by mail-it0-f49.google.com with SMTP id c15so25447653ith.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cEXXs1FFpgzbj95rnFGMYB2sCRjU8aBeA8+Jx3tDMxA=;
        b=U7SoEo08SSQwYERH1Bjo3yd4lrxns4FI9tehw1xNa+weLQ25aZ7Arggv7CWnPwfqIi
         xMdSN1zRmPMPOTFxeg3Ekh1d7brHUlx+uMgY1/NA0W17O8S0fyDbxH1BU1qkVnFtHzxF
         E5ZsNju9inqxHZrjtlOBp9vtcE0HVpjnIaGv1dhphzM6w3hjZCTkeDUxQ93vLYbvZXzz
         MZR1TGKJUcuqNFtEC0zkGas5+htTDW3O/wAxyyhW346ZjSmolHA5CFA6CZcJ91niL59a
         B7YYPvg8cNpyEiOlKLkXFbIPQkg/NLwshjWgH89Ho1QrC1jws77TGdyTHNpxTwD9uuQH
         tOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cEXXs1FFpgzbj95rnFGMYB2sCRjU8aBeA8+Jx3tDMxA=;
        b=Y8e1IlTS/HiJjYAF7Zqnx2/bopTS3J/jSbtdopvvccJNkGU6lUhNnDdhaGhBxB9Fqy
         +KncwPqTPTAkihjDVxyDnENvPgg6sQV2tOAfXVf06Fg/IK8a3ilEWSIt6ZQ7rMWDOLOZ
         KpB3H8Halt/KDk4ORhcPPJKdREHyAqUdkPNYHA5/kT1r5/NsARaSpKuA3eP32ac/ylI+
         iCYkMcmXtUAbtqPMSizOUfNNtb6gEaS6c71IeH1BpZVs5BWZIET880gj/eixMCvh0+9t
         Ki5DdmwAVEm0Wp0SgtMqL+ongVC/19/NjuyuEaoHP7Pru5/7cGC1f8/FBMw4x7FZWtMW
         YwHQ==
X-Gm-Message-State: AODbwcAa6VxuEaMvC0XWszjtqPHQO6IDUskn5BApRUA6y8K9crpz/Opy
        fJAqSrDtnJSKqQiq0gOQLvm8M4nlAA==
X-Received: by 10.36.53.79 with SMTP id k76mr13213843ita.71.1496057023365;
 Mon, 29 May 2017 04:23:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 29 May 2017 04:23:22 -0700 (PDT)
In-Reply-To: <CACsJy8DmsG_+ASEkisUTLejVkiOmYytvTCTQs=RCH6q=BeDAhg@mail.gmail.com>
References: <20170518232134.163059-1-bmwill@google.com> <20170522193535.7cgivd6pmmqhw7ze@sigill.intra.peff.net>
 <CACsJy8DmsG_+ASEkisUTLejVkiOmYytvTCTQs=RCH6q=BeDAhg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 13:23:22 +0200
Message-ID: <CACBZZX5GRxecDQkoqLv55FLuiSohGSR3U1U+sG0vFFpexcc54A@mail.gmail.com>
Subject: Re: [WIP/RFC 00/23] repository object
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 12:36 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 23, 2017 at 2:35 AM, Jeff King <peff@peff.net> wrote:
>> On Thu, May 18, 2017 at 04:21:11PM -0700, Brandon Williams wrote:
>>
>>> When I first started working on the git project I found it very difficult to
>>> understand parts of the code base because of the inherently global nature of
>>> our code.  It also made working on submodules very difficult.  Since we can
>>> only open up a single repository per process, you need to launch a child
>>> process in order to process a submodule.  But you also need to be able to
>>> communicate other stateful information to the children processes so that the
>>> submodules know how best to format their output or match against a
>>> pathspec...it ends up feeling like layering on hack after hack.  What I would
>>> really like to do, is to have the ability to have a repository object so that I
>>> can open a submodule in-process.
>>
>> We could always buy in fully to the multi-process model and just
>> implement a generic RPC protocol between the parent and submodule gits.
>> Does CORBA still exist?
>>
>> (No, I am not serious about any of that).
>
> CORBA or not, submodule IPC is a real pain. That was what I felt
> reading the super-prefix changes a few weeks ago. Some operations
> might benefit from staying in the same process, but probably not all
> (and we lose process protection, which sometimes is a good thing)
>
>>> This is still very much in a WIP state, though it does pass all tests.  What
>>> I'm hoping for here is to get a discussion started about the feasibility of a
>>> change like this and hopefully to get the ball rolling.  Is this a direction we
>>> want to move in?  Is it worth the pain?
>>
>> I think the really painful part is going to be all of the system calls
>> that rely on global state provided by the OS. Like, say, every
>> filesystem call that expects to find working tree files without
>> prepending the working tree path.
>>
>> That said, even if we never reached the point where we could handle all
>> submodule requests in-process, I think sticking the repo-related global
>> state in a struct certainly could not hurt general readability. So it's
>> a good direction regardless of whether we take it all the way.
>
> I doubt we would reach the point where libgit.a can handle all
> submodule operations in-process either. That would put libgit.a in a
> direct competitor position with libgit2.

Wouldn't that be a good thing? We already have some users (e.g.
Microsoft) choosing not to use libgit and instead use git.git because
the latter is generally more mature, if git.git gains more libgit
features without harming other things it'll be more useful to more
people.
