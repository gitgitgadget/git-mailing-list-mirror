Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19361F858
	for <e@80x24.org>; Thu, 28 Jul 2016 22:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbcG1Wb6 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 18:31:58 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35409 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbcG1Wb6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 18:31:58 -0400
Received: by mail-wm0-f48.google.com with SMTP id f65so268858897wmi.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 15:31:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9PSrOVUoVZIvxc91+HUdTLnJ6QYfS5ew0pOJgkaKEMA=;
        b=mu+prpsyMdIu26/T2tDoG3AV9amMG7Tdol1I3bL7J6mgR593n9WL3RHJxEHKBeFQF6
         CiQfmW33aZ6J3GEjuwqnEVUlTvAVT2TzfeezncjggKnVYBwPVWnAG4E/X0LP4S85RGaz
         /ygH4QFCGNYh9mTV3vpsGfG2dIuXB0z0YiwLITJxq08rXRu1q+c5pHmnA8MYFCqkx+86
         P/6fASDjR+Wp8GIjjUOZO6T5awcNaqAjuFE3AQescWa3VjDQuaI5SpWwUAOtvMpOjKhI
         8QlkT1C2IVXRypgcDbEjq3c8JuN905sN/l2xD8gaV8kIlw8BtV1MNaxpB+922sVqB74f
         Ikmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9PSrOVUoVZIvxc91+HUdTLnJ6QYfS5ew0pOJgkaKEMA=;
        b=ah4U0SMmqbkeBROLKOgi284lL35IDlmRf/fMd1er10nrnE0o6Md0EdxfTIAc6tzB2F
         x7oMa7UqJOTUMzgaOa5b4Vo78cf4C+0BrgayQ7OXKMSk8QS2OcWypMjADDWl9zPANlzR
         b7XX22uNkl8h5urTdHJcBp3GA6lft+bwYZgqpVGU0kmhf3g2q+yX3fGZkK5cfwU5yZz/
         tX8mmJW4zjuPpL197aed0nTp8DrKf0nyNEjZWJxI6mwTau1exr1/t7sUcaCI5Pc/6M4v
         5iJQUxWE6AVllYP6eKUw4uwbeAeJ8i1i+OvuSKWSypUxJ2GqCC2OMO8WEdlUF2pFzsiB
         7bsw==
X-Gm-Message-State: AEkoouvEAx00BlSefCS6nGy85XobVlvAabaw1DkuuF0AC2WkQKvbbylXXtwht7XcRFNhcbxOvphbE1KNiL61jg==
X-Received: by 10.194.149.133 with SMTP id ua5mr34868254wjb.79.1469745116588;
 Thu, 28 Jul 2016 15:31:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.130.74 with HTTP; Thu, 28 Jul 2016 15:31:27 -0700 (PDT)
In-Reply-To: <579A5D97.7080708@gmail.com>
References: <CAA787r=FH7Sa4qy2A-dy+wug81ZkqOW2KmSuWBE8_3whmNj1pw@mail.gmail.com>
 <xmqqlh0lsoq6.fsf@gitster.mtv.corp.google.com> <CAA787rmDb+1=4RCscvo1rZWSt=tUQSm5wrFet-=PhRKZcf9x5A@mail.gmail.com>
 <579A5D97.7080708@gmail.com>
From:	=?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Date:	Fri, 29 Jul 2016 00:31:27 +0200
X-Google-Sender-Auth: VjdvhAudT3s2m9Ltly7s73MAYOQ
Message-ID: <CAA787rm+qLig6mzHw0NjNDt-6HF_77FOwmg5dBBOdwbqo3wP6A@mail.gmail.com>
Subject: Re: git-testadd: Execute a command with only the staged changes in
 Git applied
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 28 July 2016 at 21:31, Jakub Narębski <jnareb@gmail.com> wrote:
> W dniu 2016-07-28 o 18:56, Øyvind A. Holm pisze:
> > Øyvind A. Holm <sunny@sunbase.org> writes:
> > > This is a script I created some weeks ago, and I've found it to be
> > > immensely useful. Here is a snippet from git-testadd --help:
> > > [...]
> > >   This script clones the repository to the directory
> > >   ".testadd.tmp" in the current directory and applies the staged
> > >   chenges there (unless -u/--unmodified or -p/--pristine is
> > >   specified), chdirs to the same relative directory in the clone
> > >   and executes the command specified on the command line there.
> >
> > That's correct, the test clone is entirely separated from the
> > working copy, and you can keep working while the tests are running
> > in the clone. Combined with git-gui and/or "git add -p/git reset
> > -p", it's easy to tweak the staged changes until things are ok.
>
> I wonder if using `git worktree` instead of `git clone` (well, local
> clone uses hardlinks, so it is not that costly as it looks like) would
> be a better solution.

That's an interesting idea. Have to test it out. This is the result from
the current master in linux.git:

With clone:

  $ time git testadd pwd
  git-testadd: Using ".testadd.tmp" as destination directory
  Cloning into '.testadd.tmp'...
  done.
  Checking out files: 100% (55256/55256), done.
  git-testadd: Applying staged changes

  git-testadd: Executing "pwd" in /home/sunny/src/test-wt/.testadd.tmp
  /home/sunny/src/test-wt/.testadd.tmp

  real    0m10.464s
  user    0m5.983s
  sys     0m2.790s
  $

With worktree:

  $ time git worktree add testaddtmp
  Preparing testaddtmp (identifier testaddtmp)
  Checking out files: 100% (55256/55256), done.
  HEAD is now at 194dc87 Add braces to avoid "ambiguous ‘else’" compiler
  warnings

  real    0m10.343s
  user    0m6.010s
  sys     0m2.523s
  $

Both tests were run with cold cache ("echo 3 >/proc/sys/vm/drop_caches"
as root). It seems as there's no difference, and that git clone is as
fast as it can get without breaking physical laws. And we probably
shouldn't do that. :)

Z poważaniem,
Øyvind
