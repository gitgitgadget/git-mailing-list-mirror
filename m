From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] generalizing sorted-array handling
Date: Fri, 10 Dec 2010 15:22:18 -0800
Message-ID: <7vd3p9b4d1.fsf@alter.siamese.dyndns.org>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Dec 11 00:22:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRCIJ-0005lD-7t
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 00:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab0LJXW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 18:22:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab0LJXW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 18:22:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6FED39DF;
	Fri, 10 Dec 2010 18:22:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=PIDDLGc51If6GUvUGsYmoPgHgmw=; b=rEhahM
	tEhO88L+WZrQprngOKz9kquey2yB48vzakDDkBcg/tmoGGsKeQFiBzHW7gviYx3T
	HjtPND+xK89hhTg1SjFLZ59lkp1+0KkLGObubjyr1VEEbY+9x3134niHdVk1HAgD
	C7HtA/dOAA26dRuG2zHYjionyuucBUH91m9eA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CYlBExr33FbSatL462GZ61Ill1PG33i+
	ZhGpDP/mcS7wQbYKtjNtsnq0h+co0AzzVJM7JbMaQ/CjCu4Bfxcpw+LIGl+nr1ke
	XvWUy2OX5z8bQnz/1sp8qUsLy3uZTU55OK0Azzf5V23daKgQqwt1FOCXAiFW+dK3
	jgGx75NkT4Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9E2739DE;
	Fri, 10 Dec 2010 18:22:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C847D39DD; Fri, 10 Dec 2010
 18:22:44 -0500 (EST)
In-Reply-To: <1291848695-24601-1-git-send-email-ydirson@altern.org> (Yann
 Dirson's message of "Wed\,  8 Dec 2010 23\:51\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6633F9D6-04B4-11E0-B089-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163449>

Yann Dirson <ydirson@altern.org> writes:

> ... I want to get my focus back to
> bulk-rename/builk-rm patches, which will make heavy use of this API.

Final comment.  As the primary thing you want to use this is to change the
way how the rename_dst/rename_src tables are managed, and these are both
tables sorted by a string, I suspect a more reasonable might be to first
updated them to use string-list API and add to that API whatever necessary
features you might need, if any.
