Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C111F404
	for <e@80x24.org>; Mon, 29 Jan 2018 00:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeA2AKb (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 19:10:31 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46765 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeA2AKa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 19:10:30 -0500
Received: by mail-qt0-f196.google.com with SMTP id o35so10632061qtj.13
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 16:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hMXcxyfEWHFiNgo/6A8eBDUY7nZDmnd9ggcYgd195/4=;
        b=RWHelecJPIhiSXLflwXtMoOGaYDF+0j4LKxCcEYqdDLRUDZ0WrA0BnSTMm+rsuZAGq
         ElDFSQHfZ83MQ2ZpcP0bZ8JrcuAgNnAZ1OE4T4NmsiVseI3h5J7AaaBbAnZeajXyn33d
         79a3Z83LtjpAa5Wl5ypJOFu1JdLAobfWzmOUFjGYn+3Klex360YdvyRCtgRxIRS+clYU
         tasgsAMTyipcVLvsUzKPGKe6zAe7cUG+CciXmdTVLrQvm2VADuNZqXTDa8yisje8dqg7
         Ul+MYYkogZ5k6Nu+cexcjeNs1si30rNnlv9NYnzI3lrnwTs42Kg+Oz1Cw+VJmriVoP8x
         6hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hMXcxyfEWHFiNgo/6A8eBDUY7nZDmnd9ggcYgd195/4=;
        b=Bn5sGLj4pLARsNATKoYwx56eL9TIQl0QnFTz1Y1mJh0DoZ0np4DDZWXijnFN2S/fPC
         0jb1Hr/OMWfT/IexHxg45l1IJLLL3LSOWcs9Dl+3928XrzfvgMvLLx9cHbYcIQeMRELW
         tVSlioymzt4hNTQM7oHvNOZ/RELbRct1nO1FSZwu5DTZeQOvu/ncV0Eyzhj+dZND2jSe
         tIT+m3Y2cLs4659fL9O1JHXON6zFG9mYNeL4Zm/z8mO9wuZaix1NBzLlflV2VypwEnP3
         zJ2BWqaJBEHs8u3Ku8LF6dwCLFzqd4bZ34VUKiGVJ9blKnPiPQeRo3HEb7OBjJNHiXHz
         A0QA==
X-Gm-Message-State: AKwxytfPLfVpAmKKkhvm+x4or7vp9+aBlonMAbvQbC9EgRl0AevdAgPC
        85TjYR7BLh8hToaGtLS/6KITCQiqWwtHkpLWRTwanA==
X-Google-Smtp-Source: AH8x2264u2/bZlCDGG3HlIR6KQYaQ+P2vt7prynInA9uL9jkEN42T95Af9DxQAFdsmS+wYHqpCqdXz1mEPtQydXRd6E=
X-Received: by 10.200.27.91 with SMTP id p27mr35608377qtk.254.1517184629716;
 Sun, 28 Jan 2018 16:10:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sun, 28 Jan 2018 16:10:29 -0800 (PST)
In-Reply-To: <1d98ac06-7cfd-c006-d3c5-9dcb385a17d8@lucaswerkmeister.de>
References: <xmqqtvvbds42.fsf@gitster.mtv.corp.google.com> <20180127183132.19724-1-mail@lucaswerkmeister.de>
 <CAPig+cTetjQ9LSH68Fe5OTcj9TwQ9GSbGzdrjzHOhTAVFvrPxw@mail.gmail.com> <1d98ac06-7cfd-c006-d3c5-9dcb385a17d8@lucaswerkmeister.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Jan 2018 19:10:29 -0500
X-Google-Sender-Auth: gWbbxAfkDkTuQxT7Y6-TYIJzI5s
Message-ID: <CAPig+cR1VXtc-wZxv3mZGsbTAzmtPbhnRPtBX97-8Rm9b6rpHQ@mail.gmail.com>
Subject: Re: [PATCH v2] daemon: add --send-log-to=(stderr|syslog|none)
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 5:58 PM, Lucas Werkmeister
<mail@lucaswerkmeister.de> wrote:
> On 28.01.2018 07:40, Eric Sunshine wrote:
>> On Sat, Jan 27, 2018 at 1:31 PM, Lucas Werkmeister
>> <mail@lucaswerkmeister.de> wrote:
>>> This makes it possible to use --inetd while still logging to standard
>>> error. --syslog is retained as an alias for --send-log-to=3Dsyslog. A m=
ode
>>> to disable logging explicitly is also provided.
>>>
>>> The combination of --inetd with --send-log-to=3Dstderr is useful, for
>>> instance, when running `git daemon` as an instanced systemd service
>>> (with associated socket unit). In this case, log messages sent via
>>> syslog are received by the journal daemon, but run the risk of being
>>> processed at a time when the `git daemon` process has already exited
>>> (especially if the process was very short-lived, e.g. due to client
>>> error), so that the journal daemon can no longer read its cgroup and
>>> attach the message to the correct systemd unit (see systemd/systemd#291=
3
>>> [1]). Logging to stderr instead can solve this problem, because systemd
>>> can connect stderr directly to the journal daemon, which then already
>>> knows which unit is associated with this stream.
>>
>> The purpose of this patch would be easier to fathom if the problem was
>> presented first (systemd race condition), followed by the solution
>> (ability to log to stderr even when using --inetd), followed finally
>> by incidental notes ("--syslog is retained as an alias..." and ability
>> to disable logging).
>>
>> Not sure, though, if it's worth a re-roll.
>
> I didn=E2=80=99t want to sound like I was just scratching my own itch ;) =
I hope
> this option is useful for other use-cases as well?

