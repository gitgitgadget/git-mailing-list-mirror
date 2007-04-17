From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Initial push of a fully packed repo - why repack?
Date: Tue, 17 Apr 2007 13:12:46 +1200
Message-ID: <46a038f90704161812r143b6d27scbcc401ee77c4597@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 03:12:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdcFW-00047j-S8
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 03:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031050AbXDQBMr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 21:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031051AbXDQBMr
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 21:12:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:62604 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031050AbXDQBMq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 21:12:46 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1847911wxd
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 18:12:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rb4dZOeMhuq+hc+pKYGG7vonLSQ5XUGNcsD4ibKR5A/XmNu2ExJKYDk5ai0C37LsNVEpjgecYqZtpcvs9fwVw8GsXk4x/OqU4ciVQaRxkdPxBApRZoPJbJkdM4S77dsLwTzPvR5lDQcn43Lvkb5c/2HtYQc64Be6zHscUDLCH2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dbTb0NbMozWsHNpfuPtBAsqdLzPVvcFeeWmcy/ieGM+xVOH6UIfa8nslG9jWY40grpeqLYV7fz+ll1XeupnE1RKWpdSuGB/N411v2Ax9MhaXwNBvWiKoCQ+5MQqVyjjorWabLU+dAy4u7y7PJh8Sphm2cO5k19cZwqqUjbajK8s=
Received: by 10.90.84.17 with SMTP id h17mr5771096agb.1176772366444;
        Mon, 16 Apr 2007 18:12:46 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Mon, 16 Apr 2007 18:12:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44704>

Pushing to a new empty repo, git spends a lot of time repacking, even
if we have just run git-repack. The process looks like

 - use parsecvs to import a large CVS repo
 - git-repack -a -d (packs to ~550MB, taking ~1hr)
 - git-push --all git+ssh://host/newlycreatedrepo.git

Does it make sense to detect and optimise for this case?

cheers,


martin
