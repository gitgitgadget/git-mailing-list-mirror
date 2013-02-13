From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] t9903: add tests for bash.showUntrackedFiles
Date: Wed, 13 Feb 2013 11:51:12 -0800
Message-ID: <7vr4kk6lhr.fsf@alter.siamese.dyndns.org>
References: <1360753138.25490.10.camel@mas>
 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
 <1360753321-5002-2-git-send-email-martinerikwerner@gmail.com>
 <7v621wb2sp.fsf@alter.siamese.dyndns.org> <1360776461.13768.8.camel@mas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:51:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5iMl-0005Cc-1G
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 20:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801Ab3BMTvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 14:51:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756093Ab3BMTvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 14:51:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C752B4A5;
	Wed, 13 Feb 2013 14:51:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rna+qX/alqH8QmqnmFABdHnpstM=; b=uRu8/i
	wsw2DigTtuotnbTZEU6Ny8HIVNP/RBEjYB6RKrq8klD0vtBKYWLszp7DGg0wDAvn
	luExuSGm9ZEqaUb5N4Qsf3jJGxzF8LPJlMDM3S+W0YsG6c2r0nac3MBqLzRtbE+d
	EORXKDHbA0puIPEiHjAk7nh6/kYYIj8fDTpNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/MupfxQipB2fIA9EEAc0IgNLIiJHkjD
	L7gTwYNVWK8wJz4eLBfDelZhmJEn7YezwxKKDT5GW28djd5iDnS5D4I7MqybOs6x
	+6Hk71FCkrtFp/6vJ+uT+U1dir+f4LIuVU98JggQrUVMeeRJXlKe8lMOZsiejivv
	+fjM1SztZh0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 015F7B4A3;
	Wed, 13 Feb 2013 14:51:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71102B49E; Wed, 13 Feb 2013
 14:51:13 -0500 (EST)
In-Reply-To: <1360776461.13768.8.camel@mas> (Martin Erik Werner's message of
 "Wed, 13 Feb 2013 18:27:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8B419A4-7616-11E2-9A31-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216278>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> So would it make sense to do:
> 	GIT_PS1_SHOWUNTRACKEDFILES="dummy" &&
> 	unset GIT_PS1_SHOWUNTRACKEDFILES &&
> 	(...)
> instead then?

I think we have sane_unset exactly for this reason.
