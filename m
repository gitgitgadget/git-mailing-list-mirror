From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] Refactor submodule push check to use string list
 instead of integer
Date: Mon, 26 Mar 2012 14:29:19 -0700
Message-ID: <7vwr67m4pc.fsf@alter.siamese.dyndns.org>
References: <20120213092541.GA15585@t1405.greatnet.de>
 <20120213092900.GC15585@t1405.greatnet.de>
 <7vbop29jqf.fsf@alter.siamese.dyndns.org>
 <20120326193317.GB41087@book.hvoigt.net>
 <20120326195535.GA41511@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:29:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCHTm-00028d-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 23:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757330Ab2CZV3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 17:29:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757173Ab2CZV3V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 17:29:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDD9C7D9B;
	Mon, 26 Mar 2012 17:29:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xdg/69vnL55MfpjRBPYqt7omWuI=; b=fv3/Su
	GKtwvE7T9hxKWctwcbTYDHEtHe3GapJUR35S43wYYU4P/+ZrhJBd5oK7ztunuhIA
	YxUYE5pA1T29MeO+9N3EEe4SkbfFLEKvrA9wbzOEht/jZc9PM3DA4NMXeoauzJrm
	EdVYycVHSRUDrrjqjxMUW0wdHGCY6tJeuJ5f0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u71erZEGdPuaSzTRrwjY5jZvnqsarxNM
	3ie7m5yOKFOhzgH7pjBlghwCVGbKyfbGmZT9GHmEihb4zQ+9OPQsyu5fZXaIl3sY
	YIc7VomrodHWIE1CprDKdupIs6EURePjSGDw455jsxK90lTPQQNywiRDd0RCiiY8
	rlBn7k+FEAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E57737D9A;
	Mon, 26 Mar 2012 17:29:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AAFA7D99; Mon, 26 Mar 2012
 17:29:20 -0400 (EDT)
In-Reply-To: <20120326195535.GA41511@book.hvoigt.net> (Heiko Voigt's message
 of "Mon, 26 Mar 2012 21:55:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFD07948-778A-11E1-804D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193981>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> It seems my guess was wrong. As far as I read in the code
> string_list_insert() already skips inserting existing strings and just
> returns the existing items in the list. So it should be fine to remove
> the string_list_has_string() call.

Sounds sane.  Thanks.
