From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: show manpage for aliased command on git <alias>
 --help
Date: Tue, 05 Mar 2013 08:16:18 -0800
Message-ID: <7v8v61vn3h.fsf@alter.siamese.dyndns.org>
References: <1362494681-11419-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:16:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCuXr-0003aQ-NV
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433Ab3CEQQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 11:16:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290Ab3CEQQZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 11:16:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFD7EAB42;
	Tue,  5 Mar 2013 11:16:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dJe1ZuZV+Nia
	pQRvvVTUj+4ETMw=; b=ni0R/yet3S4yOw2+uQu4fxkA/oH+qCo4qRdg+YIV3pmM
	Eg/BfORqKxKNnndgNalNTlKF1Rpehp3/vArylDgeXwTUa8Jbs55FWwj4hxb3ORkI
	VIDBSyMQzHx1OqD34L5uTjW6VzCk96ZTHgwHHearKPI9Tg6M4Ih1w+wp/Nd/sD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bmzgpI
	ewBWACy46wxct/MxQ7gmYzuCrBGKILMoe9dXEMkQhsSxNXWzJKtpUGEljNQhGYvj
	Rj2gTKxUWPJEuvxFC2aZBVZRkMIhTao8FEoAkm0I5waU1n7RWdI6yjrSiithrfkg
	6II8+YtrZLwqEpjOEW6X1PJ4mjZPRn8be0NX8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84F5AAB3F;
	Tue,  5 Mar 2013 11:16:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7801AB3A; Tue,  5 Mar 2013
 11:16:20 -0500 (EST)
In-Reply-To: <1362494681-11419-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 5 Mar
 2013 14:44:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04DA42C4-85B0-11E2-8D47-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217460>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the semantics of "git <alias> --help" to show the help for the
> command <alias> is aliased to, instead of just saying:
>
>     `git <alias>' is aliased to `<whatever>'
>
> E.g. if you have "checkout" aliased to "co" you won't get:
>
>     $ git co --help
>     `git co' is aliased to `checkout'

If you had "lg" aliased to "log --oneline" and you made

    $ git lg --help

to give anything but

    'git lg' is aliased to `log --oneline'

I would say that is a grave regression.
