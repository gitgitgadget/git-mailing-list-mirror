From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Detached HEAD warning (again)
Date: Mon, 30 Mar 2009 17:09:12 +0100
Message-ID: <9099EAF5-6B43-4F15-A905-9E21B45B7AE9@ai.rug.nl>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 18:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoK4f-0001dt-7c
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 18:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbZC3QJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 12:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbZC3QJY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 12:09:24 -0400
Received: from frim.nl ([87.230.85.232]:58360 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451AbZC3QJX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 12:09:23 -0400
Received: from 82-41-227-224.cable.ubr11.sgyl.blueyonder.co.uk ([82.41.227.224] helo=[192.168.50.101])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1LoK35-0007z5-RA
	for git@vger.kernel.org; Mon, 30 Mar 2009 17:09:20 +0100
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115172>

Hi all,

I strongly remember there being a discussion about this a few weeks  
ago, but I
can't find it. Basically, someone wanted to introduce a warning every  
time
someone commits on a detached HEAD. This was shot down because there  
already
is a big warning when you detach your HEAD (with which I agree).

However, someone here: http://news.ycombinator.com/item?id=538619  
pointed to
an example here: http://book.git-scm.com/5_submodules.html , which  
works with
submodules:

	$ git submodule update --init
	# sub/ is created
	$ (cd sub && touch a && git add a && git commit -am "Add new file")
	[detached HEAD 8641889] Add new file
	 0 files changed, 0 insertions(+), 0 deletions(-)
	 create mode 100644 a

	$ git submodule update
	$ ls sub/a
	ls: sub/a: No such file or directory

Now, it DOES say 'detached HEAD', but I still think this is something  
easily
missed and something that can cause a lot of confusion. Perhaps a  
warning in
such cases wouldn't hurt?

- Pieter
