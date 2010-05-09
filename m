From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
	end-of-line conversion
Date: Sun, 9 May 2010 11:21:25 +0200
Message-ID: <20100509092123.GA18774@pvv.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 11:21:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB2hc-0005g5-IM
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 11:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab0EIJVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 05:21:31 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:36155 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0EIJVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 05:21:30 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OB2hR-00054w-4p; Sun, 09 May 2010 11:21:25 +0200
Content-Disposition: inline
In-Reply-To: <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146715>

On Sun, May 09, 2010 at 12:53:17AM +0200, Eyvind Bernhardsen wrote:
> On 9. mai 2010, at 00.17, Eyvind Bernhardsen 
> <eyvind.bernhardsen@gmail.com> wrote:
>
>> I'll try to think of a better name.
>
> Heh. How about "localcrlf={true,false,native}"?
>
> It breaks down a bit if we ever decide to support old-school-Mac-style  
> CR line endings, but at that point you're approaching the borders of  
> madness anyway.

It seems that autocrlf is currently so troublesome that most people end up
disabling it, and handling it in other ways (we certainly do).

Instead of keeping the names and trying to graft on something that is
almost backwards compatible, and forever live with names that we agree
are bad, what about:

Deprecate core.autocrlf and the crlf attribute.

Make these instead:

Configs:
core.eol = lf, crlf, native [default=native]
core.eolconversion = true, false, auto [default=unset]

Attribute:
eolconversion = true, false, auto [default=core.eolconversion]

- Finn Arne
