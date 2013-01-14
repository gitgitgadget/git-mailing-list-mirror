From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] cvsimport: introduce a version-switch wrapper
Date: Sun, 13 Jan 2013 17:47:40 -0800
Message-ID: <7vr4lofscj.fsf@alter.siamese.dyndns.org>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358127629-7500-1-git-send-email-gitster@pobox.com>
 <1358127629-7500-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, mhagger@alum.mit.edu, esr@thyrsus.com,
	chris@rorvick.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 02:48:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuZ9g-0008DZ-Ot
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 02:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab3ANBrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 20:47:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832Ab3ANBro (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 20:47:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0F6EBC1E;
	Sun, 13 Jan 2013 20:47:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CLIreyAXp5ZVRx9+4EUwYO3YFHA=; b=vBQdPL
	KHO6xadcFTTX/yTraLsl+4lPdb+XBPXmXWnxhHrnSsqQu96QdDekf20ZqTlBkn+6
	gs00eEIgg+ly6p1bC4P05gWG6AKBL4MrjtaTK/CJbWoBgE+LDugjPEk4eIAvqsd7
	tul7skXK1hOqP1Tl4MVR3Qg1IKRaLcYvMYJuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UKG7KJKnKPK4oYI9bzNpbrbF3Xw09BmO
	4A4sx9/S42zfXKY/ZoKLu1Gfx9BNrrZMlRdlHV/SZetuPK1ZNJqKZivWLqhaeIxK
	50HEeG1PZ9dkbwVQ1ZyvcVHrvZk4wXplrvT/szuxjTtGjyOYv41sozWDfktlW4hg
	HjkHj1+ZreI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D52B1BC1D;
	Sun, 13 Jan 2013 20:47:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F709BC18; Sun, 13 Jan 2013
 20:47:42 -0500 (EST)
In-Reply-To: <1358127629-7500-3-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Sun, 13 Jan 2013 17:40:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 633FF82C-5DEC-11E2-B59E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213419>

Junio C Hamano <gitster@pobox.com> writes:

> In preparation to have both old and new cvsimport during the
> transition period, rename the cvsimport script to cvsimport-2
> and introduce a small wrapper that we can later change it to
> allow users to run either frontend (with their corresponding
> cvsps backends).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  .gitignore           |    1 +
>  Makefile             |    3 +-
>  git-cvsimport-2.perl | 1179 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  git-cvsimport.perl   | 1179 --------------------------------------------------

Sorry, I should have done "format-patch -M" for this one.
