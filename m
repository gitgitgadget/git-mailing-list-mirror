From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/POC 2/7] Add new environment variable $GIT_SUPER_DIR
Date: Sat, 14 Dec 2013 11:43:52 -0800
Message-ID: <7viourgqvb.fsf@alter.siamese.dyndns.org>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
	<1386771333-32574-3-git-send-email-pclouds@gmail.com>
	<xmqqmwk4r55u.fsf@gitster.dls.corp.google.com>
	<CACsJy8DG0yx0J6tnAT-BsHsArCRA2akK-txWv5ee6k4pxPpixQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 20:44:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrv8D-0005rj-Rz
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 20:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab3LNTn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 14:43:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab3LNTnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 14:43:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7437D59054;
	Sat, 14 Dec 2013 14:43:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kiUsuAGwZCY/DVU4meq3wdtqRKg=; b=Itz1Yn
	uQznPPstQtRD/CH0PNp6v5wic4F+CXa7mXl15WGfEzaf9BY2GIRQcmYazer7/VML
	YcDyGtFcupaiYt7rDnT5JoCV+z1jlHgvyeG78VCpNtY8OM9kKnfJ95ajSzEm9+6I
	RnQOkuB+/gi1KrLIf31yKmZJXCLLgpknZ+Hio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IMTGeSDrTEwihYKRT8UPWnz+F8Oz9wcQ
	QNJTIQqppab+FidLB5X+lxWUMaHMpq3y9vwl/QRBdAdOqOsHScR2qlmxWmzyM3X1
	DTDAThAVXUzWXDwGq0gNHWcRS008qNE4HtvcYTOBnk7b5PiX7eyNLLjDsQ0Z2a/4
	CA80B9GdxKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D55559052;
	Sat, 14 Dec 2013 14:43:55 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88D1359050;
	Sat, 14 Dec 2013 14:43:54 -0500 (EST)
In-Reply-To: <CACsJy8DG0yx0J6tnAT-BsHsArCRA2akK-txWv5ee6k4pxPpixQ@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 14 Dec 2013 08:11:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 10AD2454-64F8-11E3-AAAD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239314>

Duy Nguyen <pclouds@gmail.com> writes:

> The exception list could be equally long (most of them are *_HEAD).
> .git is also used for temporary files with mkstemp, but I think that's
> safe for sharing. What could break is when people add a new local
> *_HEAD and forget to update the exception list.

Sensible; it may be worth having the above to describe why we choose
to go that "share only the selected ones" route in one of the log
message and/or in-code comment.

Thanks.
