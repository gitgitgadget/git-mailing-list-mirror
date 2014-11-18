From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Tue, 18 Nov 2014 12:58:28 -0800
Message-ID: <xmqqegt0usy3.fsf@gitster.dls.corp.google.com>
References: <1416073760.9305.174.camel@homebase>
	<xmqqy4r9yc5u.fsf@gitster.dls.corp.google.com>
	<s934mtwo0zv.fsf@mad-scientist.net>
	<xmqq8uj8wbhl.fsf@gitster.dls.corp.google.com>
	<1416344066.3899.25.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Smith <paul@mad-scientist.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:58:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqpr9-0005Gn-46
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbaKRU6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:58:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932175AbaKRU6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:58:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27BC81F55B;
	Tue, 18 Nov 2014 15:58:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vXMhxiCopvz7ctdJG/bvsFXdbOk=; b=OGQQ9I
	mD6KQxxHpPP6727qYDDTMn/1kFcZi48rG+l7p0WwsAUkFIu2sfxB6uWEQSOitJB4
	UsS2YpMMwH38OAjlILLQJwkRqG1xDp4F0xDMRpV6/wOm/2Gl8TMODrt5AznHebnm
	awYwEjTbBCtdW412qHIdHvbn78KXqvt9Z3Sjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dC44rGyzCmx1fNzgOROxJ5JsSalqpUA7
	PqO4xYAeN0GdtIWUn6cY6Uf3yNNTuTHaIWtJ8BFFYip+eSGntwM1nVdVXLuU84Ub
	M03RaOqPUn7lZj89RnSUpxdgtrlElBhSQmzQqtdEOhAD8TvtzejlwSz6ngPY5hW7
	FVnGjW6QP0c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D9091F55A;
	Tue, 18 Nov 2014 15:58:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DCE51F559;
	Tue, 18 Nov 2014 15:58:31 -0500 (EST)
In-Reply-To: <1416344066.3899.25.camel@mad-scientist.net> (Paul Smith's
	message of "Tue, 18 Nov 2014 15:54:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7395A5A-6F65-11E4-9A6A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <paul@mad-scientist.net> writes:

> I can't find a clear statement that both are required and that "ls -a"
> must show them.  I've used a wide range of UNIX-en and filesystems for
> 30 years or so and never seen one that didn't provide them.  It seems
> like it would break quite a few scripts, at least.  Even virtual
> filesystems like ClearCase's MVFS provide "." and "..".
>
> If you want to allow for this possibility I can do so but it would be a
> bit crufty.  Personally I think it would be overkill but you're the
> boss: let me know :-).

Doesn't the description of the -A option I quoted upthread hint a
simpler and clearer solution?  I.e. "test $(ls -A | wc -l) = 0"?
