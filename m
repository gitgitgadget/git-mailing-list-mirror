From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Any plans to support JTA and XA in jgit?
Date: Thu, 13 Nov 2008 22:54:13 +0100
Message-ID: <200811132254.13960.robin.rosenberg.lists@dewire.com>
References: <200811132059.16616.robin.rosenberg.lists@dewire.com> <491C8DBE.9080105@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:56:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0kAc-0000pH-HH
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 22:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbYKMVy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 16:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756013AbYKMVy0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 16:54:26 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:34610 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755463AbYKMVyZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 16:54:25 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 48A144C5018EBD1C; Thu, 13 Nov 2008 22:54:17 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <491C8DBE.9080105@wellfleetsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100918>

torsdag 13 november 2008 21:27:42 skrev Farrukh Najmi:
> A totally separate issue I have to sort out is how to handle multiple 
> unrelated transactions that are modifying the same git repo. If a 
> transaction needs to be rolled back how do roll back exactly some 
> changes in some files in git that were impacted by the transaction. This 
> is not easy because git (and most VCS) do not have transaction isolation 
> like databases do. Any suggestions?
Updating the head ref is the hard part, but we have locking already there
and it is atomic on any sane file system. There is no waiting implemented
so one gets an error if two threads try to update the same head simultaneously.
Seems doable I'd say. For server use one could wrap the repo with a real database,
and just let the disk based refs mirror the database view,  though that is quite a bit
off focus for my own needs.

> I am not very well versed in tag libraries myself. My situation is one 
> where everything happens inside a SOAP service endpoint and so I suspect 
> JSP tag libraries are not likely to be useful in that situation. Let me 
> know if I am wrong in this assessment.
not at all.

-- robin
