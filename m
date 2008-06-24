From: <Patrick.Higgins@cexp.com>
Subject: RE: Windows symlinks
Date: Tue, 24 Jun 2008 17:42:05 -0600
Message-ID: <911589C97062424796D53B625CEC0025E46193@USCOBRMFA-SE-70.northamerica.cexp.com>
References: <m3od5qjtv1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
To: <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBIFk-00073U-Gd
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbYFXXr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbYFXXr2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:47:28 -0400
Received: from mx02.cexp.com ([170.131.136.83]:32438 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbYFXXr2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 19:47:28 -0400
Received: from uscobrmfa-se-05 (uscobrmfa-se-05.cexp.com [170.131.144.36])
	by mx02.cexp.com (Postfix) with ESMTP id 944AB417A4A
	for <git@vger.kernel.org>; Tue, 24 Jun 2008 17:42:59 -0600 (MDT)
Received: from USCOBRMFA-SE-70.northamerica.cexp.com ([10.128.26.36]) by USCOBRMFA-SE-51.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 24 Jun 2008 17:42:59 -0600
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <m3od5qjtv1.fsf@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Windows symlinks
Thread-Index: AcjWUgJMiA+PpobuSMqA+M5oq5gufAAAHSYA
X-OriginalArrivalTime: 24 Jun 2008 23:42:59.0466 (UTC) FILETIME=[08E19EA0:01C8D654]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86186>

> From: Jakub Narebski [mailto:jnareb@gmail.com]
> 
> Patrick Higgins <Patrick.Higgins@cexp.com> writes:
> 
> Second, the problem there can be _only_ if your repository contains
> (or contained) symlinks, and then it is your own damn fault.

Agreed. The first thing we started working on was getting symlinks out of our repositories. Unfortunately, we chose to use them because we are using broken development tools that don't support proper modularity. We found the best way to get the IDE's compilation to work was to symlink shared code into each project. It's a nasty solution, but it was the only one that worked. Clearcase made this solution possible. As powerful and flexible as git is, it would have left us out in the cold in this situation.


> I don't know how Cygwin, or msysGit deals with symlinks in a wirking
> directory

msysGit just created a file with the target of the symlink as it's contents, but its tools didn't know how to make use of it. I think Cygwin did the same thing, but ls, cat, and all the other Cygwin tools were able to make use of it. I tried to run the Java compiler over a symlinked file and it didn't work, though.

Copying files at build time is an interesting idea, but since the point was to get an IDE's build system to work, I don't I'll have the level of control I would need to make this work.
