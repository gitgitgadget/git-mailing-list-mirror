From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 06 Jun 2012 15:54:34 -0700
Message-ID: <7vy5o0jbkl.fsf@alter.siamese.dyndns.org>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:54:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScP7q-0008Uc-Df
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 00:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759189Ab2FFWyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 18:54:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759167Ab2FFWyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 18:54:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 656248B37;
	Wed,  6 Jun 2012 18:54:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=cnzadzIAsutAoWkpPhsbUxBaq0w=; b=odQ+QCblg3YXkMTb0xKl
	Zy/NYJRcA9i/aH6e5L8WIqXvpReC1NX0YIxGsg63D/vT3pVMp1e5TKg2fdIlw4FL
	/ilVFJrK/S/fFUQ8ZSQRsdnr75erTSYEHqFKnQ3U+DZvExbCgh5o6TcXCKsG4TTS
	2M4m0TbfcD4tvWkPxoUbieE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=lYtZO+kdc+vNS3VWEHfFZllY43IZ4GPZQYQyufh28Zpnrs
	9YMUE3sRz40CM90Hj4dXFRgVfkna3PCG/NJ5waywAL80yYyDEcyGqG5OWmh3NapP
	WhPzvIdjWyzQr4eWVs7TjZMYt8ZExvmr8fyg/+lIACy4AjHZ0q90f/L4jr+BU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AC978B35;
	Wed,  6 Jun 2012 18:54:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD8598B34; Wed,  6 Jun 2012
 18:54:35 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9689A02C-B02A-11E1-B423-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199360>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> The part of --onto in the documentation is changed to be consistent
> with the other options. The exec line, when using the option --autosquash,
> is now only added after the squash/fixup series.

Thanks.

Inserting "exec" before each "pick" and then adjusting the result
(i.e. removing the very first one and adding one at the end) is a
clever idea. I wonder if that can be done without temporary variable
whose value can grow to be a large string, though.

Queued, but I've tweaked the log message a bit before queuing.
