From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/9] connect: only match the host with core.gitProxy
Date: Fri, 20 May 2016 15:56:35 -0700
Message-ID: <xmqqoa80baos.fsf@gitster.mtv.corp.google.com>
References: <20160517013554.22578-1-mh@glandium.org>
	<20160517013554.22578-3-mh@glandium.org>
	<xmqqbn40cser.fsf@gitster.mtv.corp.google.com>
	<20160520223054.GB7752@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat May 21 00:57:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3tMM-00054A-E4
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 00:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbcETW4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 18:56:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751065AbcETW4j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 18:56:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40CC51E8A3;
	Fri, 20 May 2016 18:56:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJZhQApqc1Ie+sJmsJCbi28AMKc=; b=N11HEd
	dO7FVQm235c4BS6Os0b/nMHJ2Yfn52bpuzxxZfTPPXE04wQ9Ozq5jYOgk4R4bxUk
	kStJgf47LL3mO9QcJXrurWJwM/3r+2e917o31kOXK7/KMwEzdXLmY1YhvgJGCKkx
	tSK1fxTigPwxPZI37311AC66/98OQx/EVFxeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbr5m4olnkt7V/s39gaDTP/79bFItJ8X
	UCRhpUTlYLgjkDhrba9IWJg//GIyC4ueE84QnDurhyB2uVn0bAc1mV7XGIwDKtgF
	OHEWKhTVUbGFVLAyneGIePcTpgdiE3KDpsclTF4fGuF4two9LGlbs9+JecT8xEi+
	0MB2xkKzIdA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 392BC1E8A2;
	Fri, 20 May 2016 18:56:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FCD31E8A0;
	Fri, 20 May 2016 18:56:37 -0400 (EDT)
In-Reply-To: <20160520223054.GB7752@glandium.org> (Mike Hommey's message of
	"Sat, 21 May 2016 07:30:54 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1BA3C1A4-1EDE-11E6-9DA8-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295220>

Mike Hommey <mh@glandium.org> writes:

> On Fri, May 20, 2016 at 02:48:28PM -0700, Junio C Hamano wrote:
>> So, even if we agree that per-port behaviour is not something we
>> would use if we were building the system without any existing users
>> today, I do not think we want "git now fails with an error" at all.
>> It goes against the approach Git takes to give smooth transtion to
>> users when we must break backward compatibility.
>
> I don't disagree. I went with a hard fail because it was easier. I'm
> not too keen blocking this series on this transition happening. So I'll
> try to finish this series without this change, and we can separate this
> transition discussion from the rest of the connect.c changes.

Yeah, I was thinking about the same thing as a short-term
direction.

Thanks.
