From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line
 up properly
Date: Wed, 16 Mar 2016 12:59:34 -0700
Message-ID: <CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:59:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHbZ-0007dF-06
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbcCPT7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:59:36 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35597 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbcCPT7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:59:35 -0400
Received: by mail-io0-f179.google.com with SMTP id g203so72989507iof.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=fnoNiwsPt1d2HDl5HcKdjk0i6A7IHsNbylfNJpQ7+/o=;
        b=VLc53rpiVQpzv/gqG+0oq4nJyh9unaXq/dwH1WIt7FQmIIxGSNviwNR1jQFRLcVYUn
         WF9C2c68zxhQY08/BRGC9Qt2vVTbrkPCLjY8IKl6SS7OR/QOR1vX21BmlSHKvT6dOm36
         eMftRSxQ4lNIPdL+YXPtEg8CPIr3vmKdQnDu+zFUvZyShcXFezRSDpqtNDI/q0zNxLjB
         LGXyKTLsasn6D9tPA2TM3oXgEVR5mgKpTTda584XxEHNw0DEOLB/wfyUorvjSQLGyBuA
         pBspIaDhgrF/AiY9B4WcFpJbCaASCVMFHNCGGkxlZP/CAQTOdJY2m3ULg7A4Uq86me+H
         TWoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=fnoNiwsPt1d2HDl5HcKdjk0i6A7IHsNbylfNJpQ7+/o=;
        b=e6NKvY/CubqgQh+SjQJM5H2V6WpL7+levdTUXheQ7ZmgyfxEy2XRNV5mFOySz4OkL0
         bBsdLTT83WXwt/016/443dXJhAVTmW0nvei9HB235HavialWTI4cQqibfOL7krGf2JzS
         OGYE9FrvJ8J1xCEaPbSOIeQQSO9ooxdTr9Sv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fnoNiwsPt1d2HDl5HcKdjk0i6A7IHsNbylfNJpQ7+/o=;
        b=mFj3y/x9GxYsJA81KP0571gIQy5eudWb0zLjpMCjxqA891gTjGe1xEM7/eIKRC4mYS
         9+9NOBI2JnXCDEmGqTkGrN6nWqP/1ps0Z3gk3ILZhngX/VzjR8USCCcylPqROlfX9GbF
         slw9xnU3L/QBjpumDG/Um92A32JdiCJCyqw5bzIUCw51wfFFgUcxV37R/wn0M+J9QrTo
         yENIrf6GoOw46BNsRCrkuh48lq/M4XUcu4QtDfAeDcdz1LXrnnvpIendFrrT2LD/E3uL
         hUSBtslt0YuZXwTxFVsbqwfi6Ew0ii2qjTr6NNEXXqQEbY5ey0p7oTmzkHGUkXi/SGlE
         ixYg==
X-Gm-Message-State: AD7BkJKM+TS1eP5EP76sTM6367Y/p239bCtlHE9mQ2Lq9aNKpUJURawj71RJHBxpMId88PM8Gtu8YYwuaxXkSA==
X-Received: by 10.107.13.65 with SMTP id 62mr5849877ion.186.1458158374734;
 Wed, 16 Mar 2016 12:59:34 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Wed, 16 Mar 2016 12:59:34 -0700 (PDT)
In-Reply-To: <xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: TzRzDioXbzp52BtIeoNwe6dTJfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289028>

On Wed, Mar 16, 2016 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Strangely running t4201 with your patch (without any squashing)
> seems to show a breakage in shortlog.  I won't be able to come back
> to this topic for at least a few hours, so this is just a single bit
> "breaks" report, without "how and why" analysis, sorry.

It's because those things have tabs in their first line, so the output
now differs from the expected one exactly because of the tab-vs-space
expansion.

The wrapping logic is then also different, because the .wrapping code
does the tabs as "align to 8 chars" while the new code does tabs as
"align to 8 chars modulo the indent offset".

I only looked at the first case, but I assume the others are just more
of the same. We'd just adjust the expected output, I assume.

               Linus
