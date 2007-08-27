From: "Jason Garber" <jgarber@ionzoft.com>
Subject: Advise Requested: Branching, Merging, and Deployment
Date: Mon, 27 Aug 2007 15:59:47 -0500
Message-ID: <E7DE807861E8474E8AC3DC7AC2C75EE5032F00E3@34093-EVS2C1.exchange.rackspace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 00:19:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPmt0-0003tf-V8
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 00:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758224AbXH0WLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Aug 2007 18:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbXH0WLs
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 18:11:48 -0400
Received: from server107a.exghost.com ([207.97.204.37]:3588 "EHLO
	server107.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758266AbXH0WLq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 18:11:46 -0400
X-Greylist: delayed 3604 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2007 18:11:46 EDT
Received: by server107.appriver.com (CommuniGate Pro PIPE 5.1.11)
  with PIPE id 89547496; Mon, 27 Aug 2007 17:04:47 -0400
Received: from [72.32.49.6] (HELO FE2.exchange.rackspace.com)
  by server107.appriver.com (CommuniGate Pro SMTP 5.1.11)
  with ESMTP id 89543132 for git@vger.kernel.org; Mon, 27 Aug 2007 16:59:56 -0400
Received: from 34093-EVS2C1.exchange.rackspace.com ([192.168.1.18]) by FE2.exchange.rackspace.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 27 Aug 2007 15:59:53 -0500
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Advise Requested: Branching, Merging, and Deployment
Thread-Index: Acfo7TPgW8EsAqDLRke4FomQ9hCnvA==
X-OriginalArrivalTime: 27 Aug 2007 20:59:53.0259 (UTC) FILETIME=[37186FB0:01C7E8ED]
X-Policy: GLOBAL
X-Primary: jgarber@ionzoft.com
X-Note: This Email was scanned by AppRiver SecureTide
X-ALLOW: jgarber@ionzoft.com ALLOWED
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 72.32.49.6
X-Note-Reverse-DNS: fe2.exchange.rackspace.com
X-Note-WHTLIST: jgarber@ionzoft.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 70 80 
X-Note: Mail Class: ALLOWEDSENDER
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56884>

Hello,

Time is valuable, so any of it is appreciated.  I'm looking for sound a=
dvice on a good strategy for maximizing git's branching and merging cap=
abilities to assist us in frequent web-app deployments.

--
I am running a project (in git) that has ~20,000 source files and sever=
al full-time developers making changes constantly.  The project is a we=
b-app, so the files are a mix of textual source code and (usually) smal=
l binary files.

We were using Subversion for some time, but eventually the deficiencies=
 (like "svn status =3D=3D 90 seconds" and no merge tracking) caused me =
to look for a better solution.  After a lot of research, I ended up her=
e, and we are in the process of moving all of our projects to git.  Tha=
nks, by the way!

We have always maintained three copies of each project - [Development, =
Preview, Production].  Changes were typically made in Development sites=
 and tested.  Then (manually) copied to the Preview sites and tested.  =
=46inally, they would be manually copied to the Production site.

It becomes very difficult to tell (manually) who changed what line of w=
hat file for each task that needs to be moved into Production.  Some ta=
sks are long-running, some are short, but in general, it's a mess.

This is quite different from traditional software development where rel=
eases are done on a more "predictable" basis.  Unfortunately in our cas=
e, releases are done on a sub-daily basis (yes, I'm working on that).  =
We need a lot of agility in whatever strategy we choose.

--
Here are some requirements:
- Separate change-sets.  Keep track of the changes introduced by each t=
ask separately.
- Have changeset ABC stay in the Preview level for a variable amount of=
 time.
- Create, Preview, and move to Production changeset DEF while changeset=
 ABC sits in the Preview level.
- Developer sanity :)

Here are some intents:
- To maintain a branch called "Production" which represents what is in =
production
- To maintain a branch called "Preview" which represents what is being =
previewed


Any help is greatly appreciated.

--
Best Regards,
=A0
Jason Garber
Senior Systems Engineer
IonZoft, Inc.
=A0
(814) 941-2390
jgarber@ionzoft.com
=A0
=A0
