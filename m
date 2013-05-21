From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Contributing to git: cleaner git -rm & add configuration options
Date: Tue, 21 May 2013 09:35:10 -0700
Message-ID: <7v38tgqojl.fsf@alter.siamese.dyndns.org>
References: <fb43f66aed3826d04b75826e187e3e6c@ensibm.imag.fr>
	<CALkWK0kV_wTbbb15SwVgxW5CVufqJgAjBifT_MwnJXR1-J+3JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu =?utf-8?Q?Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>, git@vger.kernel.org,
	garciagj@ensimag.imag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 18:35:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UepWz-0007Zt-Fe
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 18:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab3EUQfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 12:35:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872Ab3EUQfN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 May 2013 12:35:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06A5920ED7;
	Tue, 21 May 2013 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=u7AAvZSMLrLb
	Us2I8ABam7cX5oc=; b=twDYMhYJaVF+Xx1Sl8oyarLZqIjrkGZOUR/YxHj/t0vO
	zOA+FA8P4on4hUQR6HdX7xYtdleWVOEL2jaB+CpjDNdZSsqN0l/MnBl5TzNxJAfb
	pCeZvAqhhHCbjRDIIzYsOyt86yqIykzrPzlRoJOhPnpGRClDsqB65Z6ZgBBljRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VnZKwJ
	q/+2I9XnPIfb/ChL6P4VomGglgp4bZIkL3nt7Cahby0V+siqAwYSQAIHmE0b5uZg
	4jdo+N+GgCDEfriSIjyk68u3lbLDnb5DJfOExtaHnIKujYjwU1VA2sMG6hF2k7SZ
	uHqS3LT76Nf/7w3yZ7P5iIi8HFpn3jrxXPpE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F03AA20ED5;
	Tue, 21 May 2013 16:35:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6080020ED2;
	Tue, 21 May 2013 16:35:12 +0000 (UTC)
In-Reply-To: <CALkWK0kV_wTbbb15SwVgxW5CVufqJgAjBifT_MwnJXR1-J+3JQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 21 May 2013 12:50:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68A18EDC-C234-11E2-AF06-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225039>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> [+CC: Matthieu Moy]
>
> Mathieu Li=C3=A9nard--Mayor wrote:
>> -Cleaner error message when "git rm" fails with multiple files
>
> Should be fairly straightforward to implement.  Just collect the
> errors and print them out at once.
>
>> -Add configuration options for some commonly used command-line optio=
ns
>
> I'd really like status.short, status.branch, am.scissors and am.3way.
> Should be fairly straightforward to implement, although others might
> have different opinions on the names of the configuration variables.
>
> Also, I've taken the liberty to remove three ideas from the list:
> jk/fetch-always-update-tracking, vv/help-unknown-ref, and
> rr/rebase-autostash are already in `pu` and will hit `master` soon.

Matheiu, please ignore the "will hit 'master' soon" part.  These
particular implementations might be ejected from 'pu' without
prejudice and discussed further.


But the idea is the same.  Somebody have already been working on
them.
