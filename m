Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2EC91F461
	for <e@80x24.org>; Tue,  3 Sep 2019 11:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfICLUG (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 07:20:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:51403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfICLUG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 07:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567509598;
        bh=2fudmlf46086d9xJovFt52R0BlbslvtC/WZk4yHRimg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hyOQs3k1pVCPEVIyXDk1Cryenf90H5vgZ9qg2ZtDhscjNBL+JMqjyOKuRwt0oOB4n
         Eh5rply5qaUi91BbT2AJwbRCYmhPNd7JGHmTnT6RCIAbi9FsZnIKXnsI3MmerCjAUO
         crhKtNOWFMYccWIDGKnI8rtpZjGj2XqHRMzqj9I4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1htreP1WB9-00Buge; Tue, 03
 Sep 2019 13:19:58 +0200
Date:   Tue, 3 Sep 2019 13:19:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
In-Reply-To: <xmqq5zmav9ej.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1909031256290.46@tvgsbejvaqbjf.bet>
References: <pull.327.git.gitgitgadget@gmail.com>        <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>        <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com> <xmqq5zmav9ej.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KHv+NXGitTSjciGIjI4FSqnCG/98546GWrE2EnflGDOSlayCmZ9
 9qK3iD/nnaHkIgoBv5f+3YIV8n0OIvaAdr1DFU2x2d2/8JOBn3GhQacq/Cy6QPANdvYqaG+
 uWuCLste0UC8DIdkNHNIp65lbEPS8uS4pwCK4z+1sOLupcVjMtM+0/ml4cwNoZcF5L+Hy+B
 ln+WVTFz7i6kN3h692duw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s/NNpj4Ued0=:3PYOX9gCDONnnlRNdKXQmS
 CDUSD7fG/Grssa8gErsYWuK6YIGqMX5JObG8MwAgJBwjAh2s6Bgm3LSIONuyfBrNQv02S7w/K
 bWDNukkVlaB2hKQQlhrRI7X7/rjtq3AyKVKwM17sWargHDJvQ4EqpVQVwui9QFaMaYeCIGqV8
 bBl9+oPRpnR9s6gLc015ME6Lkn5ucOjxfacvCm7kRdRfCk/Go37kZQhWCCSxWDxF/OdPMyOpG
 BvcxJBfuVs7vyKn+/Pz74iXXPn2WVXtzfpdbgK6EwsiLudLirfmTqXOEvfcVIXOVUZGa/4mUB
 OcP+go10s3/Kg1QS3r2gbvBQTgYHWrMs+FhPb/z0cRfptKgGpAnQzmdDad4qIe3P99wR0w7Tq
 X+rQrXWunB66gHrD5q5LCNfTJs5/BE8TsRfZhI3OkyEjKdmhLPkr5jF/vQPBml9D0VIqSE7Fp
 N8nhjrc5iN4p8aFR+cW3JZZsL5TKcVmePHpnAaeEmotG7kiGHGkboVRlhLq0mXS09S3NYdXXP
 03ntEEzWMiuO+4uHRxytU27WNoDvRuLeIbGuINxPNrCSd0ausVZeMXIv0nvJEpqykooQFHXXp
 ULCaCMzantUWJ9tccNd038WamLO2N0Ibgp39jvZDJmehC2dGxpvwFdOUSQdjbK9vIO5V9KJe2
 O8yVcwIuSqyge4ogctw256YRekX9ocXDgK9k3gC4SZemwJux9av+Q9iTssD/5fLyMang++ilm
 BaiSUxeqLX1P8OytzoPKd7LlRyR8OwowUd8Ee+Zt3fetMR53hAUQSMRSO1IICA+rAvfM9vc0A
 KmbFmY2D54xkbZhUrUk8lldNI9fFtnmOmFFxpOFvzr/NfHkQp+QVDYYhSDy8JwdpLi2plv2Oe
 3bXbBeYYvcH4Pp4lRQqFbLj67UH7S3OiS0xlNei36nGtDzXsV8fI96J7F79xXPRlrqEwuxx4y
 N0pFv+cEYLpvp6omGpb1OZkVGQABd/CjKCKrzGK+Mjb9TuwdJ1VyBPTFmm4mOc0ejw/oSpkyl
 p5WT2KJDDO0LahuHsWnCt76iQjTI9mBWvtYohlvqQocgx72DGiyBUbZrogR9t3fz27FO08AC7
 2MxQpquVgTFpaII3qE5jElOS9JbBp2VzaQtOtM5cV37tABMAwh2y0WFbLbprAx52zoLHswmjv
 bN76PNHKtDGs3prbLe1fYnB8Tt1TBTQ8W7g35jHXQ4AVtWKYrJ6qTLgyhHW7YuJ51Eje4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 2 Sep 2019, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >>   		for (p1 =3D label.buf; *p1; p1++)
> >> -			if (isspace(*p1))
> >> +			if (!(*p1 & 0x80) && !isalnum(*p1))
> >>   				*(char *)p1 =3D '-';
> >
> > I'm sightly concerned that this opens the possibility for unexpected
> > effects if two different labels get sanitized to the same string. I
> > suspect it's unlikely to happen in practice but doing something like
> > percent encoding non-alphanumeric characters would avoid the problem
> > entirely.
>
> I'd rather see 'x' used instead of '-' (double-or-more dashes and
> leading dash in refnames may currently be allowed but double-or-more
> exes and leading ex would be much more likely to stay valid) if we
> just want to redact invalid characters.

