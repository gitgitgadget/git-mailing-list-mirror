Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA661F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 09:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCYJqK (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 05:46:10 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:52761 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeCYJqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 05:46:08 -0400
Received: by mail-it0-f46.google.com with SMTP id k135-v6so7287862ite.2
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 02:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n4YGqeVnHhPnZeKngi7xl1IlctIi6y4vecZWW/Qy+9U=;
        b=Ln7wSomctsGCyOlEgtuLPjuZp9WF+TfestfNMPZzjgNE47Qon/xmHtaznLHTmTnLJn
         M308rEWp113cjkbsyli0TOAu6ep4IRp/9dv/EbxioiJdM1LbtgJKXqShCTJrgaZGxPLr
         OO1xnWJRQr3beeowJb+mx76EQa4BT959j+gjcn5Oo4+UwELCfGh2a5wVQcmTlddKwVIY
         wP4AmS/5WiAE4jtLJO2iNozJY078hMmeDA36kUqtqVeGKdhtNVcXLEvkV7EXRIEAmzjj
         1+SVdmW7M18OhELW4TJDMkhJR1LlrlDaybKp2gsRuXncTpxKdOgOZ3i6a0PSrBwmgZf5
         gTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n4YGqeVnHhPnZeKngi7xl1IlctIi6y4vecZWW/Qy+9U=;
        b=nIF2nyRBew94TQz+jf0kDCuL2QbJI4ukCFXqTMCzZr95+P2F9pKxjEni81Ci8ojyJI
         5dKxT/2iq/by/vxYxQDWfXnwkWPBhs/LM5lilW1S3WoLInEFCrqE0TWMP55dhqYZutYm
         T/AG9LyMN5jG+O/lGp7orO2ZddpnGRiUdensXSFHJsExdmDw11ASggF/nC2+RzhFerTp
         TqE9CVK5/igXWDdtGTFI5tz9cwGh6CDhNTloQ6quwJgCoJkQOyMdG+AxwATN+6UzzEyv
         qQgm72wKSGMj3bTbv9IkPHQG+DeDsfmLL3+oLbESidDjCess7m5VsKnLiU9vG+2CviTj
         qVqw==
X-Gm-Message-State: AElRT7EpRbx//3YxZkrNVEYmnTSk40eiqAImHfjqLSl1NylCPsAVsfky
        WlWYTGZTq+Coj+KTbDnF58HTAb/o75GnM+H7nVk=
X-Google-Smtp-Source: AG47ELsob6BgMQPQjx4/ETLXVQyxR+lpb3Yl6GzvrR0zFAWXLc/xt/9OrnG7vMDgcfMMkb522QkSPMi39ni0zm253k8=
X-Received: by 2002:a24:fa89:: with SMTP id v131-v6mr19587115ith.40.1521971167897;
 Sun, 25 Mar 2018 02:46:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sun, 25 Mar 2018 02:46:07 -0700 (PDT)
In-Reply-To: <6603149f-776a-fde8-5d11-a7d9d6d37e96@gmail.com>
References: <1521576562.2188.10.camel@gmail.com> <CAP8UFD3NKCSN8mVDiCUzvor5uZh4nFCAw4T0zgxpvHLf9AWmyA@mail.gmail.com>
 <1521760546.11809.20.camel@gmail.com> <CAP8UFD3bRaPke8MvubZ3+v6RrY7K7Peip1dpQ2LG9kxKoXcmbw@mail.gmail.com>
 <6603149f-776a-fde8-5d11-a7d9d6d37e96@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 25 Mar 2018 11:46:07 +0200
Message-ID: <CAP8UFD2y605FQeiymO2JNxy7MXs=-vRcN-Z2ri1=ttDF8kccvQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtHU29DXSBDb252ZXJ0IOKAnGdpdCBzdGFzaOKAnSB0byBidWlsdGluIHByb3Bvcw==?=
        =?UTF-8?B?YWw=?=
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 8:31 PM, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> On 23.03.2018 19:11, Christian Couder wrote:
>
>>> * Ensure that no regression occurred: considering that there are plenty
>>> of tests and that I have a good understanding of the function, this
>>> should be a trivial task.
>>
>> There are a lot of things that the test suite doesn't test.
>
> Hopefully, by first adding new tests, any eventual bug will be spotted.

I was thinking about things like memory leaks that tests cannot easily spot=
.

>>> * In the end, an analysis based on performance can be made.
>>> Benchmarking the script will be done by recording the running time
>>> given a large set of diversified tests that cover all the
>>> functionalities, before and after conversion. The new commands should
>>> run faster just because they were written in C, but I expect to see
>>> even more improvements.
>>
>> If you want to do benchmarks, you might want to add performance tests
>> into t/perf.
>
> That is great. I will surely make use of the existent testing framework t=
o
> do benchmarks.

Good.

>>> ## Example of conversion (for =E2=80=9Cgit stash list=E2=80=9D)
>>> ------------------------------------------
>>> To test my capabilities and to be sure that I am able to work on a
>>> project of this kind, I tried to convert =E2=80=9Cgit stash list=E2=80=
=9D into a built-
>>> in. The result can be found below in text-only version or at the Github
>>> link.
>>
>> I think it would be better if it was sent as a patch (maybe an RFC
>> patch) to the mailing list and add the link to the patch email in the
>> maling list archive to your proposal.
>
> I sent it as a [RFC] patch to the mailing list and included it in the
> proposal.
>
> <https://public-inbox.org/git/20180324182313.13705-1-ungureanupaulsebasti=
an@gmail.com>

Nice.

>> It could be useful if you described a bit more how you could (re)use
>> the work that has already been made.
>>
>> In the rest of your proposal it looks like you are starting from
>> scratch, which is a bit strange if a lot of progress has already been
>> made.
>
> The patches about converting =E2=80=98git stash=E2=80=99 are a great star=
ting point and I
> will definitely use them. Each time I start converting a new command I wi=
ll
> first take a look at what other patches there are, evaluate them and if I
> consider the patch to be good enough I will continue my work on top of th=
at
> patch. Otherwise, I will start from scratch and that patch will only serv=
e
> for comparison.
>
> One other resource that is of great importance is git itself. I can learn
> how a builtin is structured and how it is built by considering examples t=
he
> other Git commands. Having a similar coding standard used, the codebase w=
ill
> be homogeneous and hopefully easier to maintain.
>
> Another important resource are commands that are Google Summer of Code
> projects from previous years (2016 and 2017) which had as purpose to conv=
ert
> =E2=80=9Cgit bisect=E2=80=9D and =E2=80=9Cgit submodule=E2=80=9D. I can a=
lways take a look at the patches
> they submitted and read their code reviews to avoid making same mistakes
> they did.

Nice.

>> It is probably better especially for reviewers and more common to work
>> in small batches, for example to send a patch series converting a few
>> related commands, then to start working on the next small batch of
>> commands in another patch series while improving the first patch
>> series according to reviews.
>>
>> Also we ask GSoC students to communicate publicly every week about
>> their project for example by writing a blg post or sending a report to
>> the mailing list.
>
> Noted.
>
>>> ## Git contributions
>>> ------------------------------------------
>>> My first contribution to Git was to help making =E2=80=9Cgit tag --cont=
ains
>>> <id>=E2=80=9D les chatty if <id> is invalid. Looking over the list of a=
vailable
>>> microprojects, there were a couple of microprojects which got my
>>> attention, but I picked this up because it seemed to be a long-standing
>>> bug (I noticed it was approached by students in 2016, 2017 and now in
>>> 2018). Thanks to the code reviews from the mailing list, after a few
>>> iterations I succeeded in coming up with a patch that not only fixed
>>> the mentioned problem, but also a few others that were having the same
>>> cause.
>>>
>>> It got merged in the proposed updates branch.
>>
>> What is its status in Junio's "What's cooking in Git" emails?
>
> It is now in the =E2=80=98next=E2=80=99 branch of the Git repository.
>
> I updated the proposal, in which I included these ideas and some addition=
al
> examples. Thank you a lot!

Ok. Feel free to resend another version of your proposal.

Thanks.
