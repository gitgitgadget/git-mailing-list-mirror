From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Wed, 29 Dec 2010 01:05:22 +0100
Message-ID: <4D1A7B42.1050907@web.de>
References: <20101201171814.GC6439@ikki.ethgen.de> <20101201185046.GB27024@burratino> <7vipydwp50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 01:06:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXjYP-000161-W5
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 01:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0L2AF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 19:05:26 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:34134 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab0L2AF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 19:05:26 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id A2AC5184B4235;
	Wed, 29 Dec 2010 01:05:24 +0100 (CET)
Received: from [93.240.96.127] (helo=[192.168.178.53])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PXjXg-000141-00; Wed, 29 Dec 2010 01:05:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vipydwp50.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/2XMge2sO2W3z+SMtRRhRDyTgtR0m8T4Ql1KXl
	zLImU5Aj87KhVPMC08+EbIPr9tNQB1G9MfeWkgfmoH1YP2Ww/5
	gX5w5ZZXxOg99X++rugA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164298>

Am 28.12.2010 22:42, schrieb Junio C Hamano:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> 	git submodule add -b $branch $repository
>>
>> fails when HEAD already points to $branch in $repository.
> 
> I was reviewing the overall picture before tagging 1.7.4-rc0 and started
> wondering if this was a good change.  If repository already had branch
> checked out, and if it was pointing at a commit that was different from
> whatever was taken from origin, shouldn't the command _fail_ to prevent
> the divergent commits from getting lost?

But doesn't this change only affect the case where the submodule is
freshly cloned, so there is no chance of losing local changes?

(But AFAIK the patch doesn't really fix the issue, please see [1] and
Jonathan's followup)

[1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/772659/focus=163242
