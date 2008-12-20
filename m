From: Mark Burton <markb@ordern.com>
Subject: RFC: Change whatchanged to report changes from merges by default?
Date: Sat, 20 Dec 2008 10:42:32 +0000
Organization: Order N Ltd.
Message-ID: <20081220104232.5ff1b7c0@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 11:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDzJL-0002PY-8L
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 11:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbYLTKmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 05:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbYLTKmg
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 05:42:36 -0500
Received: from c2bthomr02.btconnect.com ([213.123.20.120]:26092 "EHLO
	c2bthomr02.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbYLTKmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 05:42:36 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2bthomr02.btconnect.com
	with ESMTP id JNM32590;
	Sat, 20 Dec 2008 10:42:33 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id D7D81190CFB
	for <git@vger.kernel.org>; Sat, 20 Dec 2008 10:42:32 +0000 (GMT)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr02.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090203.494CCC19.0208,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103636>


Hi,

Is it just an accident of history or by design that whatchanged
requires the -m option to show changes introduced by merges but
diff and git log show those changes without requiring any extra
options?

Would it not make more sense to have git whatchanged show the changes
introduced by merges by default and then people can use the (already
supported) --no-merges option to suppress that behaviour?

It appears that just setting rev.ignore_merges to 0 in cmd_whatchanged()
would do the trick. Shall I submit a patch?

Mark
