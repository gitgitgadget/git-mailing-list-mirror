From: Tim McCormack <cortex@brainonfire.net>
Subject: gitk does not reload tag messages
Date: Thu, 6 Sep 2012 14:17:52 -0400
Message-ID: <MTAwMDAxMC50aW1tYw.1346955478@quikprotect>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 21:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9hMS-0000IB-T1
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 21:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758856Ab2IFTD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 15:03:26 -0400
Received: from out.packetderm.com ([96.39.53.27]:49806 "EHLO
	out.packetderm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab2IFTDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 15:03:25 -0400
X-Greylist: delayed 2723 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2012 15:03:25 EDT
Received: from localhost (localhost[127.0.0.1])
        (authenticated bits=0)
        by smtp (5.7.4/5.7.4) with ESMTP id q86IHvu0042268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <git@vger.kernel.org>; Thu, 6 Sep 2012 14:17:58 -0400 (EDT)
        (envelope-from cortex@brainonfire.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204915>

If a tag that gitk knows about is deleted and recreated with a
different message, gitk still shows the old message after any
combination of refresh, reload, and reread refs.

git-gui version 0.13.0.8.g8f85

Reproduce:
1. git tag -a test -m "foo" HEAD
2. Open gitk, see that correct message ("foo") is present for tag "test"
3. git tag -d test
4. Reload/refresh gitk [optional, it won't make a difference]
5. git tag -a test -m "bar" HEAD
6. Reload/refresh gitk
7. See that the message on tag "test" is still "foo"
8. $ git show test # shows correct message "bar"

Apologies if this is an old version or a known bug; I could not find an
issue tracker to search, although I did check the gmane archives.

 - Tim McCormack
