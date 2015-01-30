From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: implement a stable 'Last updated' in Documentation
Date: Fri, 30 Jan 2015 11:05:36 +0100
Message-ID: <54CB5770.8030503@drmicha.warpmail.net>
References: <20150126172409.GA15204@aepfle.de>	<xmqqd25zkeg7.fsf@gitster.dls.corp.google.com>	<20150128080214.GA18851@aepfle.de> <xmqqbnlif6t9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 11:05:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YH8SV-0006p1-IJ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 11:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760474AbbA3KFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 05:05:42 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39689 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754278AbbA3KFj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2015 05:05:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 575B9206E8
	for <git@vger.kernel.org>; Fri, 30 Jan 2015 05:05:38 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 30 Jan 2015 05:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=gDBXJMV0eVFqrG/Msp0nIz
	JCigs=; b=EH97vmxuQDKV2GV5uozdLrNTDkbfAx1Xxnh94MUeI3R8w8xvCbcw1m
	AOUsLwZiah5h8YimplymF8BlMeWT25o6MAe7zc/+Y9zWRxK74GC9gql11DWLmK4N
	fC7+3BV8+QlYW4C0jkvTYJACfKZ0YUpvzvF33nSMCQdeUr42SIZmU=
X-Sasl-enc: ylDAHcCnQZx84dGkXo/mL7fNsXJlsoiIsrEklBJfSMr1 1422612338
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A8EBEC0028A;
	Fri, 30 Jan 2015 05:05:37 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqbnlif6t9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263175>

Junio C Hamano schrieb am 29.01.2015 um 07:18:
> Olaf Hering <olaf@aepfle.de> writes:
> 
>> On Tue, Jan 27, Junio C Hamano wrote:
>>
>>>> What file timestamp should be used for them? Likely "../version"?
>>>
>>> I tend to think the "Last updated" timestamp taken from the
>>> filesystem timestamp is a bad practice inherited by these tools from
>>> the days back when nobody used any revision control systems.
>>
>> I'm not sure. The bug is that such 'Last updated' line exists at all in
>> the default output. Noone asked for it, noone really needs it. And it
>> makes it impossible to get reproducible builds.
> 
> Amen to that ;-)
> 

It's a shame one can't simply replace the [footer-text] template which
asciidoc insists on.

It turns out asciidoc 8.6.9-3 and later will habe a knob to turn:

https://github.com/asciidoc/asciidoc/pull/9

I'll try and get my hands on it to see whether we can simply use that.
I'm wondering though which is more useful - the version of the tree the
doc is processed from, or the version of the last commit changing the
corresponding doc source file. The first one changes even when the doc
source is unchanged (but is stable between reruns, of course).

Michael
