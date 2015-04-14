From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --date format
Date: Tue, 14 Apr 2015 10:10:59 -0700
Message-ID: <xmqqoamq3aak.fsf@gitster.dls.corp.google.com>
References: <CAHtLG6SPqoZJ+bc6eaHEAkEN9VAwuq+hh4OUG8opOETRQKfUyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 19:11:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi4Mg-0000Ns-0a
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 19:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbbDNRLG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2015 13:11:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933038AbbDNRLE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2015 13:11:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3F95472F4;
	Tue, 14 Apr 2015 13:11:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=41z8SnvKfoPY
	OPlxIFuQ5rflzUk=; b=vkWrG4ujlX3XvFyVCsfiD6jF8uQdGFPdk5p08YL7ONr9
	cxzQbGeVT47SpPgm25DgCm+3yTFw4LW45SWZOGFpgwEZZ/8+dlpgyzSHkYftD/dz
	BPZNz/t7hA04FrnBpQssG55dfqCkivIa3in5e7cnMExx0L9zDAn5GNrIp4Sf/s4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Axm9gA
	kYnRScoHRUNKf2K6oCZafkN+xTm5dHMBAAvw3MoFtRk7hkpFO36txFiennvGMLWi
	FimSI46LkYR6v9Pb6pDIplaGh+AoIjtG7emomfsBZC0TFGfSq55ucDhxKlPfQxas
	QHKkURXX8hI3otmzgnApLYcRKVM7ReaSh+rf4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC16D472F3;
	Tue, 14 Apr 2015 13:11:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38F03472F0;
	Tue, 14 Apr 2015 13:11:01 -0400 (EDT)
In-Reply-To: <CAHtLG6SPqoZJ+bc6eaHEAkEN9VAwuq+hh4OUG8opOETRQKfUyg@mail.gmail.com>
	(=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Mon, 13 Apr 2015 23:42:18
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39B9AE26-E2C9-11E4-938D-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267149>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> Hi,
>
> In git < 2.0, git commit --amend --date=3D"" can amend commit with
> current time as author time.
> But since git 2.0, this does not work, dying with "invalid date forma=
t".
> I have to instead type git commit --amend --date=3D"now".
> Is empty string date format no longer supported? Or will be fixed?

I think this was a fix to the overly loose parser which took any
typo (including an empty string, e.g. --date=3D"$prevuois" that
misspels the name of a shell variable that has the timestamp) as
"now".
