From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC 7/7] t2016 (checkout -p): use printf for multiline y/n input
Date: Tue, 7 Sep 2010 10:06:27 +0200
Message-ID: <201009071006.27607.trast@student.ethz.ch>
References: <4C85357A.8090000@web.de> <20100907014135.GA1182@burratino> <20100907015509.GH1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 10:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OstCP-0007bA-C9
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 10:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab0IGIGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 04:06:33 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:35519 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab0IGIGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 04:06:30 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 7 Sep
 2010 10:06:27 +0200
Received: from thomas.site (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Tue, 7 Sep
 2010 10:06:28 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100907015509.GH1182@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155685>

Jonathan Nieder wrote:
> Instead of
> 
> 	(echo y; echo n; echo n) | git checkout -p HEAD^ -- dir
> 
> write
> 
> 	printf "%s\n" y n n |
> 	git checkout -p HEAD^ -- dir
> 
> which means the same thing but might be easier to read.

I'm indifferent about this.  It does save a process, but (maybe that's
just me though) I had to look up a POSIX manpage to verify that the
repeating behaviour is guaranteed.

> While at it, add a missing && to the "git checkout -p HEAD with change
> already staged" test.

Good catch.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
