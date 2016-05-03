From: Stefan Beller <sbeller@google.com>
Subject: Re: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile build
Date: Tue, 3 May 2016 11:53:36 -0700
Message-ID: <CAGZ79kYxSCsXGLBoBTAOLfe_pOu7YNBQoccs_fA0btEzpnU=-w@mail.gmail.com>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
	<CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
	<CAGZ79kYy=+xz5k0pN+MZTRBALd-sqbQ0TePNjkx6itjQpbRUvA@mail.gmail.com>
	<CAA6PgK4M2Ag6anEFYakW9NJe0ehTtS1UEQmDWe387W_uV-MCXA@mail.gmail.com>
	<CAGZ79kav27h+_eswTd3hRWjYhH5aApVcERa1bSxKD8p2R50HTw@mail.gmail.com>
	<CAPc5daX4noqHaOZCrZ78s0ytFBkeU7znXs0QY1LXEw8w3RnQ1A@mail.gmail.com>
	<20160503184841.GA30530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jan Keromnes <janx@linux.com>,
	=?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 20:53:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfS2-0003s9-Ea
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933709AbcECSxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:53:38 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38218 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933291AbcECSxi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:53:38 -0400
Received: by mail-ig0-f173.google.com with SMTP id m9so28339621ige.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=V/reDOD7vJ4xdu4I+KUm/SDNWiU4RC4hOx2fSZ1Ep24=;
        b=M/fG4flz7Doo3a7v5GQ96AJrV1QD6L3oCFy4HJfFbuhh5ZAvV47pYa4ckAvUBULtnD
         /26y8BLJP62gfuXkocXmz8FkLB2n6tvW+R5fcRqmqna75Jr1a/PZyMXFVcC9R3f7ZXdq
         nib5+vOaYbJEpIzNICuNISHmv1xqmIGIi+rAmjuwrSG8TK7TMjAM+mSRi+/4RE4fXGDT
         ZlsfgO36guaxZNNZhIiZxJ6SFEjWKCr3O8Zbe53m+dPr/8fGUHwcMovdsYNTkkqUR20B
         vur8Vynerb+HBQhphwgYuI4C5yrXd9sVCiuFDeds3kAoixkfqsBs/hYaVnfQiHWX9Kre
         Qw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=V/reDOD7vJ4xdu4I+KUm/SDNWiU4RC4hOx2fSZ1Ep24=;
        b=PHn5R3YPdULdy/C3dHeIHk8N4i1PNNWA9vG7lGKJfVuxoOpizinmTyfwUFuEn/BdSs
         +kTX4MtKv5Ey1de1g/kyHxnEf5MfYlrJ1widDGaLkxWxsc9oPU8EShyOTx735sMbeAR/
         GoRuUUgYO1N1/ZJQPcX/0Y65oiSh1NJvHG02gdas2zsn3gj3IX9UZBiKVqD0TOJFOBFX
         yYB1q8uNKLRTSFxcSQpctYe4jbjx4/tM9fc/z+/WclaKv63iQqU9oCERge9FfZvMW/jE
         0WiNfB761yOCwQ4DHQf76iHbNQPfALQLysiMYdNuElCszDWwayRVAuKy9yXWvwCQ5cl0
         pBLg==
X-Gm-Message-State: AOPr4FWvli1TxHf56nZnAuua+0HtWaCKj4IyZGvGdJNnwytT0OaQJovKDrnFQPlxEdA4D1jzhxDsDLrw1dd1INWX
X-Received: by 10.50.30.228 with SMTP id v4mr5485261igh.85.1462301616810; Tue,
 03 May 2016 11:53:36 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 11:53:36 -0700 (PDT)
In-Reply-To: <20160503184841.GA30530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293434>

On Tue, May 3, 2016 at 11:48 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 03, 2016 at 11:05:09AM -0700, Junio C Hamano wrote:
>
>> On Tue, May 3, 2016 at 11:02 AM, Stefan Beller <sbeller@google.com> wrote:
>> >
>> > So I wonder if is_nonbare_repository_dir() is the culprit here.
>> > (We do a chmod 0 on the .git before the `git clean` in the test to confuse Git)
>>
>> Ask if the test is run as root; if so, then mark the test to require
>> SANITY prerequisite.
>
> Yeah, I can easily reproduce the failure with `sudo ./t7300-clean.sh`.
> So the immediate fix is the SANITY prereq.
>
> Looking at Stefan's message, I wondered if the patch he came up with:
>
>         diff --git a/setup.c b/setup.c
>         index 3439ec6..4cfba8f 100644
>         --- a/setup.c
>         +++ b/setup.c
>         @@ -323,8 +323,7 @@ int is_nonbare_repository_dir(struct strbuf *path)
>                 strbuf_addstr(path, ".git");
>                 if (read_gitfile_gently(path->buf, &gitfile_error) ||
> is_git_directory(path->buf))
>                         ret = 1;
>         -       if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
>         -           gitfile_error == READ_GITFILE_ERR_READ_FAILED)
>         +       if (gitfile_error)
>                         ret = 1;
>                 strbuf_setlen(path, orig_path_len);
>                 return ret;
>
> is related or worth doing on top. But I don't think so. That code is
> just trying to convert some error-cases into "let's err on the side of
> assuming it is a repo". Doing that for all values of gitfile_error is
> definitely the wrong thing (it would treat a totally non-existent
> ".git" file as "yes, it's there", which is clearly bogus).

The proposed change is overly eager indeed.
What if we get back a READ_GITFILE_ERR_STAT_FAILED ?
I would think that is a reasonable indicator of a submodule being there?
(The stat failure may be transient ENOMEM Out of memory (i.e., kernel memory).)

By being overly eager I wanted to make sure the assumptions I had were
wrong.

I'm about to send the SANITY prerequisite patch,

Thanks,
Stefan

>
> -Peff
