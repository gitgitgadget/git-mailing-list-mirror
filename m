From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] convert.c clean-up
Date: Tue, 10 May 2011 07:09:51 -0700
Message-ID: <7voc3alk9c.fsf@alter.siamese.dyndns.org>
References: <20110508101925.GA19525@do>
 <1304978701-19310-1-git-send-email-gitster@pobox.com>
 <BANLkTi=fjLkqWB2MTGtKE93qSjXU76cpvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 16:10:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJndV-0004uK-HA
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 16:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550Ab1EJOJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 10:09:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233Ab1EJOJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 10:09:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E614D3144;
	Tue, 10 May 2011 10:12:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=xJC+fXFXtxOzx7jLta2MMijkf/k=; b=kJ3iqkZGKBkDWLekZH/n
	hRySaRgD/smSz44eYbf064ztBLuktZNu0zXtpBZ8OjycCfMfEqCcxdfyGH2K3WvZ
	S1EfVK5GaI52IFxo4H2P5WRVIGsEeIKuuojoMrpdTwovlsr7v3kjEQ46jeFQt2gD
	m8jQl2KKtuvV1JRPJNHurmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=N5pDxgW86V7k3nSgcoinGKOn76IjUJPw2BMkUrj+bgRxDb
	OmK4+KPzB+XmZRD4lx63PUVyxLTvNpvInb3q7cbDv1gERufXj24wnlv4I58vyTmg
	FKabmFlQnBrWQl9OjluaIWVvWF7xjJLs/WOnPokacUNN5W97zM95LyD1V42Gk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3DCB3143;
	Tue, 10 May 2011 10:12:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D211D313F; Tue, 10 May 2011
 10:11:59 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A45C572-7B0F-11E0-A65B-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173337>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, May 10, 2011 at 5:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Yeah, I think that would probably make more sense. If a file is small
>> enough, it is more sensible to send it to a loose object just like any
>> other files. We do not want to invite users to make a mistake of marking
>> it as bigdata and send it straight to a packfile. Having one less knob to
>> tweak is always a good thing to do.
>>
>> However, while reviewing your patch, I noticed that convert.c was littered
>> with misnamed types, variables and functions to the point to make it
>> almost unreadble as the result of its evolution. I originally wrote this
>> series so that I can add "bigdata" sensibly, and it turns out that there
>> is no benefit to do so for now, but the clean-up by itself would be worth
>> it.
>
> I still don't like "bigdata" attribute.

I think we are in agreement. I do not like it anymore and that was what I
tried to say in the first paragraph, and that was why I said "it turns out
that there is no benefit" in the second paragraph.
