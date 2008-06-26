Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MSGID_FROM_MTA_HEADER,
	MSGID_NOFQDN1,RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 30504 invoked by uid 111); 27 Jun 2008 00:17:39 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 20:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbYF0AR2 (ORCPT <rfc822;peff@peff.net>);
	Thu, 26 Jun 2008 20:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbYF0AR2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 20:17:28 -0400
Received: from w2.willowmail.com ([64.243.175.54]:32802 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754747AbYF0AR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 20:17:27 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2008 20:17:27 EDT
Received: (qmail 19347 invoked by uid 90); 27 Jun 2008 00:10:39 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@willowmail.com>
To:	<git@vger.kernel.org>
Subject: is rebase the same as merging every commit?
X-Mailer: Willow v0.02
Date:	Thu, 26 Jun 2008 23:04:58 -0000
Message-ID: <willow-jeske-01l78ZaEFEDjCZEG>
Received: from 72.14.229.81 at Thu, 26 Jun 2008 23:04:58 -0000
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Rebasing is described in the docs I've read as turning this: (sorry for the
dots)

..........A---B---C topic
........./
....D---E---F---G master

Into this:

...................A'--B'--C' topic
................../
.....D---E---F---G master

If I understand it right (and that's a BIG if), it's the same as doing a merge
of C into G where every individual commit in the C-line is individually
committed into the new C' line.

...........-------------A---B---C
........../            /   /   /
........./        /---A'--B'--C'  topic
......../        /
....D---E---F---G - master


(1) Is the above model a valid explanation?

(2) From the documentation diagrams, it looks like the rebased A' has only (G)
as a parent, not (A,G). If this is the case, why?  (i.e. not connecting those
nodes throws away useful information)

(3) If it only has (G) as a parent, does the rebase explicitly remove the
source A,B,C nodes from the repository? (the diagrams make it look like it
does) ..or do they just get cleaned up during GC?
