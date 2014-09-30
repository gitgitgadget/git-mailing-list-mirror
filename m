From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not make trace.c/getnanotime an inlined function
Date: Tue, 30 Sep 2014 08:54:49 -0700
Message-ID: <xmqq7g0lt86u.fsf@gitster.dls.corp.google.com>
References: <1411890626-28237-1-git-send-email-bdwalton@gmail.com>
	<CACsJy8ArOU7WF4fiy5vn8zq5y6Vm5JxgTf+Tiai_WOeMSj--Ug@mail.gmail.com>
	<xmqqa95iuxlf.fsf@gitster.dls.corp.google.com>
	<CACsJy8Cnx=KQ02MT354Ly=o04=smbOhnrgCXLNa_tAtOPGmSdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Walton <bdwalton@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 17:54:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYzlQ-0004Nj-Hl
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 17:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbaI3Pyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 11:54:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65279 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbaI3Pyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 11:54:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B33D3D2BF;
	Tue, 30 Sep 2014 11:54:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WDelYmZB6omcgX63s3aRnsPwFXM=; b=DLBqwC
	oOKv9e+9+iXPVEAFAF2omwHZ4KQZO5lZFVod1dfzuD2eZVDWR40W03ms7AwXoYmU
	Tm3C8qpFFIr8XsdLM5L6dpYKkIR+o7zeSYC7JhsLZZRzEo3AJmMEq7E/z6KfY7ZP
	bcJcuIyPwWU/3zLbaARS35QSjDpihysFP7KIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wHf3AYfEzJyHIqUbtnYoU3HvS33mNEE2
	yL9W77EQsaaoYLhCaq6ZIFxNc60vD/EibSsq1Sbyz4SuPtoZCDxnfPTQaEHD24Zi
	d8KB8FVlngUWY+Yubd2k4nkNiIx8zuMlJLsMnwDMHsffw7G/fwp6A5KHC/J/cSRp
	VsbofyZ0RFk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 408F93D2BE;
	Tue, 30 Sep 2014 11:54:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B41CA3D2BD;
	Tue, 30 Sep 2014 11:54:50 -0400 (EDT)
In-Reply-To: <CACsJy8Cnx=KQ02MT354Ly=o04=smbOhnrgCXLNa_tAtOPGmSdA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 30 Sep 2014 16:25:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C843636-48BA-11E4-9374-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257672>

Duy Nguyen <pclouds@gmail.com> writes:

> Hmm.. no. Even if the function is inlined in multiple places, inline
> code still points to the same "offset" variable.

OK, thanks.
