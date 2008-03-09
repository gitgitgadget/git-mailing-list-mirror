From: Simon Fraser <smfr@mac.com>
Subject: Parsing diff --git lines
Date: Sat, 8 Mar 2008 17:48:30 -0800
Message-ID: <F4D3B820-CCF4-4212-BF32-700EFD448143@mac.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 02:57:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYAmc-0000Rv-KT
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 02:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbYCIB4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 20:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbYCIB4D
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 20:56:03 -0500
Received: from smtpoutm.mac.com ([17.148.16.80]:62691 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbYCIB4C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 20:56:02 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Mar 2008 20:56:02 EST
Received: from mac.com (asmtp009-s [10.150.69.72])
	by smtpoutm.mac.com (Xserve/smtpout017/MantshX 4.0) with ESMTP id m291mWqa023061
	for <git@vger.kernel.org>; Sat, 8 Mar 2008 17:48:32 -0800 (PST)
Received: from [192.168.1.205] (netblock-68-183-25-67.dslextreme.com [68.183.25.67])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp009/MantshX 4.0) with ESMTP id m291mUK9028184
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 8 Mar 2008 17:48:31 -0800 (PST)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76629>

I'm working on a GUI for git, and I'd like to be able to provide
some diff navigation tools. That requires that I can find the
file chunks in a diff, and parse out the file names.

However, I don't see a reliable way to identify the two files
from a "diff --git" line. Here's a (deliberately pathological)
example:

diff --git a/a / b/file with spaces.txt b/a / b/file with spaces.txt

In this case, the repository contains directories called "a " and
" b" and the file names have spaces in.

What would make this possible would be either to always quote
file paths containing spaces, or use a character other than
a space (e.g. a \t) between the two file names.

Thanks
Simon

