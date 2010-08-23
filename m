From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: git-describe --contains fails on given tree
Date: Mon, 23 Aug 2010 13:26:04 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1008231324280.17348@obet.zrqbmnf.qr>
References: <alpine.LSU.2.01.1008212145520.14934@obet.zrqbmnf.qr> <m3occvoi5c.fsf@localhost.localdomain> <alpine.LSU.2.01.1008212241410.23864@obet.zrqbmnf.qr> <201008222358.04504.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 23 13:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnVAL-0005w0-7J
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 13:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab0HWL0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 07:26:08 -0400
Received: from borg.medozas.de ([188.40.89.202]:51902 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575Ab0HWL0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 07:26:05 -0400
Received: by borg.medozas.de (Postfix, from userid 25121)
	id D7175F0C32A80; Mon, 23 Aug 2010 13:26:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id B885754A4;
	Mon, 23 Aug 2010 13:26:04 +0200 (CEST)
In-Reply-To: <201008222358.04504.trast@student.ethz.ch>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154216>

On Sunday 2010-08-22 23:58, Thomas Rast wrote:
>> On Saturday 2010-08-21 21:55, Jakub Narebski wrote:
>> >> for some reason, git-describe cannot figure out v1.17~15^2^2 in
>> >> the pam_mount tree, despite me being able to actually give
>> >> a description that would fit the contains syntax:
>> >What does
>> >
>> >  $ git describe --contains --tags v1.17~15^2^2
>> 
>> "Cannot describe 95ce..."
>> 
>> Funny thing is, describing "v1.17~15^2" does work, as does "v1.17~15^1".
>
>That's clock skew:
>
>  $ git show -s --format="%cd" v1.17~15^2 
>  Fri Jan 9 04:35:59 2009 +0100
>
>  $ git show -s --format="%cd" v1.17~15^2^2
>  Sat Jan 24 16:35:34 2009 +0100

Thanks for pointing that out.
(Ah the joy of BSD-inside-VMware.)

>Interestingly, --stdin disables this optimization:
>
>  $ git rev-parse v1.17~15^2^2 | git name-rev --stdin
>  95ce932690dfce8cbe50b6a3a8949e41a54c8966 (tags/v1.17~15^2^2)
