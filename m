From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 14:13:59 -0400
Message-ID: <4262A767.4040300@dwheeler.com>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417170539.B13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170937020.7211@ppc970.osdl.org>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Russell King <rmk@arm.linux.org.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:08:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNEC1-0003CH-O8
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVDQSMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVDQSMO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:12:14 -0400
Received: from cujo.runbox.com ([193.71.199.138]:52931 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261387AbVDQSMK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 14:12:10 -0400
Received: from [10.9.9.1] (helo=bolivar.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNEFX-0000jK-Nf; Sun, 17 Apr 2005 20:12:03 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by bolivar.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DNEFX-0006No-9e; Sun, 17 Apr 2005 20:12:03 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504170937020.7211@ppc970.osdl.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Russell King wrote:
>>BTW, there appears to be "errors" in the history committed thus far.
>>I'm not sure where this came from though.  Some of them could be
>>UTF8 vs ASCII issues, ....> 
...
>>One thing which definitely needs to be considered is - what character
>>encoding are the comments to be stored as?

Linus Torvalds replied:
> To git, it's just a byte stream, and you can have binary comments if you
> want to. I personally would prefer to move towards UTF eventually, but I
> really don't think it matters a whole lot as long as 99.9% of everything
> we'd see there is still 7-bit ascii.

I would _heartily_ recommend moving towards UTF-8 as the
internal charset for all comments.  Alternatives are possible
(e.g., recording the charset in the header), but they're
incredibly messy.  Even if you don't normally work in UTF-8,
it's pretty easy to set most editors up to read & write UTF-8.
Having the data stored as a constant charset eliminates
a raft of error-prone code.

--- David A. Wheeler
