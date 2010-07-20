From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Automatically exclude hunks from the commit
Date: Tue, 20 Jul 2010 07:36:16 +0200
Message-ID: <51F8E66E-9CDD-466A-8411-38CA8431D8AC@wincent.com>
References: <4C4511C8.8090405@workspacewhiz.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 08:37:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob6SO-0004Un-8Y
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 08:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab0GTGhb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 02:37:31 -0400
Received: from outmail128155.authsmtp.co.uk ([62.13.128.155]:55606 "EHLO
	outmail128155.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754398Ab0GTGha convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 02:37:30 -0400
X-Greylist: delayed 3665 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jul 2010 02:37:30 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt2.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o6K5aNQe007339;
	Tue, 20 Jul 2010 05:36:23 GMT
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o6K5aKdm029806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Jul 2010 06:36:21 +0100 (BST)
Received: from [192.168.1.6] (182.Red-88-3-76.dynamicIP.rima-tde.net [88.3.76.182])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o6K5aHCf027562
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 20 Jul 2010 01:36:19 -0400
In-Reply-To: <4C4511C8.8090405@workspacewhiz.com>
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: bac9d12f-93c0-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH aB4dDEdXdwdEHAkR A2ABWFJeUl8/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNEn5tUGdV Wx4cWxFycUtCcHdw KxQzDXkPXUYsaE9+ EU5JFGxSM3ppbzJN TUBYdQFSdApNdhpE Yh4dAXkdECBDOScx Aw44NjQ1LH1SOC9R Xw0AZVIPR0UQVjAm QBVKATUiVUYCQiAy M3QA
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151306>

El 20/07/2010, a las 05:02, Joshua Jensen escribi=F3:

> I have some files I update frequently where I have some normally comm=
ented out debug code purposely uncommented during development.  Git's h=
unk-level staging saves the day.  I can stage everything but the debug =
code without issue.
>=20
> This got me to thinking.  Is there a better way?  Is there a facility=
 in Git where I could mark a hunk as 'permanently frozen unstaged'?  An=
ything marked as such would never be staged for commit.  I could rest a=
ssured I would never accidentally commit my debug code, be it extra pri=
ntfs or a development server or a password or so on.

A custom pre-commit hook might be of some use here. You could create on=
e which rejects changes which are obviously debug code.

Cheers,
Wincent
