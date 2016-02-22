From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] Tests and fixes for merge-recursive rename options
Date: Mon, 22 Feb 2016 13:00:25 -0800
Message-ID: <xmqqpovo5ul2.fsf@gitster.mtv.corp.google.com>
References: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	sunshine@sunshineco.com,
	Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: =?utf-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 22:00:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXxas-00037x-AO
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 22:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbcBVVA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 16:00:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59338 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752199AbcBVVA2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 16:00:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4FBBB4754E;
	Mon, 22 Feb 2016 16:00:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X0IYMosWn6vi
	0dljHsoAEj5u7c0=; b=EhOvhiaNnkPQHMoSo6Jg+0UR3ql2h1p4U0oJaODDqHN5
	P8Kr995W/HQh91U9tUwNGRSDnA5/LWGjyb61SEZ6CR5SRM2ZGlN+uFxfMoP85mrK
	0KNm8cLGC2OIPAw6WCnf1BTztJ+r8UdvLz9bCcDlnZrxeJ+KFC8kjV5oYzmk8vU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gDB2ew
	LN0IHlMYCA4DQWiUWnQi3oxBf1EKQSceNRiM+zMLp8qyVYnC4jxAtwqeTfWJfG91
	T7TwgvHBysymurh2fp5yqecZrvGEAcaSXMXZd2fL9p/mTiMRUwddCbNWNe3xkXSG
	5TKP5gSJNutRrItzuaiar/w4vy7IVVNixK18I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 475B54754D;
	Mon, 22 Feb 2016 16:00:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BA8E24754C;
	Mon, 22 Feb 2016 16:00:26 -0500 (EST)
In-Reply-To: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Sun, 21 Feb 2016
 19:59:00
	-0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C5084D0-D9A7-11E5-A2A0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286951>

"Felipe Gon=C3=A7alves Assis"  <felipeg.assis@gmail.com> writes:

> This is a reorganisation of the previous series, bundling the test fo=
r the fix
> along with the commit itself, as suggested by Eric. It also includes =
many fixes
> and improvements pointed out by the same reviewer, whom I thank.
>
> The typo fix is the same as before.
>
> In "add rename threshold tests", I include tests involving --find-ren=
ames,
> except for one that depends on the fix.
>
> "test option to disable renames" adds tests involving --rename-thresh=
old.
>
> "test deprecated interface" tests the aliasing --rename-threshold.
>
> In "find-renames resets threshold", the specific test for the feature=
 was
> bundled along.
>
> To Junio: Please pay special attention to the test of threshold trunc=
ation.
> Given that it seems to be an undocumented feature, I am not sure whet=
her it
> should be included or not.
>
> Felipe Gon=C3=A7alves Assis (5):
>   merge-strategies.txt: fix typo
>   t3034: add rename threshold tests
>   t3034: test option to disable renames
>   t3034: test deprecated interface
>   merge-recursive: find-renames resets threshold

As I said, I am reluctant to take the 25%/50%/75% tests in their
current form.  Let me take the first one and a half of the last one
(i.e. excluding the test) for now.

Thanks.
