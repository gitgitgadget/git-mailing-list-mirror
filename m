From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH 2/4] Improve cached content header of status output
Date: Mon, 8 Jan 2007 15:27:31 +0100
Message-ID: <17826.21715.925000.540592@lapjr.intranet.kiel.bmiag.de>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
	<11677659921833-git-send-email-j.ruehle@bmiag.de>
	<459E2E57.6020503@shadowen.org>
	<7vr6u9g1l4.fsf@assigned-by-dhcp.cox.net>
	<459E4F2D.4000806@shadowen.org>
	<17822.34697.691000.253492@lapjr.intranet.kiel.bmiag.de>
	<7vk601fh7k.fsf@assigned-by-dhcp.cox.net>
	<45A24709.9090904@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 15:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3vTc-0002gN-JY
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 15:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbXAHO1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 09:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbXAHO1t
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 09:27:49 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:44406 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbXAHO1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 09:27:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 630B83AF22;
	Mon,  8 Jan 2007 15:27:45 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11796-10; Mon, 8 Jan 2007 15:27:45 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id C2B363AF21;
	Mon,  8 Jan 2007 15:27:40 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 423543ADCC;
	Mon,  8 Jan 2007 15:27:40 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13555-08; Mon, 8 Jan 2007 15:27:37 +0100 (CET)
Received: from LAPJR (lapjr.intranet.kiel.bmiag.de [10.191.7.182])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 5D4903ADCA;
	Mon,  8 Jan 2007 15:27:35 +0100 (CET)
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45A24709.9090904@shadowen.org>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36265>

Andy Whitcroft writes:
 > Junio C Hamano wrote:
 > > Juergen Ruehle <j.ruehle@bmiag.de> writes:
 > >> Does this better reflect that git tracks content and not files?
 > >>
 > >> # Changes to these files will be committed:
 > >>
 > >> # Changes to these files are not marked for commit:
 > > 
 > > One of the goals is to find a pair of messages that make sense
 > > when the same file appears on both lists.
 > 
 > Doh, double changes ... yes.
 > 
 > I am not sure it is possible to sanely textualise that subtlety in a
 > single line.  I wonder if its worth splitting this lot into three.
 > Basically those files on list one, those on list two and those on both.
 > 
 > Anyhow, lets see if we can textualise:
 > 
 > # Changes to these files will be committed:
 > 
 > # The latest changes to these files will not be committed:
 > 
 > The first here still implies its the latest changes.  I can not
 > trivially word round that.  Perhaps we could mention staging?
 > 
 > # Staged changes for these files will be commited:
 > 
 > # These files have unstaged changes which will not be committed:
 > 
 > >> BTW: how about also adding a hint how to review the changes in
 > >> question (i.e. diff --cached and diff; as an alternative to diff
 > >> --cached we could just advertise the --verbose switch to status and
 > >> commit).
 > > 
 > > Sounds sane.

Together with an appropriate second line it is looking good to me

# Staged changes for these files will be commited:
#   (use --verbose to review and "git reset HEAD <file>..." to unstage)

# These files have unstaged changes which will not be committed:
#   (Use "git diff" to review and "git add <file>..." to stage for commit)

Perhaps we do not even need to mention files?

# Staged changes to be commited:
#   (use --verbose to review and "git reset HEAD <file>..." to unstage)

# Unstaged changes to the working directory which will not be committed:
#   (Use "git diff" to review and "git add <file>..." to stage for commit)
