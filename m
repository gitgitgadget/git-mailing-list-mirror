From: Andreas Ericsson <ae@op5.se>
Subject: Re: Feedback outside of the user survey
Date: Mon, 20 Oct 2008 17:02:31 +0200
Message-ID: <48FC9D87.3010303@op5.se>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com> <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com> <48F7A4F8.2080600@jaeger.mine.nu> <20081018134906.GA13894@garry-thinkpad.arpnetworks.com> <48F9EC2B.2010200@jaeger.mine.nu> <48FC55F9.3060509@op5.se> <48FC9927.5030903@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Garry Dolley <gdolley@arpnetworks.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Mon Oct 20 22:30:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrwIV-00065g-OH
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 17:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbYJTPCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 11:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbYJTPCh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 11:02:37 -0400
Received: from mail.op5.se ([193.201.96.20]:56266 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbYJTPCh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 11:02:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5889D1B800B2;
	Mon, 20 Oct 2008 16:56:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.869
X-Spam-Level: 
X-Spam-Status: No, score=-3.869 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.531, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJnGwZaVWUdH; Mon, 20 Oct 2008 16:56:00 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E67971B8004E;
	Mon, 20 Oct 2008 16:55:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <48FC9927.5030903@jaeger.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98699>

Christian Jaeger wrote:
> Andreas Ericsson wrote:
>> Christian Jaeger wrote:
>>> If you really wanted, I suppose you could additionally look into 
>>> implementing a kind of shallow cloning that only copies objects over 
>>> the wire which are necessary for representing the subdirectory you're 
>>> interested in.
>>>
>>
>> So what do you do when one such commit also affects something outside
>> the subdirectory?
> 
> You haven't said what you mean with "affect".
> 

I mean "how would you handle a commit (and its tree-object) that updates
all Makefiles in, for example, the Linux kernel project?". Those files
are spread far and wide, and you'd want that change to *your* tree, but
getting it into your tree either means you need to rewrite the tree (and
thereby the commit) itself to get rid of uninteresting blob's from the
tree, and you'd also have to prune the tree to not reveal the directory
layout of the rest of the repository.

I take it parentage could be resolved by a ridiculously large grafts-file.

What you'd end up with wouldn't be a git repository at all anymore. It
would be a "stump", as it'd be missing large parts of the tree entirely.
I'm unsure just how much you'd have to compute to be able to use such a
stump to incorporate your changes with other users again, but I doubt it
would be trivial to implement. Good thing it's not my itch, really.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
