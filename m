Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB580C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 11:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiHPLh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiHPLhN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 07:37:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F24DB78
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 04:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660647758;
        bh=3RsiTNhmquDY3V2rlFROTBkEh2xkfkomFudK2BytWGA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Mm2fgpekZ+Xs8jkVEsqxRJJ8eTfiWEpC1iOYbQdsrjYC5n7+T/Q6sC2W+MgvI+wgV
         5l0R26wOZ/wUotY3oha5+XKFYKuuSNv+R51HcECNhJivzKqHpWCNxFvMhJpsP9t9v1
         IKShPC8lLnQNn2rHNKvaeMhKYCcyIWjNMtl75Js8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1oC2eD2ATD-00BrBk; Tue, 16
 Aug 2022 13:02:38 +0200
Date:   Tue, 16 Aug 2022 13:02:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] sequencer: do not translate reflog messages
In-Reply-To: <870072d5-d220-09e7-684b-f9d7d8d59c93@gmail.com>
Message-ID: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
References: <b8ab40b2b0e3e5d762b414329ad2f4552f935d28.1660318162.git.git@grubix.eu> <333bbaa9-d484-7c20-90d6-e64edf8a8248@gmail.com> <xmqqy1vt9ora.fsf@gitster.g> <92sr80s2-6311-p065-755s-61s28s543q6n@tzk.qr> <870072d5-d220-09e7-684b-f9d7d8d59c93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KVjS/0vdbq2F1XR/twR2P+rojJP3Kfc3ZesSiNBVOR7OV6eUeP3
 aDyFkZGp8yfFP37pi03bEZrL6jKc+qGqDJnvwbqH8OUPRek5hMCOndhRqmkoOE5V0wVofdW
 BQAsRpjIXqgUTV2yubrL/1cZVHgyyZZFi+HjERGc1cGdVXBh5kXizR2iEFo7BxVWouWnW/D
 IxHm4t1qHtrEAhZNjiPsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LSiFflnz5Uk=:Qp3aCffF/0UtMIQTXYSfW+
 ThSwzND7COZ0K9V9Nj5jLcPSo6C9OevImanLusEEyzGw6QyFv03jDPB46jSGADVq6xMFeuAvC
 SV8AfdU5rhHdrduO9HtpMFIh7bdEnhohJxAy+I1odeqyEnhhrjbOoKQp+867JJwgKqCDfg3PP
 p+XtthFgCuC09C4bP+bh2JXXtFkNsnhvhBnknU/bW4dMgDRe+LE9ve4BFnhidlUysVRWGeH7U
 yl8cnh2tINlZVjMXM/27gMNw2BDRJNybw6THLBkEIC0cnLNKKfrjq1R7R8xu4KPVXoNjzh+Fa
 j4Xgsn7YmXjH9LNk0IYafq1lXor8n0Zh+YJDlIc+hxoS3Y0llsbPIOsviAO6rLKERmopAcezs
 GKiqXqaN8RvGvN8A4/thbpRLIqcnxBD73ysNqjacdYuNTRHJMNvTJ/OorNPmhSRNlfI4Mq5Tw
 zsuoa3dolaGYpSG+W/Jnh7JOS506Ay8ebpizQeO9Dg2mz4Bqo5EnLEHBWM0GtP2r7/c8RFXjh
 dFd3ss+PpVIRuGmxpPf0w2oh3cioFRwyqAbDkZ3sNSu7BjAvEFiC/s2D3rWVc1zJBkUqXH6d6
 X+OumNdmbk7i2MFzwydRiCCxr8kPCWCexGAmMDiGsffIHwT9EUJ5kvZOZ53TVd2XOQbn4ElOE
 HG1VjlOd7wIMt+OqNHwrk9g47urxQOATCOc6MT3wZkpkELpYCi6MOToFqbGFXPzBWaqewt3ZY
 tMhayWl3FD1Ufyr9moafkwe9wyCmJZisRfId1X+LQ2VpVSgha7oiylVLPbmeyoX19tYykfM7M
 XzQmVBcbVxGI1ZBBFmeZfkzk3smZE/gKnavt8aqboP+x2TOKxbiUn0fHa/JIULlEboPu//+JX
 n59ArLZ7Z0PyrCDJrT9OFjif6einpzY6KTUEvJT3lNJj2uH8Z9PUT4sYq6ml0tRXgvquoy4HG
 2cuOHsCXGZjhewHN+voII8RF2xbHjBd22iKDpdDj0ejW6US0s7l8TiPWxhYTNhTTz23jjfk7d
 K8ZWxMUDCb/inoQczYHv7B4NL5jpbLHAbYjhbcLNfnhooRopAekKzEkh1gkGhji25zIlxkJ7R
 p8fdk3u+QPYFZPGhPpucsLGJSMBO1QBI16hL48jESsGFddyNHNC5cVdmQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 16 Aug 2022, Phillip Wood wrote:

> On 15/08/2022 21:20, Johannes Schindelin wrote:
>
> > On Fri, 12 Aug 2022, Junio C Hamano wrote:
> >
> > > Phillip Wood <phillip.wood123@gmail.com> writes:
> > >
> > > > Removing the N_() stops these strings from being extracted for
> > > > translation, but there are several callers left that are still usi=
ng
> > > > _() to get the (now non-existent) translated string. I only had a
> > > > quick look but I think we should remove the _() from all the calle=
rs
> > > > of action_name().
> > >
> > > Thanks, that's all correct.
> >
> > I am afraid that it is not.
> >
> > In https://github.com/git/git/blob/v2.37.2/sequencer.c#L502-L503, for
> > example, we use the value returned by `action_name()` in a translated
> > message:
> >
> >  error(_("your local changes would be overwritten by %s."),
> >   _(action_name(opts)));
>
> Isn't this message using action_name() to get the name of the command th=
at the
> user ran? As that name is not localized when the user runs the command I=
 don't
> see that we should be translating it (and playing sentence lego with the
> result) in this message. I think the same applies to the message at line=
 689
> that you mention below.

I do not believe that this error message talks about the command,
otherwise it would use "`git %s`" instead of "%s" here. Imagine, for a
second, that Git was written in French and you preferred to read your
error messages in English, therefore set your locale, and you just issued
a `git retour`, would this error message read well for you?

	error: your local changes would be overwritten by retour.

That looks wrong to me. I could see us changing this to:

	error: your local changes would be overwritten by `git retour`.

or to:

	error: your local changes would be overwritten by revert.

i.e. either use "`git %s`" without translating, or keeping "%s" with the
translated `action_name()`. But it would probably read better to have the
action name localized (which is what I suggested).

Ciao,
Dscho
