From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Mon, 22 Jul 2013 21:08:43 -0700
Message-ID: <7vy58x9aus.fsf@alter.siamese.dyndns.org>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
	<1374314290-5976-1-git-send-email-pclouds@gmail.com>
	<79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley>
	<CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 06:08:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Tu6-0002Ja-MB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 06:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab3GWEIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 00:08:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab3GWEIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 00:08:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 152352B730;
	Tue, 23 Jul 2013 04:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D7RZ7VWirg4BkMsin0R7qjXuPSo=; b=GcSg8j
	cDqfSEK5eVHkWcK+glMPZTlfrsOqx+6oFmHuBt20db81Ofp0ivZDL9Wko6XeSwtk
	v6yhcxF9ZOhyX+J7PhoDQcGfwjL6IjEzzRc2M/tU7J8c+Jrnx5qIrDVtFobvU+nW
	siBJ1HP4fClcQrO/oiuR6ZV6juEjkQZYQkLs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WZBvPoXMJUVfVVwSq346UKlmEnoGhjOx
	74CRw/x+tCXASw3aqff+BC2QehBk1kjXwslC0yThqx5G4GAYHVRsLUV3SD7wqdlk
	BX07/14qh7SuJ5++bjcbL9RzisQO5ZodjviIYgvE7meGBB1kV9xdkf9sE9NTHLs6
	OcmJooAEa5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 092072B72F;
	Tue, 23 Jul 2013 04:08:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DF8F2B72D;
	Tue, 23 Jul 2013 04:08:45 +0000 (UTC)
In-Reply-To: <CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 23 Jul 2013 08:20:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 918E1870-F34D-11E2-8AC7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231018>

Duy Nguyen <pclouds@gmail.com> writes:

> This one, on the other hand, changes the "shape" of the repo (now with
> holes) and might need to go through the same process we do with this
> series. Maybe we should prepare for it now. Do you have a use case for
> size-based filtering? What can we do with a repo with some arbitrary
> blobs missing? Another form of this is narrow clone, where we cut by
> paths, not by blob size. Narrow clone sounds more useful to me because
> it's easier to control what we leave out.

I was about to say "Hear, hear", but then stopped with a question to
myself: why are these "some people do not want them" paths in the
same repository in the first place?
