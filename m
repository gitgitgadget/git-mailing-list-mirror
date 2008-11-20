From: Matthias Kestenholz <mk@feinheit.ch>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 19:36:29 +0100
Message-ID: <A12D78B0-7CC0-4877-AB91-A547AE1A7EC8@feinheit.ch>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com> <20081120112708.GC22787@ravenclaw.codelibre.net> <492560C5.5070308@op5.se> <20081120141533.GC6023@codelibre.net> <49257949.4070308@op5.se> <20081120151925.GE6023@codelibre.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Christian MICHON <christian.michon@gmail.com>,
	git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:37:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3EPX-0007j8-PP
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 19:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbYKTSgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 13:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbYKTSgg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 13:36:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:23307 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbYKTSgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 13:36:35 -0500
Received: by nf-out-0910.google.com with SMTP id d3so297549nfc.21
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 10:36:34 -0800 (PST)
Received: by 10.86.95.8 with SMTP id s8mr1763431fgb.79.1227206193783;
        Thu, 20 Nov 2008 10:36:33 -0800 (PST)
Received: from saufpark.feinheit.local (77-56-178-27.dclient.hispeed.ch [77.56.178.27])
        by mx.google.com with ESMTPS id 3sm2953781fge.3.2008.11.20.10.36.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Nov 2008 10:36:32 -0800 (PST)
In-Reply-To: <20081120151925.GE6023@codelibre.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101466>


On 20.11.2008, at 16:19, Roger Leigh wrote:

>>
>> Then write a hook for it. You agree that for most users this will be
>> totally insane, and yet you request that it's added in a place where
>> everyone will have to pay the performance/diskspace penalty for it
>> but only a handful will get any benefits. That's patently absurd.
>
> The cost is tiny.  The extra space would be smaller than a single
> SHA1 hash.

No, the cost is huge. The SHA-1 for the tree with _exactly the same
contents_ will be different, just because f.e you applied a patch one
second earlier than I did, and that's completely insane. Git is purely
a content tracker as has been said numerous times on this mailing
list, and that is for good reasons. If the tree entries change just
because some timestamps are different, the CPU time needed to
generate a diff will grow by a big amount of time.

Atempts to add additional information to the basic git objects have
failed several times, and yours will probably fail too since there are
numerous reasons why you do _not_ want a timestamp in the tree
_and_ there are several workarounds for your problem, which at
least in my opinion seem much less insane than adding timestamps...


>> Especially since there are such easy workarounds that you can put in
>> place yourself instead.
>
