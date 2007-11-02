From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Support "history replay" for git log commands
Date: Fri, 2 Nov 2007 14:17:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711021416450.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021333050.3342@woody.linux-foundation.org>
 <7v4pg41hq0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 22:18:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io3uN-0005qe-QY
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 22:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXKBVSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 17:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbXKBVSA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 17:18:00 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50870 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753702AbXKBVR7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 17:17:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2LHRjx031773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2007 14:17:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2LHQim011367;
	Fri, 2 Nov 2007 14:17:26 -0700
In-Reply-To: <7v4pg41hq0.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-3.231 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63177>



On Fri, 2 Nov 2007, Junio C Hamano wrote:
> 
> Can one iteration of loop in log_tree_commit() smudge more
> than one commits with FORCE_REPLAY?  Maybe make the
> trigger_replay a counter and count down in this loop until we
> find that many commits that have the FORCE_REPLAY flag?

Good point, and yes, that sounds like the right thing to do.

		Linus
