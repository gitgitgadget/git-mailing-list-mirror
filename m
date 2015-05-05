From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git-p4 edit_template() and P4EDITOR w/options
Date: Mon, 04 May 2015 17:22:46 -0700
Message-ID: <xmqq8ud3g9ex.fsf@gitster.dls.corp.google.com>
References: <5D2E2EAF-FFE7-437F-A716-E152E865E634@pixar.com>
	<xmqqh9rsovd4.fsf@gitster.dls.corp.google.com>
	<xmqq4mnsottj.fsf@gitster.dls.corp.google.com>
	<xmqqzj5knf2t.fsf@gitster.dls.corp.google.com>
	<xmqqvbg8netq.fsf@gitster.dls.corp.google.com>
	<20150504231136.GY5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Chris Lasell <chrisl@pixar.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 02:22:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpQdS-0008R8-Qo
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 02:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbbEEAWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 20:22:51 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751158AbbEEAWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 20:22:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2D354F43F;
	Mon,  4 May 2015 20:22:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qBxx9ECPd7bZt5O4z3UB2baKu8I=; b=ENk+Hv
	+8+4F4X/7zww2gDtEF90Fpu0w/kHKxGxAVFHzxG7ilf6R8Z8bofV5EZTlFy/TXai
	UeqPnoyflm82uWGRvFexcNoPaLfgL8pZp5VJZdwx0PBO7gLsWa6AuopFIlH6F4lq
	zOM4oO5GIfvUiodU4jh4VcUd7kDsvCqYzZqqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GZKsrGr6YMWzdW7SCV2iX8hr2NX70uMs
	3LU5fA5EK3rl52w8R+2KGkcZLjIcK7+YwcLrStTNOSufQcdd7Bs8oSt87n6kuCoZ
	KND5+W8iyi/9tc8GzxOjabKaOnSWb2VFkaxXcU7oev7tp/5ln5DgHNAqsu6qEaOU
	8CcqxSzTPWQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC2834F43E;
	Mon,  4 May 2015 20:22:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FFD84F43D;
	Mon,  4 May 2015 20:22:48 -0400 (EDT)
In-Reply-To: <20150504231136.GY5467@google.com> (Jonathan Nieder's message of
	"Mon, 4 May 2015 16:11:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DBB95B2E-F2BC-11E4-825C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268375>

Jonathan Nieder <jrnieder@gmail.com> writes:

> run-command.c does
>
> 	system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
>
> to avoid having to figure out how to shell-quote template_file.

Yup, thanks.
