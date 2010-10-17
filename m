From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] t0003: properly quote $HOME
Date: Sun, 17 Oct 2010 21:34:43 +0200
Message-ID: <201010172134.43983.trast@student.ethz.ch>
References: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch> <20101017191827.GD3202@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>, <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 21:35:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Z19-0000u2-AD
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 21:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635Ab0JQTfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 15:35:33 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:27179 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932540Ab0JQTfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 15:35:33 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 17 Oct
 2010 21:35:31 +0200
Received: from pctrast.inf.ethz.ch (129.132.209.217) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 17 Oct
 2010 21:35:30 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc8-32-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20101017191827.GD3202@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159214>

Jonathan Nieder wrote:
> Thomas Rast wrote:
> 
> > 6df42ab (Add global and system-wide gitattributes, 2010-09-01) forgot
> > to quote one instance of $HOME in the tests.  This broke the test for
> > me with the shell complaining about an ambiguous redirect (but only
> > when run with --root for some reason).
> 
> Thanks.  What shell do you use?
> 
> IIRC it is not ambiguous according to POSIX but since e.g. OpenBSD
> complains it is worth fixing.

Oh, huh, so much for the theory that it's --root causing it:

  $ sh ./t0003-attributes.sh -q
  # passed all 8 test(s)
  1..8
  $ dash ./t0003-attributes.sh -q
  # passed all 8 test(s)
  1..8
  $ bash ./t0003-attributes.sh -q
  not ok - 1 setup
[...]
  $ bash --version
  GNU bash, version 4.1.7(1)-release (x86_64-suse-linux-gnu)
[...]

Then again, so much for your theory that it's only OpenBSD... ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
