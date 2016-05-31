From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to add custom metadata to Git commit object
Date: Tue, 31 May 2016 08:25:12 -0700
Message-ID: <xmqq4m9e6yhz.fsf@gitster.mtv.corp.google.com>
References: <959E96F7-0FF3-4336-B098-58836136DB08@jetbrains.com>
	<20160530183016.GB17253@sigill.intra.peff.net>
	<xmqqtwhf8jl7.fsf@gitster.mtv.corp.google.com>
	<A5ADADA5-B772-488E-8FAD-20FCB68E5933@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	kostix+git@007spb.ru
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Tue May 31 17:25:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lY3-0001Jc-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949AbcEaPZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 11:25:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754496AbcEaPZS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 11:25:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DF331CB5F;
	Tue, 31 May 2016 11:25:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Efs69Ob2BoyD
	rU+/QOk8OKhwMow=; b=BWmkQLtMn18/LSEBsFcbjkP3jG3Xusa+UUy3BfINUUlA
	TR88v36TAPcZcBZQ7KCRbSYIveXVVGtSkmkhyCX1vwmZwEOCmNnttAZz3L/IE/vO
	/jZRsuPlEHnIVfZ1OuXCI4jByZBgx56huVoFNXFXDTd+ytB+xVlagf9U409ShtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BQo4ni
	gtwGnSwjiukLzuZTNVm6wz+0q4U00paKF4JWsuZGbgZ1qvMORXKTxLk5ost0Wvog
	n8GXn6OmJxi+4dknpM7Fh57O43ko+ux6Pi/0YLgReSG3DRWsyvAB2MolX0KoLkE3
	yV7I3VdUJic8fmekpwY5OcNfb793g9Dh38axg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 056681CB5E;
	Tue, 31 May 2016 11:25:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D0DC1CB5C;
	Tue, 31 May 2016 11:25:14 -0400 (EDT)
In-Reply-To: <A5ADADA5-B772-488E-8FAD-20FCB68E5933@jetbrains.com> (Kirill
	Likhodedov's message of "Tue, 31 May 2016 18:17:23 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF5F95E2-2743-11E6-8422-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295985>

Kirill Likhodedov <kirill.likhodedov@jetbrains.com> writes:

> Just out of curiosity, is it possible to add a custom invisible heade=
r=20
> to commit object with some Git command?=20
> git commit or commit-tree don=E2=80=99t have an option for this.

There isn't, and that is very much deliberate. We do not want to
make it easy for people to even experiment with such "custom"
headers; we want to encourage people to find solutions to whatever
problem they are trying to solve that does not involve touching the
object header.
