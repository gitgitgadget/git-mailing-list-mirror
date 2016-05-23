From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_INDEX_FILE relative path breaks in subdir
Date: Mon, 23 May 2016 09:44:28 -0700
Message-ID: <xmqqwpmkafmb.fsf@gitster.mtv.corp.google.com>
References: <20160517171836.GA12183@kitenet.net>
	<xmqqy478wptr.fsf@gitster.mtv.corp.google.com>
	<20160517182645.GA27396@kitenet.net>
	<20160522190404.GA20998@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Mon May 23 18:44:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4syB-0008JR-3x
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 18:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbcEWQod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 12:44:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750778AbcEWQoc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 12:44:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DCAE1BD8D;
	Mon, 23 May 2016 12:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NEhhco4/YBnhcIj2vhf9XatS1hY=; b=frNDBm
	ceXpF+Lwte1b9z0bR2ZxutLZ4/Q/Hzys1/TgwxMQiBLMD0Rmh3NGgvpAFkJtmQtk
	QPTqJQC4hVRC8RfYNwm4IO3fe11gRUSCvrLfKvz4leDUJpEyfny9z770R5W85xpW
	Ep75RCypeIo9q7C88SIvlD7IiZfNpKIgpa7Is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jp+5HSNP/VyLHpNJUlUwGuMysWfX3Ws6
	r6uez+Il8LVFWzWxmkmQ6jBQurd9FH3FV+wsHuMawinipTS5s4pnynwSCLWeXQ5v
	y5bw/gqBmlDr+Nl2X0OvcSjKaDn8k4S2T5rSxpMeWfXKCdXhdI8O2wOfEQabSm0j
	JmXx4JEPCyc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 141D11BD8B;
	Mon, 23 May 2016 12:44:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C3981BD8A;
	Mon, 23 May 2016 12:44:30 -0400 (EDT)
In-Reply-To: <20160522190404.GA20998@kitenet.net> (Joey Hess's message of
	"Sun, 22 May 2016 15:04:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9EE728CA-2105-11E6-AACD-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295337>

Joey Hess <id@joeyh.name> writes:

> This seems to make it basically impossible for any program that wants to
> use GIT_INDEX_FILE to use anything other than an absolute path;
> there are too many configurations to keep straight that could change how
> git interprets what should be a simple relative path to a file.

Thanks for digging.  Perhaps this needs to be documented (not "in
this case it is take as relative to that, in this other case, ...",
but "you cannot rely on relative being relative to something you
think").
