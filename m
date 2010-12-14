From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/8] Refactor parse_loc
Date: Wed, 15 Dec 2010 00:06:12 +0100
Message-ID: <201012150006.12462.trast@student.ethz.ch>
References: <cover.1292291624.git.trast@student.ethz.ch> <ff9def9ac3f207b9f9be9c59ec3a313c9b3d4d84.1292291624.git.trast@student.ethz.ch> <7v8vzsrmhk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 00:06:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdwq-0000m1-6j
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 00:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457Ab0LNXGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 18:06:14 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:11170 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932443Ab0LNXGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 18:06:14 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 00:06:06 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 00:06:12 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-16-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <7v8vzsrmhk.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163716>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > +test_expect_success 'blame -L parses end' '
> > +	git blame -L1,1 tres >out &&
> > +	cat out &&
> > +	test $(wc -l < out) -eq 1
> > +'
> 
> What does this test exactly?  "end"?

That's the test I was referring to in the commit message:

  The new test is for a case that made me pause during debugging: the
  'blame -L with invalid end' test was the only one that noticed an
  outright failure to parse the end *at all*.  So make a more explicit
  test for that.

So I guess a more thorough test title would be

  blame -L parses <end> part of its argument

IOW, the test verifies that -L1,1 is not parsed the same as -L1, which
would result in *two* lines of output.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
