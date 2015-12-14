From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] Rerolling sb/submodule-parallel-fetch for the time after 2.7
Date: Mon, 14 Dec 2015 13:00:42 -0800
Message-ID: <xmqqio40iw3p.fsf@gitster.mtv.corp.google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<566F2952.8000307@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:00:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8aEo-0007p5-80
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbbLNVAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:00:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932088AbbLNVAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:00:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1319F344B8;
	Mon, 14 Dec 2015 16:00:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TjqBEMtWw/4LauJHyMCt/trcOQk=; b=LXGgJg
	qnFDA0H7slH4UP1liR90M3GuMdr+7E+us3Xd0s3YefM+YjQerdxW4W1A0Ogtpuav
	zzvkK6otw3wV+JKMs+YefhLt//4EfYDw/GF5wm0FTymDWCEkrG4mSS+AaJd6gBiv
	icYUDayUblAjIaxmxrZSQpO9CO1RW6bZVFGks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sk4+BNjuWgb7PkFaAVqVkdPIPtQ/la+I
	B1TMg/1uJ6D4dycEjCXAwd81pc2DX7/DBzhYb10V5ZQcWxv7SieVNKhWD38vt1L7
	cicGLGJzdxlK50chIFNIFyxTiUVYAxbe5kGOj11AOZzWnpqyLr9Kw9ANGG0cesOY
	gQplIZV7zG4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 096C1344B7;
	Mon, 14 Dec 2015 16:00:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E3D6344B6;
	Mon, 14 Dec 2015 16:00:43 -0500 (EST)
In-Reply-To: <566F2952.8000307@kdbg.org> (Johannes Sixt's message of "Mon, 14
	Dec 2015 21:40:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD659450-A2A5-11E5-9722-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282413>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 14.12.2015 um 20:37 schrieb Stefan Beller:
>> I am sending out a new version for replacing sb/submodule-parallel-fetch for
>> the time after the 2.7 release.
>>
>> The content are
>>   * all patches as in the branch sb/submodule-parallel-fetch
>>   * inlcuding the fixups as suggested by Hannes,
>>   * write a message to the debug log for better testing and debugging purposes
>>    (a patch cherry picked from the series which is supposed to build on top of this)
>>
>> The patches themselves were rebased such that there are no fixup commits
>> any more, but we get things right the first time.
>>
>> The commit message of "run-command: add an asynchronous parallel child processor"
>> has slightly been updated to mention the fact that we don't want to use waitpid(-1)
>> but rather use the assumption of child's stderr living as long as the child itself.
>
> Thanks! I rebased a version of sb/submodule-parallel-fetch that
> includes my suggested improvements, and the result is identical to
> this series except for the trace output mentioned in the last bullet
> point.
>
> With or without addressing my note about the commit message in 6/8:
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>

Thanks, both.  This round does look very clean to build on top.
