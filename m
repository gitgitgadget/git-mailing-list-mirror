From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 13:47:07 -0700
Message-ID: <xmqqwqmfw4z8.fsf@gitster.dls.corp.google.com>
References: <5236FBEA.80909@gmx.de>
	<CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
	<vpqvc1z6eoo.fsf@anie.imag.fr>
	<CAP8UFD1u9hPFcbftpacDFdp27Jmp0YLGbpHPP12uEtjzEmnPQA@mail.gmail.com>
	<CACsJy8AEoUUat-1smJ1BmDuDBLseWf8oZ+EJyuadSLncb1UMSw@mail.gmail.com>
	<xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
	<1496b663-6b6c-45a2-95d1-cbe634b0d160@email.android.com>
	<xmqqpps7xoax.fsf@gitster.dls.corp.google.com>
	<CAA01Csp6tjKJ9LqX+9qcJL4t3kfFJCagjZQ=QwddvscPori9Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:47:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM2B7-0003Cp-33
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab3IQUrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:47:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab3IQUrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:47:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F41743E03;
	Tue, 17 Sep 2013 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D7w28MLMcY0PAjwB++Ms31vtYpk=; b=qcwh6M
	Q/zl5BVtYz1Bmt7P20k5p07XX/hfxKzwZwxwieeY5x9F16TtUqdrZqPcgBY3IWXS
	vnrh1uDE2oa2w8QuKBBC6CoUizha3asbJZMOU1Kpi7387GRF8cfpcpx7Myz400YZ
	yM3LbdWCvapQ/AZWXt6Mr7BCbbQ6dbM3RH/MA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z52VwFQdpHqShCkIRdRfgcuFk15DtdXB
	cwQKDSvVARwYi94ZaqO4B7l1Av3OwtylNLgw8+4NOOV6vkVJoQuzB2SYzB+7SCxt
	iwJtsRlSNO8yRXsDTPh0oXuyw+AB0arMpdorU4ok/ZrLz++zltKz1z1lNDRAjh1w
	B0Fg8jfhF2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EBBE43E02;
	Tue, 17 Sep 2013 20:47:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D71A43DFF;
	Tue, 17 Sep 2013 20:47:08 +0000 (UTC)
In-Reply-To: <CAA01Csp6tjKJ9LqX+9qcJL4t3kfFJCagjZQ=QwddvscPori9Ow@mail.gmail.com>
	(Piotr Krukowiecki's message of "Tue, 17 Sep 2013 21:41:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 51C9545C-1FDA-11E3-972D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234926>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Ignoring (possible) inconsistency thing, I think they are easy to
> understand and use.

Probably you are right (in the sense that I do not offhand think of
a confusing and ambiguous set of positive and negative pathspecs;
others may find holes in my/our thinking).

I am not sure if it will fit well to the current "struct pathspec"
design, though.  We could start from "when there is any negative
pathspec, disable the 'optimize away the common leading prefix'
thing", I guess.
