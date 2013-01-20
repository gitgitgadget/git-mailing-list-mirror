From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore
 certain stat fields
Date: Sun, 20 Jan 2013 20:51:51 +0100 (CET)
Message-ID: <1999787368.3950248.1358711511739.JavaMail.root@dewire.com>
References: <7va9sa6f0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:52:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx0wB-00020J-Ku
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 20:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab3ATTvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 14:51:54 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:58432 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab3ATTvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 14:51:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 0513D826FE;
	Sun, 20 Jan 2013 20:51:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9ouxp39NZrh; Sun, 20 Jan 2013 20:51:51 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id CE429826E3;
	Sun, 20 Jan 2013 20:51:51 +0100 (CET)
In-Reply-To: <7va9sa6f0h.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214040>



----- Ursprungligt meddelande -----

> That configurability is a slipperly slope to drag us into giving
> users
> more complexity that does not help them very much, I suspect.
> 
> Earlier somebody mentioned "size and mtime is often enough", so I
> think a single option core.looseStatInfo (substitute "loose" with
> short, minimum or whatever adjective that is more appropriate---I am
> not good at picking phrases, it sounds to me a way to more loosely
> define stat info cleanliness than we usually do) that makes us
> ignore all fields (regardless of their zero-ness) other than those
> two fields might not be a bad way to go.

Would something like this be good?

core.statinfo = 
default = all fields
minimal = whole seconds of mtime and size
medium = seconds, nanos of mtime and size
nonzero = all non-zero fields

-- robin
