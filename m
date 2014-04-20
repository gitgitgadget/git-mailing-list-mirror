From: Junio C Hamano <gitster@pobox.com>
Subject: Re: the ".git" folder
Date: Sun, 20 Apr 2014 15:13:57 -0700
Message-ID: <7v38h7lkd6.fsf@alter.siamese.dyndns.org>
References: <7F780F951A13B047BB0CE5F6EA9069C121871366@hou150w8xmbx06.hou150.chevrontexaco.net>
	<CACsJy8CXADh_wrHeqf47FuBUiF8pq_xboUPnts6mP8iVj0F-Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miller\, Hugh" <HughMiller@chevron.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:12:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbzyJ-0006Im-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 00:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbaDTWMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 18:12:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbaDTWMS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 18:12:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E2897EF11;
	Sun, 20 Apr 2014 18:12:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5PkhL02N88M0X2tcSbtLliDTcHQ=; b=Mv5+Es
	mIJKkjWVFaDGUSZ329Wsl1FUVUoFl921siWQF4t982xW/WAdtrmortAv59hbbJVV
	GnyRH2SdWcWW/E5agrJaKXXIBpuJL5vvkPlE14ar4DYn48YD59V0eNuK3ixvCLgG
	fidybFIHg7jDsL7oPBp8PeAOc6DbOmOwZHPqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TVhrUWh8Ln1UAFll75T6zzTWyi2iGh1N
	C6AjYthZp/j7PAHqSEgzV51W2bkPivfXV/D7QikwdNsOyS9puEFdWPsLv4H4vYTU
	FtEdP+ETs1nY2flcTIf/6+w2Y96MYoSb/jvAb7f19gdEXlR4IHm6WJyXWmo6p63k
	0cALmZcGNRM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E69237EF10;
	Sun, 20 Apr 2014 18:12:17 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CAB07EF0D;
	Sun, 20 Apr 2014 18:12:15 -0400 (EDT)
In-Reply-To: <CACsJy8CXADh_wrHeqf47FuBUiF8pq_xboUPnts6mP8iVj0F-Pg@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 20 Apr 2014 16:49:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: D4D9BE52-C8D8-11E3-BD14-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246596>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Apr 20, 2014 at 4:13 PM, Miller, Hugh <HughMiller@chevron.com> wrote:
>> Dear Community,
>>
>> Is there any way to use .git (e.g., a different set of "client" commands) that allows the .git folder to be placed in a location away from the actual files being versioned ? For example, can one set environment variables that let the software know where the .git folder is ?
>
> Try
>
> git --git-dir=<new .git location> --work-tree=<top work tree location>
> <some command>
>
> The reason of two arguments instead of one is because .git is also
> used to mark top work tree location, which is now lost after you move
> .git elsewhere. You could also set environment variables GIT_DIR and
> GIT_WORK_TREE, which have the same effect. "man git" for details.

Depending on the true reason why such a split layout is desired, the
answer might be the textual .git (aka "gitfile: there") that is used
by the submodule folks via "clone --separate-git-dir".
