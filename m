From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] name-hash: allow dir hashing even when !ignore_case
Date: Thu, 27 Feb 2014 15:20:31 -0800
Message-ID: <xmqqk3cgw3b4.fsf@gitster.dls.corp.google.com>
References: <cover.1393059605.git.tr@thomasrast.ch>
	<38527c9f6ae31ad39d8f3dddfe5252a3527629ed.1393059605.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Feb 28 00:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJAFs-00088B-Q8
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 00:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbaB0XUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 18:20:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbaB0XUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 18:20:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1867F7009C;
	Thu, 27 Feb 2014 18:20:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=nV+o5Ws0pofH018oDFW71PDBJ78=; b=W/fxlH+jnntTTh8jXwfx
	cFBGjw3wvTe/sITtBV5w9oizsCOKjOZCbRtlZNAYzGrCBdZLWXrsVKQ8kNYzYj2L
	bOR8EYGqQ9qpK5hncV0CbGZ5Og2ZeRzSM9yEkZ34HQJQWEyYgxV2qS6Otxbastvy
	B48noBQkUQsP1ZFBeg0xw5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MMP5i9qXlc1iB0Tb/1YdQqzvB7lSmcPPjuZwcgmaFZtVkB
	Wmj2KbFCX1Olnnh80tOQzklWSVrDzrXDWHSJ+ouQ7MI1E0GpoIm86/UI7+0I1N7p
	0FyYjcJ2AEjwij6A0mvmtl/JX3UWyc12OnLKn2sdeD9eBg48qaBq5eaCGc2dw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE53B7009A;
	Thu, 27 Feb 2014 18:20:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41AD470098;
	Thu, 27 Feb 2014 18:20:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C17DE23A-A005-11E3-B22E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242873>

Thomas Rast <tr@thomasrast.ch> writes:

> The directory hash (for fast checks if the index already has a
> directory) was only used in ignore_case mode and so depended on that
> flag.
>
> Make it generally available on request.
>
> Signed-off-by: Thomas Rast <tr@thomasrast.ch>
> ---

I somehow had an impression that we were getting rid of these two
hashes and merging them into one, but I do not see any such change
between 'master..pu'.  Perhaps I am confused with some other topic.
