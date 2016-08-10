Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F8B1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934928AbcHJURY (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:17:24 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35093 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbcHJURW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 16:17:22 -0400
Received: by mail-yw0-f172.google.com with SMTP id j12so32041845ywb.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 13:17:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=clbpSAE1IY7YG+uhY4hffzmAO4anfyoXkCS1hd3w2w0=;
        b=yUoHrs9p1cgPg0uYs67rD5vwbwYiLOU5NADHmrEr2oZ8d3XY7tX4tfGnniUzXAfmsE
         aHrFKqCGy3JqrKb6t4BdOgvWLmOv0DiulSh3F4EyvkPysJDx1a5sv9XjovQWJiiXuwzt
         Z4FSlOmtBtvL8OR2NEriRCOh612Ey4h4StzeW1g5emiZWYsCwZsHsK8uMSg0jpW3o0TD
         RtDz8lPM8ROkbbsFsJQCwoMN7XrkQ7Vvlwi2YSLu0FHS5MlWeb7tVq/Ge05nt/6sICrf
         F8Gvvw+RcQNBG3E9qXvSy2AZUpKWaKO3G4ma5Oo2kpshuuJPfMVwmEf17esNwP/3AVQh
         16nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=clbpSAE1IY7YG+uhY4hffzmAO4anfyoXkCS1hd3w2w0=;
        b=IICxwk5I6WY1oSCnbp+4d6wgA7mBuF2669GtASaFsJoxNhQBtbW/70loOL1ZTvQptg
         NCYub+It6r+M2O1hm0flGdB+ggcF6AJDALkc2zsNieoaKWxGlyW6A22J9zYBJ8VpA0/E
         JhmIkddTSaMPSlGPDjY8oeBSXlB9T4HhzKMjdcsFMtY+h5i12CrenodXK+AbWWCANoYr
         WoKJ/lsgp36XwG2f/T65voDsGAVFgxEEBhb+xBGG6W8E6etxfKqEM2NVAZjxP91CTcxh
         Y2WzyKY11Z2lx2QGUAAYZdApVeL1hg4oD2t8XgKUjtNqARrbgIQZMXLEL3Jk27GVJHkj
         aVfw==
X-Gm-Message-State: AEkoouuewOQZgNM3+SCF93MS0hnQncLccp8EDx+hn/+6St8DVQXOYsf+/PhyMKGeFPIuPZwsVxdcMu+Xx27pEw==
X-Received: by 10.129.135.2 with SMTP id x2mr1635439ywf.310.1470811941779;
 Tue, 09 Aug 2016 23:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Tue, 9 Aug 2016 23:52:01 -0700 (PDT)
In-Reply-To: <xmqqtwet70ra.fsf@gitster.mtv.corp.google.com>
References: <20160810002315.25236-1-jacob.e.keller@intel.com> <xmqqtwet70ra.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 9 Aug 2016 23:52:01 -0700
Message-ID: <CA+P7+xpGGqNC8B-fQiQXZcXWha2BBQa96sFvj+_MBVHWakMh_Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2] diff: add SUBMODULE_DIFF format to display
 submodule diff
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 8:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>> +             cp.dir = path;
>> +     cp.out = -1;
>> +     cp.no_stdin = 1;
>> +     argv_array_push(&cp.args, "diff");
>> +     argv_array_pushf(&cp.args, "--src-prefix=a/%s/", path);
>> +     argv_array_pushf(&cp.args, "--dst-prefix=b/%s/", path);
>
> I think this is wrong.  Imagine when the caller gave you prefixes
> that are different from a/ and b/ (think: the extreme case is that
> you are a sub-sub-module, and the caller is recursing into you with
> its own prefix, perhaps set to a/sub and b/sub).  Use the prefixes
> you got for a/ and b/ instead of hardcoding them and you'd be fine,
> I'd guess.

I'll have to get these passed, but yes this makes more sense, will look into it.

>
>> +     argv_array_push(&cp.args, sha1_to_hex(one));
>> +
>> +     /*
>> +      * If the submodule has untracked or modified contents, diff between
>> +      * the old base and the current tip. This had the advantage of showing
>> +      * the full difference of the submodule contents.
>> +      */
>> +     if (!create_dirty_diff)
>> +             argv_array_push(&cp.args, sha1_to_hex(two));
>> +
>> +     if (start_command(&cp))
>> +             die("Could not run 'git diff' command in submodule %s", path);
>> +
>> +     diff = fdopen(cp.out, "r");
>> +
>> +     c = fgetc(diff);
>> +     while (c != EOF) {
>> +             fputc(c, f);
>> +             c = fgetc(diff);
>> +     }
>> +
>> +     fclose(diff);
>> +     finish_command(&cp);
>
> I do not think you need to do this.  If "f" is already a FILE * to
> which the output must go, then instead of reading from the pipe and
> writing it, you can just let the "diff" spit out its output to the
> same file descriptor, by doing something like:
>
>         fflush(f);
>         cp.out = dup(fileno(f));
>         ... other setup ...
>         run_command(&cp);
>
> no?  I do not offhand recall run_command() closes cp.out after done,
> and if it doesn't you may have to close it yourself after the above
> sequence.


That makes a lot more sense, yes. I hadn't thought of dup, (long time
since I've had to use file descriptors).

the child_process api does close the descriptor itself. That's a much
better way to get the result we want, and it is less code, so I'll try
this out.

>
> While I personally do not want to see code to access submodule's
> object store by temporarily adding it as alternates, the "show
> left-right log between the commits" code already does so, so I
> should point out that running "diff" internally without spawning it
> as a subprocess shouldn't be too hard.  The diff API is reasonably
> libified and there shouldn't be additional "libification" preparation
> work required to do this, if you really wanted to.

I looked at trying to call diff for this, but I think it's not worth
it. Using the child process API makes more sense and is a cleaner
method. I'll go this route as it appears to work pretty well. The only
major concern I have is that options may not get forwarded
correctly...

Thanks,
Jake
