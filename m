From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: fix filetype detection on files opened exclusively
Date: Thu, 02 Apr 2015 14:17:07 -0700
Message-ID: <xmqqiodei624.fsf@gitster.dls.corp.google.com>
References: <2D2A7688059E344DB86768405D63DEB42D3D75FC@USCULXMSG09.am.sony.com>
	<CAE5ih7_QpkX-U+XJ8gKSKKt1+Vu+FM4XBADTkys-4MDa129jyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Holloway\, Blair" <Blair_Holloway@playstation.sony.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Apr 02 23:17:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdmUF-0001oL-GR
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 23:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbbDBVRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 17:17:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751289AbbDBVRK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 17:17:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BFA4434F3;
	Thu,  2 Apr 2015 17:17:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yIMP7YFPCfzMKXrvVCkPsndxFgM=; b=fWB9KI
	BBGVC1hbSwXlJxgYej+99bhbnxj1aHJGd00e8VaKJL5mOslj02BpgBqcpbHpeNbr
	WDGlxXcDAerEUZHnm8usqvROlIpBrXnDyzozLUPzffRKi7oKqrezZrvacecgDrNg
	BPXpAxQQ1QayuFNvg1eyIpWzoxpF7Kh0+8+AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nxa2oAnz/g6fX8jZHX1oPzqKVe9sYPQh
	68TGi3rgNSYQHNXE83P8ofvfuzUcF7NkRbp3yNFDcn28SOBvtQLP5NKwePp6jebP
	k0bWBLJmEsi3QTHtHeom/n2TeTFBVGgd0AVHcIewGgb03xp6gmRTET3lMJeOLWL9
	yd+Lx2tIIqo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83D71434F1;
	Thu,  2 Apr 2015 17:17:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED329434F0;
	Thu,  2 Apr 2015 17:17:08 -0400 (EDT)
In-Reply-To: <CAE5ih7_QpkX-U+XJ8gKSKKt1+Vu+FM4XBADTkys-4MDa129jyw@mail.gmail.com>
	(Luke Diamand's message of "Thu, 2 Apr 2015 20:54:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F029A0E-D97D-11E4-8F14-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266679>

Luke Diamand <luke@diamand.org> writes:

> (+Pete for interest).
>
> On 31 March 2015 at 22:54, Holloway, Blair
> <Blair_Holloway@playstation.sony.com> wrote:
>> If a Perforce server is configured to automatically set +l (exclusive lock) on
>> add of certain file types, git p4 submit will fail during getP4OpenedType, as
>> the regex doesn't expect the trailing '*exclusive*' from p4 opened:
>
> Thanks - that actually fixes a part of the long-standing problem of
> handling locked files which Pete identified about a year ago.
>
> There's a test case for handling of locked files,
> t9816-git-p4-locked.sh, which needs updating now as a bit more of it
> passes. Junio, I'll submit a followup patch to update those tests once
> I get back from vacation.

Thanks.  Lest I forget, I'd prefer this patch resent from you in a
two (or more) patch series, with this one marked as 1/N with your
"Acked-by:", and your follow-up patches 2/N...N/N.  If it is not a
too much work for you, that is.

Thanks.
