From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Fri, 06 Jul 2012 00:29:41 -0700
Message-ID: <7vpq89ny8q.fsf@alter.siamese.dyndns.org>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
 <7vd34arvhu.fsf@alter.siamese.dyndns.org>
 <7vtxxmqezp.fsf@alter.siamese.dyndns.org>
 <1341559103.10752.59.camel@flaca.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 09:36:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn35N-0000I8-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 09:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab2GFHgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jul 2012 03:36:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51227 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997Ab2GFHgD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2012 03:36:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D93198BA;
	Fri,  6 Jul 2012 03:29:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vN0E8F7zqeVJ
	iHbjCJoHDt+92Ik=; b=noPVhNPhRXv17Vu4HwWz8y9kYqiTa9PegYd9TMcGlHHb
	0oF3wyvlbt9VaQz5U1/iIA/l7FJBeDhTm9LbjseKrtfWrLCdCRzaehsWP5oWW24B
	viFCpXaukBTHKyWTVZgM2ZD7jISN+XfQOe2EDeUZ2ws53SEhOb7m2+hBo1oextw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rK7gfm
	lV4HSl8fbnYT3YgqKcXvpKoHXTE6xvBAeRMnM6wZUrOoi1CgRz2Ry12iCx1AhHZY
	ly1esIkLW/MUdBqd0r0COESKJ70Zswia26mo6kamOHYoyXlpsSxg5+024vd+SLR3
	+nFIOFapZ3ii2iqUwrPegAbsn5ryENVTM7Z7g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 250CA98B9;
	Fri,  6 Jul 2012 03:29:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB71C98B8; Fri,  6 Jul 2012
 03:29:42 -0400 (EDT)
In-Reply-To: <1341559103.10752.59.camel@flaca.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 06 Jul 2012 09:18:23
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A70B35E-C73C-11E1-A341-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201088>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Yep, this seems good. Now that you mention the <name> existing, I won=
der
> if letting --set-upstream create the branch as well wasn't another ba=
d
> decision, as the name suggests it's for setting that information afte=
r
> the branch has already been created.

You should be able to correct that for --set-upstream-to=3D<upstream>.
It is clearly about setting upstream for an existing branch, right?
