From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 09 Sep 2011 17:59:20 +0200
Message-ID: <4E6A37D8.8050400@web.de>
References: <4DF6A8B6.9030301@op5.se> <20110614003029.GA31447@sigill.intra.peff.net> <7vtybtm3dl.fsf@alter.siamese.dyndns.org> <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com> <201106141202.46720.johan@herland.net> <20110614170214.GB26764@sigill.intra.peff.net> <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com> <20110614194749.GA1567@sigill.intra.peff.net> <BANLkTi=GZDLu-ey1=h8LLDbWssoSpsM_jd7R-oFr+b+82Otb8g@mail.gmail.com> <1315511619144-6773496.post@n2.nabble.com> <1315529522448-6774328.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:00:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23Ut-0003rg-0k
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759301Ab1IIQAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 12:00:00 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:41091 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758537Ab1IIQAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 12:00:00 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id C8D3E1AAA76CD;
	Fri,  9 Sep 2011 17:59:20 +0200 (CEST)
Received: from [79.247.248.31] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1R23U8-0000Rg-00; Fri, 09 Sep 2011 17:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <1315529522448-6774328.post@n2.nabble.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+1BmOysgb4t4zaX9VWfmQBRsyeU7ffxpXbu01c
	yLwEVEBXQf4yBLXUxLeWS7TNrvlszjhp1MHV/+x72yFH77xDtO
	hyL96/Fa64vMrVJNZiTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181084>

Am 09.09.2011 02:52, schrieb Martin Fick:
> An update, I bisected it down to this commit:
> 
>   88a21979c5717e3f37b9691e90b6dbf2b94c751a
> 
>    fetch/pull: recurse into submodules when necessary
> 
> Since this can be disabled with the --no-recurse-submodules switch, I tried
> that and indeed, even with the latest 1.7.7rc it becomes fast (~8mins)
> again. The strange part about this is that the repository does not have any
> submodules. Anyway, I hope that this can be useful to others since it is a
> workaround which speed things up enormously. Let me know if you have any
> other tests that you want me to perform,

Thanks for nailing that one down. I'm currently looking into bringing back
decent performance here.
