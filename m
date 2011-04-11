From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] Teach --dirstat to not completely ignore
 rearranged lines within a file
Date: Mon, 11 Apr 2011 15:08:24 -0700
Message-ID: <7vwrj0sap3.fsf@alter.siamese.dyndns.org>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <1302475732-741-4-git-send-email-johan@herland.net>
 <7vtye4tqmk.fsf@alter.siamese.dyndns.org>
 <201104112356.09408.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 00:08:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9PHl-0006ru-4z
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 00:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193Ab1DKWIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 18:08:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112Ab1DKWIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 18:08:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 46157505A;
	Mon, 11 Apr 2011 18:10:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N0XALY2HwDDDdFx+Y6p3fiJ5nmM=; b=p8y/Jl
	E2CxGXOhv428bsg0QaCED5cy4ew5pFvNkIgAaoo9gJM3rB0AKviElYh/aGx9/I2u
	f48ZOmukdL0SonozKLK5vu7aorqhkwa8QMd03xvFJwlsxyRATqjR0glPMStmP8Z2
	W+6/SN4bxKCGHVyH9ypM/FNOEx+9NHxgyUkXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rsMkFTUG3Y9NrsQiayc8GGNYOEWUClrm
	oa7KmBsPxWGRftv1uLYvJugEv3UqVhaLLlGoIemVNu7bMMXi8BqB4Ic25Yv7zO+6
	JjUa4CSVgzBVJA+0+FmojiHkjdOtzWefO1uKYiS3K7NoIo3TcDe4rJJnuFUr6Fok
	opIgGoxnQPo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13AE85059;
	Mon, 11 Apr 2011 18:10:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F14785057; Mon, 11 Apr 2011
 18:10:23 -0400 (EDT)
In-Reply-To: <201104112356.09408.johan@herland.net> (Johan Herland's message
 of "Mon, 11 Apr 2011 23:56:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81F78D20-6488-11E0-902C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171366>

Johan Herland <johan@herland.net> writes:

> I still feel that a file with 1000 rearranged lines should somehow count 
> "more" than a file with only 1 rearranged line,...

I think that is just entirely a different mode of operation.  I do not
think it is wrong to have an alternative implementation of the dirstat
damage counter that is based on numstat code.

It may end up counting the damage slower than the current code, and more
importantly it will count a different kind of damage than the current code
does, so we may probably want to make it an optional feature.
