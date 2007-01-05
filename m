From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH 2/4] Improve cached content header of status output
Date: Fri, 5 Jan 2007 18:14:49 +0100
Message-ID: <17822.34697.691000.253492@lapjr.intranet.kiel.bmiag.de>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
	<11677659921833-git-send-email-j.ruehle@bmiag.de>
	<459E2E57.6020503@shadowen.org>
	<7vr6u9g1l4.fsf@assigned-by-dhcp.cox.net>
	<459E4F2D.4000806@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 18:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2seu-0001Xm-9v
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 18:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbXAERPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 12:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbXAERPG
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 12:15:06 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:36825 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161163AbXAERPE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 12:15:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 215653AF21;
	Fri,  5 Jan 2007 18:14:58 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15034-01; Fri, 5 Jan 2007 18:14:58 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 22F203AF20;
	Fri,  5 Jan 2007 18:14:56 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id E0CEE3ADCB;
	Fri,  5 Jan 2007 18:14:55 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29176-06; Fri, 5 Jan 2007 18:14:52 +0100 (CET)
Received: from LAPJR (lapjr.intranet.kiel.bmiag.de [10.191.7.182])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id B002D3ADCA;
	Fri,  5 Jan 2007 18:14:51 +0100 (CET)
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <459E4F2D.4000806@shadowen.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36008>

Andy Whitcroft writes:
 > Junio C Hamano wrote:
 > > Andy Whitcroft <apw@shadowen.org> writes:
 > > 
 > >>> +static void wt_status_print_cached_header(const char *reference)
 > >>> +{
 > >>> +	const char *c = color(WT_STATUS_HEADER);
 > >>> +	color_printf_ln(c, "# Cached changes to be committed:");
 > >>> ...
 > >> We seem to be using 'Cached' and 'staged' here.  I thought we had
 > >> updated all the docs to call files in the index "Staged for commit".
 > > 
 > > 	# Changes staged to be committed:
 > > 
 > > Somebody did not like the verb "stage"; perhaps we can say:
 > > 
 > > 	# You have added changes to these files to be committed:
 > > 	...
 > 
 > # These files have changes and are marked for commit:
 > 
 > >         # There are yet to be added changes to these files:
 > 
 > # These files have changes but are not marked for commit:

Does this better reflect that git tracks content and not files?

# Changes to these files will be committed:

# Changes to these files are not marked for commit:

BTW: how about also adding a hint how to review the changes in
question (i.e. diff --cached and diff; as an alternative to diff
--cached we could just advertise the --verbose switch to status and
commit).
