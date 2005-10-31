From: Marcel Holtmann <marcel@holtmann.org>
Subject: Another problem with not existing directories
Date: Mon, 31 Oct 2005 18:20:34 +0100
Message-ID: <1130779234.5848.15.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 31 18:22:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWdKo-0005NN-ER
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 18:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVJaRUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 12:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVJaRUf
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 12:20:35 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:10123 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932475AbVJaRUf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 12:20:35 -0500
Received: from blade (p5487CE7F.dip.t-dialin.net [84.135.206.127])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j9VHKZGB024273
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 31 Oct 2005 18:20:36 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.4.1 
X-Virus-Scanned: ClamAV 0.85.1/1150/Sun Oct 30 12:20:38 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10866>

Hi guys,

I think there exists another problem with git-unpack-objects if the
sub-directory in "objects" doesn't exists.

# cg-push master
updating 'refs/heads/master'
  from 581c1b14394aee60aff46ea67d05483261ed6527
  to   197c190b0b00689074c03fc3ebcfa114dbed1d73
Packing 37 objects
Unpacking 37 objects
unable to write sha1 filename ./objects/dc/59cd72edc7bc6169c2c9c073c86483f9318e7c: No such file or directoryfatal: failed to write object
fatal: git-unpack-objects exited with error code 128

In this case the directory "objects/dc" doesn't exists. Creating it
fixes the problem, but I think they should be created on demand.

Regards

Marcel
