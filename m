From: "=?ISO-8859-1?Q?Eirik_Bj=F8rsn=F8s?=" <eirbjo@gmail.com>
Subject: Invalid dates in git log
Date: Wed, 12 Dec 2007 10:11:12 +0100
Message-ID: <34660cca0712120111k3f11769fk1a8cefda3b82683e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 10:11:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Nd1-0003X6-JM
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757596AbXLLJLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 04:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbXLLJLP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:11:15 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:65342 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553AbXLLJLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 04:11:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so144900rvb.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 01:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=h/24RXMg6ABiAnNiO+Bzjtxxnpa1mCk1gnCBC9Mx9Xo=;
        b=uMGQc/H0yY61mRixkY7tgoWsGSBQyWNXVpr0k7riUKH6Ztv48ePcUbI7V2gLY2+Ugu985FEpBOmXpM53p4to1qz2wC+9+ZkYRddAtvSn3KAV2KMxKMsXukxGrsumEcQ0ikgriifsE9r6PPeEJySUwNjW6YlPONYTUDRLlDgFFfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XQLbyr2q+Opu0tP3zW0Udqx2HszveE8CqZ3OA8QF4SwMIwHqvdvFDyuBzZxHrsVLvRgu4/6UH8N11ISW9tEzG64mbTiDM03oZdUnifeqkRN/dBoQ6JJLquRi6dEkARebfQqfUBoyn3emybmJILYpf/L+vGV6czPK9gMgjHizKlA=
Received: by 10.141.99.4 with SMTP id b4mr199302rvm.40.1197450672815;
        Wed, 12 Dec 2007 01:11:12 -0800 (PST)
Received: by 10.140.207.1 with HTTP; Wed, 12 Dec 2007 01:11:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68017>

Hi there,

I'm experiencing a date issue with certain commits in Git in Linus's
2.6 kernel repository.

One commit has a date from 2019, while another commit has a date from
1970. Although Git has been around for a while and seeing a Linux
commit from 2019 would be cool, I think there's something wrong here.

My questions are:

1) Is this a problem in the Git software?
2) Or is it a data corruption issue in the repository?
3) Can it be fixed and should I contact anyone to get it fixed?

I'm doing some log analysis and these two dates mess up my charts.

Steps to reproduce:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

$ git  log  a27ac38efd6dc6dccebfc9bcc475ab4aa5fc4a56 -1
commit a27ac38efd6dc6dccebfc9bcc475ab4aa5fc4a56
Author: Len Brown <len.brown@intel.com>
Date:   Fri Apr 5 00:07:45 2019 -0500

    [ACPI] fix merge error that broke CONFIG_ACPI_DEBUG=y build

    Signed-off-by: Len Brown <len.brown@intel.com>

$ git  log  224426f168aa4af3dcb628e6edaa824d32d60e6f  -1
commit 224426f168aa4af3dcb628e6edaa824d32d60e6f
Author: Ursula Braun <braunu@de.ibm.com>
Date:   Thu Jan 1 01:00:01 1970 +0100

    qeth: remove header_ops bug

    Remove qeth bug caused by commit:
    [NET]: Move hardware header operations out of netdevice.

    Signed-off-by: Ursula Braun <braunu@de.ibm.com>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>


Thanks,

Eirik.
