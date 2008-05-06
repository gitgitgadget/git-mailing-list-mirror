From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: [minor] t1004-read-tree-m-u-wf.sh no more passes when "root"
Date: Tue, 06 May 2008 15:22:30 +0200
Message-ID: <fvpmdn$hq1$1@ger.gmane.org>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 15:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtNEV-00025Y-6s
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 15:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbYEFN2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2008 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbYEFN2i
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 09:28:38 -0400
Received: from main.gmane.org ([80.91.229.2]:45337 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532AbYEFN2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 09:28:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JtNDb-0005ei-M9
	for git@vger.kernel.org; Tue, 06 May 2008 13:28:31 +0000
Received: from ngw.virtuallogix.com ([212.11.48.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 May 2008 13:28:31 +0000
Received: from t2a2e9z8ncbs9qg by ngw.virtuallogix.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 May 2008 13:28:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ngw.virtuallogix.com
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81359>

Hello,

as I've been used to building and testing Git as root - granted, this=20
goes against what INSTALL guidelines suggest - I have noticed the=20
following : until v1.4.4.4, 'make test' could be successfully run as=20
"root" ; it now (v1.5.5.1) fails on t1004-read-tree-m-u-wf.sh with=20
following output:

* FAIL 13: funny symlink in work tree, un-unlink-able


                 rm -fr a b &&
                 git reset --hard &&

                 git checkout sym-a &&
                 chmod a-w a &&
                 test_must_fail git read-tree -m -u sym-a sym-a sym-b

Meanwhile I have found out that this isn't a problem for me in practice=
,=20
since the test-suite passes when run "as myself", still I report this i=
n=20
case it could be a clue for something more serious...

Thanks,
J=E9r=F4me
