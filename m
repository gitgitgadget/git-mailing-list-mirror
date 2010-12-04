From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] t9143: do not fail when unhandled.log.gz is not created
Date: Sat, 04 Dec 2010 12:37:01 +0100
Message-ID: <4CFA27DD.7030105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: normalperson@yhbt.net, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 04 12:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POqQt-0003Ky-Kr
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 12:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab0LDLhF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Dec 2010 06:37:05 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:54357 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab0LDLhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 06:37:04 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4795618B7E817;
	Sat,  4 Dec 2010 12:37:02 +0100 (CET)
Received: from [213.64.3.195] (helo=birne.lan)
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1POqQI-0000Ov-00; Sat, 04 Dec 2010 12:37:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX19CwgSZsJIsKJZQiXk91fNcygEVllcp12PVlGeE
	JyGWCPcB3XV3jwEUkSuwhSExfH2STgiJNaJcAk6LgBdrI03XRR
	ddXhJeqkM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162891>

t9143 fails on my system because a unhandled.log.gz is created,
even if perls Compress::Zlib is missing.
Instead of relying on svn using perl and its Zlib to generate
a .gz file, simply check if the .gz file had been created.
Now we do not depend on internal implementation details of svn.
And the code is 3% easier to understand :-)

*** BLURB HERE ***

Torsten B=C3=B6gershausen (1):
   t9143: do not fail when unhandled.log.gz is not created

  t/t9143-git-svn-gc.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
