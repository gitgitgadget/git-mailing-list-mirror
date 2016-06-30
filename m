Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914C31FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 15:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbcF3PPL (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 11:15:11 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34551 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbcF3PPJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2016 11:15:09 -0400
Received: by mail-io0-f194.google.com with SMTP id 100so8560163ioh.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 08:14:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Pr4K/NY2jCFNEIJe1opTLs5HYlq7+VZc3+Lcif+EKw=;
        b=Ix4MTFGiD+Sk/mz/Qcn6DQ6IJIOU69+rIy21sT/U2EfGuXVjoNxuOEvqDvyoxKib9A
         iwmBTrEqcr73yuPVMVRkFQJWd5PEoOl51sCfS/GTgM19Qh91gdlQyBJOG3tXVt/RNn8I
         NNPvjfIfjdS9cM+GJXhXGk7RgnlL7k0OZwJU9SJI+RTLUUWAAwn4sKgTvDaMpTeCY7mC
         dhWWtbMaifqes+r0++BofZnGBFawJSaWHYTz9zH8zeTIAwzNaUt8CgTwv94QtwlddCsh
         oYTk+ZFsbM6dNTjIFaMy+XwXHoJuZjvqN73dMWA94aOc3/FBx2lnHuIC61NrGAgF9+Je
         Ybfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Pr4K/NY2jCFNEIJe1opTLs5HYlq7+VZc3+Lcif+EKw=;
        b=UePuB7Y4B30KUw74csy6Io9+MVKN3PTf/0np3siEreSeAdZFZ6Z8ZUvqVCWML2QLNG
         LP0+Ns/HaRwm2tKQOdDZSs7xICBRQVLFQ9SguCq/swj4Rka6ATwQK75wWKAM6JpEuBZt
         JNgVVfhQjfru4/DzNf5lZ3AFH/vL1hgQ3i6uS1bo1szXGGztvpZAFfFVuhYpnXHhyk2A
         Ux6pOhHq46mZ7GHTgIey9924adsEdMlFt4iRDBIVJE6VM1Rmy9528sAif6GHXhooGj1z
         1Ke3V8Jvcsl7KHznpwVpnmgOEGx8chFbNLHhwUxEQxn00dYmVbUkmaiOZED4mQ+fghyH
         m0yA==
X-Gm-Message-State: ALyK8tJLAMW6IIdoc7NJ1QOwf+nBy7ISnF8kbBCqODrrNj0Xg+lw/1L7/RuZwAH7sVqj1Uqy/qNjPpiiEKD0tA==
X-Received: by 10.107.22.6 with SMTP id 6mr15147650iow.128.1467299685343; Thu,
 30 Jun 2016 08:14:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 30 Jun 2016 08:14:15 -0700 (PDT)
In-Reply-To: <5774E992.7070905@gmail.com>
References: <577425EF.6030900@gmail.com> <CAPc5daVqjhWrJjNX6monHdMTRwimbjz==j9B2FS-nXNCqPDCYQ@mail.gmail.com>
 <57743BFB.9040709@gmail.com> <xmqqy45n1y8a.fsf@gitster.mtv.corp.google.com> <5774E992.7070905@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 30 Jun 2016 17:14:15 +0200
Message-ID: <CACsJy8AES0iu341DU6FDYZq6fmssbD3QSZaiwi9BntTnMQS5Gw@mail.gmail.com>
Subject: Re: [RFD] Place to document magic pathspecs like ":/" and pathspec handling
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jakub,

Where have you been all these years? :D

On Thu, Jun 30, 2016 at 11:42 AM, Jakub Narębski <jnareb@gmail.com> wrote:
>>>>> Nowadays we have gitcli(7) manual page, but perhaps
>>>>> it would be better to create a separate manpage for issues related
>>>>> to pathspec handling (of which ":/" is only one part)... but then
>>>>> what should it be named?
>
> So we could describe how Git handles pathspecs and pathspec magic
> in the new manual page named gitpathspec(7), or gitpaths(7). The
> former has the advantage of the name being identical to the entry
> in gitglossary(7). The latter has the probable advantage of being
> easier for the Git novice to find,

git-pathspec(7) is a great idea. It bugs me that all the pathspec
details are hidden in that glossary file (though I didn't know it was
also available via "git help glossary", which probably just reinforces
its invisibility). The closet place I could think of was git(1) but
that page is already very long.

> and that it could be used to
> gather various ways to generate list of files in Git (files in
> the working area, files in the staging area aka the index, files
> in the revision / tree object, changed files, etc.);

You mean the list of commands in this man page? OK. Another thing we
could do is the reverse direction, add gitpathspec(7) as a reference
to all commands that may need it.

> the pathspec
> in strict sense is about the input. Well, we could have 'manpage
> alias' of gitpaths to gitpathspec, or vice versa.

>  Sidenote: I wonder if people (especially novices) have problem
>  finding relevant documentation, and if adding something like
>  "git apropos <topic>" command ("apropos", or "man -k"), or
>  add the '--apropos' option to "git help" would be useful...
>  and if it would be easy to create.

I have that problem sometimes and I don't think I can call myself a
noob anymore. I usually need to do some grepping. So yeah "git
apropos" would be great.
-- 
Duy
