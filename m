From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/6] Teach fetch/pull the on-demand mode and make it the
 default
Date: Thu, 24 Feb 2011 00:48:56 +0100
Message-ID: <4D659CE8.3030604@web.de>
References: <4D656F25.5090007@web.de> <20110223232156.GE6819@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:49:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsOS7-0007fk-0a
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582Ab1BWXs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:48:58 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:42600 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab1BWXs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:48:57 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id A7A67198E99FB;
	Thu, 24 Feb 2011 00:48:56 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsOS0-0001kt-00; Thu, 24 Feb 2011 00:48:56 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110223232156.GE6819@elie>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19dLY77TXpiS5i1+JvglHDSWDyesyQn6hBhMM6c
	ZS7rDCFCHk6QsTzadwlU+6knhWmHdn4esvQo+qQdWUv6wO7WY2
	hoo56kOyRewlaCW+83xQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167746>

Am 24.02.2011 00:21, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
> 
>> *) The fetch is only done when the recorded submodule commit isn't
>>    already present.
> 
> I like this part a lot.

Glad to hear ;-)

>> I tend to think that this is suited for 1.7.5 but don't have any
>> objections against holding it back until 1.8.0 either. What do
>> others think?
> 
> I see no backward-compatibility to wait for this, but I would be more
> included to trust people using "git submodule update" heavily than I
> do.

Yeah, I would appreciate some feedback here too.

> The "submodule update" change could cause the following to break.
> Would that be disruptive?
> 
> 	cd submodule
> 	git fetch --no-recurse-submodules
> 	...
> 
> 	cd ..
> 	bin/script-to-update-submodules-that-calls-submodule-update

But then "git submodule update" would notice that the commit isn't
present and do a "git fetch" itself, no?
