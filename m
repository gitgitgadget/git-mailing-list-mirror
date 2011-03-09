From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Wed, 09 Mar 2011 09:13:07 +0100
Organization: Bertin Technologies
Message-ID: <20110309091307.4b759b7e@chalon.bertin.fr>
References: <20110225133056.GA1026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 09:32:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxEoI-00082Q-Qz
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 09:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756520Ab1CIIbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 03:31:44 -0500
Received: from blois.bertin.fr ([195.68.26.9]:54204 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904Ab1CIIbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 03:31:43 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id CB6F25434E
	for <git@vger.kernel.org>; Wed,  9 Mar 2011 09:31:39 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id A931E5434A
	for <git@vger.kernel.org>; Wed,  9 Mar 2011 09:31:39 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LHS00AER7ORF880@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 09 Mar 2011 09:31:39 +0100 (CET)
In-reply-to: <20110225133056.GA1026@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.5.0.1024-17966.004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168725>

That's a nice feature.

It may be good to extend the idea to support editing non-default notes
refs too.  Maybe something like:

<commit msg>
--- Notes ---
<info for GIT_NOTES_REF>
--- Notes <whatever> ---
<info for notes/whatever>

In this case, if we want to allow the user to customize the mark, we
will want to allow formatting like "--- Notes %N ---", but then the
defaulting for GIT_NOTES_REF would not fit - would we want to force the
use of "--- Notes commits ---" or similar ?  Maybe this would warrant a
separate mark for this default case:

	--default-note-mark="---"
	--note-mark="--- %N ---"

OTOH, using a single --note-mark and no special case for the default
notes ref seems more sane to me, since that shows the user when a
non-default GIT_NOTES_REF is in effect.

We may also want it to behave in a way similar to git-log, including
--show-notes[=<ref>] support to override the list of notes ref
to be considered.

-- 
Yann Dirson - Bertin Technologies
