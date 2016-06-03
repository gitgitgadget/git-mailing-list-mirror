From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Fri, 3 Jun 2016 18:59:46 -0400
Message-ID: <CAPig+cQXA3mgYC3rCTx2h93rB6djdKvYJ+oCXUP24-xk2PqW=Q@mail.gmail.com>
References: <20160530232142.21098-1-e@80x24.org> <20160530232142.21098-2-e@80x24.org>
 <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
 <20160531074506.GA8911@dcvr.yhbt.net> <CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
 <20160531182932.GA27021@dcvr.yhbt.net> <20160602075125.GA19551@dcvr.yhbt.net>
 <CAPig+cTLVXJBn00aco0vC9oFvZuchTgtNXtGGjpLPx1LwRZz4Q@mail.gmail.com> <xmqqlh2loq6p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <e@80x24.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 00:59:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8y4G-0004aL-NA
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 00:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbcFCW7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 18:59:48 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33958 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbcFCW7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 18:59:47 -0400
Received: by mail-io0-f194.google.com with SMTP id l9so12696188ioe.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=T2bMNjboI8nsB/7LYuWmRG5icd94qJuZSUGcknJqRio=;
        b=yR7BtVb6s7rHCNCl0o+75r7tVPAAqLjUhGNEqgHsCKc5sI6eMLib9Nqd4gtlvlUVz2
         xk4WG7uB67sevr3IjNf3XtfXFQpfteLgz/dLRnSl0/mybjB9uN4zh82i5lcD8boQ2V9f
         4gfYlyYa2gbLodACrtLWxrNoAPrqR1ltgSK2Fb2WV1Sfq0h8QolK/7D7c7xMRi98XmVZ
         sTuBrfVtIzVeyfy7atkuVG3LCqLzZS/bYaSHGDLTaU7ifsrcPMMqCYVjrQTrsDwuKmBC
         XdvXLCFbdIAjdL1LoyNivx6N3HM0QfpNzWdFEkoy3wsVrbLpHB8pqJUugHy4+WVRYWEC
         xohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=T2bMNjboI8nsB/7LYuWmRG5icd94qJuZSUGcknJqRio=;
        b=UBJ+tKelqNVN9iL2ekiQasPt5G5UUA42jyVCcKqGGAhs5oxIJO73sPUMa7CbcQIdiW
         89RjWH3YfhHjmR6hd0AJ284JVPDY3VJeUAaOrQIjn/Z7sXuMcM+gFplKuNaUohmrm+WF
         Nmgyd1TctgSCV9qRy76eVEvY9rJmS7ZyF+M0rWlgFbuO6qAed3VwYjQWuyx3+//KauaL
         hHazXtJVOAOaxRQGkLIJAgfVrX60pb+g7bKaKADvmod9qLREusATpEik/wyWN3970eJ/
         4y0Yt0MEEz7u0XBlwNkdiWBz861lRhSLnC5yyXhwNSkfiyv8hafulDdO76wpZWW5bYLg
         2Jmw==
X-Gm-Message-State: ALyK8tLYmiupFWVz6vGlwPNUWMp00QvBoDZUCGY19Lmpvml0+M2DYuYYm1tW7/TpFOoPrQJ74TTrHScmumRU8A==
X-Received: by 10.107.132.40 with SMTP id g40mr9443826iod.34.1464994786680;
 Fri, 03 Jun 2016 15:59:46 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Fri, 3 Jun 2016 15:59:46 -0700 (PDT)
In-Reply-To: <xmqqlh2loq6p.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: PLC3FzO8fIDaPD3TaAQ9egtIZqA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296424>

On Fri, Jun 3, 2016 at 6:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Thu, Jun 2, 2016 at 3:51 AM, Eric Wong <e@80x24.org> wrote:
>>> Eric Wong <e@80x24.org> wrote:
>>>> Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> > On Tue, May 31, 2016 at 3:45 AM, Eric Wong <e@80x24.org> wrote:
>>>> > > Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> > >> I wonder if hand-coding, rather than using a regex, could be an improvement:
>>>> > >>
>>>> > >>     static int is_mboxrd_from(const char *s, size_t n)
>>>> > >>     {
>>>> > >>         size_t f = strlen("From ");
>>>> > >>         const char *t = s + n;
>>>> > >>
>>>> > >>         while (s < t && *s == '>')
>>>> > >>             s++;
>>>> > >>         return t - s >= f && !memcmp(s, "From ", f);
>>>> > >>     }
>>>> > >>
>>>> > >> or something.
>>>> > >
>>>> > > Yikes.  I mostly work in high-level languages and do my best to
>>>> > > avoid string parsing in C; so that scares me.  A lot.
>>
>> As mentioned above, it's all subjective and, of course, I have a bias
>> toward the example I provided, but don't otherwise feel strongly about
>> it. I do, however, like the idea of using a simple hand-coded matching
>> function over the regex (but no so much that I would complain about
>> it). Use whatever you and Junio feel is appropriate.
>
> This is meant to be a replacement for the original that uses
> regexec(), which in turn means the string we are checking is
> guaranteed to be NUL terminated, right?

Yes, this is meant as a replacement for the regexec(), but no, there
is no guarantee that the "line" is NUL-terminated. In this case, the
'line' in pretty.c:pp_remainder() might end at a NUL or it might just
end at the next newline in the larger buffer.

The bit about sending the "line" to regexec() without taking its
logical end-of-line into account was what caught my attention in the
first place.

>         static int is_mboxrd_from(const char *line) {
>                 return starts_with(line + strspn(line, ">"), "From ");
>         }
>
> is sufficiently high-level that no longer is scary, hopefully?

That's nice and concise but unfortunately not useful for this case
where we must respect the logical end-of-line (within the larger
buffer), represented by line+linelen.
