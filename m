From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 14:50:31 -0700
Message-ID: <7viqwfbpzs.fsf@gitster.siamese.dyndns.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
 <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>
 <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org>
 <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>
 <alpine.LFD.1.10.0806101935130.3101@woody.linux-foundation.org>
 <832adb090806102258v3fd63605p8c45513690b78fe8@mail.gmail.com>
 <832adb090806102318k5727bb06p6c3211a6aebbfbe9@mail.gmail.com>
 <alpine.LFD.1.10.0806110752550.3101@woody.linux-foundation.org>
 <832adb090806111052p32a750c2n5f2d43e0ed1b910d@mail.gmail.com>
 <alpine.LFD.1.10.0806111105150.3101@woody.linux-foundation.org>
 <832adb090806111148u5e13e9c5g7afc5b013e6f1223@mail.gmail.com>
 <alpine.LFD.1.10.0806111151260.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Lynn <benlynn@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:51:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6YEI-00066Q-7o
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbYFKVur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbYFKVur
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:50:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbYFKVuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:50:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 742691F7A;
	Wed, 11 Jun 2008 17:50:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B405F1F79; Wed, 11 Jun 2008 17:50:37 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806111151260.3101@woody.linux-foundation.org>
 (Linus Torvalds's message of "Wed, 11 Jun 2008 11:53:27 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 70347DF8-3800-11DD-82BA-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84672>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 11 Jun 2008, Ben Lynn wrote:
>>
>> The only drawback is that I'm not sure how acceptable it is to write to 
>> the index on a read operation. Is this a big deal?
>
> Historically, we *never* did it. In fact, it was a big deal. These days we 
> do it opportunistically for "git diff" if we can, but making sure that it 
> all still works for a read-only access (think gitweb etc - the reader is 

Thanks for giving a good summary (I've been away), and I agree with your
analysis of the situation.  I do not see much need to _fix_ anything
around this area, except your "smudging is not zero timestamp" update.
