From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 4/4] Write to $XDG_CONFIG_HOME/git/config file
Date: Fri, 08 Jun 2012 23:19:17 -0700
Message-ID: <7vipf1aty2.fsf@alter.siamese.dyndns.org>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <CAJDDKr6sCrwy99-5-sOaAuNjYmnw73CicF3PyYMe8hvf38oFvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 08:19:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdF1X-0000gn-Tl
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 08:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab2FIGTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 02:19:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab2FIGTU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 02:19:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC1305297;
	Sat,  9 Jun 2012 02:19:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8noYdYYxrtiJdSHU5NNioUEplqg=; b=nizbSn
	AOJXKOtJkSV9uuv8IyhUIlTC7RELJJBDq2JItCuUQjfYw9BxN7wy5PXA7IXizfpo
	xxyaYMKggmO+ZCpFKpLh0LEYT99oOEo6Qjc3fWiH3TsINRYxlP6vrCncWJ+E/6lG
	YRdizNrS7UN9uKnVA1Hv/L40TRkLk0lKm/DbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pgvvwp9MPdAp/TUDxHCcQbKkiJbeXOl1
	LdrI9Zjw1dUJtEbkFxC5xtxWmRD0VNnbdeuxJUE4Qm0/LkJW2o9vr4dRqOs4eMMk
	09rA9Qt25UG0GeUi7hQ2DwYa/Jf8mMTH64EoUsmdYHrDgS0r3pPDAdp4ToMquFsw
	v9NCXjuTA4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1FCA5296;
	Sat,  9 Jun 2012 02:19:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 345CB5295; Sat,  9 Jun 2012
 02:19:19 -0400 (EDT)
In-Reply-To: <CAJDDKr6sCrwy99-5-sOaAuNjYmnw73CicF3PyYMe8hvf38oFvg@mail.gmail.com> (David
 Aguilar's message of "Fri, 8 Jun 2012 20:48:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BE9EEFE-B1FB-11E1-B13E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199545>

David Aguilar <davvid@gmail.com> writes:

> I'm all for this change too.

Do you mean just the general direction, or including the
implementation?

> I did a little research RE: the OSX and Windows question.
>
> glib makes no differentiation between OSX and Linux,
> but Windows does have its own #ifdef.
>
> http://git.gnome.org/browse/glib/tree/glib/gutils.c#n1251
>
> I certainly don't think this should affect this series,
> I'm just noting it as something that the Windows folks might
> care about.  Perhaps something for compat/ in the future?
>
> The downside to doing the same as glib is more documentation.
> The upside is... consistency?

Probably.  I think we should follow whatever existing and prevalent
practice is, and my gut feeling is that we would end up first doing
POSIX only thing in my tree, and msysgit folks will quickly feed me
updates to tweak the behaviour to match what of Windows version.
