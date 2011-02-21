From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to recovery a corrupted git repo
Date: Mon, 21 Feb 2011 16:31:02 +0100
Message-ID: <vpqipwds8uh.fsf@bauges.imag.fr>
References: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
	<20110221100454.GM22168@axel> <vpqpqql1lw6.fsf@bauges.imag.fr>
	<AANLkTim-O+LR_r=N6y7Dcip8xQGcBVP2FiVhu22Zhysf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 16:31:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrXjH-0005Ox-DT
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 16:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469Ab1BUPbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 10:31:09 -0500
Received: from mx1.imag.fr ([129.88.30.5]:39735 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335Ab1BUPbI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 10:31:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p1LFV0WM013742
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Feb 2011 16:31:00 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PrXj4-0001cj-Ae; Mon, 21 Feb 2011 16:31:02 +0100
In-Reply-To: <AANLkTim-O+LR_r=N6y7Dcip8xQGcBVP2FiVhu22Zhysf@mail.gmail.com> (Ping Yin's message of "Mon\, 21 Feb 2011 23\:03\:55 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Feb 2011 16:31:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1LFV0WM013742
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1298907064.23846@VVXs2NXVMoiAsJQ7Qy4KTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167488>

Ping Yin <pkufranky@gmail.com> writes:

> Thanks. This should be an applicable method. However, before rsyncing,
> the pack should be unpacked first.

No need. Just copying the pack files works too, and is way faster:

/tmp/corrupted$ git fsck
missing commit 4815c2955d5863005edc4ff61c0de42e9609a920
dangling tree c8b826f673e1f1edb0fb5dc58294148be06cd6cb
/tmp/corrupted$ cp ../cloned/.git/objects/pack/pack-e34444a471a9cd3e6f2656b609ffa0d66cce1f9c.* .git/objects/pack/
/tmp/corrupted$ git fsck                                                                                         
/tmp/corrupted$ git gc
Counting objects: 12, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (12/12), done.
Total 12 (delta 0), reused 12 (delta 0)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
