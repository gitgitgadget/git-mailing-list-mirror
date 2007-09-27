From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: return void expressions in C (Was: [PATCH 3/6] Rework
 pretty_print_commit ...)
Date: Thu, 27 Sep 2007 15:56:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709271554560.3579@woody.linux-foundation.org>
References: <11892962763548-git-send-email-madcoder@debian.org>
 <11892962761617-git-send-email-madcoder@debian.org>
 <11892962764194-git-send-email-madcoder@debian.org>
 <1189296276114-git-send-email-madcoder@debian.org> <7vsl5nflj2.fsf@gitster.siamese.dyndns.org>
 <20070910090656.GC3417@artemis.corp> <7vir6isvu1.fsf@gitster.siamese.dyndns.org>
 <7v642iqumt.fsf@gitster.siamese.dyndns.org>
 <20070910183256.GD32442@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:57:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib2IY-0004sC-Ms
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 00:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889AbXI0W52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756233AbXI0W52
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 18:57:28 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44929 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757163AbXI0W51 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2007 18:57:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8RMuXam023333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2007 15:56:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8RMuWiC032065;
	Thu, 27 Sep 2007 15:56:33 -0700
In-Reply-To: <20070910183256.GD32442@artemis.corp>
X-Spam-Status: No, hits=-2.738 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.39__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59348>



On Mon, 10 Sep 2007, Pierre Habouzit wrote:
>
>   Okay, I stand corrected, but as I'm curious, I've now the Truth about
> this, for those who still care at that point (as the patch has been
> fixed in the next round anyways ;p)

The

	void fn1(void);

	void fn2(void)
	{
		return fn1();
	}

thing is a gcc extension. It happens to be one we use in the kernel too, 
since it makes for nicer-looking source code in some circumstances, but 
it's definitely nonstandard.

		Linus
