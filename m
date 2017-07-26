Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355182047F
	for <e@80x24.org>; Wed, 26 Jul 2017 20:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdGZU4W (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 16:56:22 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:37197 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdGZU4T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 16:56:19 -0400
Received: by mail-pg0-f53.google.com with SMTP id y129so88859981pgy.4
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U5fftsNbxgqVH1sAr+KOo66AE8Xxu+zBgD504Y0C34I=;
        b=fXAS0IBS6FyuOARfFql3p9vYDt1XHFYBNgS5MeCzZrtR7VpMwkvtGG/CCHUEkvo5j8
         HsxWnoJMlRvJnY8BdE4PUkgMPsGSzpkOUIkfmWphW8dSnTlY3WfJcMfyzWBjYPM+BhFi
         w+cBF+zkaVAr/h2LTiVrQO2AYz+IsGO8zRz0vHTi+Ha+xWQsXksAeJ+L18lt9WYSkTMt
         9beZUPnzMtC0HGzxx11Sw8Dj+zAmU0CIu+A68/kICSfjjn3Zi+xxwS+G0fsZCuIKFs6S
         WouSWDD+7CuIMw3U0WDL1MnMl4iba0QnJTz6Fd+Il0wwD5XGSBqTbNBSe554Vqg53inN
         FI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U5fftsNbxgqVH1sAr+KOo66AE8Xxu+zBgD504Y0C34I=;
        b=RClM9gJweLbBxDMNPhNQo89D3x+G5MLu7IpJ79pPdEStxkhHJcp5RvfCIzSART09KB
         IBwyWS3wLL2eBl9lT/AQQen/GMVpdSbOQlfzfNkuT8iwrFwt6RmAh5FjCBl+edlrcqVs
         zRX41dK6MNuByUe67KVoaT/bmJ1+EnL3em60Qsh4SXuNUQpTmCyYRSBa+ThqwoiDMVZu
         /gp0T+pNKUXtv2XIln8MwNaUGnlztmKZAjTFm2rbzZYNXZtXFklA6sPIl1RvtK4OiQhD
         iDrMSa2lhLJbu/PPzehty9/s0hs2O+HzbtRH5X/YdE88db+6/nkKsv2GMcojOAkej7kf
         CQOQ==
X-Gm-Message-State: AIVw113h3uXAvi0QAZMJKzzmo49Q8bPQP1K89Kh34vcPq6A/FVCaSeuC
        23tgXflMeDFdHnR02EGj0uyHIvY7fDpa8pWMNA==
X-Received: by 10.101.91.137 with SMTP id i9mr1989674pgr.27.1501102578273;
 Wed, 26 Jul 2017 13:56:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Wed, 26 Jul 2017 13:56:17 -0700 (PDT)
In-Reply-To: <xmqqh8xzq6td.fsf@gitster.mtv.corp.google.com>
References: <20170726200832.28522-1-sbeller@google.com> <xmqqh8xzq6td.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Jul 2017 13:56:17 -0700
Message-ID: <CAGZ79kaYQ5Lzz5i_+uLt3wWtid+YvDxXSyw=isaYj3+98X7Mbg@mail.gmail.com>
Subject: Re: [PATCH] submodule: correct error message for missing commits.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2017 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When a submodule diff should be displayed we currently just add the
>> submodule objects to the main object store and then e.g. walk the
>> revision graph and create a summary for that submodule.
>>
>> It is possible that we are missing the submodule either completely or
>> partially, which we currently differentiate with different error messages
>> depending on whether (1) the whole submodule object store is missing or
>> (2) just the needed for this particular diff. (1) is reported as
>> "not initialized", and (2) is reported as "commits not present".
>>
>> If a submodule is deinit'ed its repository data is still around inside
>> the superproject, such that the diff can still be produced. In that way
>> the error message (1) is misleading as we can have a diff despite the
>> submodule being not initialized.
>
> This is confusing...
>
> So are you saying that if we do "submodule init A && submodule
> update A" followed by "submodule deinit A",

  $ git clone https://gerrit.googlesource.com/gerrit
  $ git show --submodule=log bb798b00bb
  ...
  Submodule plugins/replication ... (not initialized)

  $ git submodule update --init
  $ # a good example of cross repo changes:
  $ git show --submodule=log bb798b00bb
  ...
  Submodule plugins/replication db4aecb2b8...98b7156cee:
  > Stop using WorkQueue#unregisterWorkQueue.
  < PushOne: Remove redundant string concatenation

  $ git submodule deinit -f --all
  $ git show --submodule=log bb798b00bb
  ...
  Submodule plugins/replication db4aecb2b8...98b7156cee:
  > Stop using WorkQueue#unregisterWorkQueue.
  < PushOne: Remove redundant string concatenation

  $ rm -rf .git/modules/*
  $ git show --submodule=log bb798b00bb
  ...
  Submodule plugins/replication ... (not initialized)

> we _could_ show the
> difference for submodule A between two commits in the superproject,
> because we already have the necessary data for the submodule, but we
> _choose_ not to show it because the user told us explicitly that the
> submodule is not interesting?

We _do_ show the submodule as demonstrated by the code sample above
if we possess the objects.

Hence the "not initialized" is not quite technically correct. (After deinit it
is not initialized, but we show nevertheless, so the user perceived
_reason_ why we do not show the submodule is "commits not present".

> That sounds like a very sensible and user-centric behaviour to me,
> and "not initialized" sounds like the right message to give in such
> a case (as opposed to "commits not present"---even the user told us
> they are not interesting, we may have them, so "not present" is not
> just incorrect but irrelevant because that is not the reason why we
> are not showing).

So you are saying we should instead do:

  if (not active)
    message = "not initialized"
  if (problems with object loading)
    message = "commits not present"
  ...

> Or are you saying that even the user told us that the submodule is
> not interesting, if we had "init" it earlier even once, we show the
> difference and with a wrong label?  Showing the difference sounds
> like a bug that is more severe than using a wrong label to me.

I looked through the man pages and they never specify if submodule
activeness affects the superproject diff, so we'd want to change that
so that only active submodules are diffed.
