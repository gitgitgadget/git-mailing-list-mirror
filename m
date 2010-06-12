From: Thomas Rast <trast@student.ethz.ch>
Subject: vger doesn't like UTF-8 from send-email
Date: Sat, 12 Jun 2010 12:11:12 +0200
Message-ID: <201006121211.12870.trast@student.ethz.ch>
References: <20100612000002.GA30196@neumann> <cover.1276336602.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 12 12:11:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONNgn-0003pK-Sm
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 12:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab0FLKLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 06:11:37 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:30994 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871Ab0FLKLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 06:11:36 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 12:11:36 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 12:11:13 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <cover.1276336602.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149002>

Thomas Rast wrote:
> [Argh.  Or maybe it's an encoding problem?]

First, sorry everyone on the Cc list for the triple post.  I first
blamed it on the fact that I was Cc'ing Gabor, but apparently the
problem was in the content.

The files I handed to git-send-email were UTF-8, and I used my usual
git alias to --cc Gabor on the first pass which also results in an
UTF-8 encoded name.

I got this back from our university mail server:

  git@vger.kernel.org
  vger.kernel.org #550 5.7.1 Content-Policy reject msg: Wrong MIME labeling on 8-bit character texts. BF:<H 0>; S1753608Ab0FLKCQ ##

AFAICT the original message did not declare an encoding:

  Subject: [PATCH v2 0/2] bash completion: Support "divergence from upstream" warnings in __git_ps1
  Date: Sat, 12 Jun 2010 12:02:14 +0200
  Message-ID: <cover.1276336602.git.trast@student.ethz.ch>
  X-Mailer: git-send-email 1.7.1.561.g94582
  In-Reply-To: <20100612000002.GA30196@neumann>
  References: <20100612000002.GA30196@neumann>
  MIME-Version: 1.0
  Content-Type: text/plain
  Return-Path: trast@student.ethz.ch

It's hard to be 100% sure though because in the infinite wisdom of MS
Exchange, the bounce came back with everything wrapped in a layer of
HTML(!) and declared latin-1.

Is this a new vger policy, or am I hitting a send-email bug?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
