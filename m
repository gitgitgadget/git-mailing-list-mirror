Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4FB32018E
	for <e@80x24.org>; Tue, 30 Aug 2016 16:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757962AbcH3Q1Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 12:27:25 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37405 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757954AbcH3Q1V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 12:27:21 -0400
Received: by mail-wm0-f44.google.com with SMTP id i5so45116652wmg.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nmmCZ8q8+grVSRqISi0EFVipyW8ansGf1ksE3drdOe4=;
        b=PzehxutEiJD+oMMD7IwWK2YFGMJ8wRsdaJukf+qpMZRjhbp21bcpkZ4+cdS+UVU+86
         T5ihJwqZ11nzwUjU2JTaI54FZdpQGt4S1I1FMg7R/kpitTCOjxIYQ2l9Tde2HU4zYA05
         RLTywI5D3sndweocpM6MbLQalgS5bl7GKwFlANcRCgdaF4VN+9buxjyRGS0E5kuGjrYw
         1FmhG1TDAcn1zW5DbdVqGftxg76t421EjTVSfiUMY1kq0hiWv81sr7/v3NEtxCpC9wpK
         1hdhzAY6RTZiyYtpUviWx5vKtLJyA7w9eVC/TisjLx5Rx+AwZje0DUR710u+wATKmu59
         hnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nmmCZ8q8+grVSRqISi0EFVipyW8ansGf1ksE3drdOe4=;
        b=N0+4b785z4+5ve8oeViL/ZLVZVKX1oYtdPx/Fq0s4yy1Uu+snkOrwxAopGbNq/mo7Q
         JE+Og4Ik+imhd0dhdrH0XqdhczYcf/emkh0M3zDWHpZIseCowXejzguOdxUzcsUZaiX3
         Qhfm3GLC/3I5vnvQBnottWixclYeEWt374jyrV6rERgKjvUqXYjWwhldMCquM2UtUE/M
         TzJ8krcepwgcTzxCicVJTnOrYq4lXlMx+ihoxi6Wl/PF8+dv/uPM30MsBCy6LlQ4zETG
         T/tDHvDmQnqwrp34EgBsN6mK16AdowDK992Evufjegu73S2n9kOtIQGzlPARNwS0ibV+
         ywLQ==
X-Gm-Message-State: AE9vXwMutFZG1m35pXW3VmRev9UIJfhs8VZPSc59ElRy3j/tK/O/M7lTYfg5vgg08+6dOA==
X-Received: by 10.194.178.102 with SMTP id cx6mr4139154wjc.58.1472574439490;
        Tue, 30 Aug 2016 09:27:19 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id g67sm4700815wme.5.2016.08.30.09.27.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Aug 2016 09:27:18 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 12/13] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 30 Aug 2016 18:27:17 +0200
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A378528-58DE-4C17-9F00-9708947716DD@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-13-larsxschneider@gmail.com> <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Aug 2016, at 00:21, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> +In case the filter cannot or does not want to process the content,
>> +it is expected to respond with an "error" status. Depending on the
>> +`filter.<driver>.required` flag Git will interpret that as error
>> +but it will not stop or restart the filter process.
>> +------------------------
>> +packet:          git< status=3Derror\n
>> +packet:          git< 0000
>> +------------------------
>> +
>> +In case the filter cannot or does not want to process the content
>> +as well as any future content for the lifetime of the Git process,
>> +it is expected to respond with an "error-all" status. Depending on
>> +the `filter.<driver>.required` flag Git will interpret that as error
>> +but it will not stop or restart the filter process.
>> +------------------------
>> +packet:          git< status=3Derror-all\n
>> +packet:          git< 0000
>> +------------------------
>=20
> This part of the document is well-written to help filter-writers.

Thanks!


> One thing that was unclear from the above to me, when read as a
> potential filter-writer, is when I am supposed to exit(2).  After I
> tell Git with error-all (I would have called it "abort", but that's
> OK) that I desire no further communication, am I free to go?  Or do
> I wait until Git somehow disconnects (perhaps by closing the packet
> stream I have been reading)?

The filter can exit right after the "error-all". If the filter does
not exit then Git will kill the filter. I'll add this to the docs.

"abort" could be ambiguous because it could be read as "abort only
this file". "abort-all" would work, though. Would you prefer to see
"error" replaced by "abort" and "error-all" by "abort-all"?


