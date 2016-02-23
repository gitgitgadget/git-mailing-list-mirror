From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git "thin" submodule clone to feed "describe"
Date: Tue, 23 Feb 2016 13:33:49 -0800
Message-ID: <xmqq1t83yuv6.fsf@gitster.mtv.corp.google.com>
References: <CACPiFCLnXLdt5rLuX0a3pTS3OphKW=1oVKxyYpwvSLhY7ydb2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:33:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKai-00010S-LO
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbcBWVdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:33:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755423AbcBWVdw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:33:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFF2F46816;
	Tue, 23 Feb 2016 16:33:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nkbi5uEuQy/TztttMWuYTEPQGIM=; b=scOErJ
	i/LZPZgM44Z0s/XB2jY37bY20kUuI5IUar0LdxBUePrjj35j6abdockJqbsDzhHV
	jAxNSw02lbugNPLZ9ShXfa9RsH8u/4tCHPUrOrrQE9gAelwdy+JL5qOjxcvBl8XM
	sstlYEcN8X4J89yUtsYzY8S7+ubRTH9lPqhqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vfiFom4Cf/YMmxjz3Dwoj2n1BDOCCwk6
	5rZNzh5nDjRn0tyVR71zaOLQEBATLThvfSbfSkODnCkduPgH6I0IgNDQWm1cujTc
	UKuAZI9PJ12yHaeFyzPuTj5otPIABHmNl/5NiN49Vbc+2BXOPgI8NhhOCsPl9QYL
	JkWGXVIm+Sg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7E3046815;
	Tue, 23 Feb 2016 16:33:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BCF746813;
	Tue, 23 Feb 2016 16:33:51 -0500 (EST)
In-Reply-To: <CACPiFCLnXLdt5rLuX0a3pTS3OphKW=1oVKxyYpwvSLhY7ydb2g@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 23 Feb 2016 16:03:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2173E35A-DA75-11E5-8CFD-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287128>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Hi git list! long time no see! :-) Been missing you lots.
>
> Do we currently have any means to clone _history_ but not _blobs_ of a
> repo, or some approximation thereof?
>
> With a bit more context: If I have a top-level project using a couple
> dozen submodules, where the submodules are huge, do I have a
> git-native means of running git-describe on each submodule without
> pulling the whole thing down?

No, I do not think so.
