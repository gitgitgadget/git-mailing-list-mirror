From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/6] t0021: use $SHELL_PATH for the filter script
Date: Mon, 04 Jan 2010 17:46:38 +0100
Message-ID: <4B421B6E.3070501@kdbg.org>
References: <20091230095634.GA16349@coredump.intra.peff.net> <20091230110335.GF22959@coredump.intra.peff.net> <4B3E73AE.6050003@kdbg.org> <20100103072408.GA23031@sigill.intra.peff.net> <4B420E4F.1040706@kdbg.org> <20100104160317.GB9136@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:46:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRq51-0004O0-NB
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab0ADQqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556Ab0ADQqr
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:46:47 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:65132 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753478Ab0ADQqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 11:46:47 -0500
Received: from [77.117.74.72] (77.117.74.72.wireless.dyn.drei.com [77.117.74.72])
	by bsmtp.bon.at (Postfix) with ESMTP id 84C06CDF88;
	Mon,  4 Jan 2010 17:46:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100104160317.GB9136@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136130>

Jeff King schrieb:
> I converted more than that; see my 2/6. It is also the pager, the
> imap-send tunnel helper, and external merge helpers. Not the editor,
> since it already had the no-metacharacters optimization (though it, too,
> could be affected if we implement your DWIM trick instead of the
> metacharacter thing).
> 
> So I think we need to make a conscious decision that this is an
> acceptable change of behavior (and I am totally fine with the change
> happening -- I just want to be clear about the extent of what is being
> changed).

Hm, ok, I see.

- The clean and smudge filters are probably the most important cases.

- I *did* write my own merge script (to merge PNGs!), but I made sure to 
begin it with #!/bin/bash, and I don't think anybody else is crazy enough 
to write a custom merge script ;)

- imap-send on Windows is so new that I don't think anyone is already 
using it with a custom tunneling script.

- The change in pager.c is unimportant because all versions shipped so far 
(via msysgit) have the conflicting change that tried without "sh -c" first.

I think that these can be handled with an entry in the release notes.

-- Hannes
