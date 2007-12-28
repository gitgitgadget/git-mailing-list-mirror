From: Bernt Hansen <bernt@norang.ca>
Subject: [PATCH] git-gui: Make commit log messages end with a newline
Date: Thu, 27 Dec 2007 21:15:56 -0500
Organization: Norang Consulting Inc
Message-ID: <87k5mzmun7.fsf_-_@gollum.intra.norang.ca>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
	<8763yof9lg.fsf@gollum.intra.norang.ca>
	<Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<20071225044202.GO14735@spearce.org>
	<87myrxqrev.fsf@gollum.intra.norang.ca>
	<20071227041902.GR14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 03:17:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J84mV-000082-0Z
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 03:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbXL1CQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 21:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbXL1CQM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 21:16:12 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54057 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbXL1CQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 21:16:10 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1J84lc-0003z6-2Y; Fri, 28 Dec 2007 02:16:08 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+u/bDwn/kJg1TKctw1VAIn
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id lBS2G1FS019262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 27 Dec 2007 21:16:04 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.2/8.14.2/Debian-1) with ESMTP id lBS2G1w2015952;
	Thu, 27 Dec 2007 21:16:01 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.2/8.14.2/Submit) id lBS2FuFZ015951;
	Thu, 27 Dec 2007 21:15:56 -0500
In-Reply-To: <20071227041902.GR14735@spearce.org> (Shawn O. Pearce's message of "Wed\, 26 Dec 2007 23\:19\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69275>

Concatenating commit log messages from multiple commits works better
when all of the commits end with a clean line break.

Its good to be strict in what you create, and lenient in what you
accept, and since we're creating here, we should always try to
Do The Right Thing(tm).

Signed-off-by: Bernt Hansen <bernt@alumni.uwaterloo.ca>
---
 lib/commit.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index b2d2d53..1c0586c 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -303,7 +303,7 @@ A rescan will be automatically started now.
 		puts stderr [mc "warning: Tcl does not support encoding '%s'." $enc]
 		fconfigure $msg_wt -encoding utf-8
 	}
-	puts -nonewline $msg_wt $msg
+	puts $msg_wt $msg
 	close $msg_wt
 
 	# -- Create the commit.
-- 
1.5.4.rc1.21.g0e545
