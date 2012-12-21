From: John Moon <johnmoon77@hotmail.com>
Subject: git diff --ignore-space-at-eol issue
Date: Fri, 21 Dec 2012 10:04:31 -0500
Message-ID: <BLU163-W40634B340214076467C88ECF360@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 16:04:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm49b-0001JE-1x
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 16:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab2LUPEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 10:04:34 -0500
Received: from blu0-omc3-s29.blu0.hotmail.com ([65.55.116.104]:49291 "EHLO
	blu0-omc3-s29.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751352Ab2LUPEc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 10:04:32 -0500
Received: from BLU163-W40 ([65.55.116.72]) by blu0-omc3-s29.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 21 Dec 2012 07:04:32 -0800
X-EIP: [3UHHMuHU6ZE1UnPGRcpz/U2Iyq0OrVBx]
X-Originating-Email: [johnmoon77@hotmail.com]
Importance: Normal
X-OriginalArrivalTime: 21 Dec 2012 15:04:32.0029 (UTC) FILETIME=[7B472CD0:01CDDF8C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211975>


Hi all,

The --ignore-space-at-eol option is ignored when used in conjunction 
with --name-status.
It works fine otherwise.

$ git init
Initialized empty Git repository in /tmp/test/.git/
$ printf "hello\r\n" > test.txt
$git -c core.autocrlf=false add test.txt
$git commit -m.
[master (root-commit) 5c4ce92] .
1 file changed, 1 insertion(+)
create mode 100644 test.txt
$ printf "hello" > test.txt
$ git diff --ignore-space-at-eol test.txt
$ git diff --stat --ignore-space-at-eol test.txt
0 files changed
$ git diff --name-status --ignore-space-at-eol test.txt
M test.txt


Thanks.

 		 	   		  