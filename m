Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51F11F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeAZTXc (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:23:32 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:46554 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbeAZTXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 14:23:25 -0500
Received: by mail-ua0-f180.google.com with SMTP id j23so966049uak.13
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 11:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yg7W10Dla5I4agBcqWnWdLiOb27Ejr6U3V8tby75AO0=;
        b=TIRMnyTWpStD9Zaf4bxhHih80TTQamVRpzDkgu91wN3ykO9jivTwQKw9vTZbCrpANi
         0YM99dxy98HBSCNJzajB6OCJmdWGer2CdtFzRjmILU5hR2QfV1JAGvP7bQlMDb41Jyrq
         dYcFZ718+Ncs7WmIJC7GM219hLeoRIqsp6DcHWRK7s1x1qgUsN3qGqulFaZtMEbwz8KR
         uQtSQhMCf9fGZFwTfWYFfWzv2zCwng250oawMvOu2TIBpbDPzDOraQ5nO6gMnsoUtMtH
         rtZyJXmqmqi+b5GaRtfDLajVL6p0DeNilBh7gMKq2746JbBSOInwtf2ZrqfrlPwV9Zd8
         YxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yg7W10Dla5I4agBcqWnWdLiOb27Ejr6U3V8tby75AO0=;
        b=Yx5NxXpidpSFJOq1PtPNKmHSVIpJrHQHVvcLLGHIewH30YjLdrVtzBN9N6ATYIdUIW
         RSXb545s78uh9/MauNvwuETvyi6Wau0Kh6LwgrgROmTgzi73Ql+guJlfJPibXEhBZaY+
         u46XGenCqiFxxcck8QjVHFig4S1dfcC4+vwpmyLdPCsmqU+iz6m8s9GkuLqgg1kQIYwd
         IYU+iJ4xLURpItvhPlAMR3m0pM4xi0tI40qi3mdqnyuI02hO7HSCd2PxNJSNMMBZ+YcZ
         3swx+fc5dbxHzLRxje7hJjXmBDv//NeCDujpOAay41xg+o82GQn+uvmYGyu8NXFX0xnO
         IeMQ==
X-Gm-Message-State: AKwxytfoVquB8bhQTWBCyHXpFQPoZTNXWs/iMHtzo8XvInQzjNx9C4fO
        qrzxcgMgAB7i7PQWFjCQErENSr82wyDIMImKSfw=
X-Google-Smtp-Source: AH8x225DwDvmaJftpYVaToYdNasiiPWEikieVRPdGs0SG4pfiXiJxUwVoKdn+AfKkNbX6OQ8m6jUhHnrf+fkaHJDv34=
X-Received: by 10.159.57.111 with SMTP id i47mr11394508uag.79.1516994605091;
 Fri, 26 Jan 2018 11:23:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Fri, 26 Jan 2018 11:23:24 -0800 (PST)
In-Reply-To: <20180126185007.GG27618@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com> <20180126123708.21722-11-szeder.dev@gmail.com>
 <20180126185007.GG27618@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 20:23:24 +0100
Message-ID: <CAM0VKj=Qsbkog+rj94bZOk=G-XBsXAqQnRUo4eCXQq2LKjre-w@mail.gmail.com>
Subject: Re: [PATCH 10/10] t: make 'test_i18ngrep' more informative on failure
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 7:50 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 26, 2018 at 01:37:08PM +0100, SZEDER G=C3=A1bor wrote:
>
>> When 'test_i18ngrep' can't find the expected pattern, it exits
>> completely silently; when its negated form does find the pattern that
>> shouldn't be there, it prints the matching line(s) but otherwise exits
>> without any error message.  This leaves the developer puzzled about
>> what could have gone wrong.
>>
>> Make 'test_i18ngrep' more informative on failure by printing an error
>> message including the invoked 'grep' command and the contents of the
>> file it had to scan through.
>
> I think this is an improvement. You can also use "-x" to get a better
> sense of exactly which command failed,

Yeah, I know...  but I have some issues with running tests with '-x'; I
suspect PEBKAC, but haven't yet got around to investigate.
