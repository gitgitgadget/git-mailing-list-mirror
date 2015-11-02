From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --author=me
Date: Mon, 02 Nov 2015 10:05:42 -0800
Message-ID: <xmqqy4ege0p5.fsf@gitster.mtv.corp.google.com>
References: <563764B8.4010101@exec64.co.uk> <8737wos32p.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Harry Jeffery <harry@exec64.co.uk>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 19:05:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtJUS-0007Bz-Hc
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 19:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbbKBSFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 13:05:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752603AbbKBSFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 13:05:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FCD6272C8;
	Mon,  2 Nov 2015 13:05:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h2Oc9NlBYeeLnNxC74Sak8tSAdE=; b=k2JAzl
	vJID1WvV87fh6ve2ddMaFdP77IV2xvDQB9jivivDomKIjQua528avVOv0lu8DipD
	rh2W1TP/eNJEBPF41XxWh2/89sRugU0A1JWjSmaHqs3Q88C9EyQI0p67xtZaC0LD
	wqRK1euUjf0IddxkGLtMvf4rX5zpgKBcoRV8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SKanE3yEoNBNesWlLKPSKXaVM/oG+hbc
	fvs+z7tFLEHQ0EtFqaHUwhNPYQPa9LVqshlAXz7ofNnjuwdO1bBJCCOhAV7YiYL8
	ErV1qKg07E9TbQgRg0F1fbpD2u60/CsQUNMfmI1Rb2A1lUZ2At6nlRHfDp1d+7fq
	MBcqQABAMac=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 677DA272C7;
	Mon,  2 Nov 2015 13:05:45 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE073272C6;
	Mon,  2 Nov 2015 13:05:44 -0500 (EST)
In-Reply-To: <8737wos32p.fsf@igel.home> (Andreas Schwab's message of "Mon, 02
	Nov 2015 18:50:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5660C5D4-818C-11E5-B09D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280705>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Harry Jeffery <harry@exec64.co.uk> writes:
>
>> The purpose being to make finding your own commits quicker and easier:
>>     git log --author=me
>
> Since --author does a regexp search, this would most likely break
> someone's searches.  Better add a new option for that functionality.

I do not think it would hurt too much to add "--mine" to look for
"--author" that matches you, but on the other hand, I am not sure
its value outweighs the additional noise in the manual page.

It certainly does not help "I have done this much to this project in
the time period, and you can look at the output of this command
yourself to verify my claim.  Type 'git shortlog --mine' and then
promote me this season, please!" use case ;-)

So...
