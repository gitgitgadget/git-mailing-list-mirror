From: Junio C Hamano <gitster@pobox.com>
Subject: Re: MERGE_RR droppings
Date: Mon, 18 Jun 2012 16:05:37 -0700
Message-ID: <7v8vfk2pby.fsf@alter.siamese.dyndns.org>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
 <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 01:05:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgl10-0006je-PU
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 01:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab2FRXFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 19:05:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314Ab2FRXFm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 19:05:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD3C4894D;
	Mon, 18 Jun 2012 19:05:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eaUj6zQrD6w4BJieOzCb4X0ecYQ=; b=aUg3UJ
	nHKf+CVl78lTmcUUlTh4L+2B+zDd3yNum/jPszRFTr05ib+aX4GsLM0bOrmtmjXh
	nyBFU/qE/OdO69tJHq0EgCnckwUx687IevPt5qyTmqnDt9Ta3Hp7qV5ubuT1NiFz
	IMljG8Ov/yevpRC6ok8zNXkecn5xwgxwbck04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sL1l0GEFNTiKXAaYM3kahRXJ3gqKLSWH
	hS32hYNq2RoeTWkYhMV3pJIuqtMun6viBdgp4qGf29l7CXC84kIrZ2JrQPlJ18G/
	k7jH4SBp1jWFJUsyiTCUghoy++Fuwn5FbCoQdxdr7bZKNLxDVL8B6Rx+gb6e69/A
	eI3ugOMjHE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A391F894C;
	Mon, 18 Jun 2012 19:05:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 398DD894B; Mon, 18 Jun 2012
 19:05:39 -0400 (EDT)
In-Reply-To: <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com> (Phil
 Hord's message of "Mon, 18 Jun 2012 18:41:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EE84C48-B99A-11E1-AEBE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200180>

Phil Hord <phil.hord@gmail.com> writes:

> git mergetool decides to use rerere-remaining based on the existence
> of the .git/MERGE_RR file:
>
>     if test -e "$GIT_DIR/MERGE_RR"

This is correct, I would probably write it with "test -f" if I were
writing this line today, though.  After you commit to conclude the
merge, the MERGE_RR marker should disappear.  Isn't it happening for
you?
