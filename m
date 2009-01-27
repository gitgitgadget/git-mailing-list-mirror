From: Sverre Rabbelier <alturin@gmail.com>
Subject: git-am annoyance
Date: Tue, 27 Jan 2009 23:07:14 +0100
Message-ID: <bd6139dc0901271407i4406d5e6u6db1df9e5a7bdc4f@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:08:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRw6t-0002VN-TL
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbZA0WHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbZA0WHS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:07:18 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:27138 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZA0WHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:07:16 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2880138yxm.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 14:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=/QDrGkPyC4MPtSVuDE9gnyCcyYeKjYmnFT3fQfdSJBc=;
        b=pX0wHMKpWSzPE4ZDpSht3drR4IvnZIe0uMz0bgpV3kLZJjFMXjVzdEzHVa4yzTUXTD
         Z4IMs7hbIJ1tJXDR1nbtjKq2JLv4o9pTWvT0viX7oOAlfwrhm3qMIwQ3oEN3bJM/CXZT
         EKYLo8jwdvG8OzSHJ2VCzgWf/YNyhTS0AZ488=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=KCxNP0shE72jwSRKj6oQ5mlUO4SGqePAospngO+G/jtm4MMQsS7bxX1uMPn/Pl4nJF
         /axw6vVfxFPgvromiDqfqZ/SRZtlkRkzh+hEWrMJMwqm91tBjlrmihKDFUe/+Ndkfc6M
         TipNuHCSj/i1WcBe01KD9k5iLHHa8IwgWrv1s=
Received: by 10.150.96.10 with SMTP id t10mr445607ybb.213.1233094034339; Tue, 
	27 Jan 2009 14:07:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107394>

Heya,

Observe what happens if, on accident, rather than running a alias
(amendall), the 'tab' didn't catch on:
$ git am
^C
$ # ok, now what do I do?
$ git status
# On branch checker-caching
nothing to commit (working directory clean)
$ # looks like everything is ok, great
$ # ... some time later
$ # same thing happens
$ git am
cat: /home/sverre/code/Melange/.git/rebase-apply/next: No such file or directory
cat: /home/sverre/code/Melange/.git/rebase-apply/utf8: No such file or directory
cat: /home/sverre/code/Melange/.git/rebase-apply/keep: No such file or directory
cat: /home/sverre/code/Melange/.git/rebase-apply/threeway: No such
file or directory
cat: /home/sverre/code/Melange/.git/rebase-apply/apply-opt: No such
file or directory
cat: /home/sverre/code/Melange/.git/rebase-apply/sign: No such file or directory
cat: /home/sverre/code/Melange/.git/rebase-apply/next: No such file or directory
/usr/local/libexec/git-core//git-am: line 319: test: : integer
expression expected
/usr/local/libexec/git-core//git-am: line 326: test: : integer
expression expected
$ # whoops?!

Wouldn't it be nice if "git am" without any arguments just prints a
usage message? Either that, or provides you with a way to bail out? Or
if it'd clean up after itself so that it doesn't crash?

-- 
Cheers,

Sverre Rabbelier
