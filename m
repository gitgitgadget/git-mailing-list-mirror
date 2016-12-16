Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9BC91FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 02:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758917AbcLPCAs (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 21:00:48 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36533 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758904AbcLPCAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 21:00:43 -0500
Received: by mail-it0-f67.google.com with SMTP id n68so965426itn.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 18:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=w0JJGc5Q8d3hUOR7zY9RJ99IR4ZoACBA+02bCJRWHNQ=;
        b=TuSlyQkNJdnB6G7i/Ju8TQZbb+nI/IcxNPqGsFxKzp8QDHkxRMh4wGXlepAbLqu30d
         8BdE6it+h2LF5y5ihqIoWolmfOC6e4n7Ywjf6knOHQpnssy95tfUzLUEyHfNQn2n4eve
         7r+S5QAF/xIAf1bvOOXfPDeogdVYqtri2isBCx79yZauRmKWESVNIARPpHRLRNLpXz6S
         BO2Lyzqda7scG5AeT+5OyukG8Yy69jNiWl0DF7wW4sfck2dlXINarlssrhbOhp7svnwu
         O/0ZY+M0Ya6o8wFrCfl3Y1F+ur2RLA+0Hnzc5n/xNOqwy/yOEWn2VULoACrYl5nI/Xkx
         nxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=w0JJGc5Q8d3hUOR7zY9RJ99IR4ZoACBA+02bCJRWHNQ=;
        b=guF3fr9jSZrTK4OMkg7PgTBkmEfeOKYlqVzTzJPZejjGJvPCbwon4Pj6gZIl4LDFWX
         JuglpWxoX/dqaUgUTPXU6ZrFpdXsvEW8vOVXbTJNnwPUTZP+gBeNyTT1QQv3eBmKtPLn
         qmNzuHVYDvZgyiRi51/KYDSUffjOhk822vbOF1LPX2jhHOMV1mlvtuTkyjDMTWGKUP2X
         6htf4EytuFbcGNw9wPEBTAnOWMtqhEn8q5MW/7NmO8mP6bDvbw7NKmf5ZO2hVPLQrPwl
         EXikulGnoRADLvvgxaPpxZeIEDZggzYiWW8RpPsx0eL3F7j2b1bdkmwbAntSoiOALBlj
         iMQw==
X-Gm-Message-State: AKaTC035DC93xXckf6WKd6+7R5/TLPai5QO0cNSWyDH+tm1HCCepoPbci1jEUnekUkCptx3oPXFlhp+nqUzKDg==
X-Received: by 10.36.148.84 with SMTP id j81mr613662ite.35.1481853601917; Thu,
 15 Dec 2016 18:00:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.65 with HTTP; Thu, 15 Dec 2016 18:00:01 -0800 (PST)
In-Reply-To: <3720429.U3o1zloj4W@thunderbird>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <xmqqoa0cu3nn.fsf@gitster.mtv.corp.google.com> <3720429.U3o1zloj4W@thunderbird>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Dec 2016 18:00:01 -0800
X-Google-Sender-Auth: HUFc8hEQsTB3g2jGKFFqeZR_nP4
Message-ID: <CA+55aFxwDQAqXb+QYzS+3uZRQCFwHMofZXeWNns9t9Z7uNV4Wg@mail.gmail.com>
Subject: Re: Allow "git shortlog" to group by committer information
To:     "Stephen & Linda Smith" <ischis2@cox.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 5:51 PM, Stephen & Linda Smith <ischis2@cox.net> wrote:
>
> Why does gmail make it unnecessarily hard?

I read email with the gmail web interface, which is wonderful because
of the server-side searching etc. The only real downside is the weak
threading, but you get used to it.

I personally find IMAP and POP to be a tool of the devil, and have
never had a good experience with them as a mail interface. In theory
IMAP is supposed to support server-side searches, in practice it never
worked for me.

But the problem with sending patches using the web interface is that
you cannot attach things inline without gmail screwing up whitespace.

I suggested to some googler that a "attach inline" checkbox in the
would be a wonderful option for text attachments, but considering that
the android gmail app still has no text-only option I don't think that
suggestion went anywhere.

> I thought that a good percentage of the kernel maintainers use git send-email.
> what would make that command easier to use with gmail?

Oh, I can send inline stuff (as I just re-sent that patch), but then I
have to fire up alpine and do it the old-fashioned way. So it's an
extra step. So since I spend all my time at the gmail web interface
_anyway_, the attachment model ends up being the slightly more
convenient one.

And sure, I could use git-send-email as that extra step instead, but
I'd rather just use alpine. That's the extra step I do for some other
things (ie the "200-email patch-bomb from Andrew Morton" things - I'm
not using the web interface for _that_).

                 Linus
