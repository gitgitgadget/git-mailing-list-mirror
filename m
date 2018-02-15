Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7311F404
	for <e@80x24.org>; Thu, 15 Feb 2018 04:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966551AbeBOEfL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 23:35:11 -0500
Received: from mail.javad.com ([54.86.164.124]:58384 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966421AbeBOEfK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 23:35:10 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6C0023E89E;
        Thu, 15 Feb 2018 04:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518669309;
        bh=3rZ/3TsXjxbbHzXESRMu1T2y7coe+ibrn+1L8ABCSKs=; l=872;
        h=Received:From:To:Subject;
        b=mhY1o9V2O0irfHpPw5fIQr3UAptZNjzGMKkwj/oh8RJa82Dz3Q7rHHPQvVQx4WXDJ
         X+gdP3Kj+HzcNGpyGlF5BnN78BXENugoAdRIHPdrrRH4jn+kSTzzoN07qkW5PpvZCG
         GZBw8TA6X8hIKG0pUpKub8mjuxNJNVrYmshBbiQI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518669309;
        bh=3rZ/3TsXjxbbHzXESRMu1T2y7coe+ibrn+1L8ABCSKs=; l=872;
        h=Received:From:To:Subject;
        b=mhY1o9V2O0irfHpPw5fIQr3UAptZNjzGMKkwj/oh8RJa82Dz3Q7rHHPQvVQx4WXDJ
         X+gdP3Kj+HzcNGpyGlF5BnN78BXENugoAdRIHPdrrRH4jn+kSTzzoN07qkW5PpvZCG
         GZBw8TA6X8hIKG0pUpKub8mjuxNJNVrYmshBbiQI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518669309;
        bh=3rZ/3TsXjxbbHzXESRMu1T2y7coe+ibrn+1L8ABCSKs=; l=872;
        h=Received:From:To:Subject;
        b=mhY1o9V2O0irfHpPw5fIQr3UAptZNjzGMKkwj/oh8RJa82Dz3Q7rHHPQvVQx4WXDJ
         X+gdP3Kj+HzcNGpyGlF5BnN78BXENugoAdRIHPdrrRH4jn+kSTzzoN07qkW5PpvZCG
         GZBw8TA6X8hIKG0pUpKub8mjuxNJNVrYmshBbiQI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518669309;
        bh=3rZ/3TsXjxbbHzXESRMu1T2y7coe+ibrn+1L8ABCSKs=; l=872;
        h=Received:From:To:Subject;
        b=mhY1o9V2O0irfHpPw5fIQr3UAptZNjzGMKkwj/oh8RJa82Dz3Q7rHHPQvVQx4WXDJ
         X+gdP3Kj+HzcNGpyGlF5BnN78BXENugoAdRIHPdrrRH4jn+kSTzzoN07qkW5PpvZCG
         GZBw8TA6X8hIKG0pUpKub8mjuxNJNVrYmshBbiQI=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1emBGF-0005O6-JG; Thu, 15 Feb 2018 07:35:07 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <874lmqirma.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87zi4edbp3.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xqKPbwt-KeYTKadM3bHDkU3m0WiezKeVu75TyftBSEYDA@mail.gmail.com>
        <8760718imo.fsf@javad.com>
        <CA+P7+xpg76nP8+KBrYWeYPcm8+0jS_MzL+B=LF6WPfBv44zrwA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802150209390.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 15 Feb 2018 07:35:07 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802150209390.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Thu, 15 Feb 2018 02:14:11 +0100
        (STD)")
Message-ID: <87a7wazx8k.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,
Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

[...]

>> > I'd not argue this way myself. If there are out-of-git-tree non-human
>> > users that accept and tweak todo _generated_ by current "git rebase -p"
>> > _command_, I also vote for a new option.
>> >
>> 
>> To be fair, I have not seen anything that actually reads the todo list
>> and tweaks it in such a manner. The closest example is the git garden
>> shears script, which simply replaces the todo list.
>> 
>> It's certainly *possible* that such a script would exist though,
>
> We actually know of such scripts.

Please consider to explain this in the description of the change. I
believe readers deserve an explanation of why you decided to invent new
option instead of fixing the old one, even if it were only a suspicion,
more so if it is confidence.

-- Sergey
