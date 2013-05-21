From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reading commit objects
Date: Tue, 21 May 2013 15:22:12 -0700
Message-ID: <7vzjvokm7f.fsf@alter.siamese.dyndns.org>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
	<CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
	<CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>, git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 00:22:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueuwl-0003DE-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 00:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab3EUWWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 18:22:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab3EUWWP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 18:22:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE6A721A40;
	Tue, 21 May 2013 22:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J7Xu/KZT6vGLIuVBexRUomi/xYw=; b=jX9BjE
	BxarubBfZHnreWfRfUJjUZazatGkYK5unA99zAsvHoC+H3pO8sYsfPmglaMzO1HR
	rD0dYpBWnp+c4l+JBEpILY9Fk2yVH0H+KnZlXpy5/wEXYWl9kugSXKYDhGGbGlws
	fXwDQTAC67fpN5bzyRzjSAu83bkY8o79pkGbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YTe8MOBCnlqHnJvBPVqvKSZRIK59Ev+I
	b+W09REqVZ7uEmpOy8nEXeDsCDiDf0SdgYZ0/S5zB+rNiMzDKJ+aICiy3motOpqS
	daamkIpC6txIFc3ucFQ0kRxNCRFjCQaX17bJbuyGzXg0JTXy301Oxs3fYYmYz9Cg
	Zh3Yurb4y9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4DC721A3F;
	Tue, 21 May 2013 22:22:14 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3994E21A3C;
	Tue, 21 May 2013 22:22:14 +0000 (UTC)
In-Reply-To: <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
	(Chico Sokol's message of "Tue, 21 May 2013 19:18:35 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E36A207C-C264-11E2-ADDA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225086>

Chico Sokol <chico.sokol@gmail.com> writes:

> Ok, we discovered that the commit object actually contains the tree
> object's sha1, by reading its contents with python zlib library.
>
> So the bug must be with our java code (we're building a java lib).

Why aren't you using jgit?
