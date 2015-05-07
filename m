From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/12] t4013: call git-merge instead of git-pull
Date: Thu, 07 May 2015 10:17:42 -0700
Message-ID: <xmqqk2wkqpc9.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-8-git-send-email-pyokagan@gmail.com>
	<a2c6df723ca5237c094ab4002e45a834@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 19:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPQk-00035P-Hi
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbbEGRRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:17:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751333AbbEGRRp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:17:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A0674EBDE;
	Thu,  7 May 2015 13:17:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rRDfpslaFoaKOuiTFIpG688tbQU=; b=UVKoEe
	UyHiZ/z5TSsVZu40yYn7QPvJ7bR+rCsr2UQxP7ISFflIS2WwK+dLlr26ftxQRteC
	7exRzncZZ3xmZDzXXGhJB77fvH1HORRlaLRodE1wXyTmNjM/bOaZs84AqI+oGaP8
	g2P95flm2/m+GkOLkDc8W9t8a6CjbK98V1+90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MFTX7Y4hlOS6UiV47LvafxC3bhlsCxGG
	CgO1b6OsN2IlCyqjldrMbS6A1Z82wJm6rC9aC8XfKP0+Eb3OS+8qMUb/nYBZlrdh
	LLJ5PojVChvBFoxvHFZjdOcIUSHB3oCkEflbMdSaxPeirSUHwOlZOeFQAM+iIXBX
	ykoH+x0DOF8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82CAF4EBDD;
	Thu,  7 May 2015 13:17:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAC1D4EBDB;
	Thu,  7 May 2015 13:17:43 -0400 (EDT)
In-Reply-To: <a2c6df723ca5237c094ab4002e45a834@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 07 May 2015 18:26:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9381E16-F4DC-11E4-AB2D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268555>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Both this patch and 9/12 change `git pull` invocations to equivalent
> non-pull ones, but I wonder whether it would not be a better idea to
> leave them as-are, so that we can make sure that scripts out there
> that might use similar `git pull` invocations would be unaffected by
> the rewrite?

Yes.  I do not mind changing t4013 that is not about testing 'git pull'
to lose 'git pull . other-branch', but then we would want to have a
corresponding test somewhere in the test script that is about
testing 'git pull' to cover that (ancient) pattern of use.

Thanks.
