From: <nolan.ring@emc.com>
Subject: svn2git question:  Build directory inserted at top level?
Date: Wed, 15 Sep 2010 09:47:42 -0400
Message-ID: <4E10ACF241081344B9702AA8C6440440C5B13F2162@MX01A.corp.emc.com>
References: <DDB24DEE-934B-4C8D-8DAA-595905035AC4@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 15 15:48:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvsLP-0000bV-PK
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 15:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab0IONsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 09:48:03 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:59312 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab0IONsB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 09:48:01 -0400
Received: from hop04-l1d11-si01.isus.emc.com (HOP04-L1D11-SI01.isus.emc.com [10.254.111.54])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8FDlxjh032736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 15 Sep 2010 09:47:59 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.221.251]) by hop04-l1d11-si01.isus.emc.com (RSA Interceptor) for <git@vger.kernel.org>; Wed, 15 Sep 2010 09:47:55 -0400
Received: from corpussmtp3.corp.emc.com (corpussmtp3.corp.emc.com [10.254.169.196])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8FDlnm6022630
	for <git@vger.kernel.org>; Wed, 15 Sep 2010 09:47:55 -0400
Received: from mxhub02.corp.emc.com ([10.254.141.104]) by corpussmtp3.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 15 Sep 2010 09:47:47 -0400
Received: from MX01A.corp.emc.com ([169.254.1.232]) by mxhub02.corp.emc.com
 ([10.254.141.104]) with mapi; Wed, 15 Sep 2010 09:47:47 -0400
Thread-Topic: svn2git question:  Build directory inserted at top level?
Thread-Index: ActU1VMpeXCyNvqdQCKR4S7dkabhLgABX0MA
In-Reply-To: <DDB24DEE-934B-4C8D-8DAA-595905035AC4@jetbrains.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 15 Sep 2010 13:47:47.0963 (UTC) FILETIME=[950174B0:01CB54DC]
X-EMM-MHVC: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156237>

All,

I'm converting repositories from svn to git using svn2git.  I have a repo with the following hierarchy:

trunk/
dist/
tags/
branches/
REbranches/

Ultimately I want to convert everything except the dist directory but am trying to understand what svn2git is doing and why.

I ran the command to see what I would get just importing trunk:

svn2git -v --nobranches --notags  http://poc.emc.com/repos/POCcs

After the conversion completed I had the following:

buildadm@suse-s11:/work/POCcs> ls 
Automation  build_cs_rpm.pl  ControlStation  depends.properties

Then I ran the following command because I wanted to include the branches as well as the trunk in the conversion:

svn2git -v --notags  http://poc.emc.com/repos/POCcs

When I include the branches in the conversion I get a Build directory at the top level and then the usual directory structure of the repo.  Where is the Build dir coming from?  Is svn2git doing that?  Or is it finding that somewhere somehow in the repo?

buildadm@suse-s11:/work/POCcs> ls
Build
buildadm@suse-s11:/work/POCcs/Build> ls
Automation  build_cs_rpm.pl  ControlStation  depends.properties

Thanks for any help.

Nolan
