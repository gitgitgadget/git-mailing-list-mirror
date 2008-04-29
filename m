From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: cvsexportcommit and cvsimport's -k option
Date: Tue, 29 Apr 2008 21:46:42 +0200
Message-ID: <200804292146.42262.robin.rosenberg.lists@dewire.com>
References: <f6c6e2a5cc39.481773ba@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lars Alexander Noschinski <Lars.Noschinski@rwth-aachen.de>
X-From: git-owner@vger.kernel.org Tue Apr 29 21:48:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqvnj-0002If-FN
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 21:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbYD2Tqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 15:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754469AbYD2Tqu
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 15:46:50 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15952 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754390AbYD2Tqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 15:46:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C65C11456304;
	Tue, 29 Apr 2008 21:46:45 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srbn0cb3cK3E; Tue, 29 Apr 2008 21:46:45 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 394ED1456300;
	Tue, 29 Apr 2008 21:46:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <f6c6e2a5cc39.481773ba@rwth-aachen.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80721>

tisdagen den 29 april 2008 19.15.06 skrev Lars Alexander Noschinski:
> ... hack away ...
> git-cvsimport -i -r cvs -kk -v -d $CVSREPOS
> git-rebase cvs # If work was done in the meantime
> git-cvsexportcommit -cpuv $COMMIT # Multiple times, if necessary
> git-cvsimport -i -r cvs -kk -v -d $CVSREPOS
> git-checkout -b master cvs # commit ids are changed now
>
> As far as I am concerned, this works fairly well, accept when for any
> reason a line containing a CVS keyword (e.g. $Id$) is contained in a
> changeset. In this case, patching fails, and I have to investigate why it
> fails, eventually just copying the old version from the cvs repository.
>
> Would it be possible to add an option to cvsexportcommit to detect such
> killed keywords and ignore them?

Sure, but is it necessary? If the cvs checkout you use is checked out
with -kk there shouldn't be any problem.

If not, start by thinking up a few testcase for inclusion in 
t9200-git-cvsexportcommit.sh that illustrates the problem. Then we can
change cvsexporcommit until the new tests pass.

-- robin
