Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2001F403
	for <e@80x24.org>; Wed, 13 Jun 2018 01:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935170AbeFMBEn (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 21:04:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51973 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935100AbeFMBEk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 21:04:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so1807182wmc.1
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 18:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ylyVnPyuEF4vXxBfz5fMWAoyLQhrz7p/Kz9BCY8cY+I=;
        b=ZHDAZpnaRw80hEC6jRSSC4RQPqJqyTta7nnjYH6irRAMK2DDbEHGmKq8cejmff9FfD
         9rV/E+cSAveWZ/Vfc+WiZDewl5vrxgHJPBBgKI8LNU24hkseZJbsMz+FDYzYXt5muGuR
         AxGp1vpxhlFZfensL0u8RkjqxifX/FsdxBe1rhkMrKsburpiXsLItx3KUxkgi/ZU/3lj
         Vcx1iQEfzJ73JQNV6jV+ZqFzTNvDZ6OHE02NglGoyTVmd9UeW6Pq+qQDFq4OXIfwvr3T
         HKLkeHZJ/TZF3CyFtZ0HbVJrOBTmsTsqGQa4KCJmAFcFEGVFzlQYg4NDqflkQzj+FvmC
         Mcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ylyVnPyuEF4vXxBfz5fMWAoyLQhrz7p/Kz9BCY8cY+I=;
        b=aUzqcmt9IzckK+nN1L4Cx2HfMEL3ISsz8ceNo3tY6tcqZNivnGKPp+zMu2Pe5jW6Kp
         dRyhalJUKFf0sZf0CZaGGMpaY37EU1czNfuizcRvW1eWgmb99geCkrREddK0L4n/U9EO
         OSb7esZp3Ngv+eTFc5Ia+21IYVH5dAttMN37gHoQGS1oz4ymewQfdanCaNLgxlE7/8zX
         aTypqXySPtab/uTYK2hdU0c3/tsOUXgNy6hPb918fSRdassAUkPwbyjfuKnMbuzVju2m
         lqFFV+TfNu1Pd1Wyj8Vth9kjAkCbpa11DVQsLpTiMdgI+SATAT8pX0SsNw/HhofD1XI6
         8Hsw==
X-Gm-Message-State: APt69E1w0TjaFz3LKrpvRPZOeSfy92wOmiNHlSLE9zUeqwuUWp9zYw5k
        FMheBkr6PkM/mwAY3CFO7ZIarjmuF3jYY26dV7E=
X-Google-Smtp-Source: ADUXVKLsDXQP8iYDG0OCh86c3vQaDkpNHik++iUTXNPE3XsVNzw2Kcm0FScrWRf56E0IQnGPWAO6L5SQMo7sER0toCU=
X-Received: by 2002:a1c:8742:: with SMTP id j63-v6mr1852624wmd.105.1528851879040;
 Tue, 12 Jun 2018 18:04:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:ca0f:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 18:04:38
 -0700 (PDT)
In-Reply-To: <xmqqk1rolcxg.fsf@gitster-ct.c.googlers.com>
References: <20180525225601.22575-1-lintonrjeremy@gmail.com>
 <CACsJy8C4zNZAe6Vw-mz8r8HueYdQKs4ZhMOQYX0v7ypfHdmShg@mail.gmail.com>
 <xmqq8t86m0m3.fsf@gitster-ct.c.googlers.com> <CACsJy8CNmDkxzhkdfwjVHjGF4JeUzzPHGnp1x647NxU-GxkxvA@mail.gmail.com>
 <xmqqsh6dl3gg.fsf@gitster-ct.c.googlers.com> <xmqqk1rolcxg.fsf@gitster-ct.c.googlers.com>
From:   Jeremy Linton <lintonrjeremy@gmail.com>
Date:   Tue, 12 Jun 2018 20:04:38 -0500
Message-ID: <CAEFTgiw03eDXAobWrP4J_CM1uGHoAEUkguV1_agAiNkssCpwyg@mail.gmail.com>
Subject: Re: [PATCH] packfile: Correct zlib buffer handling
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry about the delay here (bit of a mix-up and didn't reply to the list).

(see inline )

On Sun, May 27, 2018 at 9:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Sun, May 27, 2018 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:

(trimming)

>
> Specifically, I was worried about this assertion:
>
>     Lets rely on the fact that the source buffer will only be fully
>     consumed when the when the destination buffer is inflated to the
>     correct size.
>
> which I think is the exact bad thinking that caused troubles for us
> in the past; isn't the explanation in 456cdf6e ("Fix loose object
> uncompression check.", 2007-03-19) relevant here?
>
> -       stream.avail_out = size + 1;
> +       stream.avail_out = size;
>         ...
>                 stream.next_in = in;
>                 st = git_inflate(&stream, Z_FINISH);
>                 if (!stream.avail_out)
> -                       break; /* the payload is larger than it should be */
> +                       break; /* done, st indicates if source fully consumed */
>                 curpos += stream.next_in - in;
>         } while (st == Z_OK || st == Z_BUF_ERROR);
>         git_inflate_end(&stream);
>         if ((st != Z_STREAM_END) || stream.total_out != size) {
>                 free(buffer);
>                 return NULL;
>         }
>
> With minimum stream.avail_out without slack, when !avail_out, i.e.
> when we fully filled the output buffer, it could be that we had
> correct input that deflates to the correct size, in which case we
> are happy---st would say Z_STREAM_END, we would leave the loop
> because it is neither OK nor BUF_ERROR, and total_out would report
> the size we expected.  Or the input zlib stream may have ended with
> bytes that express "this concludes the stream", and the input bytes
> before that was sufficient to construct the original payload fully,
> and we may have just fed the bytes before that "this concludes the
> stream" to git_inflate().
>
> In such a case, we haven't consumed all the avail_in.  We may
> already have all the correct output, i.e. !avail_out, but because we
> haven't consumed the "this concludes the stream", st is not
> STREAM_END in such a case.

If I understand correctly your concerned the avail_in is longer than
what is required to fill the output buffer..

I'm fairly sure that won't result in a Z_STREAM_END, as you rightfully
point out, but the loop _will_ terminate due to the output buffer
being full and then since its not Z_STREAM_END the
unpack_compressed_entry fails, as it should.

>
> Our existing while() loop, with one-byte slack in avail_out, would
> have let us continue and the next iteration of the loop would have
> consumed the input without producing any more output (i.e. avail_out
> would have been left to 1 in both of these final two rounds) and we
> would have exited the loop.  After calling inflate_end(), we would
> have noticed STREAM_END and correct size and we would have been
> happy.

Your assuming that zlib will terminate with an error, but a fully
decompressed buffer, because it hasn't consumed the entire input
buffer. I don't think that is how it works (its not how the
documentation is written, nor the bits of code i've looked at seem to
work, which granted i'm not a zlib maintainer).


>
> The updated code would handle this latter case rather badly, no?  We
> leave the loop early, notice st is not STREAM_END, and be very
> unhappy, because this patch did not give us to consume the very end
> of the input stream and left the loop early.

Your correct if the above case is a valid zlib behavior then there
would be a problem. But, I don't think the termination is dicated by
insufficient output space until there is an attempt to utilize that
space.


>
>>> This yields two problems, first a single byte overrun won't be detected
>>> properly because the Z_STREAM_END will then be set, but the null
>>> terminator will have been overwritten.
>
> Because we compare total_out and size at the end, we would detect it
> as an error in this function, no?  Then zlib overwriting NUL would
> not be a problem, as we would free the buffer and return NULL, no?
>
>>> The other problem is that
>>> more recent zlib patches have been poisoning the unconsumed portions
>>> of the buffers which also overwrites the null, while correctly
>>> returning length and status.
>
> Isn't that a bug in zlib, though?  Or do they do that deliberately?
>
> I think a workaround with lower impact would be to manually restore
> NUL at the end of the buffer.

I agree, just resetting the NULL its likely safer, and I will repost a
patch soon which if nothing else makes git more robust to errant zlib
behavior.
