From: Marco Costalba <mcostalba@yahoo.it>
Subject: [RFC] Patches exchange is bad?
Date: Tue, 16 Aug 2005 13:01:32 -0700 (PDT)
Message-ID: <20050816200132.88287.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 16 22:03:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E57cv-0002tl-Ie
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 22:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVHPUBe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 16:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVHPUBe
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 16:01:34 -0400
Received: from web26304.mail.ukl.yahoo.com ([217.146.176.15]:38499 "HELO
	web26304.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932313AbVHPUBe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 16:01:34 -0400
Received: (qmail 88289 invoked by uid 60001); 16 Aug 2005 20:01:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hvKumnTFxymqDUWdV1lgXSXbI1wo60AfWVaXWNQ8b3jr9SFkOakNrhUjkbDXiTf9wkT/b7ZVG8whHVEQ9kIiLyQTXbWzlhGXrv11P6Pu2vnOSisETQIUuRMz2soLVmp/4hWP1LBdvggfX3EvCxWAXTnyBZ1QTvIQ6mrgnSG2BJQ=  ;
Received: from [151.38.74.63] by web26304.mail.ukl.yahoo.com via HTTP; Tue, 16 Aug 2005 13:01:32 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I would like to ask the list about something I'am thinking about,
and I'am not sure it's a good idea.

Suppose a possible scenario involves using a couple of git archives, one 
for releases and stable code, say MAIN, and one for experimental stuff  
or new development, say HEAD.

Suppose there is stuff in HEAD you don't want merged in MAIN, more,
you need to update MAIN with only a subset of patches in HEAD, peraphs 
in different order. Or simply, you are not interested to see the history 
of the HEAD tree when looking MAIN. All this points could keep you 
from merging.

I have mocked up a very simple and very stupid 'drag and drop' function.
Basically you drag some selected revs in another instance of qgit, open on 
a different archive.

What happpens in the background is that git-format-patch-script is feeded 
with the selected revs and a bunch of temporary patch files are created, 
then git-applymbox (re)creates the corresponding commits in the destination 
archive.

It is just a very thin layer above the two git scripts, the only extra work 
is the cleaning up of some info that git-format-patch-script automatically adds, 
so that the new commits look like the originals (i.e. same header and description).

I've built-up this thing mainly because I found it useful for me, but I have  
some concerns that this is the correct way to go, the way git it's meant to be used.

If there is some interest for this I can push something on SF, after a due polishing, 
but if it is deeply broken I prefer discard and eventually switch to a more consistent
workflow.

What do you think?

	Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
