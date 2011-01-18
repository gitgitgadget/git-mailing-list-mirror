From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Manually turning a --bare local repository to a real mirror repository (--bare --mirror)
Date: Tue, 18 Jan 2011 23:35:13 +0100
Message-ID: <m2wrm13kny.fsf@igel.home>
References: <AANLkTikE-sDhzw8=ybKhYhHtTH84V8EEOptMaq8xxRHc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilyes Gouta <ilyes.gouta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 23:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfK95-0000xx-I2
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 23:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab1ARWfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 17:35:17 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:35775 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab1ARWfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 17:35:16 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 035331C0F56B;
	Tue, 18 Jan 2011 23:35:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id F26F11C00333;
	Tue, 18 Jan 2011 23:35:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id I+V44-ohynmd; Tue, 18 Jan 2011 23:35:14 +0100 (CET)
Received: from igel.home (ppp-88-217-100-201.dynamic.mnet-online.de [88.217.100.201])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 18 Jan 2011 23:35:14 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id C79C4CA2A0; Tue, 18 Jan 2011 23:35:13 +0100 (CET)
X-Yow: - if it GLISTENS, gobble it!!
In-Reply-To: <AANLkTikE-sDhzw8=ybKhYhHtTH84V8EEOptMaq8xxRHc@mail.gmail.com>
	(Ilyes Gouta's message of "Tue, 18 Jan 2011 22:59:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165229>

> My question: given that I don't have enough bandwidth and constant
> Internet connectivity, I'd like to ask if it's possible to manually
> turn a pure --bare local repository into a --bare --mirror one? If
> yes, how to do that?

An ordinary bare clone has no fetch configuration.  To turn the repo
into a mirror you just have to add one:

$ git config remote.origin.fetch "+refs/*:refs/*"

and set the mirror flag:

$ git config remote.origin.mirror true

Then do a git fetch to fetch any missing refs.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
