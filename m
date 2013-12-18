From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -A fails in empty repository since 1.8.5
Date: Wed, 18 Dec 2013 11:56:24 -0800
Message-ID: <xmqq1u1ahr13.fsf@gitster.dls.corp.google.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
	<CALWbr2wXxSU4qD_Gj5P7aYxB39tEVBa-TDALVepuwZLh+RNU1Q@mail.gmail.com>
	<CACsJy8DY7eZm7-P=azJF-jEiBKM_QPf_GXG3uzbuw5C1vq1Q5A@mail.gmail.com>
	<xmqqioumhtvp.fsf@gitster.dls.corp.google.com>
	<vpqvbymarnw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Dec 18 20:56:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtNEO-0003iq-3p
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 20:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146Ab3LRT42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 14:56:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab3LRT41 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 14:56:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D41915A466;
	Wed, 18 Dec 2013 14:56:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X7/t/uUoBI241l9IrdsNTdoXoXs=; b=oDX5m5
	hIIq8g1cydIhYklQ2p4+cShFVZ8WsW/DUd+SEuTpiGMD1svgeTYDpX2t6BbYMhsu
	aPHJFVo3TXE4LXihk4mnfMKLv0KK4nSOMuqiiMmZsmj/wnzGJCv2e1NTtKWj19x/
	VUeo7Ur6e8xtN1akvWyX3k4DuOoMgUgx8xpd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z7oH0NJZ4opd28W51FJCCPd6ZJmE85XY
	k2Qhr5YD5FKvvJyDhar6xdoWa9pv3mx4liLNXnbbDHd7sleKTpxXrluI9pAo7VEG
	qEfvvREL8+OM98XWWj3mDSnsiTapP7LC5rd5JcYjZk/v0QCUzkypWUoaaRJJ0BOa
	aQ9Texxiu6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA0215A465;
	Wed, 18 Dec 2013 14:56:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0CC55A463;
	Wed, 18 Dec 2013 14:56:25 -0500 (EST)
In-Reply-To: <vpqvbymarnw.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	18 Dec 2013 20:24:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A2CD39C-681E-11E3-86DA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239475>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> It could be argued that a "git add [<any option>] .", with an
>> explicit "." given by the end-user, that is run in an empty
>> directory may be an error worth reporting.
>
> But what we have right now is really weird:

I know.  That is why I said "It _could_ be argued".
