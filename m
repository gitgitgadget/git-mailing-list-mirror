From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Possible bug in Git
Date: Fri, 16 Apr 2010 19:00:26 +0200
Message-ID: <201004161900.26537.trast@student.ethz.ch>
References: <4BC6EECE.6060408@gestiweb.com> <alpine.LFD.2.00.1004160845350.15116@i5.linux-foundation.org> <7vvdbrcp5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	"David =?iso-8859-1?q?Mart=EDnez_Mart=ED?=" <desarrollo@gestiweb.com>,
	<git@vger.kernel.org>, <deavidsedice@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 19:00:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ouW-0007bR-Qt
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 19:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758658Ab0DPRAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 13:00:48 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:2944 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758653Ab0DPRAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 13:00:47 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Apr
 2010 19:00:46 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Apr
 2010 19:00:27 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <7vvdbrcp5g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145086>

Junio C Hamano wrote:
> There was already a "fix" posted for the "empty vs missing" confusion.
> 
> From: Thomas Rast <trast@student.ethz.ch>
> Subject: [PATCH] combined diff: correctly handle truncated file
> Date: Thu, 15 Apr 2010 14:59:37 +0200
> Message-ID:
>  <884b9b68a4478aceda580299c059a9a67417cb1c.1271336073.git.trast@student.ethz.ch>
> 
> I've been busy for the past few days, but I have it in my 'to-maint'
> queue.  We may actually want to do the same for "missing" case as well,
> though.

Why?  The evil deletion is already reported as

  diff --cc foo
  index 5716ca5,7601807..0000000
  deleted file mode 100644,100644
  --- a/foo
  +++ /dev/null

with no diff -- but the absence of a diff is because of your 4462731
(combine-diff: do not punt on removed or added files., 2006-02-06) and
I tend to agree with the reasoning.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
