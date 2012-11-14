From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git does not understand absolute Win'dos' path
Date: Wed, 14 Nov 2012 10:45:40 +0100
Message-ID: <50A36844.3090000@viscovery.net>
References: <1352884329.28981.YahooMailNeo@web162504.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Martin Lichtin <lichtin@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYZXm-0001ER-CH
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 10:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863Ab2KNJpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 04:45:47 -0500
Received: from so.liwest.at ([212.33.55.23]:23314 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932820Ab2KNJpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 04:45:45 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TYZXR-0007Mo-NP; Wed, 14 Nov 2012 10:45:41 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 433E41660F;
	Wed, 14 Nov 2012 10:45:41 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <1352884329.28981.YahooMailNeo@web162504.mail.bf1.yahoo.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209707>

Am 11/14/2012 10:12, schrieb Martin Lichtin:
> Maven's release plugin prepares a call Git like in this example:
> 
> cmd.exe /X /C "git commit --verbose -F
> C:\cygwin\tmp\maven-scm-915771020.commit pom.xml"
> 
> Git doesn't seem to understand the -F argument and treats it like a
> relative path (relative to the repository root):
> 
> $ cmd.exe /X /C "git commit --verbose -F C:\cygwin\tmp\commit pom.xml" 
> fatal: could not read log file 'mytestdir/C:\cygwin\tmp\commit': No
> such file or directory

According to the code, this should not happen if you are using msysgit.
For this reason, I guess you are using Cygwin git. Right?

I don't know what Cygwin programs are supposed to do if they receive an
argument that looks like a Windows style absolute path.

OTOH, it could be argued that Maven should not treat a Cygwin program like
a DOS program, and it should pass the path in the POSIXy form
/c/cygwin/tmp/commit or /tmp/commit.

-- Hannes