If the reader does not know that --inetd implies --syslog, then

    This makes it possible to use --inetd while still logging to
    standard error.

leads to a "Huh?" moment since it is not self-contained. Had it said

    Add new option --send-log-to=3D(stderr|syslog|none) which
    allows the implied --syslog by --inetd to be overridden.

it would have provided enough information to understand the purpose of
the patch at a glance. Talking about the systemd race-condition first
would also have explained the patch's purpose, and since the proposed
solution is general (not specific to your use-case), scratching an
itch is not a point against it.

Anyhow, it's not that big of a deal, but it did give me a bit of a
pause when reading the first paragraph since it's customary on this
project to start by explaining the problem.

>> I understand that Junio suggested the name --send-log-to=3D, but I
>> wonder if the more concise --log=3D would be an possibility.
>
> --log sounds to me like it could also indicate *what* to log (e.=E2=80=AF=
g. =E2=80=9Clog
> verbosely=E2=80=9D or =E2=80=9Cdon=E2=80=99t log client IPs=E2=80=9D). Bu=
t perhaps --log-to=3D ?

Perhaps we can take into consideration precedent by other (non-Git)
daemon-like commands when naming this option. (None come to my mind
immediately, but I'm sure they're out there.)

>>>                 if (!strcmp(arg, "--inetd")) {
>>>                         inetd_mode =3D 1;
>>> -                       log_syslog =3D 1;
>>> +                       log_destination =3D LOG_TO_SYSLOG;
>>
>> Hmm, so an invocation "--inetd --send-log-to=3Dstderr" works as
>> expected, but "--send-log-to=3Dstderr --inetd" doesn't; output goes to
>> syslog despite the explicit request for stderr. Counterintuitive. This
>> should probably distinguish between 'log_destination' being unset and
>> set explicitly; if unset, then, and only then, have --inetd imply
>> syslog. Perhaps something like this:
>>
>>     static enum log_destination {
>>         LOG_TO_UNSET =3D -1
>>         LOG_TO_NONE,
>>         LOG_TO_STDERR,
>>         LOG_TO_SYSLOG,
>>     } log_destination =3D LOG_TO_UNSET;
>>
>>     if (!strcmp(arg, "--inetd")) {
>>         inetd_mode =3D 1;
>>         if (log_destination =3D=3D LOG_TO_UNSET)
>>             log_destination =3D LOG_TO_SYSLOG;
>>         ...
>>     }
>>     ...
>>     if (log_destination =3D=3D LOG_TO_UNSET)
>>         log_destination =3D LOG_TO_STDERR
>>
>
> I=E2=80=99m not sure if that=E2=80=99s worth the extra complication=E2=80=
=A6 some existing
> options behave the same way already, e.=E2=80=AFg. in `git rebase --stat
> --quiet`, the `--stat` is ignored.

I took "last one wins" into consideration when writing the above but
was not convinced that it applies to this case since --inetd and
--send-log-to=3D have no obvious relation to one another (unlike, say,
--verbose and --quiet or other similar combinations). Unless one reads
the documentation very closely, output ending up in syslog despite
"--send-log-to=3Dstderr --inetd" is just way too counterintuitive and
may well lead to bug reports later on. Therefore, doing the additional
work now to stave off such bug reports is likely worthwhile.

>>> +                       }
>>> +                       else if (!strcmp(v, "stderr")) {
>>
>> Style: cuddle 'else' with the braces: } else if (...) {
>>
>
> Is that a general rule? I couldn=E2=80=99t find anything about it in
> CodingGuidelines and daemon.c seemed to use both styles about evenly, so
> I wasn=E2=80=99t sure what to use.

It's not stated explicitly in CodingGuidelines, but there is one
example of cuddling 'else' with braces in the section talking about
braces and 'if' statements.