>> +If the filter dies during the communication or does not adhere to
>> +the protocol then Git will stop the filter process and restart it
>> +with the next file that needs to be processed.
>=20
> Hmph, is there a reason not to retry a half-converted-and-failed
> blob with the fresh process?  Note that this is not "you must do it
> that way", and it is not even "I think doing so may be a better
> idea".  I merely want to know the reason behind this decision.

A filter that dies during communication or does not adhere to the =
protocol
is a faulty filter. Feeding the faulty filter after restart with the =
same=20
blob would likely cause the same error.=20

There are legitimate reasons for retries. E.g. if the filter =
communicates
with the network. In these cases I expect the filter to handle the retry
logic. Git just writes to and reads from pipes. I don't expect frequent
problems in that area. Plus the existing filter mechanism has no retry
either.

Later on we could easily add a "retry" capability if we deem it =
necessary,
though.


>> +After the filter has processed a blob it is expected to wait for
>> +the next "key=3Dvalue" list containing a command. When the Git =
process
>> +terminates, it will send a kill signal to the filter in that stage.
>=20
> The "kill" may not be very nice.  As Git side _knows_ that the
> filter is waiting for the next command, having an explicit
> "shutdown" command would give the filter a chance to implement a
> clean exit--it may have some housekeeping tasks it wants to perform
> once it is done.  The "explicit shutdown" could just be "the pipe
> gets closed", so from the implementation point of view there may not
> be anything you need to further add to this patch (after all, when
> we exit, the pipes to them would be closed), but the shutdown
> protocol and the expectation on the behaviour of filter processes
> would need to be documented.

I implemented a shutdown command in v4 [1][2] but dropped it in v5 after
a discussion with Peff [3].

[1] =
http://public-inbox.org/git/20160803164225.46355-8-larsxschneider@gmail.co=
m/
[2] =
http://public-inbox.org/git/20160803164225.46355-13-larsxschneider@gmail.c=
om/
[3] =
http://public-inbox.org/git/20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.p=
eff.net/

My main reasons to drop it:

A) There is no central place in Git that could execute code *after*
   all filter operations are complete and *before* Git exits. Therefore,
   I had to add a "clean_on_exit_handler()" to "run-command" [1]. This
   change made this series even larger and therefore harder to review.

B) If we communicate "shutdown" to the filter then we need to give the
   filter some time to perform the exit before the filter is killed on
   Git exit. I wasn't able to come up with a good answer how long Git=20
   should wait for the exit.

Do you think I should resurrect the "shutdown" patch?


>> +If a `filter.<driver>.clean` or `filter.<driver>.smudge` command
>> +is configured then these commands always take precedence over
>> +a configured `filter.<driver>.process` command.
>=20
> It may make more sense to give precedence to the .process (which is
> a late-comer) if defined, ignoring .clean and .smudge, than the
> other way around.

I agree.


>> +Please note that you cannot use an existing `filter.<driver>.clean`
>> +or `filter.<driver>.smudge` command with `filter.<driver>.process`
>> +because the former two use a different inter process communication
>> +protocol than the latter one.
>=20
> Would it be a useful sample program we can ship in contrib/ if you
> created a "filter adapter" that reads these two configuration
> variables and act as a filter.<driver>.process?

You mean a v2 filter that would use v1 filters under the hood?
If we would drop v1, then this would be useful. Otherwise I don't
see any need for such a thing.


> During an imaginary session of "git add .", I think I found where
> you start THE filter process upon the first path that needs to be
> filtered with one for the configured <driver>, and I think the same
> place is where you reuse THE filter process, but I am not sure where
> you are cleaning up by killing the filter once all paths are added.

I don't clean them up. The filter gets killed when Git exits.


> Wouldn't you need some hooks at strategic places after such bulk
> operation to tell the multi-file-filter machinery to walk all the
> entries in cmd_process_map and tell the remaining filter processes
> that they have no more tasks, or something?

That would be nice. I tried to find these strategic places but it
turned out to be harder than I thought because Git can exit in a lot
of places.


>  Are you relying on
> these processes to exit upon a read failure after we exit and the
> pipe going to the filter is severed?

Not really. The filter process is killed by the run-command machinery
with the atexit child_cleanup_handler.

Thanks,
Lars=
