From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 11:14:54 -0700
Message-ID: <CA+55aFwYAFuz5p0=8QiAFDy4e66f1pF3v=D5nnL6+3um7Z3L2g@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
	<CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
	<20130610220627.GB28345@sigill.intra.peff.net>
	<7vk3m1efda.fsf@alter.siamese.dyndns.org>
	<7v8v2hedou.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
	<7v4nd5ecmy.fsf@alter.siamese.dyndns.org>
	<7vwqq1ct0g.fsf@alter.siamese.dyndns.org>
	<CAMP44s0r96ByEs3+N1Qo+O18rOmT72rHk4zAEFAyFdU_DsQ8wA@mail.gmail.com>
	<7vtxl4blht.fsf@alter.siamese.dyndns.org>
	<CAMP44s02PqGFNmrGEcJVT6xcQHx8k4NYqJ_TtOTUEY8XHPj0BA@mail.gmail.com>
	<7vppvsbkc3.fsf@alter.siamese.dyndns.org>
	<CAMP44s02KaMaMUz4618n5RqVqVSXzr_D9rPS1uesy2XEdqnq5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:15:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmT5w-0003LS-Ab
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab3FKSO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:14:56 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:44120 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab3FKSOz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:14:55 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz10so5957614veb.5
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=10pNOz72grO8Jsh87BVbbh/8Ilieu4Sy6WzUYgytvvo=;
        b=Zp/ojpWmmnlb1/EwkoEmu8WXJixm/dRDeLF/iRlv3R3vL3UC45kff9+xBfritZMQ0p
         HnlfeK1XUc53Ug7YOxcj74XC3HHTwuRFRbKH3dZem1TSJc6t17BmkORbR69DUidWdPfs
         sQ2lEd+DCdHhY5f93U/1R4rTH9ntUPrITfrwDy1roeA2M0u4+SD0/RcgqcDc968zr7K6
         Yr5QDA3XDPr2X6t9gOI/VICSbhMbN1vMjHkgAklYgXOLXLr/oNMYJA5QDL0UaKHuVfWF
         b/e2mjJeb2Vy79OF9401uhiuvGiJg/crWLiI+exNa4E/bmGGA3Eb2YYhyp3TtGuayunR
         6Q9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=10pNOz72grO8Jsh87BVbbh/8Ilieu4Sy6WzUYgytvvo=;
        b=F1UyA1Q/52vbZwlp6yY8pvd2PhWv11AT6tjVywEZ0ghqskA3I+7aKe7iyUd4f6zJWm
         EHXx5Ypa+g6l4tBKeLKsg2u6Xol8WqWL1cswCy6uvHPNpQo8svCkU7Sg5Vb+N+KZ+W/K
         lm+sEzL2tggqcOCEdc8N0FuWbvwYUrjDWBAU4=
X-Received: by 10.52.0.232 with SMTP id 8mr7243377vdh.12.1370974494593; Tue,
 11 Jun 2013 11:14:54 -0700 (PDT)
Received: by 10.220.8.71 with HTTP; Tue, 11 Jun 2013 11:14:54 -0700 (PDT)
In-Reply-To: <CAMP44s02KaMaMUz4618n5RqVqVSXzr_D9rPS1uesy2XEdqnq5A@mail.gmail.com>
X-Google-Sender-Auth: h_nd79Fpt0iluJae8EKaC0S_big
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227482>

On Tue, Jun 11, 2013 at 11:06 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Moreover, if you are going to argue that we shouldn't be closing the
> door [...]

Felipe, you saying "if you are going to argue ..." to anybody else is
kind of ironic.

Why is it every thread I see you in, you're being a dick and arguing
for some theoretical thing that nobody else cares about?

This whole thread has been one long argument about totally pointless
things that wouldn't improve anything one way or the other. It's
bikeshedding of the worst kind. Just let it go.

              Linus
