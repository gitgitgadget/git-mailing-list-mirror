From: "Murphy, John" <john.murphy@bankofamerica.com>
Subject: Problem packing repository
Date: Mon, 27 Jul 2009 11:31:39 -0400
Message-ID: <F635344B8FC01740B0AA69090F092E9B01669B3C@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 17:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVSOg-0002I8-IC
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 17:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbZG0Ppp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 11:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbZG0Ppp
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 11:45:45 -0400
Received: from vamx02.bankofamerica.com ([171.159.192.79]:53589 "EHLO
	vadmzmailmx02.bankofamerica.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732AbZG0Ppo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2009 11:45:44 -0400
X-Greylist: delayed 840 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2009 11:45:44 EDT
Received: from vadmzmailmx03.bankofamerica.com ([171.182.200.79])
	by vadmzmailmx02.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n6RFVhHF005570
	for <git@vger.kernel.org>; Mon, 27 Jul 2009 15:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bankofamerica.com;
	s=corp1; t=1248708704;
	bh=gffzgo2mV64R+8dY6vWDtggCkx8hptVTkioCoLhHKBI=;
	h=Date:From:Subject:To:Message-id:MIME-version:Content-type:
	 Content-transfer-encoding;
	b=V7jInjf2hdjEP2T1HR47xDsH/ntCVLHAcpuIAXXVyQbs6QksqB4oya4jyr27IMeAT
	 tEohJFvqKoKxrfoNpwFOQvV0RR3s0J0xdF6w91PBxB+7rx8/xhY03uW8acLq7Env4m
	 LYvCZh35ZyINaC7+QGTaeOFWbfiIqLJhQcAsyb2w=
Received: from memva2mta01.bankofamerica.com (memva2mta01.bankofamerica.com [171.186.140.73])
	by vadmzmailmx03.bankofamerica.com (8.13.8/8.13.6) with ESMTP id n6RFVgdk010163
	for <git@vger.kernel.org>; Mon, 27 Jul 2009 15:31:43 GMT
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Thread-topic: Problem packing repository
Thread-index: AcoOz1WKoxCg3DUwR3uI2hbxNE9Xbw==
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-OriginalArrivalTime: 27 Jul 2009 15:31:40.0311 (UTC) FILETIME=[56580A70:01CA0ECF]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-07-27_05:2009-07-24,2009-07-27,2009-07-27 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124170>

I thought I resolved this problem with an upgrade to version
1.6.3.2.306.g4f4fa

I am getting this from git-gc in repositories that alternates:

usage: git-pack-objects [{ -q | --progress | --all-progress }] 
        [--max-pack-size=N] [--local] [--incremental] 
        [--window=N] [--window-memory=N] [--depth=N] 
        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] 
        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*]
[--reflog] 
        [--stdout | base-name] [--include-tag] 
        [--keep-unreachable | --unpack-unreachable] 
        [<ref-list | <object-list]


I tried running with GIT_TRACE=2 and I do not see anything glaring.

sudo -u git -s 'export
GIT_DIR='/docbuilder/git/repos/aimcore.git';export GIT_TRACE=2;git gc'
trace: built-in: git 'gc'
trace: run_command: 'reflog' 'expire' '--all'
trace: exec: 'git' 'reflog' 'expire' '--all'
trace: built-in: git 'reflog' 'expire' '--all'
trace: run_command: 'repack' '-d' '-l' '-A'
trace: exec: 'git' 'repack' '-d' '-l' '-A'
trace: exec: 'git-repack' '-d' '-l' '-A'
trace: built-in: git 'rev-parse' '--parseopt' '--' '-d' '-l' '-A'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'config' '--bool' 'repack.usedeltabaseoffset'
trace: built-in: git 'pack-objects' '--honor-pack-keep' '--non-empty'
'--all' '--reflog' '--unpack-unreachable' '--local'
'--delta-base-offset'
'/docbuilder/git/repos/aimcore.git/objects/.tmp-13099-pack'
usage: git-pack-objects [{ -q | --progress | --all-progress }] 
        [--max-pack-size=N] [--local] [--incremental] 
        [--window=N] [--window-memory=N] [--depth=N] 
        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] 
        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*]
[--reflog] 
        [--stdout | base-name] [--include-tag] 
        [--keep-unreachable | --unpack-unreachable] 
        [<ref-list | <object-list]
error: failed to run repack
