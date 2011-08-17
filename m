From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: Utilize config variable pager.stash.list in stash
 list command
Date: Wed, 17 Aug 2011 11:44:32 -0700
Message-ID: <7vd3g3ev3j.fsf@alter.siamese.dyndns.org>
References: <4e4a58c2.48d6f6ce.bm001@wupperonline.de>
 <4e4b8418.068889fb.bm001@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Wed Aug 17 20:44:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtl6V-0004Hc-IA
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 20:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab1HQSof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 14:44:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab1HQSoe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 14:44:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 495F13B7D;
	Wed, 17 Aug 2011 14:44:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Me4+H7L47td+dcf3Rgz5kWYjtL8=; b=mfidA1
	0BzF95jyrrtzCv39jEaEELoWxSSsFF0kGRXFAiuF1HeBBYN8EpFDBgglP/jwS/So
	673HmFgecLxeuCT2Glzpd8pSqf7NTTBKMJUxXQH7LEVT51c4RgHhS4AeCfK4cDlN
	EOenLS61vWTHeT6UwWRMMQr+axQ6VMwQQ0/lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F5mRUvSF+hGq64GxBAi1yiqCxn7nFePS
	4qhphtFMEDNNYBl7cgN8vEvMuaMYN3O683xpgIw0deaqu7yxopUySUVKI+JvGjxT
	k7+CveNDiQVbzsNjHSycfZe8TjqeHlD7igDaB6kYrApPEw2H/wSgrniOdCASg9ig
	WpNDtKZi50I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40DA03B7C;
	Wed, 17 Aug 2011 14:44:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B39C33B7B; Wed, 17 Aug 2011
 14:44:33 -0400 (EDT)
In-Reply-To: <4e4b8418.068889fb.bm001@wupperonline.de> ("Ingo =?utf-8?Q?Br?=
 =?utf-8?Q?=C3=BCckl=22's?= message of "Wed, 17 Aug 2011 11:04:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F32322CA-C900-11E0-B31F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179525>

At least "pager.stash.list" should be spelled as "pager.stashList" or
something. It is not like there are multitude of arbigrary choices that
may match "pager.*.list" pattern.

Also a variable can be set to false by setting it to 0, no, etc., so you
need to inspect it with "git config --bool" to get the canonical version
of its value.

What's so difficult to say "git stash list | less" or even "git -p stash list"?
