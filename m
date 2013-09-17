From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Tue, 17 Sep 2013 21:16:13 +0200
Message-ID: <CAHGBnuMgE1zO4=MnJJXcDLJSD2Vsjptk1x2Bc6CpF9GSxmFp8w@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	<xmqqppscij8a.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM=QqLxPNNZmoL1jG+oAm2y6o=AuBtkH+FRwZ_8ahGC+w@mail.gmail.com>
	<xmqqli30idfx.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOfYoosgWQdfF+L3=YCqO-MYEx-TpNzBAD-Zt0kqeR_Hw@mail.gmail.com>
	<xmqqhadj1kyo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 21:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM0l2-0006Ac-0i
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 21:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab3IQTQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 15:16:16 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61006 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab3IQTQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 15:16:15 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so5713495lbh.5
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2SUchiwm3h2vW5jWkGXs2RjPg1ACMK0h0VSen3LkX/k=;
        b=h1vEII5mZg/31fz8vpZfOVjKee9bZifmskBT/gqYb6XdR0BADoodM16H2kGuRSI6e2
         o83jJg1QG3FtW6qC5e1fwUoxcxDV+tAbATRoCbi2EczqCkzQLw3ymQxIEx3yZz2Y123P
         gjTdqdykwOXLixGJa188A4T2xUEnQs3MldRjzna2yuGu7MufXI4hTyGNJ5qIG3hr7cU6
         zbu+JYBI9Mvh08q/AWT5bcEf+OyXP/yD36091bTSn5jEykESaarLhnZpx427UTxALKET
         EIUUkBVM05dzU5Ea9WGiO9QM02JUayjm9lWgEAEnOzf5vqP8HV/rkJ8r3vdhZ+ei6Up2
         HRwA==
X-Received: by 10.152.228.130 with SMTP id si2mr2951145lac.32.1379445373836;
 Tue, 17 Sep 2013 12:16:13 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Tue, 17 Sep 2013 12:16:13 -0700 (PDT)
In-Reply-To: <xmqqhadj1kyo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234904>

On Tue, Sep 17, 2013 at 6:17 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Keeping the ugliness to deal with the platform issue (i.e. broken
> string.h) in one place (e.g. compat/mingw) is far more preferrable
> than having a similar ugliness in git-compat-util.h for people on
> all other platforms to see, no?

I don't think people on other platforms seeing the ugliness is really
an issue. After all, the file is called git-*compat*-util.h; I sort of
expect to see such things there, and I would expect only more complex
compatibility stuff that requires multiple files in the compat/
directory. Also, your solution does not really keep the ugliness in
one place, you need the change in config.mak.uname, too (because yes,
I do insist to avoid GCC-ism in C files, just like you probably would
insist to avoid Bash-ism in shell scripts).

-- 
Sebastian Schuberth
