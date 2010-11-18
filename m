From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] t9157-git-svn-fetch-merge.sh: remove dependency on
 subversion 1.5
Date: Thu, 18 Nov 2010 18:35:11 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1011181826560.14285@dr-wily.mit.edu>
References: <1287737937.3785.15.camel@balanced-tree> <1287798958-22549-1-git-send-email-stevenrwalter@gmail.com> <alpine.DEB.2.02.1011181606340.14285@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, normalperson@yhbt.net,
	git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 00:35:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJE0i-00086M-1G
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 00:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759997Ab0KRXfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 18:35:16 -0500
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:55849 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754729Ab0KRXfP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Nov 2010 18:35:15 -0500
X-AuditID: 12074422-b7c3eae000000a70-a6-4ce5b832fbce
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id 8A.A3.02672.238B5EC4; Thu, 18 Nov 2010 18:35:14 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id oAINZDJ3018865;
	Thu, 18 Nov 2010 18:35:14 -0500
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oAINZBPJ025468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 18 Nov 2010 18:35:12 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1011181606340.14285@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161717>

On Thu, 18 Nov 2010, Anders Kaseorg wrote:
> Junio: Did this get lost?  It fixes a test suite regression between 
> v1.7.3.1 and v1.7.3.2 on systems with Subversion 1.4.

Hmm, perhaps I spoke too soon; when I actually run the patched test on an 
Ubuntu 8.04 system, I still get a failure.  Apparently Subversion 1.4 
thinks the manually set svn:mergeinfo properties cause conflicts:

+ svn merge -r5:9 file:///tmp/andersk/git/t/trash directory.t9157-git-svn-fetch-merge/svnrepo/branches/branch2
A    baz
 C   .
+ svn propset svn:mergeinfo /branches/branch1:4-8
/branches/branch2:6-9 .
property 'svn:mergeinfo' set on '.'
+ svn resolved baz
+ svn commit -m merge branch2
svn: Commit failed (details follow):
svn: Aborting commit: '/tmp/andersk/git/t/trash directory.t9157-git-svn-fetch-merge/.git/svn/refs/remotes/git-svn/svn-tree' remains in conflict

Anders
