Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585FC20196
	for <e@80x24.org>; Thu, 14 Jul 2016 16:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbcGNQOc (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 12:14:32 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34940 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcGNQOb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2016 12:14:31 -0400
Received: by mail-io0-f196.google.com with SMTP id q83so4858348iod.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 09:14:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8nlP4+Oi1wOBlt1xQb00wEgzPXxlezzIH7ADULVq2eg=;
        b=TRlwXaTzNQ6HfMQ5ScGWRCzqU7bqjQUNqR+SHfTSWWCNTjaiG9Ip/ONsDnZcwVpAxC
         sMjvpAJoZ4aHw3M4uIsULe6M7KOedqjfldwFMhitVT5wt8dj3pmkrHY3E0yMJiwSXwRG
         +2rj2tFKDegjK8IJNWkpEESv1w6gS6LX5ST6hZf49uSJxOBMEJsPIo5PyaqvxspvXrFg
         c0hTuvgKPJ5JqyPIl/PYaLc8m+tVjLi7uEox6N6qHxxaxdMyUPNs18EeGwJp+fN4ulfF
         U01Q7bcLvC1uOGZESTVrAtZOy0jV1vlZvk3IXzY/TY4aujQm1UU3YLX0QN9Lh7WZYF5O
         CR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8nlP4+Oi1wOBlt1xQb00wEgzPXxlezzIH7ADULVq2eg=;
        b=Hn41ehPrjb18xdMIXR+9umoog5rAN09bDz2SkEcJn2LjYwCz1pWjWRuI0eaiXW48Ea
         IN4MrvZ+ZCtoQvrXSPuLveiqBpLodK1/L8RDuo9gchhMFGbf/nh8a/K8H9ok26CWQOkP
         fk3L8MSPyMGUSFy2TN2of6k7Vn7OTWkLrz6ILrO58PIkbXsDAPZfAOJRfH4RM9CgWpz/
         LE/xLLIzTfEQdjBzBf6X0YRCQcKaaDdhTNHSkfLrkGDskPNXwX+CAvBPsFrG5kqZBEbd
         HzyfRmIE2VFtFk5bbFlq9wEuxsbwEFADLIvGacWmHziSfpXyXqq0QA6aRkTNBQMfKjXy
         tGSQ==
X-Gm-Message-State: ALyK8tI4Kwpv5pFqvvOw1WPVy8hNuDGiHJQW/wVIkOQKTn6gXRmH0ikVQwtibluPqvolOs9A/TccV0wHP2f0lQ==
X-Received: by 10.107.159.16 with SMTP id i16mr15072063ioe.29.1468512865690;
 Thu, 14 Jul 2016 09:14:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 14 Jul 2016 09:13:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607141750190.6426@virtualbox>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com>
 <alpine.DEB.2.20.1607141750190.6426@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 14 Jul 2016 18:13:55 +0200
Message-ID: <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 5:53 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Thu, 14 Jul 2016, Nguyễn Thái Ngọc Duy wrote:
>
>> Helped-by: Jeff King <peff@peff.com>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>
> This commit message is quite a bit short on details.

Because it's fully documented in config.txt.

> I still fail to see what use case this would benefit,

It allows you to group repos together. The first mail that started all
this [1] is one of the use cases: you may want to use one identity in
a group of repos, and another identity in some other. I want some
more, to use a private key one some repos and another private key on
some other. Some more settings may be shareable this way, like coding
style-related (trailing spaces or not...)

[1] http://thread.gmane.org/gmane.comp.version-control.git/273811

> and I already start to suspect that the change would open a can of worms that might not be desired.

You can choose not to use it, I guess. From what I see it's nothing
super tricky. The config hierarchy we have now is: system -> per-user
-> repo. This could change this to: system -> per-user ->
per-directory -> repo. You could create a different hierarchy, but
with git-config now showing where a config var comes from, it's not
hard to troubleshoot.

>> +     ; include if $GIT_DIR is /path/to/foo/.git
>> +     [include "gitdir:/path/to/foo/.git"]
>> +             path = /path/to/foo.inc
>
> I find this way to specify a conditional unintuitive. Reading
> "gitdir:/path/to/foo/.git" suggests to me that the Git dir is *re-set*,
> not that this is a condition.

Well.. to me it's no different than [remote "foo"] to apply stuff to "foo".

> I would have expected something like
>
>         [include "if-gitdir-is:/path/to/foo/.git"]
>
> instead.

If we do this, should we change gitdir/i to
if-git-dir-case-insensitively-is ? I think we are supposed to read
documents before using any feature, not just guessing then trial and
error.
-- 
Duy
