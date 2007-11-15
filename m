From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [BUG] encoding problem with format-patch + send-email
Date: Thu, 15 Nov 2007 11:57:26 +0100
Message-ID: <20071115105726.GA18555@bre-cln-ukleine.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 11:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IscOe-00066G-57
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 11:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbXKOK4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 05:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbXKOK4H
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 05:56:07 -0500
Received: from mail164.messagelabs.com ([216.82.253.131]:37683 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750747AbXKOK4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 05:56:06 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-12.tower-164.messagelabs.com!1195124164!19731325!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 1010 invoked from network); 15 Nov 2007 10:56:05 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-12.tower-164.messagelabs.com with SMTP; 15 Nov 2007 10:56:05 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 15 Nov 2007 04:56:04 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 15 Nov 2007 04:56:03 -0600
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id E1F0749A5E; Thu, 15 Nov 2007 11:57:26 +0100 (CET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>,
	git@vger.kernel.org, Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 15 Nov 2007 10:56:03.0790 (UTC) FILETIME=[1DB22EE0:01C82776]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65105>

Hello,

Brian just stumbled over a problem with format-patch + send-email.

format-patch only adds Content-Type and Content-Transfer-Encoding
headers iff the body needs it.

send-email adds "From: A. U. Thor <author@tld>" to the body if sender
and From: in the patch to send differ.

Both is just fine, but if the author has some non-ascii characters in
her name but the body is ascii-only the resulting mail is broken.

What about adding the Content-Type and Content-Transfer-Encoding header=
s
in any case?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
