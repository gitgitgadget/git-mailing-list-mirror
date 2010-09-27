From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_author_ident_from_commit(): remove useless quoting
Date: Sun, 26 Sep 2010 21:15:38 -0700
Message-ID: <7vfwwvn7o5.fsf@alter.siamese.dyndns.org>
References: <20100922212302.GA22368@pengutronix.de>
 <1285233730-30611-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Sep 27 06:15:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0582-0004Kj-Js
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 06:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196Ab0I0EPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 00:15:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab0I0EPp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 00:15:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9D2CD9EC1;
	Mon, 27 Sep 2010 00:15:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=t26X1svXkMqF
	Ko7JGyWU5pjxK5A=; b=cG45C3ongZ3rWOi20n3wMtWsgh0B7r3zweqCw7f8z9/F
	jJcPNaIobG8tNoTNHBplfbQ8x7JYBriKM4foi+Mg4s0Htz0ZUMpw/ezSLCfrfyIO
	MDjeVwUSGCXZMtYv5VfozyHz7C8NlejckdxGXaujIouMXzfl8C2HX6vPcGOe31I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sdE65E
	PLnXzmIx1mOhaw9te1BEXB9B5E1CkvPqrvqkd0gxaAA6q2VsUk0RY2zleShNY5MX
	mRdRUGMyIkmBTKCzqfjfa69bDsB8N0XyjeQPgiRIpnByREzBmE5kueV9vguLDbRH
	KP539A7enRGrCzi+oseRzCgGMLXiMeQq52sMk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AAC4FD9EC0;
	Mon, 27 Sep 2010 00:15:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F04DBD9EBF; Mon, 27 Sep
 2010 00:15:39 -0400 (EDT)
In-Reply-To: <1285233730-30611-1-git-send-email-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu\, 23 Sep 2010 11\:22\:10
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4BFD56A-C9ED-11DF-B1FE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157294>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> The command 's/'\''/'\''\'\'\''/g' only triples single quotes:
>
> 	$ echo "What's up?" | sed 's/'\''/'\''\'\'\''/g'
> 	What'''s up?
>
> This doesn't hurt as compared to a single single quote it only adds a=
n
> empty string, but it makes the script needlessly complicated and hard=
 to
> understand.

Interesting.  I think this was an ancient misconversion that dates back=
 to
June 2005 ;-)

Thanks.
