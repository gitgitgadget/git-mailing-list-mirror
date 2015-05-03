From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/15] t5520: style fixes
Date: Sat, 02 May 2015 18:57:30 -0700
Message-ID: <xmqq7fsqxw1h.fsf@gitster.dls.corp.google.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
	<1430342973-30344-1-git-send-email-gitster@pobox.com>
	<1430342973-30344-4-git-send-email-gitster@pobox.com>
	<CACRoPnR+OHp1ho-az=C8tE=bczX5h1yEvSozGXVTShB09q1-dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 03:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YojA2-0001ur-8E
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 03:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbbECB5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 21:57:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750807AbbECB5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 21:57:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A78A4E430;
	Sat,  2 May 2015 21:57:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HVPCXAe5DDQoikEK9hBpaHwxNUE=; b=YH+aVb
	QIAsYiVv7kMpEfMvwYAZ6f5TjiUCQLQ2y3Dvnix7r4Wvx8tKBzBKiREmKw88FKC4
	FTh6BSYZgHY7P0dQV2xsjfGPeDl4Hc99XrqEkScv5WfKFZZmfiqNpw02Eg9RMbM1
	UIeAdI5Q3FbfGTHDvnTa92TeL6uMt8mUBn2dA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xVtTR8jtJMdu0uk3NBeN/DjlOXnU32Nd
	XuR74sjJytF7ze0SiR1TPQKxnObkHY1px2IPbC/t8/DUnLTftKYNs5XiyRcfHxGN
	v3ZdzktutL/ngDsIqf/4bla3oPeEriQtlwptM+3lsCouROnK/GsLuDfDYERvX6QE
	GO68gzukU7Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 019AB4E42F;
	Sat,  2 May 2015 21:57:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 711EF4E42E;
	Sat,  2 May 2015 21:57:31 -0400 (EDT)
In-Reply-To: <CACRoPnR+OHp1ho-az=C8tE=bczX5h1yEvSozGXVTShB09q1-dg@mail.gmail.com>
	(Paul Tan's message of "Fri, 1 May 2015 16:35:54 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C2639FEE-F137-11E4-9256-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268246>

Paul Tan <pyokagan@gmail.com> writes:

> Just wondering, would it be good to clean up the created repos in the
> above tests to make it clear that they won't be used anymore?
> Something like:
>
>     git init cloned &&
>     test_when_finished "rm -rf cloned" &&
>     ...

It might be a good idea when you are doing the wholesale style fix
of the entire script. That was not a part of the scope of my series,
so I kept my changes to the minimum and made my additions in line
with the existing tests (i.e. new one-time-use repository that is
just left behind without being used by others).

Having said that, when it is very clear that each of the new
directories are for one-time-use (like the use of them in 5520), I
tend to prefer leaving them around, if only to make it easier to
insert "exit", go there and manually inspect the situation, which
will become necessary when the tests start failing.
