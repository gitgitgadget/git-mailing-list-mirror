From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 0/2] bookmarks (was: Re: git-fetch and unannotated tags)
Date: Wed, 25 Apr 2007 23:51:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
References: <200704252004.45112.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
	<200704252142.33756.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 00:51:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgqKk-0004CW-7x
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 00:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423396AbXDYWva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 18:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993112AbXDYWva
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 18:51:30 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:42111 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423396AbXDYWv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2007 18:51:29 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E2F86C60FF
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 23:51:27 +0100 (BST)
Received: (qmail 16195 invoked by uid 103); 25 Apr 2007 23:50:25 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3159. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.036154 secs); 25 Apr 2007 22:50:25 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 25 Apr 2007 23:50:25 +0100
Fcc: sent-mail
In-Reply-To: <200704252142.33756.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45590>

On Wed, 25 Apr 2007, Andy Parkins wrote:

> On Wednesday 2007, April 25, Julian Phillips wrote:
>
>> Why not create a directory .git/refs/bm and put things you don't want
>> to make public in there?  You can then use bm/foo etc ...
>
> I could, but then they don't get treated as tags properly in qgit.  I
> still want to list them in git-tag -l

While I like the idea of private tags, I find the idea of them having 
their own namespace to be much more attractive than simply having the 
ability to not export lightweight tags.

In particular it means that you can control which tags are exported 
individually.

(You can also create a signed private tag, and then make it public at a 
later date - e.g. maybe a security fix that you have to sit on?)

>
>> You could even modify git-tag to create them for you with some
>> appropriate switch ...
>
> Well yes, but that's the answer to everything isn't it?

Not with closed source software ... :(

The first of the following patches just changes do_one_ref so that passing 
a base with strlen(base) > trim is actually worthwhile.  The second adds 
basic support for private tags (bookmarks).

-- 
Julian

 ---
Nothing is but what is not.
