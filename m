From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] push: Use sideband channel for hook messages
Date: Fri, 05 Feb 2010 16:51:56 +0100
Message-ID: <4B6C3E9C.7040009@viscovery.net>
References: <20100205033748.GA19255@spearce.org> <4B6C07E3.5030705@viscovery.net> <20100205153252.GC19255@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 16:52:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdQTb-0005Bs-Pq
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 16:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab0BEPwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 10:52:04 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61567 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752654Ab0BEPwB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 10:52:01 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NdQTN-0004VY-G8; Fri, 05 Feb 2010 16:51:57 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 39C9A1660F;
	Fri,  5 Feb 2010 16:51:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100205153252.GC19255@spearce.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139052>

Shawn O. Pearce schrieb:
> Johannes Sixt <j.sixt@viscovery.net> wrote:
>> What would you think about passing both channels to the async callback,
>> and the communicating parties must agree on which channel they communicate
>> by closing the unused one? It would require slight changes to all current
>> async users, though. (It also requires in the threaded case that we pass
>> dup()s of the pipe channels.)
> 
> Yup, I could do that.  I feel like it might be over-engineering the
> solution a bit.  But I'll respin the patch by splitting it apart,
> and doing a bidirectional async here, since you asked nicely.

I do agree about the over-engineering aspect. I mentioned it because in
one patch in the past Erik Faye-Lund also extended the async
infrastructure for bidirectional communication to use it in git-daemon
(Windows port). Meanwhile, he's abandoned this approach because there were
unsurmountable obstacles elsewhere; so if you introduce bidi now, it would
not immediately buy us anything.

It's your draw.

-- Hannes
