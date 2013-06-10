From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: remove ancient "ensure colon in COMP_WORDBREAKS" workaround
Date: Mon, 10 Jun 2013 13:48:52 -0700
Message-ID: <7vhah5g097.fsf@alter.siamese.dyndns.org>
References: <1370822361-15637-1-git-send-email-szeder@ira.uka.de>
	<20130610000954.GA6464@elie.Belkin> <20130610091419.GF2091@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 10 22:49:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um91P-0003Ul-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 22:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab3FJUsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 16:48:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab3FJUsz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 16:48:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52D9526CA3;
	Mon, 10 Jun 2013 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xfZVsRW0iexz
	e8jnF6a+H1RBNIM=; b=P+OkKmlCeeVmwyIG/T+IL4/ZB8WtemWb/7168Oe/AxgI
	PSJsklMw+5hTm1OtUY1K1pibuHLJNsnLJWQtHfrejvq7poq6JSgRKyjm+EItrn3N
	V0LJxwO4oIamAINujAwT3KUi/NrBhpgFGOtBTkTAwNXS7pBml+zpExD0zuWYEyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I4dYwX
	CFn5rfsEj2qtu6JgigI/9zZecDDDsbo9cJWJJhlrpuLXzAgEKQdjfhdmcQUFRjmm
	lNLkqpQiShR4xhaE+oj2FyfEhsdcS6Wv/BgkgTBJFETf1j32msaVQJnWxAV3tzgt
	Ogx+ZLAPbLB5RQiAoDEw/1bKLzIJOsmxZrJ88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47CE226C9F;
	Mon, 10 Jun 2013 20:48:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B58E426C9E;
	Mon, 10 Jun 2013 20:48:53 +0000 (UTC)
In-Reply-To: <20130610091419.GF2091@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Mon, 10 Jun 2013 11:14:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29862E7A-D20F-11E2-B678-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227375>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Anyway.  Although the completion script in Fedora's gvfs package migh=
t
> be fixed, there are other completion scripts making the same mistake,
> so I'm afraid we should keep the workaround and drop this patch.
> Moreover, we should even consider extending our workaround by adding
> back '=3D' to COMP_WORDBREAKS, too.  Oh, well.

Thanks.

Perhaps the summary of your problem analysis deserves to be added as
a in-code comment to make sure others won't later try to remove it
only by checking how old Fedora 9 is?
