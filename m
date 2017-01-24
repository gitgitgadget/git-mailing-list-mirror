Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1E52092F
	for <e@80x24.org>; Tue, 24 Jan 2017 10:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750865AbdAXK5L (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 05:57:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:57903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750824AbdAXK5K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 05:57:10 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuPYt-1cLQfb3lcF-011jS2; Tue, 24
 Jan 2017 11:56:53 +0100
Date:   Tue, 24 Jan 2017 11:56:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] stash: support filename argument
In-Reply-To: <20170121200804.19009-1-t.gummerer@gmail.com>
Message-ID: <alpine.DEB.2.20.1701241148300.3469@virtualbox>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r9gjD4tGoTIzBg6mGDabBIiDkfaOSaYYxCEBohcNnj72uwPlo2D
 xXt74+3m9lCqTBcc3PgY+TR2zY+AgtpjUzZSlFqm5AQksH7bCuFUvtCbLvHJ7jkYfaeKsno
 mL0lR3HcZ5ZDlUr6QC9cL2KZhZdt+ezN8lW8fP/LItx6dx8zFdz1FXO1dkjqYAFjz11IPFO
 s018jRGIoMkqU4I3UrFzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JAGW2ztcnK8=:QvO9bUexF/OPPRliKiggdC
 j9Y4HN7YCoWc1UFtapYQKQVLZrM7tOEhiPx6rqWEMAMvQ/GPI4Pt9kU6iCFOdPGgEnvEGBX3Q
 MpsYf+STIY9FgERtuFNf4tQemNe8VXMeWIerxH9D6s98MFaXICXl47rmxezr87n0qXRIgOYe6
 wXUwSDqN7YvX/XiX6Op0B+s9wQN3zefoQ/9kg3zv4vfhf9ZL6cD1sDmO9z5XSzYUDeq5Nq4u3
 hvayCMLc/DTLIGgUaGxfVLomkJg355CldQRC5VmfiLsUEGJ3N8w8nbwUOqe2wJKCWS3u+KREU
 t7YzNPvPCNE3ckgalCJb5jOn3Vguaqr6X9j5EzndN5p1MQvbzyh5JsOG90mRPTm7xjDup0aUL
 3bjlMqW7JJR+jvH5MSJpLT8O+VGBhzYw6/QLL7hvchLWU4I5UT4BnmeHBf5ZElUCx5M3jjHgC
 IGRxl9NXGwahFK/5IinF08C2DqTwXXwORjZGwTXmuARvuXgbsNrsCxKvbgmnlR+Z1gYtoqNGm
 ls4zh15GOUJVqZgpjwTm6uK7IFVQfQcp+UqSw+1bCZp+sk67I+0GR8tfgl+FTa7PULK9zPpPZ
 G1LOluJz7c2Y4JSI4K+aJwLu8lkp3ZuhQ3IxQJMawa82RcTaW81rgEpcmy5uW/jwo0RX7eVe2
 vxX7FhuwQW+0LVJlO3FV4YYvrN65tt0wGY2Q+yxKBGz34YkhUUwn5dTZxeqydYqa0Uyh3mroz
 6rI4hkWbJapxa4qeSyzE8GKiR/LdY79tLWiZL/GMQRGRB6XLhRMLCUiD7tX1Y7j5oyDxn93cV
 8GbV01S
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sat, 21 Jan 2017, Thomas Gummerer wrote:

> This is the first try to implement the RFC I posted a week ago [1].  It
> introduces a new push verb for git stash.  I couldn't come up with
> any better name that wasn't already taken.  If anyone has ideas I'd be
> very happy to hear them.

I would have preferred a series of patches that essentially adds a new and
improved `save` syntax:

git stash [save] [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
          [-u|--include-untracked] [-a|--all] [-m <message>]]
          [-- <path>...]

and keeps the legacy syntax, but deprecates it:

git stash [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
          [-u|--include-untracked] [-a|--all] [<message>]]

The problem with that is, of course, that 3c2eb80fe3 (stash: simplify
defaulting to "save" and reject unknown options, 2009-08-18) in its
infinite wisdom *already* introduced the `--` separator to drop out of
option parsing.

On a positive note, it is a thorn in Git's CUI that `git stash` implies
the `save` command, and that `save` is not at all the opposite of `apply`
or `pop`. Your introduction of the `push` command will fix that flaw, and
we can *still* deprecate the `save` command.

Ciao,
Johannes
