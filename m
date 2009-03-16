From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: undoing something
Date: Mon, 16 Mar 2009 15:48:20 -0400
Message-ID: <450196A1AAAE4B42A00A8B27A59278E70A2AEFD7@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEFA4@EXCHANGE.trad.tradestation.com> <7veiwxwa9z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 20:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjIpQ-0005uw-WA
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 20:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbZCPTs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 15:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbZCPTs6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 15:48:58 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:59495 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbZCPTs5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 15:48:57 -0400
X-ASG-Debug-ID: 1237232934-283603050000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id CAEAF215EB5; Mon, 16 Mar 2009 15:48:54 -0400 (EDT)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id U3yLdR9UXFkBL8nf; Mon, 16 Mar 2009 15:48:54 -0400 (EDT)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Mar 2009 15:48:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: RE: undoing something
In-Reply-To: <7veiwxwa9z.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: undoing something
Thread-Index: Acmma2L4yenUkhl/Qj+CKF0q3eOHfgABALbA
X-OriginalArrivalTime: 16 Mar 2009 19:48:54.0409 (UTC) FILETIME=[3CD7BF90:01C9A670]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1237232934
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113357>

=== Re: ===
The answer was best only because in your previous question you wanted to
ensure fast-forwardness, i.e. "git push . origin/dev:dev" without plus
in
front to cause it to fail if it is not fast-forward.
=== end ===

No, I don't want to ensure ff.  The remote may have been changed in
other ways.  Though in that case I will avoid doing so; when it is not
the case it's even more important to see that your local copy is
different, and understand the tree, rather than blindly pulling.

=== Re: ===
If you know you have one unwanted commit you would want to discard at
the
tip of topic, you do not want fast-foward safety to kick in.

 (1) if you are on the topic branch, you can say "git reset --hard
HEAD^";
     or

=== end ===

It was a rebase, so the old value is not under the current, or even
visible on the tree.  That's why I needed the reflog to find it.
Tagging it let it appear in gitk.


=== Re: ===
 (2) if you are not, you can obviously check out topic and do the above,
     or "git branch -f topic topic^".
=== end ===

As documented, this destroys the existing branch and makes a new one.
That would, by design, blow away the reflog for that branch.  What I
want is a way to re-point it, and record that repointing =in= the
reflog.  That is, a command-line version that does what I can do with
the GUI, but isn't limited to what I can point to with the mouse.

--John
(please excuse the footer, yadda yadda)

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
