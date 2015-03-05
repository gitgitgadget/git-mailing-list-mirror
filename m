From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] sha1_file: implement changes for "cat-file --literally -t"
Date: Wed, 04 Mar 2015 22:25:10 -0800
Message-ID: <xmqqoao83qrd.fsf@gitster.dls.corp.google.com>
References: <54F5888B.7040400@gmail.com>
	<1425377556-25332-1-git-send-email-karthik.188@gmail.com>
	<xmqqy4nc7a4w.fsf@gitster.dls.corp.google.com>
	<54F7B0CE.4070006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 07:25:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTPDo-0004TF-Ey
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 07:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbbCEGZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 01:25:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753214AbbCEGZM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 01:25:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CADD63612C;
	Thu,  5 Mar 2015 01:25:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jpapmN1gBrLNqX4ORbrTULWDqXg=; b=WeRnQR
	gLG+0+I1qmB5yDhRZ7Ku2rr/0MuPX+htSgWNzJtpxpwWLotb2AmXPB0QyFzjuKt9
	BZZ3PXNc6c8ay81wHgRKLYYKs4cV8+0p/8oUKrOEAOs9yFMrhvxbSfuf2d4rJQtp
	ZnM54BysrMpZ3Gvrn1cvB18aM6uHPMw0WE1iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VtpL0cxFGswt8d9nQnE0Zco6Dwu0HANr
	qcZ+KLd+YvgwUYwXsvC8OgGOlNXj2Ufg6z2gaBSGpqEauDBEhd2WN5qBugUKvOCi
	dxl1V12vFZaMTKYQ4FYwBRqwvf+WxguIpUQTQOU+Du+/u9jWYQkfMI+aKI9thedp
	4nVl2/HEYMI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C31A23612A;
	Thu,  5 Mar 2015 01:25:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A5D936128;
	Thu,  5 Mar 2015 01:25:11 -0500 (EST)
In-Reply-To: <54F7B0CE.4070006@gmail.com> (karthik nayak's message of "Thu, 05
	Mar 2015 06:56:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60636EE2-C300-11E4-9EF9-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264818>

karthik nayak <karthik.188@gmail.com> writes:

>> Looks suspiciously familiar...
> Yes, you suggested it.
> It has a similar structure to unpack_sha1_header().
> Anything wrong with it?

I don't know if there is something wrong with the code, or not, but
it wasn't mentioned in the log message at all that it is not your
code, and I was mostly reacting to that.

It is fairly common around here to take somebody else's code and run
with it, but people say things like "This is based on suggestion
from X", "This function was stolen from Y", etc. and then conclude
with "but I adjusted it to match the caller I wrote, so bugs are
mine." when they do so.
