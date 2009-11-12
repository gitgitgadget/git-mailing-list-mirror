From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: git status internals and line endings
Date: Thu, 12 Nov 2009 21:32:14 +0100
Message-ID: <4AFC70CE.5020106@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 21:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8gkd-0008S0-IO
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 21:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbZKLU6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 15:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbZKLU6b
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 15:58:31 -0500
Received: from syntevo.com ([85.214.39.145]:47485 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574AbZKLU6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 15:58:30 -0500
X-Greylist: delayed 1580 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2009 15:58:30 EST
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id A7BAD37CA4F
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132800>

I'm trying to figure out under which circumstances changes in line
endings are resulting in 'modified' status (resp. will be committed). I
have three files with the same content, differing only in line endings:

- file1 is committed with CRLF and has LF in working tree
- file2 is committed with CRLF and has CRLF in working tree
- file3 is committed with LF and has CRLF in working tree

On Linux, file1 and file3 are reported as modified -- as I would expect.
The surprise is on Windows: here only file1 is reported as modified. Why
not file3? Btw, 'git hash-object file3' reports the same SHA as for the
LF-only content in the repository (not so on Linux, as expected).

Is this some special handling on Windows (and possibly on Mac OS)? In
this case, can someone please point me to the corresponding code part?
Thanks for any comments regarding this topic.

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com
