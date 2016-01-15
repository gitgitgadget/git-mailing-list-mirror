From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Worktree "gitdir" file being mangled after upgrade to 2.7.0
Date: Fri, 15 Jan 2016 09:52:59 -0800
Message-ID: <xmqqsi1yivb8.fsf@gitster.mtv.corp.google.com>
References: <20160113234753.GA26473@gmail.com>
	<xmqqh9iglwf3.fsf@gitster.mtv.corp.google.com>
	<CACsJy8D2Bz42kvBD1e=0oqxrYDry7_wCOy5Fi3oS-sGJxux4-w@mail.gmail.com>
	<CANoM8SUB5hfZHkLenDEq1O1wFrZno1OUUSH2uwDfihC0z+tUkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Erik Johnson <palehose@gmail.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:53:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK8Ye-0000os-AF
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbcAORxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:53:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753142AbcAORxC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:53:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 574FD399D5;
	Fri, 15 Jan 2016 12:53:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XkLcBgXmkFFsd9/pKledZTGT0Og=; b=TeUgo6
	dSXx036pyWRtk32OWJkUj6yawTymLiohleeUjSQ5M/1znXtM8gagkpWiO5Xz9F4j
	i4Cqod5qPnx0icfpv2EBiHlwjIXdDBouQD826BpAtgGIGib6E7MbMpXu3n/n08mJ
	LM/zAXQDZ2ZPQhtSWk316gFn7lMAC9ECkxfic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aFX1D8mLacGpJD3WTWFyU6ZNMlwWKN92
	vYLBxteEm8m12766BNB/JOIn1oB3BJ5rihYyQ4IMHcUw1ExS8VE7vzZCrj9OhqAd
	uy5zqEgZ9VcdD3Ow2hU4MJhd2dbmUJON2nkfyBxXAMSvuwbFdOPaqpka0tIiM5VX
	vBviYytcvnU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B47E399D3;
	Fri, 15 Jan 2016 12:53:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5918A399D2;
	Fri, 15 Jan 2016 12:53:00 -0500 (EST)
In-Reply-To: <CANoM8SUB5hfZHkLenDEq1O1wFrZno1OUUSH2uwDfihC0z+tUkQ@mail.gmail.com>
	(Mike Rappazzo's message of "Thu, 14 Jan 2016 08:58:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D13DDAE0-BBB0-11E5-A946-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284192>

Mike Rappazzo <rappazzo@gmail.com> writes:

>>> Thanks for relaying.  Duy, Michael, I think this is your area?
>>
>> The only place that a relative path can be written is
>> update_linked_girdir() unless i'm mistaken. That function is being
>> deleted "soon" because it causes another problem
>
> `git worktree list` command does not modify the worktree gitdir file,
> so this is only a symptom of the problem.  If at all possible, we
> should move to get Duy's fix into the 2.7.1 release.  This problem
> almost makes git worktree list useless.

Yes, what's the doneness of that "being deleted 'soon'"?

Thanks.
