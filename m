From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Compiler warning under cygwin/mingw
Date: Tue, 12 Apr 2016 16:20:25 -0700
Message-ID: <xmqqy48imn2e.fsf@gitster.mtv.corp.google.com>
References: <20160229104708.GA17042@sigill.intra.peff.net>
	<1456754714-25237-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:20:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7bl-000105-Ic
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbcDLXU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 19:20:29 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934186AbcDLXU2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 19:20:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECBBE5506A;
	Tue, 12 Apr 2016 19:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vxQ7b0wEsuv3
	sPT/eosdgzqlils=; b=jcolQO1T8s3lSlI7cBZOZoczn234H+AjzygHh5dkqzSG
	iNmVXkMQdChMLuN6zVAJj6xrcMzyiYwzH4RUI8t1w0avpy5dNjEcf88MFy5h5rqe
	9/fpJ5RdE5L0f7a7Rp3VMMH8maBgmfau0jPtAqhUk+NZyIUWuw52RQo3eS1CZns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K4QTJt
	ssx+TkWPD+gJOEtlKcCOzqhoi1sxiSiLME44sRKsBjdx6/LFjHUvz1bHJSygQyPb
	Jbuc+pflwq3lORr117fr5ecUlfiE1xMxt01iECxXfoT8+mHUod72+X6kntwPIOpn
	Pmd1nr0NwOLHSN9mI+sLy8er5tS37irzj481I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB72155069;
	Tue, 12 Apr 2016 19:20:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A1CC55068;
	Tue, 12 Apr 2016 19:20:26 -0400 (EDT)
In-Reply-To: <1456754714-25237-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 29 Feb 2016 15:05:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 237C61D4-0105-11E6-A041-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291323>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Hi,
>
>> > And MINGW is not happy for other reasons:
>> >
>> > builtin/rev-parse.c: In function 'cmd_rev_parse':
>> > builtin/rev-parse.c:775:12: warning: implicit declaration of funct=
ion
>> > 'realpath' [-Wimplicit-function-declaration]
>> >        if (!realpath(gitdir, absolute_path))
>> >             ^
>>=20
>> I guess you're building "pu"; that is only in sg/completion-updates.=
 I
>> don't know if our custom real_path() would suffice there. You might =
want
>> to ping the author. The patch is:
>>=20
>>   http://article.gmane.org/gmane.comp.version-control.git/287462
>
> Oh, I was not aware that there is a custom real_path() that is
> preferred over the system realpath().  I don't see why our real_path(=
)
> would not suffice, it even makes the code a tad shorter.
>
> I will include the patch below in the reroll.

A friendly ping to see if I am missing new development that followed
this message...

>
> Best,
> G=C3=A1bor
>
>
>  ----  >8  ----
> Subject: [PATCH] fixup! rev-parse: add '--absolute-git-dir' option
>
> ---
>  builtin/rev-parse.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 90a4dd6032c0..d6d9a82c77c4 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -762,10 +762,7 @@ int cmd_rev_parse(int argc, const char **argv, c=
onst char *prefix)
>  					if (!gitdir && !prefix)
>  						gitdir =3D ".git";
>  					if (gitdir) {
> -						char absolute_path[PATH_MAX];
> -						if (!realpath(gitdir, absolute_path))
> -							die_errno(_("unable to get absolute path"));
> -						puts(absolute_path);
> +						puts(real_path(gitdir));
>  						continue;
>  					}
>  				}
