From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/12] Allow helper to map private ref names into 
 normal names
Date: Mon, 09 Nov 2009 12:32:44 -0800
Message-ID: <7vk4xzsakz.fsf@alter.siamese.dyndns.org>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-5-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
 <alpine.LNX.2.00.0911061755360.14365@iabervon.org>
 <fabb9a1e0911061519j6d64ff50v9b0cefe61965fbbc@mail.gmail.com>
 <fabb9a1e0911082242k5950d780i584a4714e384e007@mail.gmail.com>
 <7vhbt3y7fb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911090910g4745325l842cdb91e4d9485c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 21:33:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7avC-0001pO-72
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 21:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbZKIUcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 15:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbZKIUcy
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 15:32:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbZKIUcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 15:32:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 595C99920F;
	Mon,  9 Nov 2009 15:32:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9BsNIJ0ijHglo6QxnDrIEKs+FJY=; b=AIzMpH
	eL1W85vfovJZp1xE+ndZzM6M4VDogRvm2uwqyNN0IfSKNIC8OI8v9M+yHLNvrPKQ
	T4RXH4Qyb4RkrLx0ciAiMJuw+AaHYSks+OKttVD6aIXug7NyyQFavxvbIbyaRP8R
	7Ji99Euxo82ij2XM1r7T3PBUWQJMQPp63jBW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ht/JP18xAOXwuN5/CnaFlOlKNTJjf+Jt
	ITj/KQpHNvOSPWfhcRJgcAfAFzgrIihpyHJXcRWzokkixd1BDZIcukiW7KIp/Jdx
	RTfLhyILJv5FMVGOr3dNfEIPGpguJHmxgl699E6Tf6mdSsf/W1xpJ71A1f74PqV7
	K6idAIJRnts=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17E619920B;
	Mon,  9 Nov 2009 15:32:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E32399920A; Mon,  9 Nov 2009
 15:32:45 -0500 (EST)
In-Reply-To: <fabb9a1e0911090910g4745325l842cdb91e4d9485c@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 9 Nov 2009 18\:10\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0EC4E80E-CD6F-11DE-AB4A-BD45BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132521>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Mon, Nov 9, 2009 at 17:44, Junio C Hamano <gitster@pobox.com> wrote:
>> Sverre Rabbelier <srabbelier@gmail.com> writes:
>>> It's in next now, so please send follow-ups against sr/vcs-helper.
>>
>> Do you mean 'pu' or 'next'?
>
> Sorry, my hands did not type what my mind intended, I meant to say
> 'pu', apologies!

Fine---mistakes happen; it made me worried for a while.

So either follow-up, squash-in or replacement would be fine.
 
