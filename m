From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git objects mode 755 vs 700
Date: Thu, 11 Dec 2014 14:50:44 -0800
Message-ID: <xmqqmw6tdcmz.fsf@gitster.dls.corp.google.com>
References: <8195C4C373DD42D6813F0181902AC916@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Evan Li <li.evan.chao@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzCcs-0008Cr-5G
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 23:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966683AbaLKWuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 17:50:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966346AbaLKWus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 17:50:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7EE62571D;
	Thu, 11 Dec 2014 17:50:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r1rJDp3eQPyo5U4iIPqP53e3ryc=; b=dTRK/m
	3xQuZ3x9VVfeio9LK0W+fMvKFHkOY4nPFpd3GY+/nN1zpoEttmaXUUrH53YyvjU2
	4vQ78bdorplm3x/swwOkWA3jNn0AduVLpr9PyCzN+oTZ0szx6INQNzDKh5hGtV7i
	jCTjOGxB0HlvGLUIDEoQR6RR2jhCM1iZz5LnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r5Fn2qzexV05qlRlIV86EcEhPgNQufia
	NSzTXhq1vFCKjG1eMrFhiOgQRkGbcmbWlL2yK37BPhCLwLol0YU3EgWY8h4UXds6
	H4kzmxKilDZfF3NMvWX9ovvI+hsYkr44jr3CaKWxFP/eY3WuvutU5T8Ef3wiIW1r
	lVPcnEL5kr0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C56132571B;
	Thu, 11 Dec 2014 17:50:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4067B25719;
	Thu, 11 Dec 2014 17:50:45 -0500 (EST)
In-Reply-To: <8195C4C373DD42D6813F0181902AC916@gmail.com> (Evan Li's message
	of "Thu, 11 Dec 2014 21:48:09 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 24509CCC-8188-11E4-B7A5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261300>

Evan Li <li.evan.chao@gmail.com> writes:

> Why some of them are of 755 but some 700? How can I set all
> sub-directories under ‘objects’ to be of 755 mode?

Some people who are pushing into the repository have 077 and some
others have 022 as their umask, perhaps?

If that is the case, perhaps core.sharedRepository configuration
setting is what you want to use.