Hmm. Let's take a concrete example from the VFS for Git fork:

	Merge pull request #160: trace2:gvfs:experiment Add experimental regions =
and data events to help diagnose checkout and reset perf problems

(Yes, we have some quite verbose merge commits, with very, very long
onelines. Not a good practice, we stopped doing it, but it was well
within what Git allows.)

And now use dashes to encode all white-space:

	Merge-pull-request-#160:-trace2:gvfs:experiment-Add-experimental-regions-=
and-data-events-to-help-diagnose-checkout-and-reset-perf-problems

Pretty long, but looks okay. Of course, it does not work, because colons. =
So here is the label with Matt's patch:

	Merge-pull-request--160--trace2-gvfs-experiment-Add-experimental-regions-=
and-data-events-to-help-diagnose-checkout-and-reset-perf-problems

And here is the label with your proposed xs.

	Mergexpullxrequestxx160xxtrace2xgvfsxexperimentxAddxexperimentalxregionsx=
andxdataxeventsxtoxhelpxdiagnosexcheckoutxandxresetxperfxproblems

I cannot speak for you, of course, but I can speak for myself: this is
not only way too reminiscent of xoxoxothxbye, but it is also really,
totally unreadable.

If you care deeply about double dashes and leading dashes, how about
this instead?

		char *from, *to;

   		for (from =3D to =3D label.buf; *from; from++)
			if ((*from & 0x80) || isalnum(*from))
				*(to++) =3D *from;
			/* avoid leading dash and double-dashes */
			else if (to !=3D label.buf && to[-1] !=3D '-')
   				*(to++) =3D '-';
		strbuf_setlen(&label, to - label.buf);

That would result in

	Merge-pull-request-160-trace2-gvfs-experiment-Add-experimental-regions-an=
d-data-events-to-help-diagnose-checkout-and-reset-perf-problems

> I see there are "lets make sure it is unique by suffixing "-%d" in
> other codepaths; would that help if this piece of code yields a
> label that is not unique?

I'm way ahead of you. The sequencer already goes out of its way to
guarantee the uniqueness of the labels (it's part of the design, as
applied in 1644c73c6d4 (rebase-helper --make-script: introduce a flag to
rebase merges, 2018-04-25)).

The patch you are looking at in this thread is only concerned about the
initial phase, `label_oid()` does a lot more. Not only does it make the
label unique (case-insensitively!), it also prevents it from looking
like a full 40-hex digit SHA-1, so that we can guarantee that unique
abbreviations of commit hashes will work as labels, too.

Ciao,
Dscho
