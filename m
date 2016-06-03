From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Fri, 3 Jun 2016 18:22:02 -0400
Message-ID: <CAPig+cTLVXJBn00aco0vC9oFvZuchTgtNXtGGjpLPx1LwRZz4Q@mail.gmail.com>
References: <20160530232142.21098-1-e@80x24.org> <20160530232142.21098-2-e@80x24.org>
 <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
 <20160531074506.GA8911@dcvr.yhbt.net> <CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
 <20160531182932.GA27021@dcvr.yhbt.net> <20160602075125.GA19551@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 00:22:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8xTn-00066H-HD
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 00:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbcFCWWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 18:22:06 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32998 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbcFCWWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 18:22:05 -0400
Received: by mail-io0-f194.google.com with SMTP id p194so12580987iod.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 15:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ayfJWDZjwVld1E2QDnKBIlrXZVNGgjxAVcC20fkW1x8=;
        b=mWuOTfMKRQsPDnDJTwsK6yzyDyNtEYkEp23/bSnOWAa21DUBiOZeLXQlI1mRSYW63a
         vII3T2yjlYHdDo+UAW+fxKWXTr7YlFgQGUwRZLEZ7I5TPCBgfJ4f066EUqxFATa4q9o+
         bnoiiLogBXaS0/8G1Ge6dHWeuHtNwgQqaggv+iAuA1B7g7u+yuizCUM4qRfzryGZXCMw
         Nw0H4yIQ6qrPs/Tw+r4rn1ObNDomeY5hXHsQ+Ujoz8VYNstX+qQttr8X/9Pm/I9a/1YW
         siLW1C8jauT02wE7nR8edP66RoHVG8C7/ghrcli+4IOWNP5hyEGpWazjijCx1Tc1EAC+
         cvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ayfJWDZjwVld1E2QDnKBIlrXZVNGgjxAVcC20fkW1x8=;
        b=IOA3vEdOkMvnHpgsoS2Opxkx1FXCCs1lAKtuctqy54JhTdmoPI96yd47t8rQ8ZpASD
         +bS+uBwmgnCZdbkjsnRWWIYZh8GrkR3WW8q20daPhpyj8MFpHY+saW9gUd0dWWo0nvIX
         5tjXdL6M9TI+86GfSscbNpgDqmdQKqtDepm+6usSbIXRQ87vowo2r+sgtdsed6Ybk3sx
         WXNZIFHtmZmEuRjFZErZuXatgaRRn0mtgtYdiHcE7T/CRDFPE/6fl8sAhpbXMtIwq0KQ
         EbIpa/WMeJbbeRuzGk65NC76871foyRQR+E/z2Ioz+jpJCtl2+be55tQEjHKF+2TixwR
         rsYg==
X-Gm-Message-State: ALyK8tKopBoHVC7im8YbURcDEEdjTVS1Wh6A1jDWefLZLe4vqt24YULvOjrQhf8i5I9InP7dNYOglzU367QGdQ==
X-Received: by 10.36.98.136 with SMTP id d130mr2732243itc.84.1464992523457;
 Fri, 03 Jun 2016 15:22:03 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Fri, 3 Jun 2016 15:22:02 -0700 (PDT)
In-Reply-To: <20160602075125.GA19551@dcvr.yhbt.net>
X-Google-Sender-Auth: DSBMsEZr_M_nOFBszRz746cCIhk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296420>

[cc:+junio]

On Thu, Jun 2, 2016 at 3:51 AM, Eric Wong <e@80x24.org> wrote:
> Eric Wong <e@80x24.org> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > On Tue, May 31, 2016 at 3:45 AM, Eric Wong <e@80x24.org> wrote:
>> > > Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > >> I wonder if hand-coding, rather than using a regex, could be an improvement:
>> > >>
>> > >>     static int is_mboxrd_from(const char *s, size_t n)
>> > >>     {
>> > >>         size_t f = strlen("From ");
>> > >>         const char *t = s + n;
>> > >>
>> > >>         while (s < t && *s == '>')
>> > >>             s++;
>> > >>         return t - s >= f && !memcmp(s, "From ", f);
>> > >>     }
>> > >>
>> > >> or something.
>> > >
>> > > Yikes.  I mostly work in high-level languages and do my best to
>> > > avoid string parsing in C; so that scares me.  A lot.
>> >
>> > The hand-coded is_mboxrd_from() above is pretty much idiomatic C and
>> > (I think) typical of how such a function would be coded in Git itself,
>> > so it looks normal and easy to grok to me (but, of course, I'm
>> > probably biased since I wrote it).
>
> For reference, here is the gfrom function from qmail (gfrom.c,
> source package netqmail-1.06 in Debian, reformatted git style)
>
> int gfrom(char *s, int len)
> {
>         while ((len > 0) && (*s == '>')) {
>                 ++s;
>                 --len;
>         }
>
>         return (len >= 5) && !str_diffn(s, "From ", 5);
> }

Seems less idiomatic and less like what we might see elsewhere in the
Git codebase, but that's subjective. Functionally, it appears correct.

> Similar to yours, but a several small things improves
> readability for me:
>
> * the avoidance of subtraction from the "return" conditional
> * s/n/len/ variable name

Idiomatic C code favors concise names such as 'i', 'j', or 'n', for
instance, but I don't care strongly.

> * extra parentheses

Unnecessary syntactic noise (consuming reviewer brain cycles).

> * removal of "t" variable (t for "terminal/termination"?)

Heh, no, just the next letter after 's'. Again, just an idiom, as 'i',
'j', 'k' are often used for integers, 's' and 't' are common for
strings.

> str_diffn is memcmp-like, I assume.  My eyes glazed over
> when I saw that function implemented in str_diffn.c, too.
>
> Just thinking out loud, with sufficient tests I could go with
> either.  Will reroll when/if I get the chance tomorrow.

As mentioned above, it's all subjective and, of course, I have a bias
toward the example I provided, but don't otherwise feel strongly about
it. I do, however, like the idea of using a simple hand-coded matching
function over the regex (but no so much that I would complain about
it). Use whatever you and Junio feel is appropriate.
