From: Junio C Hamano <gitster@pobox.com>
Subject: Re: http-protocol question
Date: Tue, 02 Dec 2014 09:45:06 -0800
Message-ID: <xmqqzjb6kkt9.fsf@gitster.dls.corp.google.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
	<20141202033416.GY6527@google.com>
	<CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
	<20141202044522.GZ6527@google.com>
	<CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
	<20141202053331.GA31516@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bryan Turner <bturner@atlassian.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:45:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvrVr-0000QF-2c
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbaLBRpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:45:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754298AbaLBRpM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:45:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98BF023BA6;
	Tue,  2 Dec 2014 12:45:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jI8U62fWV9YQikRLhONm/Ts+/vU=; b=pn4CVC
	GdmQlRKZgxcodArgRJ0i142Q4Xy+sgJYKattJCVB9R2mDewnZR51NB45DZXxQzE4
	EQejMP+cu9f4xSFbEl9tNw3Ioo9iLVi60Rl67EFyxW0Rm3PM8+nUwmfcj7PJqT03
	PNc9H47CNtGzcgu/lmRFQ8C2GpBx0R+VeMmAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m3rWtM78C60+hcSJWmaeg4NMcUmztT7o
	ZnSys6rAM/6ImBhjxDPlVs54JhNNQdYYepYOuRWFifWHKOmBLsQPGDVb5UtVfqz5
	Jp9pHy2CUcoDtRAoWeMtUMbXaCOLv/2wqyw1yZE8QXDq4t3tabpZJ5kuN1H+KqeK
	3MSTp5ah0lY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DE1623BA5;
	Tue,  2 Dec 2014 12:45:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1E7923B9E;
	Tue,  2 Dec 2014 12:45:08 -0500 (EST)
In-Reply-To: <20141202053331.GA31516@peff.net> (Jeff King's message of "Tue, 2
	Dec 2014 00:33:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F53FA2F0-7A4A-11E4-9993-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260586>

Jeff King <peff@peff.net> writes:

> For a public repository, it might make sense to provide a config option
> to loosen the is_our_ref check completely (i.e., to just has_sha1_file).
> But such an option does not yet exist.

In principle, yes, but that cannot be has_sha1_file(); it has to
have a fully connected healthy history behind it.
