From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/17] Add interpret-trailers builtin
Date: Mon, 27 Jan 2014 13:05:54 -0800
Message-ID: <xmqqk3dlnnil.fsf@gitster.dls.corp.google.com>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jan 27 22:06:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7tNe-00048h-VH
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 22:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbaA0VGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 16:06:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112AbaA0VF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 16:05:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F30D67B43;
	Mon, 27 Jan 2014 16:05:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lA9qdoIJBflKge2wnAJf1twiJ4k=; b=j2/rja
	e/T1+JL5hCfLc+m2GYLboukDAcA+Vuqf4zldK0rXaEgOUylHy1i2CgVOw3gkZ/5e
	5MFHyCiJyS+OvwfISh1NiwOjxggdb6yPiWM2M0V6szk1MB0yi569oi9MWBbwailM
	fDA4GbqjyroF48TfogwengJa31ulAA9VbUCoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J21qYWwEJ3wGCpT/9G8T4VHIdrRk+GjU
	jD0S5WLgmdyeyLoz7gtrlUdkygyWGtqVlxKxXN448uEPGvHGPQx9U5xYYPYgf5ht
	8N+aXA4YV7DE991enelYq/M6o++Wwm8NsSPOV7goNU2QSsuFuAqCoBtucLief1w0
	WquFh0llzmg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2F5A67B42;
	Mon, 27 Jan 2014 16:05:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B862F67B41;
	Mon, 27 Jan 2014 16:05:57 -0500 (EST)
In-Reply-To: <20140126165018.24291.47716.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 26 Jan 2014 17:59:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D14DDE40-8796-11E3-BF02-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241157>

Is this from the same Christian?

The series seems to have unusually high rate of style violations
compared to the usual submission, like these:

ERROR: open brace '{' following function declarations go on the next line
#78: FILE: trailer.c:44:
+static size_t alnum_len(const char *buf, size_t len) {

ERROR: trailing statements should be on next line
#79: FILE: trailer.c:45:
+	while (--len >= 0 && !isalnum(buf[len]));

ERROR: space required before the open parenthesis '('
#70: FILE: trailer.c:90:
+	switch(arg_tok->conf->if_exist) {

WARNING: braces {} are not necessary for any arm of this statement
#66: FILE: trailer.c:270:
+	if (!strcasecmp("doNothing", value)) {
[...]
+	} else if (!strcasecmp("add", value)) {
[...]
+	} else
[...]

ERROR: that open brace { should be on the previous line
#96: FILE: trailer.c:300:
+	for (previous = NULL, item = first_conf_item;
+	     item;
+	     previous = item, item = item->next)
+	{

Just trying to see if there is an impersonation ;-)
