From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] travis-ci: override CFLAGS properly, add -Wdeclaration-after-statement
Date: Tue, 09 Feb 2016 15:14:29 -0800
Message-ID: <xmqq7fid1noq.fsf@gitster.mtv.corp.google.com>
References: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
	<20160208122551.GD24217@sigill.intra.peff.net>
	<9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com>
	<xmqq4mdh4tel.fsf@gitster.mtv.corp.google.com>
	<CAFY1edbCSPZg892=pVQ=TDo6PRhUdees36Jp7LQ2YB3_jQd4uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>,
	linux.mdb@gmail.com, Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:14:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTHUS-0006RX-Il
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 00:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbcBIXOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 18:14:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755058AbcBIXOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 18:14:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2538E42EF3;
	Tue,  9 Feb 2016 18:14:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jgg4TpgtAY3Wbjq5A61uPT7pbJc=; b=xLgnNL
	XS4H3KT6vwgfvuUYv5WxjfA6TwW5QPtJ2OgFy0m49R+Sy+zstl8Hl52iloIpXwrQ
	PcIluIltb0xBnWbqkOaP7C0M1hHGuHiyDlBeYquYmkjkdC0YcWGublXvWwYaM1Cf
	0eQNmCpCd65f4uLzHyjD+bdsvZ9tx54wNZpT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=naDLxkr4U0YYzfuheriHiaEJdFnL2c/5
	m3Jcu1yNw08fTlIWFjaLyJGrBsa8dM4MsOXN1fmFhsXJSLPT4JKcBC2mkVbFxq7u
	NbXPOuyMaWSeGUIZNNQYGAlCjAAWPRh+HyhQtOrFyg5pzBZ0Pon+amOFRRUsOZ/g
	tGNq36E/764=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C92B42EF2;
	Tue,  9 Feb 2016 18:14:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D6CC42EF1;
	Tue,  9 Feb 2016 18:14:30 -0500 (EST)
In-Reply-To: <CAFY1edbCSPZg892=pVQ=TDo6PRhUdees36Jp7LQ2YB3_jQd4uQ@mail.gmail.com>
	(Roberto Tyley's message of "Tue, 9 Feb 2016 23:03:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF7968C8-CF82-11E5-95D6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285884>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> I've not personally run checkpatch.pl (as Peff mentioned, it's not
> actually a documented part of the Git project's recommend contribution
> workflow) - I'm still trying to understand whether it will restrict
> it's errors to just the things that are introduced in a patch,

Yes, it works as a filter to pass a submitted patch through to catch
issues on the new lines.  You can obviously diff the current state
with an empty tree and feed the result to it, which would give you
all the existing issues ;-) but that is not very useful.
