From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: No trailing newline and bogus conflicts
Date: Tue, 18 Jul 2006 14:39:48 +1200
Message-ID: <46a038f90607171939l21d986efgca1cadf0817c0229@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 18 04:40:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2fVB-0000Gr-Th
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 04:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWGRCju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 22:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWGRCju
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 22:39:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59563 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751097AbWGRCjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 22:39:49 -0400
Received: by ug-out-1314.google.com with SMTP id o2so1072319uge
        for <git@vger.kernel.org>; Mon, 17 Jul 2006 19:39:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GdRS9eNc6BCYvPsF2Gyy/VaUToB6Lk4rzVy/jG7U/DsQxYl7rs43qwBeZ4ZMH8ClTm2G7lMsZg1f0xX6GV5lY6Ujk82XmelwH8+TVl+cSI04E/Db+UXfIw/QQ0InTy5EY7AhFZtQ7tn/DvO1OObYWwQMojJqNNNrdwuyxFAEhTM=
Received: by 10.78.193.5 with SMTP id q5mr1230776huf;
        Mon, 17 Jul 2006 19:39:48 -0700 (PDT)
Received: by 10.78.120.18 with HTTP; Mon, 17 Jul 2006 19:39:48 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23990>

Hi!

I am seem to be having problems merging and cherry-picking patches on
files that have no trailing newlines. Not having a trailing newline is
bad style, but some (arguably braindead) languages and text file
formats actually expect it. (Alas, to be burdened with PHP syntax.)

I may be doing something wrong, but I've had two merges in a row where
git seemed to think that there was conflict or different at the bottom
of the file, where there wasn't.

For example if you clone
http://git.catalyst.net.nz/git/moodle.git#mdl-artena-tairawhiti
(~180MB) and you look around these two merges:

  bae5c70f0dc97d1c5a59ec2c9278d06f7427db71
  bcfc1924516baa48d6e07eb125a1cb4f39d76dfa

you will see that I cherry-picking patches to auth/db/lib.php --
however I forgot one patch and tried to fix things up in a branch and
merge it in. The last line, though identical, was always reported as
"different" between the 2 files when I was resolving bcfc19.

And later, when working on bae5c, I suspect I shouldn't have seen a
conflict, as both sides had changed exactly the same.

Any ideas other than dropping PHP?


martin
