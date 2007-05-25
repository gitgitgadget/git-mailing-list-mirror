From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on MinGW problem
Date: Fri, 25 May 2007 13:07:15 +0200
Organization: eudaptics software gmbh
Message-ID: <4656C363.FF9835E5@eudaptics.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
	 <4656A304.AF39A0B6@eudaptics.com> <Pine.LNX.4.64.0705251113280.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 13:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrXd4-000638-3v
	for gcvg-git@gmane.org; Fri, 25 May 2007 13:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbXEYLGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 07:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbXEYLGa
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 07:06:30 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:13423 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbXEYLG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 07:06:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HrXcn-0008N3-4G; Fri, 25 May 2007 13:06:26 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8FD0A54D; Fri, 25 May 2007 13:06:24 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.035
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48359>

Johannes Schindelin wrote:
> On Fri, 25 May 2007, Johannes Sixt wrote:
> > * perl scripts like git-remote contain a hard-coded path to the
> > installation directory and don't work for this reason.
> 
> GITPERLLIB should be set from the wrapper script, I think.

The clean way is certainly to derive the directory from $0:

use lib $0 =~ /^(.*)([\/\\]+[^\/\\]*){2}$/ ? ("$1/lib") : ();

(although I'm not sure whether this would work during 'make test').

-- Hannes
