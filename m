From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] clone --single: limit the fetch refspec to fetched
 branch
Date: Mon, 17 Sep 2012 13:09:45 -0700
Message-ID: <7vd31kv2ba.fsf@alter.siamese.dyndns.org>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org>
 <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
 <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com>
 <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:10:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDhdl-0003lb-6V
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245Ab2IQUJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:09:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755759Ab2IQUJs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:09:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFDDD99C2;
	Mon, 17 Sep 2012 16:09:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hhm16f+ggbG7dOwlotZNDfcbEN0=; b=ILvD7O
	LM+5Dw4HV7ChDyCtNUBWJmjblVIZlz3BC+xP98ZHK10pmGnVjjQ6PT/3YXjJkd/5
	IENVlrqZs9lrINi7Cb9QzkKZRvnv0aE3B/4R4dmJOLit3nVrZ5EdZt2yJPqgE/Lh
	xu4y92vTZ3pi1kZBYEJ1zB6sfhaSwUIzNYLaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uYmZviCE4AGycNlp8s6i2PDnLLw6dYh8
	qo9Rnflkk6fsY3+K0y8F0ltu1Hy+6KW2CQMLo66Yh9aVm8rTL5bjJtZe3nClyZoi
	QiSPiARphN/JnlgDrue/K4iNi8ARprWudMwMjOU6mzQqfSvAGU4nW1KHzYXkNWvw
	4ntMv+fg0wA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD59C99C1;
	Mon, 17 Sep 2012 16:09:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58A5499C0; Mon, 17 Sep 2012
 16:09:47 -0400 (EDT)
In-Reply-To: <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 17 Sep 2012 19:11:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1171040-0103-11E2-8C24-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205734>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Sep 17, 2012 at 7:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> --mirror --single-branch combination does not look right. The "heads/"
>> part is missing..
>
> It also does not look right for cloning a tag:
>
> $ LANG=C ./git clone --single-branch --branch=v1.7.0 .git abc

What does it even _mean_ to clone a single branch and give a tag,
not a branch, to the --branch option?  Again, shouldn't it be
diagnosed as an error in the first place?
