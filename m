From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
	end-of-line conversion
Date: Mon, 10 May 2010 13:14:39 +0200
Message-ID: <20100510111438.GA15206@pvv.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com> <20100509200935.GA22563@pvv.org> <20100510081358.GD14069@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 13:14:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBQwj-00077Z-CF
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818Ab0EJLOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 07:14:44 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:49720 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756786Ab0EJLOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 07:14:42 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OBQwZ-0002i4-4S; Mon, 10 May 2010 13:14:39 +0200
Content-Disposition: inline
In-Reply-To: <20100510081358.GD14069@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146797>

On Mon, May 10, 2010 at 12:13:58PM +0400, Dmitry Potapov wrote:
> 
> First of autocrlf is safe as it is implemented now.

No, it isn't. autocrlf as it is implemented now is destructive for any
file that contains CRLF in the repo (it also gives dirty files after
checkout and so on).

> I believe that the right solution is to be able to enable autocrlf but
> only for those repositories that are marked as autocrlf compatible by
> upstream.

Yes absolutely. But how do you tell autocrlf that the repository is
compatible with it?  This is what is causing all the problems.

Now, I propose to change autocrlf in such a way that it will work as
before for all repositories that are "compatible with it", but _also_
so that it works reasonably with those that aren't.

- Finn Arne
