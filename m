From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote: Remove -v/--verbose option from git remote show synopsis
Date: Thu, 08 Jan 2015 12:14:41 -0800
Message-ID: <xmqqoaq9do7i.fsf@gitster.dls.corp.google.com>
References: <1420739863-11602-1-git-send-email-kuleshovmail@gmail.com>
	<54AED7C3.8010604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9JTl-0001P3-QU
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 21:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbbAHUOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2015 15:14:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752141AbbAHUOo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2015 15:14:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8054B2EFBC;
	Thu,  8 Jan 2015 15:14:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5WPuzu/Detue
	cyqnAvvTkdor/6k=; b=V433bakHypdluU8E6YG6tyXkTcLP+HhCTG0Mkw74KzVe
	l5dXXw9Qt1FS5XAFo4dJV8EfnnruO2Gkzb/BxiYfxR1AkZdwW7sBpFyHt50ZNFmh
	4ae6UFe3KauPtGpTX9IeJtzOuG7n5bkO2rMhrcv7G2+20wxkiMylsk7K+NgXRXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qw/DII
	c5LFKzB7HSy1+HXzBFsGcXSw4ZQ7JhhQmgRniRKEmG2GUAW0Z9XRlYVyw6jGUF76
	aVGN7TEWGCgSqQNebI8wD6RM0RpPGGF/nRufAhvnqXU32YOgafXEPAMoQbi3ePSf
	Zhu7YrOe39ke+mX0bwQLGm9I90JVHCTzM6yB4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 778112EFBB;
	Thu,  8 Jan 2015 15:14:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03C792EFBA;
	Thu,  8 Jan 2015 15:14:42 -0500 (EST)
In-Reply-To: <54AED7C3.8010604@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Thu, 08
	Jan 2015 20:17:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB8BB8CA-9772-11E4-9AA2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262219>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 08.01.2015 um 18:57 schrieb Alexander Kuleshov:
>> git remote show doesn't use -v/--verbose option
>
> Hmm, but it does?
>
> 	$ git version
> 	git version 2.2.1
> 	$ git remote show
> 	origin
> 	$ git remote -v show
> 	origin  git://git.kernel.org/pub/scm/git/git.git (fetch)
> 	origin  git://git.kernel.org/pub/scm/git/git.git (push)
>
> Perhaps you meant the following variant?  The changed line documents
> the one above, though (-v before show).
>
> 	$ git remote show -v
> 	error: unknown switch `v'
> 	usage: git remote show [<options>] <name>
>
> 	    -n                    do not query remotes

Ahh, I misread the patch.  Thanks.

>> diff --git a/builtin/remote.c b/builtin/remote.c
>> index 46ecfd9..978c645 100644
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] =3D=
 {
>>   	N_("git remote rename <old> <new>"),
>>   	N_("git remote remove <name>"),
>>   	N_("git remote set-head <name> (-a | --auto | -d | --delete |<bra=
nch>)"),
>> -	N_("git remote [-v | --verbose] show [-n] <name>"),
>> +	N_("git remote show [-n] <name>"),
>>   	N_("git remote prune [-n | --dry-run] <name>"),
>>   	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> |=
 <remote>)...]"),
>>   	N_("git remote set-branches [--add] <name> <branch>..."),
>>

I however have a bit larger question.  Does it make sense to have
[-v/--verbose] in front of some but not all of the subcommands?

=46or example, the above snippet gives me an impression that

    $ git remote -v prune -n origin

should not work, but that does not seem to be the case.
