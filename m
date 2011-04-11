From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 12:41:10 +0200
Message-ID: <4DA2DAC6.1010009@drmicha.warpmail.net>
References: <20110411084229.GW5146@genesis.frugalware.org> <20110411091919.GE28959@kytes> <4DA2CED1.6070107@drmicha.warpmail.net> <20110411101614.GB5146@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	timar74@gmail.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 12:41:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9EYY-0006ZN-VL
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 12:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab1DKKlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 06:41:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57340 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880Ab1DKKlM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 06:41:12 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 87CDA2041A;
	Mon, 11 Apr 2011 06:41:12 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 11 Apr 2011 06:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/lDxHRXe7j40vw0JS9AXZBFvjnc=; b=s4hhElfPsCkXMXIsKeEco2WhDUrign/RYAyqQNifgwHBgK5LB5X2SuGVj4SF99RC/0boXwWhIvkKWE8rsxrCn2yq1VikxKLnOBg1INYpIr0zWzLXBDdIXPfmzTeYnC9m+0eNVWkN+YfprUtt71fzTJDSob+21kXf8bAgkgLuC0c=
X-Sasl-enc: H9Z+afA4mcc1hsRh+sifs7lDPd3RK83zl7fgsk3gTuEj 1302518472
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CC180443FA2;
	Mon, 11 Apr 2011 06:41:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110411101614.GB5146@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171326>

Miklos Vajna venit, vidit, dixit 11.04.2011 12:16:
> On Mon, Apr 11, 2011 at 11:50:09AM +0200, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> But maybe there is a better solution for your actual use case? Do you
>> want to ignore line wrap or normalise it?
> 
> I want to avoid those, so we get readable diffs, whatever line width the
> different translator tools are using. (If tool1 is using 72 and tool2 is
> using 80, then it would reformat the whole file.)
> 
> Do you have a better idea than
> 
>         git config filter.po.clean 'msgcat - --no-wrap'
> 
> ?

git config diff.po.textconv 'msgcat - --no-wrap'
git config diff.po.cachetextconv true

If you want to normalise the repo, you may want to look at hooks instead
of clean/smudge if they are a performance problem.

Michael
