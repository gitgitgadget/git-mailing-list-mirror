From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 15:07:05 -0500
Message-ID: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 21:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0jTx-000228-NO
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 21:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149AbXLGUHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 15:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757022AbXLGUHK
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 15:07:10 -0500
Received: from ro-out-1112.google.com ([72.14.202.183]:10467 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489AbXLGUHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 15:07:09 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7288117roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=gyZHoF4in70L0wWc6Pr2lZQJeD+6ELq6E7y32Vi2YQs=;
        b=SvHGfqQ7qZr8xIf2BSpcPWdpqo9fiOppctBh4eJt9XkVegIZrmr1Bx3Sv5bcMur9lO7jhIgf39aC6rz86/0tcyE06K2cH53x1nFcvkzTImpWWr6Qjh+N1MVzNOERvMAb98jblvhH1ORKaZH/bwaSMLQJG9twFWip3yyuPQHIyPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W0q0eHuPqscqAg7DG8m1Lhndl8ng2OEaXiu5TzdAeRHCPd31GhfyYLYcm2liviYECEO/InDjKWareP4otHexMroGpEI88quLAevK2sMudVkrSzcosdJfl7eNCZ2Le2lJl9xR0ES1/LWbFlOhiqdQnjNjACFqtkeyFXSZd5Y58xk=
Received: by 10.114.67.2 with SMTP id p2mr3581384waa.1197058025636;
        Fri, 07 Dec 2007 12:07:05 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 12:07:05 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67450>

I noticed two things when doing a repack of the gcc repo. First is
that the git process is getting to be way too big. Turning off the
delta caches had minimal impact. Why does the process still grow to
4.8GB?

Putting this in perspective, this is a 4.8GB process constructing a
330MB file. Something isn't right. Memory leak or inefficient data
structure?

The second issue is that the repack process slows way down on the last
10% of the packing process. I don't believe this was caused by
swapping since my disk light wasn't on. It takes a long to do the last
10% as it did for the first 70%. This seems to be correlated with the
size of the process getting so large.

-- 
Jon Smirl
jonsmirl@gmail.com
