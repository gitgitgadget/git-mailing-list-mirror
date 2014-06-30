From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Git log --show-signature breaks --graph formatting
Date: Mon, 30 Jun 2014 13:54:20 -0400
Organization: PD Inc
Message-ID: <EFDBC38B50004650A7BA9E8FB6A7F855@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:54:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1fmZ-00059P-8p
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 19:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452AbaF3RyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 13:54:16 -0400
Received: from mail.pdinc.us ([67.90.184.27]:33882 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756679AbaF3RyL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 13:54:11 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5UHsA4l015950
	for <git@vger.kernel.org>; Mon, 30 Jun 2014 13:54:10 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac+UjFFzSKn7RWJ3QcCf0UF9xeJPug==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252696>

It looks like the gpg output is not parsed to prefix the correct number of
spaces. What interests me the most is the folowing line is also wrong.

$ git log  --graph
*   commit 258e0a237cb69aaa587b0a4fb528bb0316b1b776
|\  Merge: 727c355 1ca13ed
| | Author: Jason Pyeron <jpyeron@pdinc.us>
| | Date:   Mon Jun 30 13:22:29 2014 -0400
| |
| |     Merge of 1ca13ed2271d60ba93d40bcc8db17ced8545f172 branch - rebranding
| |
| * commit 1ca13ed2271d60ba93d40bcc8db17ced8545f172
| | Author: Stephen R Guglielmo <srg@guglielmo.us>
| | Date:   Mon Jun 23 09:45:27 2014 -0400
| |
| |     Minor URL updates
| |
| * commit d8587c43cfdb12343524ce117a4a59726c438925
| | Author: Stephen R Guglielmo <srg@guglielmo.us>
| | Date:   Tue Jun 17 12:58:23 2014 -0400
| |
| |     One final 'foundation' reference. Also fix a string length for the
rescue disk.
| |
| * commit 49ecdfd874029ea287d2755f7e0d5188ce49e81a
| | Author: Stephen R Guglielmo <srg@guglielmo.us>
| | Date:   Tue Jun 17 12:44:36 2014 -0400


$ git log --show-signature --graph
*   commit 258e0a237cb69aaa587b0a4fb528bb0316b1b776
|\  gpg: Signature made Mon, Jun 30, 2014 13:22:33 EDT using RSA key ID DA0848AD
gpg: Good signature from "Jason Pyeron <jpyeron@pdinc.us>"
Merge: 727c355 1ca13ed
| | Author: Jason Pyeron <jpyeron@pdinc.us>
| | Date:   Mon Jun 30 13:22:29 2014 -0400
| |
| |     Merge of 1ca13ed2271d60ba93d40bcc8db17ced8545f172 branch - rebranding
| |
| * commit 1ca13ed2271d60ba93d40bcc8db17ced8545f172
| | gpg: Signature made Mon, Jun 23, 2014  9:45:47 EDT using RSA key ID DD3766FF
gpg: Good signature from "Stephen Robert Guglielmo <srg@guglielmo.us>"
gpg:                 aka "Stephen Robert Guglielmo <srguglielmo@gmail.com>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 0D54 BE6A B832 8701 AA94  9036 2D15 C7B0 DD37 66FF
Author: Stephen R Guglielmo <srg@guglielmo.us>
| | Date:   Mon Jun 23 09:45:27 2014 -0400
| |
| |     Minor URL updates
| |
| * commit d8587c43cfdb12343524ce117a4a59726c438925
| | gpg: Signature made Tue, Jun 17, 2014 12:58:30 EDT using RSA key ID DD3766FF
gpg: Good signature from "Stephen Robert Guglielmo <srg@guglielmo.us>"
gpg:                 aka "Stephen Robert Guglielmo <srguglielmo@gmail.com>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 0D54 BE6A B832 8701 AA94  9036 2D15 C7B0 DD37 66FF
Author: Stephen R Guglielmo <srg@guglielmo.us>
| | Date:   Tue Jun 17 12:58:23 2014 -0400
| |
| |     One final 'foundation' reference. Also fix a string length for the
rescue disk.
| |
| * commit 49ecdfd874029ea287d2755f7e0d5188ce49e81a
| | gpg: Signature made Tue, Jun 17, 2014 12:44:43 EDT using RSA key ID DD3766FF
gpg: Good signature from "Stephen Robert Guglielmo <srg@guglielmo.us>"
gpg:                 aka "Stephen Robert Guglielmo <srguglielmo@gmail.com>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 0D54 BE6A B832 8701 AA94  9036 2D15 C7B0 DD37 66FF
Author: Stephen R Guglielmo <srg@guglielmo.us>
| | Date:   Tue Jun 17 12:44:36 2014 -0400
| |
| |     Should be done!

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
