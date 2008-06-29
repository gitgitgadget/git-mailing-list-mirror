From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 09/21] Remember how a Ref was read in from disk and created
Date: Sun, 29 Jun 2008 15:51:05 +0200
Message-ID: <200806291551.06201.robin.rosenberg@dewire.com>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org> <1214726371-93520-9-git-send-email-spearce@spearce.org> <1214726371-93520-10-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 15:56:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCxO6-00053M-Pg
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 15:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206AbYF2NzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 09:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbYF2NzW
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 09:55:22 -0400
Received: from [83.140.172.130] ([83.140.172.130]:10677 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755899AbYF2NzW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 09:55:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3A75D802E18;
	Sun, 29 Jun 2008 15:55:20 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3BjSw8znA315; Sun, 29 Jun 2008 15:55:19 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B6CCB8006B7;
	Sun, 29 Jun 2008 15:55:19 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214726371-93520-10-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86802>

s=F6ndagen den 29 juni 2008 09.59.19 skrev Shawn O. Pearce:
> To efficiently deleted or update a ref we need to know where
> it came from when it was read into the process.  If the ref
> is being updated we can usually just write the loose file,
> but if it is being deleted we may need to remove not just a
> loose file but also delete it from the packed-refs.

One could argue that we should not normally just delete a ref, but
mark it as deleted and let git gc delete it when it expires, just like
any old ref, but then we should try to get C Git to do the same. There
was a thread relating to this recently.

-- robi
