From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Mon, 08 Nov 2010 10:31:09 -0800
Message-ID: <7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
 <20101104112530.5c0e444a@chalon.bertin.fr> <4CD2E7B4.3000908@nextest.com>
 <vpq62wddmc0.fsf@bauges.imag.fr> <20101104181020.GB16431@burratino>
 <20101104205307.GA8911@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, kevin@sb.org,
	git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFWVF-00057M-6t
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab0KHSbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:31:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab0KHSbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:31:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44AE42FE9;
	Mon,  8 Nov 2010 13:31:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=znmKOsmDFgBjFyHBWwwLt/tPRvE=; b=nCoy1d
	aqs+XWQJP9l43pvCkGuywVVLauIo2o0auHnVPRurIURgwwQ3I0a8eRbnGSBI/e/f
	9IlEtJqP66kGmT2fIAK2aLhS7kXovnGfvviH7sYy2R4r/3DhiWepRBwcvZI36QTr
	RgrwaPfTjcO4SOiSDfywVqAvJDnO209+ckXYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bzJVmUgMe1Gxf8gJa7GCa827bZWhbUg1
	wZ6UMSTM1ie5zbJ3eOxPZqzc4wLFztqDhOniFe8+KbKiwSHtwbjzwiTb9dxSRMqd
	ZxaSPmIUbmmhN0OzzOHL35IUkdAcg0L9Y2OzZ+Z38nREvJbbHR1WuP5GZ+PI6Oh0
	qY78N89vTa8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD1D82FE2;
	Mon,  8 Nov 2010 13:31:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E3AE92FE0; Mon,  8 Nov 2010
 13:31:13 -0500 (EST)
In-Reply-To: <20101104205307.GA8911@home.lan> (Yann Dirson's message of
 "Thu\, 4 Nov 2010 21\:53\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6334E702-EB66-11DF-B9EE-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160966>

Yann Dirson <ydirson@free.fr> writes:

> #  e, edit = use commit (if specified) but pause to amend/examine/test

When an end user is given

    pick one
    pick two
    pick three
    ...

and told the above, would it be crystal clear that, if he changed the insn
sheet to

    pick one
    edit
    pick three
    ...

then he will _lose_ the change made by foo, or will the user come back
here and complain that a precious change "two" is lost and it is git's
fault?
