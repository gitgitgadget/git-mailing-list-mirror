Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50069C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89AA20E65
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="cWf9dgBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgKPQpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:45:18 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:59884 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbgKPQpR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:45:17 -0500
Date:   Mon, 16 Nov 2020 16:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1605545113;
        bh=TCtjBe/Ci3Xu+v41TGmgfcWG8er5r+zd1XCVWqwYOjQ=;
        h=Date:To:From:Reply-To:Subject:From;
        b=cWf9dgBmyjhtYgsGEbJJhZcBZgufVK2CLdEERPV95qtH6RGcb3eSYfMNgKVmm+KXx
         0tmNGMiG6SLhK4nthLcUJTqewLKzL1lJPSaLKri1mH+JobBePiDZyDdqdQtPOjGBz2
         IA54bd+DlM2i5B5rURr8JWv83qJGwuzuMrP417Io=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Specify resume point with git difftool?
Message-ID: <gOXOaoqn-E9A2ob7ykWEcDc7ZxmSwAjcP5CCFKfr5ejCOWZQ1lfAUZcbgYT9AyQCcDgJvCrnrtziXiels-Hxol3xlkGTVHk24SvAdaSUtKQ=@rtzoeller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I use git quite a bit while working with some binary files which require a =
custom diff tool. I'll typically review changes with a command like

git difftool --tool toolname main... -- *.extension

Frequently I'll finish reviewing a file and close the diffing program, only=
 to realize that I wanted to look at part of the diff again -- e.g. after v=
iewing a few other files and wanting some additional context.

Typically I end up killing the current difftool prompt, rewriting my diffto=
ol command to specify the file I want to re-review, and upon finishing that=
 re-review running the original difftool command. However upon running the =
original command I find myself just answering 'n' to all of the prompts unt=
il I get back to where I was, which can be a bit painful.

Is there a way to tell git "resume the difftool process at file n"? The dif=
ftool prompt counts which file I'm on ("Viewing (10/20): 'filename'"), so i=
t seems like I ought to be able to jump ahead by specifying a starting inde=
x (or range to view).

Thanks,
Ryan Zoeller

