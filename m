From: "O'Connell, Ken" <Ken.O'Connell@cognex.com>
Subject: credentials are being erased from credential manager via git
 credential-wincred erase command
Date: Wed, 13 Apr 2016 18:49:55 +0000
Message-ID: <58eced84663c4ef38a63811d3367acf2@USNAEXCP1.pc.cognex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 20:59:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqQ14-0002Kg-6n
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 20:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbcDMS7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 14:59:50 -0400
Received: from mx2.cognex.com ([198.232.29.14]:42376 "EHLO mx2.cognex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932195AbcDMS7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2016 14:59:49 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2016 14:59:49 EDT
Received: from galileo.cognex.com ([10.10.128.32])
  by mx2.cognex.com with ESMTP; 13 Apr 2016 14:49:55 -0400
Received: from USNAEXCP1.pc.cognex.com (alt1adc1pip [10.10.128.111])
	by galileo.cognex.com (8.14.3/8.14.3) with ESMTP id u3DIntkD008860
	for <git@vger.kernel.org>; Wed, 13 Apr 2016 14:49:55 -0400 (EDT)
Received: from USNAEXCP1.pc.cognex.com (10.3.160.221) by
 USNAEXCP1.pc.cognex.com (10.3.160.221) with Microsoft SMTP Server (TLS) id
 15.0.1044.25; Wed, 13 Apr 2016 14:49:55 -0400
Received: from USNAEXCP1.pc.cognex.com ([fe80::68cd:1954:c52f:3d03]) by
 USNAEXCP1.pc.cognex.com ([fe80::68cd:1954:c52f:3d03%21]) with mapi id
 15.00.1044.021; Wed, 13 Apr 2016 14:49:55 -0400
Thread-Topic: credentials are being erased from credential manager via git
 credential-wincred erase command
Thread-Index: AdGVsxU+hA9S6U1qQF+GqVcpmNOQrA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.3.128.111]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291477>

Good afternoon,

My company setup wincred for management of our git/stash user credentials for our automated build scripts. It works great for days, sometimes a couple weeks. 
Then one day build haven't run and we discover the scripts are randomly found at a user prompt awaiting stash user credentials. 

We look at Windows Credential Manager store in Windows and find the Stash user credentials are erased from Credential Manager! 

We discovered via GIT_TRACE, that the command used to retrieve the credentials, is being followed up by a git command to erase the credentials. -not all the time, but seemingly in a random way.
Looking at the trace logs on one server, we see the following commands:
'git-remote-https' 'origin' https://stash-server/bla/bla/bla.git
'git-credential-wincred' 'get'
'git credential-wincred erase'

Do you have ideas on how to track down the root cause of why this command is running?  

Info:
Windows 7 machines
Git version 1.9.5-msysgit, and Git 2.7.4 windows (on one machine to see if upgrading helped) -it did not.
Stash version 3.11.2

Please let me know if I can get any more information to help diagnose.
Thanks,
-Ken
