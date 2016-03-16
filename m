From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line
 up properly
Date: Wed, 16 Mar 2016 15:04:45 -0700
Message-ID: <CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	<xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:04:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJYh-0002C1-K7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 23:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbcCPWEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 18:04:47 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37965 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937AbcCPWEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 18:04:46 -0400
Received: by mail-ig0-f177.google.com with SMTP id ig19so55982769igb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=a9VbkBvy2VloNCGMSUV7eNcZG792ECW24ZZ8TuL+6gs=;
        b=UahNiMyGI+rZmorn8L+EQ9RnRSWLr+WEtvZMleV4kKjuPkoH+3AiYcBvBIDp3eg0nn
         Icsz0uSVojJDncZbShEIwfqz3H/XxdXyQAwRs7Mr2ACtJiTjIvbuVIN7OxuVgNiu998q
         W53tLZxxnHBwhHFr9kkuRnhPdsXcB5n7vEGL84Bo4aLh/wyZw449o/sgynYQKbGps787
         g2Vd36/wRe8lc5aQzu+vtUlP6mpSyZjxgFSnJWQYLitorObiW3iQ9dVGDFfC/OW5NdTR
         6w4gPeTxpeP6lAvYNVZUn9YZ12/XY2glP4yLp/8XF/Gp3meVVoY/VaeZoF9zByzUGMHi
         q4ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=a9VbkBvy2VloNCGMSUV7eNcZG792ECW24ZZ8TuL+6gs=;
        b=JsxAVVcp2eJ7TuDNPZFZjImpf96cpC9vYjdkHss62bo8cvr90JC0Qb5D1BwSj/w47H
         geX5ywINUWoPi2O3NIa+TNwtkVM9Mj0CkmNgxWd9VJ6O+UQNSNBlkU1StD72Ohw4+oD6
         SKHIWFAJX5G/7bl5Gi2nZiNPdaC4EpEflzVjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=a9VbkBvy2VloNCGMSUV7eNcZG792ECW24ZZ8TuL+6gs=;
        b=mFu2b6D/Ki+jxTZY2wmzjiljEg4UMW3Vb1JsJL3B5KOW09kliR6TTwlNA/Vyt1rU9v
         zjJzsXF2GR/zZFps02WXjKSfcVYSJzS9aTjPT1I/IMhmvzNbymDu+dFyuDqbYJa3Pukv
         5MMNSeBiFn6U5S3ntexhv4HpfGkeXi1uELfdvn5BIKf+R11A0Efa1ldSvDxsqUpTsmp6
         91QycxwASozvbE0a//ulkL3Moe0jq3mti1jKu9r72CZwU2N6a/NFTc6t+AmafoWiE5Ko
         dJoOsa2joFomUZ8jrDRJIq93P6l+XAoDrjVWtJJcRlpmgYAuD8mjxcNe72BQdYHte/sk
         TGVA==
X-Gm-Message-State: AD7BkJIlJoA4Or87EJTcOxEyNIkGJsQtcBJrqeOHinNKSxpLe6o2DCkQgTTIl3znhA9qwVH+H8wowVluHxkcTQ==
X-Received: by 10.50.117.33 with SMTP id kb1mr3468136igb.93.1458165885543;
 Wed, 16 Mar 2016 15:04:45 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Wed, 16 Mar 2016 15:04:45 -0700 (PDT)
In-Reply-To: <xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: LHNIiW4QQKLeAD2i-os3stAqZa0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289052>

On Wed, Mar 16, 2016 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> What surprised me was that this new expand logic triggered for
> shortlog, actually.  I somehow assumed the caller that called
> de-tabify helper was only called for --pretty=medium.

I guess that would be ok, since shortlog by definition can't have any
issues with multiple lines lining up with each other.

At the same time, it might be a bit odd to show tabs in that first
line differently for the one-line vs multi-line log version. But maybe
it isn't - I think shortlog is the only thing that does that wrapping
anyway, so shortlog is already special.

I think the reason shortlog output gets both the de-tab and the
wrapping is that shortlog_add_commit() just calls pretty_print_commit
with CMIT_FMT_USERFORMAT.

            Linus
