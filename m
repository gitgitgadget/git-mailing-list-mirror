From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: git history and file moves
Date: Fri, 24 Oct 2008 15:01:40 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308580AA80062@orsmsx503.amr.corp.intel.com>
References: <1224640967.14280.0.camel@minggr.sh.intel.com>
	 <81b0412b0810220419q43f6985fs1c608e3d3cbcf8f3@mail.gmail.com>
	 <48FF1EDB.8010503@drmicha.warpmail.net>
	 <4911F71203A09E4D9981D27F9D8308580AA7FFFB@orsmsx503.amr.corp.intel.com>
 <81b0412b0810241443t75e2022fg984df400585cb254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Lin, Ming M" <ming.m.lin@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:03:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtUkE-0006gF-2U
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbYJXWBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755168AbYJXWBp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:01:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:1305 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887AbYJXWBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 18:01:44 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 24 Oct 2008 14:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.33,480,1220252400"; 
   d="scan'208";a="352097635"
Received: from unknown (HELO azsmsx601.amr.corp.intel.com) ([10.2.121.193])
  by orsmga002.jf.intel.com with ESMTP; 24 Oct 2008 15:01:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.226.213) by
 azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server (TLS)
 id 8.1.311.2; Fri, 24 Oct 2008 15:01:43 -0700
Received: from orsmsx503.amr.corp.intel.com ([10.22.226.47]) by
 orsmsx601.amr.corp.intel.com ([10.22.226.213]) with mapi; Fri, 24 Oct 2008
 15:01:42 -0700
Thread-Topic: git history and file moves
Thread-Index: Ack2IYYoQl4EnTVfTwy1baK8G1DinQAAf9XQ
In-Reply-To: <81b0412b0810241443t75e2022fg984df400585cb254@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99071>

What we are seeing is an issue after we do a file move to a new directory. Once moved, the previous history of the file is not readily available. One needs to know to use --follow on the command line, and worse, gitweb does not show the full history at all.

We have almost a decade of history on the project, from several different source control systems. We often find it useful to go back and find out when something changed, so we want to keep it and have it easily available.

>-----Original Message-----
>From: Alex Riesen [mailto:raa.lkml@gmail.com]
>Sent: Friday, October 24, 2008 2:43 PM
>To: Moore, Robert
>Cc: Michael J Gruber; Lin, Ming M; git@vger.kernel.org
>Subject: Re: git history and file moves
>
>2008/10/24 Moore, Robert <robert.moore@intel.com>:
>> Here's what we have:
>>
>> /var/www/cgi-bin/gitweb.acpica/gitweb.conf
>>
>> Containts this : GITWEB_CSS = "/icons/gitweb.css";
>>
>> What should we add to automatically get all file history?
>>
>
>Nothing. It is the default. You can change the variable Michael
>mentioned to use "-M -M -C -C" but it is very-very slow on any
>kind of history worth its commits.
>
>And you almost never talk about _file_ history in Git. It is all
>_project_ history, filtered for commits which touch the file you're
>interested in at the moment of looking.
