From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sat, 26 Jan 2013 13:43:23 -0800
Message-ID: <7v1ud71uys.fsf@alter.siamese.dyndns.org>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de>
 <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org>
 <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
 <51037E5F.8090506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 26 22:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzDXO-00047H-RF
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 22:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab3AZVn1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jan 2013 16:43:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33230 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178Ab3AZVnZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jan 2013 16:43:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C5E8B66E;
	Sat, 26 Jan 2013 16:43:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X0k3QMG1EXKZ
	g/DB4ofwQgcR7t8=; b=kVRzT10VOKAf3ZYcf8pxQR6QeWx0lwYIB1Gks7fClHNU
	+pouOuaKu/uzR5FXKNP/UHVJUt2vMz8NGLMxRuiy7HLYxD/EsUHU4OExhPij9b/e
	1zfu3to5U0R5GDc3YJ7UsCAyQAI2P2+u7Wf6jNRl7GaJ+Iog/3rFJvUjlwDDFf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Dqb3IU
	UXe58CAYjuW425N25gRkWRdU1kULxrOHa19Nm6TF0g3FMh3x6R/+373jk79TzrVu
	gtFisMOFtqccVmFZVgA9oSXIk3wWqgvjVOAIgpxmyvQGZ8j1KgcrolHUjDcnpZX9
	xZOfs1/VWL8ETiSZxBEKcJgrVL56aloLJA3CQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FB30B66B;
	Sat, 26 Jan 2013 16:43:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90FF0B668; Sat, 26 Jan 2013
 16:43:24 -0500 (EST)
In-Reply-To: <51037E5F.8090506@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sat, 26 Jan 2013 07:57:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6955C3F8-6801-11E2-8F25-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214638>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Do we really need  "which" to detect if frotz is installed?

I think we all know the answer to that question is no, but why is
that a relevant question in the context of this discussion?  One of
us may be very confused.

I thought the topic of this discussion was that, already knowing
that "which" should never be used anywhere in our scripts, you are
trying to devise a mechanical way to catch newcomers' attempts to
use it in their changes, in order to prevent patches that add use of
"which" to be sent for review to waste our time.  I was illustrating
that the approach to override "which" in a shell function for test
scripts will not be a useful solution for that goal.
