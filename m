From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: debugging git tests, was: Re: [PATCH v4 2/8] t5520: test no
 merge candidates cases
Date: Tue, 19 May 2015 15:29:23 +0200
Organization: gmx
Message-ID: <1254ff617c50077dc0c08321f168c4ce@www.dscho.org>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
 <1431955978-17890-3-git-send-email-pyokagan@gmail.com>
 <e89b333476cbb1e546371a07b357cd42@www.dscho.org>
 <xmqqoalhdbhx.fsf@gitster.dls.corp.google.com>
 <20150518185554.GB11463@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 19 15:29:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuhah-0003GC-Dy
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 15:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbbESN3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 09:29:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:50423 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755862AbbESN3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 09:29:45 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Ln897-1ZOF2X1Lsz-00hJK9; Tue, 19 May 2015 15:29:24
 +0200
In-Reply-To: <20150518185554.GB11463@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:YSdfFFAkDqBh67Js/SRNaE7eUAhnU3odlskzWJ8VDbdMuwyKYGc
 f68/dGVHuVw84gArjqSxqChMH1QheSM+9CsG3sDb3Ik0VEjeMyKINOjbswGbixLg4VaZX/D
 dXvRahaw56oRLtMGHhqR8DK9S/vPtKAPM6ypMdCDC9KwPmUgcVtx7l+hM880VQyKcMjWgb+
 +eAm+oBD2R82BR1UiUF9w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269353>

Hi Peff,

On 2015-05-18 20:55, Jeff King wrote:

> As a side note, I've also considered better support for running the
> debugger on git commands inside a test (right now, I usually stick a
> "gdb --args" in the pipeline, but you have to remember to run with "-v",
> and to redirect stdin appropriately). Do other people have this
> annoyance, too?

Yes, I have that annoyance, and I usually want to debug one very specific Git call in that script. Therefore, I made this patch:

https://github.com/git-for-windows/git/commit/0f50fd723beb5d27d2d799ef3a0cfc0b0bbd80a8

It really served me well during the past four months of Git for Windows 2.x work. Of course I also had to avoid the redirection:

https://github.com/git-for-windows/git/commit/d27cb6e0572475582677724545a71755d171ea76

So what I do these days is to run the failing test with `TEST_NO_REDIRECT=1` and with the Git call I want to debug prefixed with `TEST_GDB_GIT=1`.

Ciao,
Dscho
