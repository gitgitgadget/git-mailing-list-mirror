Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFC82047F
	for <e@80x24.org>; Thu, 28 Sep 2017 04:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbdI1E4g (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 00:56:36 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:44358 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbdI1E4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 00:56:35 -0400
Received: by mail-ua0-f174.google.com with SMTP id s15so228566uag.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 21:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ai/ySd1N7sWs7kfDwFQqw537L+o1Ss68VOqnWyEHsNY=;
        b=NdlN54KU5+OmYjCilVQlIzBydIlrGuM4pmLEGiq2kKTei8rjA++XplXAUlVU4oYM8P
         exUroTHZuZLU1ejunBNcdUYKCTNlHjRx49+lW0EtV15GCtmNcznv7gl4CQ78ek1Ntdwc
         RjkJvF3LmTHmuYfqsy0PKygmUcChF1zOLYsEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ai/ySd1N7sWs7kfDwFQqw537L+o1Ss68VOqnWyEHsNY=;
        b=kVurwQ6yCTKreZEAM0J+OUmWg4+gwft4sLThxecZOeYbmVTsn6xFfAKkkPyCPZso8t
         FDqxRqnaNFCYISUagytiN6PjtFWJNl6J7i1lcFVy3VP4R0jpE0Cif4PEGFjQ8FSGtiHe
         kiEeMFNYN0fQVkGtmglJh88KqZjr9Tl8wZQ++njdEOCF2MMMQ/iBOuaU1CT2KVmYPkKQ
         +5N/51OO525t0LQElnyZFLHzq8mdaMo/Nhw9L3ublL6yI4emAJdlk9FKGcdqkoudW6bN
         9W48WmVikn1A9P44+wkwhhkPpo9Vw9iEWUCQVfOX0RLkRZqkCq+xFlggLMyD1WqoRFrB
         r0LA==
X-Gm-Message-State: AHPjjUjnW3VcLQYjUwfhod833W6iAuE3G5SGcSCh4aXOt4nQauFnfZMJ
        m8OTjJd/JnvSPvGxqfl3aGsMHNBRIoLbrgWpYDwMew==
X-Google-Smtp-Source: AOwi7QDsrh87oQHm0qjRrdMrGpAP2PINl95PMk6oSOZL7IQs69xXyBCk7zsebmwMGqstDbsU37WceotPhCG8M+Bl/wM=
X-Received: by 10.159.53.140 with SMTP id t12mr2227901uad.192.1506574594464;
 Wed, 27 Sep 2017 21:56:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.146.1 with HTTP; Wed, 27 Sep 2017 21:56:14 -0700 (PDT)
In-Reply-To: <xmqqh8vn32mn.fsf@gitster.mtv.corp.google.com>
References: <xmqqefqs7qx8.fsf@gitster.mtv.corp.google.com> <cccb06b75df3cad9f013d5a9ab0371f0a2d9c2ce.1506541322.git.e@nanocritical.com>
 <xmqqh8vn32mn.fsf@gitster.mtv.corp.google.com>
From:   Eric Rannaud <e@nanocritical.com>
Date:   Wed, 27 Sep 2017 21:56:14 -0700
Message-ID: <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeremy SERROR <jeremy.serror@gmail.com>,
        "Shawn O . Pearce" <spearce@spearce.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 8:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     cat $input_file >&8
>
> It probably is a good idea to quote "$input_file" in case other
> people later use a full path to the file or something; for now this
> is OK.

Right.


> fd#8 at this point does not have a reader; unless the contents of
> the $input_file is small enough, wouldn't this "cat" block until
> somebody else comes and reads from it to drain?  Should we instead
> start fast-import first in the background, arrange it to be killed
> when we are done with it, and then start feeding the input?

Good point, I will swap the order.


>> +     git fast-import $options <&8 >&9 &
>> +     echo $! >V.pid
>> +     test_when_finished "kill $(cat V.pid) || true"
>
> This '|| true' is here because the process might already have died
> on its own, which sounds like a sensible precaution.

I added a comment.


>> +     error=0
>> +     if read output <&9
>> +     then
>> +             if ! test "$output" = "progress checkpoint"
>> +             then
>> +                     echo >&2 "no progress checkpoint received: $output"
>> +                     error=1
>> +             fi
>> +     else
>> +             echo >&2 "failed to read fast-import output"
>> +             error=1
>> +     fi
>
> And we expect "progress checkpoint" would be the first and only
> output after fast-import consumes all the input stream up to the
> "progress" thing we feed, so this is not "read and discard until
> we see 'progress checkpoint'" but is "read one and that must be
> 'progress checkpoint'".  Makes sense to me.
>
> If this script is (and will be in the future) all about issuing a
> checkpoint command and observing its effect, we can reasonably
> expect that the input file _must_ end with "checkpoint" followed by
> "progress checkpoint", no?  If that is the case, perhaps feeding
> these two from this helper function to >&8, instead of forcing the
> caller to prepare the input file to always end with these two, may
> be a better organization.

Agreed. Renamed the function background_import_then_checkpoint to
reflect the change.


>> +     exec 8>&-
>> +     exec 9>&-
>
> These are to make sure that nobody (after fast-import dies) has
> these file descriptors hanging open for writing.  Makes one wonder
> what happens to the reader side of the file descriptor, though ;-)
>
> Before we return from this function, we expect (as the comment
> before the function says) that fast-import is still running, waiting
> further input.  Wouldn't closing the other side of the pipe here
> like these make it notice that there is no more data by causing
> read_next_command() find EOF?  IOW, is "use import_until_checkout,
> test the outcome and then make sure import_still_running reports that
> the outcome was not due to the process terminating and flushing"
> somewhat racy?
>
> Or are we closing these file descriptors for different reason
> (i.e. not to tell fast-import we are done feeding it input) and I am
> reading the code incorrectly?  Puzzled.

Closing 8 and 9 was just housekeeping on my part. But you raise a good
point: what happens then to the stdin of fast-import?

Doesn't fast-import get a copy of 8 (open for both reading and
writing), as a child process, and exec 8>&- only closes the copy of
the file descriptor in the parent shell, so the named pipe remains
open for writing somewhere (in the fast-import process itself, in
fact), therefore fast-import will not find EOF on its stdin?

But in any case, it is sensible to delay the closing of 8 and 9 to
test_when_finished.


>> +     if test $error -eq 1
>> +     then
>> +             exit 1
>> +     fi
>> +}
>> +
>> +background_import_still_running () {
>> +     if ! kill -0 "$(cat V.pid)"
>> +     then
>> +             echo >&2 "background fast-import terminated too early"
>> +             exit 1
>> +     fi
>> +}
>
> I suspect these "exit 1" above should be "false", to give the calling
> test_expect_success a chance to notice the failure and react to it.

True.

Will follow-up with an updated patch.
