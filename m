From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t7501-commit.sh: Add test case for fixing author in
 amend commit.
Date: Mon, 5 Nov 2007 10:24:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711051020330.4362@racer.site>
References: 7vy7dg1kdg.fsf@gitster.siamese.dyndns.org
 <1194234165-9498-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-336584528-1194258298=:4362"
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 11:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioz9i-0000YD-5c
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 11:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbXKEKZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 05:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbXKEKZu
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 05:25:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:51913 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753632AbXKEKZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 05:25:50 -0500
Received: (qmail invoked by alias); 05 Nov 2007 10:25:47 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp021) with SMTP; 05 Nov 2007 11:25:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0/UlUxi+0+SUNCpdlqtgDL/zAyypETlW/Il05lY
	agBBe5guUflMFP
X-X-Sender: gene099@racer.site
In-Reply-To: <1194234165-9498-1-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63493>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-336584528-1194258298=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 4 Nov 2007, Kristian Høgsberg wrote:

> +test_tick
>  
>  test_expect_success 'partial commit that involves removal (3)' '

We usually put the test_tick into the test case.  IOW

	test_expect_success 'message' '
		test_tick &&
		...

>  '
>  
> +oldtick=$GIT_AUTHOR_DATE
> +test_tick
> +
> +author="The Real Author <someguy@his.email.org>"
> +committer="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE"
> +
> +test_expect_success 'amend commit to fix author' '

Same here.

BTW: is this committer mangling really necessary? I thought only 
GIT_COMMITTER_DATE was relevant.  And that is easily replaced by

	sed -e "s/^\(committer.* \)[0-9][0-9]*$/\1$GIT_COMMITTER_DATE/"

Ciao,
Dscho

--8323584-336584528-1194258298=:4362--
