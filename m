From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] log: add "--no-show-signature" command line option
Date: Fri, 27 May 2016 10:37:16 -0700
Message-ID: <xmqq4m9js8qb.fsf@gitster.mtv.corp.google.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
	<20160526130647.27001-3-mehul.jain2029@gmail.com>
	<20160526163241.GC18210@sigill.intra.peff.net>
	<xmqqiny0wx8m.fsf@gitster.mtv.corp.google.com>
	<CA+DCAeTnkTRnmscduio1-buKd2gNcaScYkLY7YfEQ+_Cm=Z28Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Austin English <austinenglish@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 19:37:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6LhR-0000G3-Dt
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbcE0RhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 13:37:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756486AbcE0RhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:37:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 860C21FE10;
	Fri, 27 May 2016 13:37:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1JU5mws8uFF9rNwZX3zWGiMlgPA=; b=JQX4VP
	ZUAh+YjzG0U82PJRgxip9Ha5/1iH/tvPB5VEUIfOK0oh7mQYucPuo/GC262T3aJL
	86lKoUXHCF9lGPxadubk4NFQs8o8AyWZbsBA4gilmxxkpA79U1jiu93tzrcToD/n
	q5WJcV8KOozldnuGVpnML8DjX2cPA8U9IGpCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QPt/AsR8xbTjovfRQX/3wpETKUYDCtUR
	GyNPhzybhavdp1gDIlpc5X4pE03xi/Gft89Uehvb1Z9jR4wap16czQd2Cn9BCff1
	+tarBZ2myRry/k+aoNYTEopBq1SA/EOOtIsAGEexGeRqzqmGzM1bxEdllP3wgLCa
	gZxmHN3B1Q0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D0FA1FE0F;
	Fri, 27 May 2016 13:37:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04C7B1FE0E;
	Fri, 27 May 2016 13:37:17 -0400 (EDT)
In-Reply-To: <CA+DCAeTnkTRnmscduio1-buKd2gNcaScYkLY7YfEQ+_Cm=Z28Q@mail.gmail.com>
	(Mehul Jain's message of "Fri, 27 May 2016 11:38:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A87FE398-2431-11E6-A0EA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295776>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> On Thu, May 26, 2016 at 10:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> The only reason why teaching the "--no-show-signature" option to
>> these commands is a good idea is because it would help people who
>> create an alias with "--show-sig" in early part of the command line,
>> e.g.
>>
>>         [alias] fp = format-patch --show-signature
>>
>> by allowing them to countermand with --no-show-signature, i.e.
>>
>>         $ git fp --no-show-signature ...
>> ...
>
> Just out of curiosity, I was thinking that we might be able to teach
> "--no-show-signature" option only to git-show, git-log, git-whatchanged
> and git-reflog.

Yeah, I know it is possible with extra code, but I do not think of a
good reason why it is necessary.
