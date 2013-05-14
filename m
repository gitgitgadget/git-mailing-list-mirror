From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] t5510: start tracking-ref tests from a known state
Date: Tue, 14 May 2013 18:18:07 -0400
Message-ID: <CAPig+cQk2GCL4z=xo1m86uvKzE2QrP_1ajzkJvDTadxV_dkDuw@mail.gmail.com>
References: <20130511161320.GA14990@sigill.intra.peff.net>
	<20130511161400.GA3270@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 15 00:18:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNXz-0004MI-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758678Ab3ENWSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:18:11 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:52301 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758538Ab3ENWSK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:18:10 -0400
Received: by mail-lb0-f172.google.com with SMTP id y6so1200859lbh.3
        for <git@vger.kernel.org>; Tue, 14 May 2013 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=qfq0RRdMc3/FDMeg+l9Y9diF2md5UwyF3bhlzs+f+6E=;
        b=N2EMkePI2vDndxPx+Ru4HOO9taIQW2LpN++AQN8NdlSsFK43g9vfIsGUllxrouEg4h
         XTNg9DYtb/ctaui6rF+uUQ7FtQUDdlJCTd7VG27XpivN3Osxqic093tt9jxqIJDXFc+7
         5WDQyf9bOGKJJ9vbODgY6G1ITxmB0dP0HHRo9uofeAUEt6GF9nponnQmtdcQgHx71YcZ
         YT5tuiWjFgrSUXnesYTnvK8T5edxo3uZ/Lns8fABUw/r68+MtgKrg58FTi3LxBh38P1G
         IdAoQhKUWbbJrZQlbriyMdQQFK4AXo3VprpEyMNW0TyIZX2B50vdFaWhCArWhhLUd1sj
         ijtQ==
X-Received: by 10.152.37.196 with SMTP id a4mr16542986lak.55.1368569887333;
 Tue, 14 May 2013 15:18:07 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Tue, 14 May 2013 15:18:07 -0700 (PDT)
In-Reply-To: <20130511161400.GA3270@sigill.intra.peff.net>
X-Google-Sender-Auth: iinw8VH17KbD_acjGtB5n-EZgFY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224359>

On Sat, May 11, 2013 at 12:14 PM, Jeff King <peff@peff.net> wrote:
> We have three sequential tests for for whether tracking refs

s/for for/for/
[or]
s/for for/for checking/

> are updated by various fetches and pulls; the first two
> should not update the ref, and the third should. Each test
> depends on the state left by the test before.
>
> This is fragile (a failing early test will confuse later
> tests), and means we cannot add more "should update" tests
> after the third one.
>
> Let's instead save the initial state before these tests, and
> then reset to a known state before running each test.
>
> Signed-off-by: Jeff King <peff@peff.net>
