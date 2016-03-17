From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] pretty-print: add --pretty=noexpand
Date: Thu, 17 Mar 2016 16:23:08 -0700
Message-ID: <CA+55aFzeobjmhEmZzMYnvY-sit38S2j32gOXu5STLvbKfz-JAg@mail.gmail.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	<xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
	<xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
	<xmqqoaacy9tm.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 00:23:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aghG7-0007Eq-NK
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 00:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbcCQXXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 19:23:11 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36534 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbcCQXXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 19:23:09 -0400
Received: by mail-ig0-f171.google.com with SMTP id nk17so9119180igb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 16:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=QJAijEoKf8mq3aAMliouvtZVNW6mC8j5IX3KJVQsZmg=;
        b=phXq+j66rV4XATs7ZJt4N019JdCEtntjYIWo3xxWFCvgW5N/T1ugWKUfS7QXmTP7SG
         Yy5mW4ZuGsUNbGK5vvOxSGC8zG6uaBPPzGZZT7kc5+dl/3lKTU/Z1RGFFrJA68Aqx0+w
         x2f27340MlgY8IYicgeP103n7oTSYek/0A5gVR/D/Ezjjl2cEpkx0Qd09oHtd7jU/GqH
         H5bz4fWm51X/g3X/cEvMbpafhxn07EKQ1lsAJH0KXx4sZlekOWPxJhpTwv05cm0VP8J4
         V5H7ZTRo/ar3kEOw5Ta5UFwq1qAnhRklCyk+JD8j+ghca4uX5JR80kmLlHeX662gObDt
         gh6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=QJAijEoKf8mq3aAMliouvtZVNW6mC8j5IX3KJVQsZmg=;
        b=AZ/B/Xk3Emf2QryDxcZs16Bw2n6o+tE+FAg5wpvv/GoYKOigzpmkFFRKH2CTkLvJrb
         244pT2Iz7a5SGC55QNqx9khHJoowwsSZm/miHzMLb9mJlqXlNszrHIUAbtWh3QxIb7QP
         LbhzLwqJsEvBtQskz/EhystZAwOPLmE0ELToo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QJAijEoKf8mq3aAMliouvtZVNW6mC8j5IX3KJVQsZmg=;
        b=TGR5qZV1hj3ag2eLxviLNkMaD3rAo4mtxiumTqwkJUWRAgeEy0q8iibnHMfBuFVq4C
         AXIWgJ9Rb9NkgFK/H4VCsDW1OU9UkrZQHG9FpjhB/QCI3NqwZQevUNCDN5+wxQjXsgUm
         dqZjZ/X3995AkI2w/yyR2JaRN7rrP0OCU4XZ1SxPF97FMGJ0uZ3faYG4cQX2h0AxNHjs
         yxPTtEjHcKi3taZ9nPy4dQfMvUpQaxmqOB+UFYRz9E/rWh0evK5/7zyejgNO+jT0R+Ub
         W+A0tWvlBPUdaDchH/C/JmS/nqVWf0Mm5o/tg0if1aL2FhvMscp4eRksefbEovVwd3/J
         uwUg==
X-Gm-Message-State: AD7BkJJdh8AZ4O4R2VDjx07D/Hiel0CfP5nOtGCgykhmGMaBrx+YKbUa7rNAWu+ybL0FbOdi2UFN0ALm6KoKzg==
X-Received: by 10.51.17.38 with SMTP id gb6mr14451471igd.45.1458256988067;
 Thu, 17 Mar 2016 16:23:08 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Thu, 17 Mar 2016 16:23:08 -0700 (PDT)
In-Reply-To: <xmqqoaacy9tm.fsf_-_@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: ADlz1KrPpY1d44qVugMZw444Txk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289170>

On Thu, Mar 17, 2016 at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> It is reasonable for tweak the default output mode for "git log" to
> untabify the commit log message, it sometimes may be necessary to
> see the output without tab expansion.

Thanks, these all look good to me.

Sorry for not following up, it's just that I'm in the middle of the
kernel merge window and haven't had the time to worry about it.

            Linus
