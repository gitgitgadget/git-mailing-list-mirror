From: Wincent Colaiuta <win@wincent.com>
Subject: Side-by-side diff and patch visualization
Date: Wed, 19 Sep 2007 13:40:17 +0200
Message-ID: <A92611E8-1035-46A6-AFEF-9C8A6F93AFB1@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 13:40:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXxv0-00009G-Kd
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 13:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407AbXISLka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 07:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbXISLk3
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 07:40:29 -0400
Received: from wincent.com ([72.3.236.74]:46522 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756849AbXISLk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 07:40:29 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8JBeRoa015576
	for <git@vger.kernel.org>; Wed, 19 Sep 2007 06:40:28 -0500
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58702>

Does anybody know of any tools for doing side-by-side visualizations  
of diffs and patches which work well with Git?

By side-by-side I mean something like what's shown in this screen shot:

<http://wincent.com/images/side-by-side-diff.png>

For simple diffs there is little advantage here over a raw textual  
diff, but as patch complexity and size increase the side-by-side diff  
can sometimes prove itself to be more useful:

- totally flexible notion of context (you can scroll as far as you  
want in either direction)

- this flexibility comes with the same rapid movement between changes  
(ie. up/down cursor keys to jump between hunks no matter how far  
apart they are)

- for complex diffs, truly comprehending the nature of the changes  
may be easier in a side-by-side format

- as icing on cake, the implementation in the screenshot highlights  
the removed/added portions within each line

Now, that screenshot is actually of Apple's FileMerge app on Mac OS X  
and it would be fairly straightforward to write a dump wrapper script  
that either just interpreted the output of git-diff, or could be used  
in conjunction with GIT_EXTERNAL_DIFF, to feed files into opendiff  
two at a time, but that wouldn't allow you to easily visualize diffs  
which touch many paths.

So, can anyone recommend a tool which can do this kind of side-by- 
side visualization and plays nicely with Git? Experience with  
opendiff and git-mergetool has spoilt me here. For most cases I would  
continue to use vanilla git-diff (or gitk), but when I see a change  
that I'd like to visualize side-by-side I'd like to be able to use  
this alternative diff viewer (or can gitk already do side-by-side  
diffs and I just haven't seen how to turn them on?). Bonus points if  
I could not only view existing commits, but proposed commits too (ie.  
the ability to feed in a patch and see a side-by-side visualization  
of what the diff would look like if applied).

If nothing exists I will look at quickly hacking something together  
(most likely something that just reads the output of git-diff), but  
it will be just that, a quick hack.

Cheers,
Wincent
