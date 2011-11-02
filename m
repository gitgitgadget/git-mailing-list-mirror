From: =?ISO-8859-15?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: 'git -m' dumps core
Date: Wed, 02 Nov 2011 15:29:08 +0100
Message-ID: <4EB153B4.6070404@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Junio C. Hamano" <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 02 15:29:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLboV-0001Go-2J
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 15:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab1KBO3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 10:29:08 -0400
Received: from mail96.atlas.de ([194.156.172.86]:19307 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365Ab1KBO3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 10:29:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id D8A691009A;
	Wed,  2 Nov 2011 15:29:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id OM7QWDTrS3me; Wed,  2 Nov 2011 15:29:05 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed,  2 Nov 2011 15:29:05 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 2E4802718B;
	Wed,  2 Nov 2011 15:29:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
X-Enigmail-Version: 1.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184633>

$ /usr/local/git-v1.7.8-rc0/bin/git version
git version 1.7.8.rc0

$ /usr/local/git-v1.7.8-rc0/bin/git branch -m
Speicherzugriffsfehler (core dumped)

$ /usr/local/git-v1.7.8-rc0/bin/git branch --move
Speicherzugriffsfehler (core dumped)

GDB says:

(gdb) bt
#0  0xb74694f3 in strlen () from /lib/i686/cmov/libc.so.6
#1  0x0810f1ad in strbuf_branchname (sb=0xbfb20bbc, name=0x0) at sha1_name.c:873
#2  0x0810f20e in strbuf_check_branch_ref (sb=0xbfb20bbc, name=0x0) at sha1_name.c:882
#3  0x080b516a in validate_new_branchname (name=0x0, ref=0xbfb20bbc, force=0, attr_only=0) at branch.c:142
#4  0x080b550c in create_branch (head=0x94e32ab "master", name=0x0, start_name=0x94e32ab "master", force=0, reflog=0, track=BRANCH_TRACK_REMOTE)
    at branch.c:177
#5  0x0805a8fe in cmd_branch (argc=0, argv=0xbfb215f8, prefix=0x0) at builtin/branch.c:729
#6  0x0804ba29 in handle_internal_command (argc=2, argv=0xbfb215f8) at git.c:308
#7  0x0804bc67 in main (argc=2, argv=0xbfb215f8) at git.c:512


Stefan
-- 
----------------------------------------------------------------
/dev/random says: If ignorance is bliss, you must be ecstatic.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
