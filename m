From: Clemens Buchacher <drizzd@aon.at>
Subject: Built-in checkout: wrong behaviour in subdirectories
Date: Wed, 20 Feb 2008 23:35:20 +0100
Message-ID: <20080220223520.GA23642@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxXr-0005ao-Ev
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbYBTWf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbYBTWf1
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:35:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:17386 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbYBTWfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:35:25 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2299300fga.17
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 14:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        bh=V6Oi3BDDdba41KqilA972GmYYXq3HakPEdna4H7DLS8=;
        b=TeYuzK8jub8Pwhdmlc1BjEJN+VqB2VlPKgbUy5U6RlPeYemjQel1g7tvNL+3hEI2bmxhn4wysDHczVAyQRdIVt/8LNWk+mu3XiscYfyCpezJXUn80qiqB+NN5gaVYkXmd/6xC4OeHXHctdoP5eZq+FFixaGin+y/QTHXPy6R1eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=nDiPoV+cW4dS6zU2h+pjkXcCjW7zxY/LuQgJ/hLK+P4VyvW0zd4lxaM8oSYdM2Dfg+Gj3IyDx29OFVgC+Gyha3NARLOhbyHvdpcK/hhZipoCtovWercd8SYqfnl21wwVeh47FQfoYuNmXpjhOuKlQO/m3L/m6IZ/bJgbEItGNK0=
Received: by 10.86.3.4 with SMTP id 4mr8724074fgc.69.1203546922531;
        Wed, 20 Feb 2008 14:35:22 -0800 (PST)
Received: from darc.dyndns.org ( [88.117.114.124])
        by mx.google.com with ESMTPS id 3sm14522506fge.7.2008.02.20.14.35.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Feb 2008 14:35:20 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JRxX6-0006Cb-Bi; Wed, 20 Feb 2008 23:35:20 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74556>

Hi,

The following test shows a problem since commit 782c2d6 (Build in checkout):

mkdir testrep
cd testrep
git init

: >file1
git add file1
git commit -m 'initial'

git branch dev

mkdir dir1
cd dir1
# this creates dir1/file1
git checkout dev

Regards,
Clemens
