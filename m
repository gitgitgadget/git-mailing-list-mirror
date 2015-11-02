From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git.git as of tonight
Date: Mon, 02 Nov 2015 14:16:50 -0800
Message-ID: <xmqqlhagdp2l.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
	<5637D266.4060904@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 23:16:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtNPO-00043C-15
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 23:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbbKBWQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 17:16:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751709AbbKBWQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 17:16:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 93D5B289E0;
	Mon,  2 Nov 2015 17:16:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/mMKqhpwSzubV56W2VQeCvrwmUc=; b=mFBW2Y
	dlFWLQRDLg+TMHFHQ1mIz8H+Uz30Vo6jEwxr/8pkqyvTT8BIltB1JVniByaNkzX1
	f6rhHXeDAFk+Ktsils0/dlzKEuefkgPf371tonc9Aoh/D45tkHJRqWi4rEQSBLr9
	QaYcCOjLjSCs9PhqS1EG1gEw1M1cIR1AR3qJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8McW53Uu14/zJmUeYbduaHsgnxXclrm
	PNewOaErNWOzrTupW6efoGLPhrc1SdG7LP4lHJFzZZZSLuyGq/eLau/cCyJg0Mo5
	ce1U+KNPd/ZVuMezuK9V4m31dWOEYGYKSVUdFUOh8P7BI1bGZcqYbkVTf+8SLU4g
	yapsR8QiJSA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89ABB289DF;
	Mon,  2 Nov 2015 17:16:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 12CB1289DD;
	Mon,  2 Nov 2015 17:16:52 -0500 (EST)
In-Reply-To: <5637D266.4060904@kdbg.org> (Johannes Sixt's message of "Mon, 2
	Nov 2015 22:15:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B1C5254-81AF-11E5-93E2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280730>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 02.11.2015 um 03:58 schrieb Junio C Hamano:
>> * sb/submodule-parallel-fetch (2015-10-21) 14 commits
>>    (merged to 'next' on 2015-10-23 at 8f04bbd)
>>   + run-command: fix missing output from late callbacks
>>...
>>   + submodule.c: write "Fetching submodule <foo>" to stderr
>>   (this branch is used by rs/daemon-leak-fix and sb/submodule-parallel-update.)
>> 
>>   Add a framework to spawn a group of processes in parallel, and use
>>   it to run "git fetch --recurse-submodules" in parallel.
>> 
>>   Will merge to 'master'.
>
> Please don't, yet. This series does not build on Windows:

The only reason the series is listed here is because the cycle is
still young and I was hoping that any fallout will be addressed by
the time we tag -rc0; if the extent of required fixups is too great,
that obviously would not work well.

I'll try to see if I can untangle rs/daemon-leak-fix topic so that
it does not depend on this thing and have it graduate separately.

Thanks for stopping me.
