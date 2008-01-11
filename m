From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Fri, 11 Jan 2008 16:11:13 -0600
Message-ID: <4787E981.7010200@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: drafnel@gmail.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDS6L-00066x-ER
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 23:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760725AbYAKWLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 17:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760383AbYAKWLR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 17:11:17 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58735 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758848AbYAKWLR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 17:11:17 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0BMBDbs022360;
	Fri, 11 Jan 2008 16:11:13 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Jan 2008 16:11:13 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 11 Jan 2008 22:11:13.0356 (UTC) FILETIME=[E0D328C0:01C8549E]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15652001
X-TM-AS-Result: : Yes--3.816600-0-2-1
X-TM-AS-Category-Info: : 2:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTU3MDQyLTcwMDQ3Ni03MDA5?=
	=?us-ascii?B?NzEtNzA5MjUxLTcwNDQzMC03MTE2MjQtNzAxMjMyLTcwNDI1Ny03?=
	=?us-ascii?B?MDI1OTgtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70214>


I got this message from git-commit:

$ git commit -a
<edit message, :wq>
fatal: Out of memory? mmap failed: Bad file descriptor
Create commit <my_prompt_string>

The exit status was 128.
Looks like the commit was successful though.
The partial message 'Create commit ' comes from print_summary()
in builtin-commit.c which is _after_ the actual commit.

$ git --version
git version 1.5.4.rc2.84.gf85fd-dirty

It was compiled with NO_CURL=1. The dirtiness comes from the
patches I submitted for relink earlier today.

The other possible clue is that this repo is on NFS.

-brandon
