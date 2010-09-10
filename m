From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] gettext docs: the gettext.h C interface
Date: Fri, 10 Sep 2010 15:30:41 -0700
Message-ID: <7viq2dgrji.fsf@alter.siamese.dyndns.org>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
 <1284147353-18000-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 00:31:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuC7W-0005LK-8o
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 00:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab0IJWaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 18:30:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab0IJWat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 18:30:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76F4AD5E61;
	Fri, 10 Sep 2010 18:30:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ItEIPVNRu3VN
	MLBGPssXL1bpzIY=; b=BBHG9eXUlsgWOfS33poCGG73F9cqWx7NkOYoMbbtNKgi
	zw5iTx5kOaigWu//JsgAavW3Vop7xRBC4nkSVLEE2Aa6GEUxy7/vB/+dDDbmo0mT
	/4XkkAAao089DoWXoApFpgRFcM0W0oi9mH36BnPeVHSnnGaNmZEE/6Ny9gz2FwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=abur04
	/v/x4mBd48ZMYMS1K4XSx+iTJCXzJ8SGThanP46ECYbdUooW61oc0LL9JhG4EQI4
	hcVyCCCCdd6Hd2bLx3iSYmlJeMfrcY9DzHCygHtsPCH58pRQjIp7K8q/eAQbG+qF
	s8H1iAOGRagNHVRTF7OsP0697OkeLNkHcjhp4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54FCCD5E60;
	Fri, 10 Sep 2010 18:30:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF98ED5E5F; Fri, 10 Sep
 2010 18:30:44 -0400 (EDT)
In-Reply-To: <1284147353-18000-4-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 10 Sep
 2010 19\:35\:51 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0EC16D62-BD2B-11DF-99EB-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155975>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +C:
> +
> + - Include builtin.h at the top, it'll pull in in gettext.h, which
> +   defines the gettext interface.

Hmm, I would have thought that <git-compat-util.h> would be a much more
natural place for this kind of thing, not <builtin.h>.  Shouldn't you b=
e
able to write a non-builtin Porcelain if you wanted to?
