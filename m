Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50C220988
	for <e@80x24.org>; Tue, 18 Oct 2016 23:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbcJRXZL (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 19:25:11 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33932 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbcJRXZK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 19:25:10 -0400
Received: by mail-qk0-f174.google.com with SMTP id f128so11729213qkb.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 16:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lNyU4hmIhIe/fCUTlHNLSv3rUytQDDuCAeDbsyrHTa0=;
        b=JS6+438rCGUUSVuWh0fU3NmtxpDj6HXO/d7eN7GwS7rN50NUAccA8X85GHa9ifrcG9
         ek3oOFGC8sVwy/au7Hd70ksyxmHoQ43tmszPd1nLoiKT39FjPzgdUXxIMwgEgSKb26Uq
         ozIZqU/MQQTrjLPhd3vOmBxZ/mniGlt1Kq94Dem9SJnBlGeceDfiVkVhvF9D4GrUYIRJ
         U7b7Yt+FN7PQVnNleTRWtQfbma7oZ97YANbyxXuseJTZtMhIDJDOFmZFBy1PFN9nBw7t
         4PUv0VtpgfM8ZcOaJbeaiI/K96LrGFMJ7TL96gUFErKheCjp8Y7squGtiVsLprZ8yL7R
         V+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lNyU4hmIhIe/fCUTlHNLSv3rUytQDDuCAeDbsyrHTa0=;
        b=HQJNqqUK6OUeV0MkKWSX2QwGGkrF2YiyCdO0Gq7/O9khGT9jFsbesmwEV7p6mNRYRu
         3VHTz6+9+V2K9s9DLVp4pA54P4ft3rZGQ71GYUcacUZADNO9Suo39c+aOUjYChsdh74G
         2O8BiKYTWErvVZ7nLqP1E/zAz0YU7rPiDIcGPq6iVXk5gcq5qwgw1qRYir6gCWbtWMb9
         BQ+gagGowm+X8SKrmIFTJ5N4jItv0jVaMq4Jr0Aa+yCfEz1Oat8fI1lY/FI/FaooFXVm
         ZtFcfZ4GPZgfjcX5GfJXrN2QMefZa/7/meiLt31NAuu5icSy1nO4Ei+dhTsuFmktbktF
         J+wA==
X-Gm-Message-State: ABUngvcFCTxG6zW7POT7XMt/KNIXocblzXVApDeubGGUyBeUseDYne5PkKPOZIiTK2bzg4WdCuWx75Ld1XhON57u
X-Received: by 10.55.43.194 with SMTP id r63mr3090305qkr.86.1476833109085;
 Tue, 18 Oct 2016 16:25:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 18 Oct 2016 16:25:08 -0700 (PDT)
In-Reply-To: <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com>
References: <20161018210623.32696-1-sbeller@google.com> <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
 <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Oct 2016 16:25:08 -0700
Message-ID: <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 2:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> The remote URL for the submodule can be specified relative
>>> ...
>>> v3:
>>>  * fixed the coding style.
>>
>> Ah, thanks.  I had a squash queued on top but will replace with this
>> one.
>
> Heh, I guess I shouldn't have responded before seeing what this
> breaks.  Applied on top of sb/submodule-ignore-trailing-slash, these
> seem to break.

Ugh. (I should have tested more than just t0060).

The underlying issue is two fold:

* in t3600 we'd need
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index d046d98..545d32f 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -616,7 +616,7 @@ test_expect_success 'setup subsubmodule' '
        git submodule update &&
        (cd submod &&
                git update-index --add --cacheinfo 160000 $(git
rev-parse HEAD) subsubmod &&
-               git config -f .gitmodules submodule.sub.url ../. &&
+               git config -f .gitmodules submodule.sub.url ./. &&
                git config -f .gitmodules submodule.sub.path subsubmod &&
                git submodule init &&
                git add .gitmodules &&

because the sub-submodule URL is actually the same as the submodule
(because we'd test lazily)

This looks ok from a bug fixers perspective.

However in t7403, we have a construct like:

    git clone . super

which then results in

    git -C super remote -v
...../git/t/trash directory.t7403-submodule-sync/. (fetch)

And the commit message of this patch claimed we'd never use
the /. syntax ourselves. (We could argue the stupid users in the test
suite are doing it wrong, because in practice nobody would use clone
to create a nested repository? Not sure I agree.)

However instead of fixing the levels of nesting, the fix is as easy as:
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 0726799..525d32b 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -15,7 +15,9 @@ test_expect_success setup '
        git add file &&
        test_tick &&
        git commit -m upstream &&
-       git clone . super &&
+       # avoid cloning a repository with a url ending in /.
+       git clone . root &&
+       git clone root super &&
        git clone super submodule &&
        (
                cd submodule &&

Same goes for t740{6,7} as well as t7506.

I think this change to the test suite is not warranted, because
we want to have the current behavior as-is as it seems like a nice
hack:

* Maybe we'd want to think about checking for the URL in git clone
  normalize the URL before configuring remote.origin.URL

* an often observed work flow for submodule tests seems:

    mkdir sub1 &&
    git -C sub1 init  &&
    ...

    git clone . super &&
    git -C super submodule add ../sub1
    ... # the ../sub1 looks intuitively correct
    # because from the current directory which is
    # super the relative path is ../sub1
    #
    # However in reality this ought to be a relative URL,
    # and as super sits in the same directory as sub1
    # ./sub1 would be "correct" according to the documentation
    # However as the super remote URL ends with /.
    # we had a bug that we needed to add one layer of unnesting
    # and that is how ../sub1 worked.


Not sure about this patch any more.

Stefan
