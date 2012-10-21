From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git config --unset does not remove section
Date: Sun, 21 Oct 2012 00:09:20 -0700
Message-ID: <7v3918gv33.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9C_b_PScm3vEdvxsjqNHpTbz7OTTdFeFey7Sdb+M5gYFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 09:16:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPplx-00013i-Pu
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 09:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab2JUHJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 03:09:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646Ab2JUHJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 03:09:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B8496D03;
	Sun, 21 Oct 2012 03:09:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ehca4lKGRiQ7+BDWBaDD2344PLw=; b=dv5mrS
	3RlX3KjoFWA3fGaE9F5ttESZnZ9lkslYemBsayq64gvRLqzr3ugRwWmdKtZjHron
	5mPL0cpsxZ5utTN53AaOq9OMjdP+F3RnDgjy8as+oYpUDy+K5z8bNbIYe38twGPT
	Cjq+mhhnqf8TDbV73uDn/IOc5ruZEn8Tv6YM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nieLIAg6My43qyh7obeuylr5CcgM8my1
	P38P8dy/kqDngUhKHqKV+d8oKJ28b8ytlbL4gVPuKulTwtqWfa7lyVEIT1ncrnib
	IaPkaCnjc0WRbViltwRfxViXzhdmXNLdLwXzepVceOoD9oSsynaZn6nFzPk/JuwQ
	qmocp52Yn8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 365C36D00;
	Sun, 21 Oct 2012 03:09:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A66B36CFF; Sun, 21 Oct 2012
 03:09:21 -0400 (EDT)
In-Reply-To: <CAB9Jk9C_b_PScm3vEdvxsjqNHpTbz7OTTdFeFey7Sdb+M5gYFw@mail.gmail.com> (Angelo
 Borsotti's message of "Sun, 21 Oct 2012 08:46:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CDAEFEC-1B4E-11E2-B8B6-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208115>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Another git config foo.bar true changes the config file into:
>
>     [foo]
>     [foo]
> 	bar = true
>
> Having two sections with the same name clutters the config file.

True.  It would be nice if the removal of the last element removes
the section header as well.
