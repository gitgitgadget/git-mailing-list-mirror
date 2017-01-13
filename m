Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0A720798
	for <e@80x24.org>; Fri, 13 Jan 2017 09:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbdAMJPq (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 04:15:46 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34382 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdAMJPo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 04:15:44 -0500
Received: by mail-wm0-f49.google.com with SMTP id f73so10492216wmf.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 01:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2ysKhuQFyo8wfMqe/tfDmbYAiWin6fXEvJMFuH5ta4Q=;
        b=VHMp/QPrZC02cnEdrIjhELcAdIabHTmqCgZoc4744XtxJgAE0Z/AM563Ie1gb2Y2SR
         u2FQsdw8QoaCg8rfb+4ZsD/cE+CN/ASJoIA3HgwEvoC+RGE5MnZrfNNM94iAH7/k5ZxD
         oQet9ZuCrsaVnsHUbnelaWr8lA+Kh5HrOdiQmQiPCwqAOvwFqp4ljO52KwGcYUEZIZV0
         MG1b+/21Dhxez3DeSxxwQJMQ5HR+pQCB+hh33hxwNOcQm/aJeKwB3GcrsraQ7WP/SDsV
         bGdz+67kxxzwgve/HgXetL7KJxy2y+/00jGKCYcP8AYax2J0+5Ost2I+tyqnYYEhrJNm
         +jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2ysKhuQFyo8wfMqe/tfDmbYAiWin6fXEvJMFuH5ta4Q=;
        b=nlm6iqYi08nEse3GoxSqyQW05TW+EQ1hQRb4CWeT1fRwvMG46hs2s/X0Yx/opKhKha
         +Uum5kpzWYnR216aFJYbAAb++qU3D2RMRl86BAOs8nz8xn8yo5jSFYDRkUJysj3qVcsr
         7XAO0jQBNMmP8uhr0v6EcghhbD+E6YPMeyfpHigl84KF+EEOil8SFUx7g+5ma8GDxFlB
         jAdQ32lGjIU67JxJ+9qY0PAO8YKcBehLfvS2KGsgIqlTKnCh57r3y9AJTELXN9ZZMLh/
         2RSNks28NlbIBhC9A8YJQFJt07plrNuGRpsLHOOa7dfjZQG8oGDarJM0v1+V5Tm1Zqxx
         g0AQ==
X-Gm-Message-State: AIkVDXL0lZ9oAVtJRgTgNFCp/FSN2I0Ir2MhviM/2xSPi8kDckJdTbqGTcveHIrCoQrea6tsHdB06RVC6vGSBQ==
X-Received: by 10.223.128.77 with SMTP id 71mr11020843wrk.48.1484298942914;
 Fri, 13 Jan 2017 01:15:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.94.71 with HTTP; Fri, 13 Jan 2017 01:15:42 -0800 (PST)
In-Reply-To: <20170108052619.4ucjamsqad4g5add@sigill.intra.peff.net>
References: <CAEBDL5Uc39JagdmXUxfxh1TPSK3H5wxoTfjK-pfLRYjciBnHpA@mail.gmail.com>
 <1483825623.31837.9.camel@kaarsemaker.net> <20170108052619.4ucjamsqad4g5add@sigill.intra.peff.net>
From:   John Szakmeister <john@szakmeister.net>
Date:   Fri, 13 Jan 2017 04:15:42 -0500
X-Google-Sender-Auth: MPrHKyIvXduv-6wKnKhNovBZt3M
Message-ID: <CAEBDL5Vf=rvb4fZF87pNYci4sicmzhS_qPJYHHOGcnPTMBhhWg@mail.gmail.com>
Subject: Re: "git fsck" not detecting garbage at the end of blob object files...
To:     Jeff King <peff@peff.net>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2017 at 12:26 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Jan 07, 2017 at 10:47:03PM +0100, Dennis Kaarsemaker wrote:
>> On Sat, 2017-01-07 at 07:50 -0500, John Szakmeister wrote:
>> > I was perusing StackOverflow this morning and ran across this
>> > question: http://stackoverflow.com/questions/41521143/git-fsck-full-only-checking-directories/
>> >
>> > It was a simple question about why "checking objects" was not
>> > appearing, but in it was another issue.  The user purposefully
>> > corrupted a blob object file to see if `git fsck` would catch it by
>> > tacking extra data on at the end.  `git fsck` happily said everything
>> > was okay, but when I played with things locally I found out that `git
>> > gc` does not like that extra garbage.  I'm not sure what the trade-off
>> > needs to be here, but my expectation is that if `git fsck` says
>> > everything is okay, then all operations using that object (file)
>> > should work too.
>> >
>> > Is that unreasonable?  What would be the impact of fixing this issue?
>>
>> If you do this with a commit object or tree object, fsck does complain.
>> I think it's sensible to do so for blob objects as well.
>
> The existing extra-garbage check is in unpack_sha1_rest(), which is
> called as part of read_sha1_file(). And that's what we hit for commits
> and trees. However, we check the sha1 of blobs using the streaming
> interface (in case they're large). I think you'd want to put a similar
> check into read_istream_loose(). But note if you are grepping for it, it
> is hidden behind a macro; look for read_method_decl(loose).

That's for the pointer.

> I'm actually not sure if this should be downgrade to a warning. It's
> true that it's a form of corruption, but it doesn't actually prohibit us
> from getting the data we need to complete the operation. Arguably fsck
> should be more picky, but it is just relying on the same parse_object()
> code path that the rest of git uses.
>
> I doubt anybody cares too much either way, though. It's not like this is
> a common thing.

I kind of wonder about that myself too, and I'm not sure what to
think about it.  On the one hand, I'd like to know about
*anything* that has changed in an adverse way--it could indicate
a failure somewhere else that needs to be handled.  On the other
hand, scaring the user isn't all that advantageous.  I guess I'm
in the former camp.

As to whether this is common, yeah, it's probably not.  However,
I was surprised by the number of results that turned up when I
search for "garbage at end of loose object".

> I did notice another interesting case when looking at this. Fsck ends up
> in fsck_loose(), which has the sha1 and path of the loose object. It
> passes the sha1 to fsck_sha1(), and ignores the path entirely!
>
> So if you have a duplicate copy of the object in a pack, we'd actually
> find and check the duplicate. This can happen, e.g., if you had a loose
> object and fetched a thin-pack which made a copy of the loose object to
> complete the pack).
>
> Probably fsck_loose() should be more picky about making sure we are
> reading the data from the loose version we found.

Interesting find!  Thanks for the information Peff!

-John
