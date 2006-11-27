X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,
	MSGID_FROM_MTA_HEADER,SPF_SOFTFAIL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Some tips for doing a CVS importer
Date: Mon, 27 Nov 2006 12:29:06 +0100
Message-ID: <456ACC02.6090508@alum.mit.edu>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>	 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>	 <9e4733910611201753m392b5defpb3eb295a075be789@mail.gmail.com>	 <456969DA.6090702@gmx.net> <9e4733910611260735g2b18e9d1p51a0dca153282cc7@mail.gmail.com> <4569BCB8.9030809@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 11:29:41 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061117 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <4569BCB8.9030809@gmx.net>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32411>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goeg6-0003Ev-5R for gcvg-git@gmane.org; Mon, 27 Nov
 2006 12:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758059AbWK0L3L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 06:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758064AbWK0L3L
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 06:29:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:39827 "EHLO
 einhorn.in-berlin.de") by vger.kernel.org with ESMTP id S1758059AbWK0L3K
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 06:29:10 -0500
Received: from [192.168.100.152] ([212.222.128.142]) (authenticated bits=0)
 by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id kARBT7vP017845
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT); Mon, 27
 Nov 2006 12:29:07 +0100
To: Marko Macek <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org

Marko Macek wrote:
>> Another note for doing a converter. When combining things into change
>> sets, for git import the comments in the branches should not be mixed
>> between branches and the trunk when detecting change set. Git doesn't
>> allow simultaneous commits to the trunk and branches.
> 
> Yup, this is the current problem I'm facing now. Even for CVS->SVN
> conversion,
> I don't want to see multi-branch commits.

To avoid multi-branch commits, you have to start cvs2svn with an
--options file, and in the options file set

ctx.cross_project_commits = False

