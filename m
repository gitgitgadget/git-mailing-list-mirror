From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: http-smart-backend: can clone, cannot push
Date: Tue, 1 Jun 2010 14:28:21 +0200
Message-ID: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 14:28:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJQa7-0002UI-2j
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 14:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111Ab0FAM2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 08:28:24 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:58680 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab0FAM2X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 08:28:23 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id EF2D737E59; Tue,  1 Jun 2010 14:28:21 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 9FDA137E42
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 14:28:21 +0200 (CEST)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 927CE37E48
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 14:28:21 +0200 (CEST)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148110>

Hello,

	I've set up a directory to serve git repos under /var/www/git using:

	- apache2
	- git 1.7.1
	
	The apache config file is literally pasted from the http-smart-backend documentation, modified for my installation. I clone successfully over https using the smart backend. I know this because when you use the smart backend you get this type of message:

	git clone https://git.pelagicore.net/var/www/git/administrivia.git
	Initialized empty Git repository in /home/jeremiah/administrivia/.git/
	remote: Counting objects: 69, done.
	remote: Compressing objects: 100% (47/47), done.
	remote: Total 69 (delta 15), reused 0 (delta 0)
	Unpacking objects: 100% (69/69), done.

	As opposed to a more terse message when using a 'dumb' http transport.

	I cannot push however. This is what git says:
	
	$ ~/administrivia >  git push origin master
	error: Cannot access URL https://git.pelagicore.net/var/www/git/administrivia.git/, return code 22
	fatal: git-http-push failed

	And this is what the logs say:

	[Tue Jun 01 14:25:54 2010] [error] [client 109.74.195.212] Request not supported: '/var/www/git/administrivia.git/'

	How is that I can clone with the smart transport, and not push?

Thanks,

Jeremiah