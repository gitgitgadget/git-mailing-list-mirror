From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Get rid of the non portable shell export VAR=VALUE costruct
Date: Fri, 23 May 2014 14:25:03 -0700
Message-ID: <xmqq8upsi3ww.fsf@gitster.dls.corp.google.com>
References: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqmwe8jr44.fsf@gitster.dls.corp.google.com>
	<20140523184405.GE12314@google.com> <537FB249.8050708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	dak@gnu.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 23 23:25:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnwxp-0000OA-Dz
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 23:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbaEWVZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2014 17:25:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62053 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbaEWVZJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2014 17:25:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 084A31B978;
	Fri, 23 May 2014 17:25:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BXOyJam1CFqB
	qaEQovuXbBY5gbA=; b=H67+Og/Sm8WGNBYVdYvnKznbOyaIC80WNbgkEKfQ5Ef7
	XKylptEQWXFUix9t79wBLw6IZut9SVVCfKcZj6g0bXo1G5tZN8LI8D+awYj9H2ju
	21jQ3WYjdTQPzFgGGQLvCZQzdoPrFaLSkqfRMUNoex+hqmc6uxcQsbdbFrzu/qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EuzafW
	qXOJAyVTwS0E6AB6XXY3znGFJ4VWx2NA3yRUiQnlNbL9KYs5CZ5XIiz/yC5SSBxg
	aKSTtKZLf7UI9HukNLFiEDpBUVjFxb4r4pbCa6KN9PTq2AG670C23UvozcArYLEi
	A8H6jvcH3iFqxdtmbJvCgm2ut1oVnKYNQbz5U=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F18F11B977;
	Fri, 23 May 2014 17:25:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4628D1B974;
	Fri, 23 May 2014 17:25:05 -0400 (EDT)
In-Reply-To: <537FB249.8050708@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 23 May 2014 22:40:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B534D008-E2C0-11E3-B16C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250035>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I wonder if we could keep the anchoring (to reduce false positives)
> and try to catch a line "command1 && command2" at the same time:

Well, "command1 || command2" would be the next thing you want to
catch, and I think you are at the entrance of a slipperly slope at
that point.
