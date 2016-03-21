From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] git-p4: fix AsciiDoc formatting
Date: Mon, 21 Mar 2016 10:53:42 -0700
Message-ID: <xmqqpounn2e1.fsf@gitster.mtv.corp.google.com>
References: <1458499161-61642-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 21 18:53:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai41Z-0007yP-Il
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 18:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605AbcCURxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 13:53:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757550AbcCURxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 13:53:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 807EA4E213;
	Mon, 21 Mar 2016 13:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v3s7sIPkoC3R3L3I4rn1nfD3FOo=; b=EPzZAe
	sskseYiSH86MSJwwNguX7RAIK0xPG3Yk1p0gEB2Pj67d6GgWsslk9ecPVaZskugJ
	MBm8TwKAr1xsSeCNwkImwR70YhqxkwbOX4i2urmg2yfi+tW7JJugpr98hG1373ec
	s4YU4VkwDA82USH/g2xTVESTj3aFo6dD+gpq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AoPu5h57SESco4fZxLsMlN1DQgeCrzq5
	eTial1EsraTDuXR26qhPimlhK3r8uBU7L849LXOXpvwa5KOSpVGD5+d97awep5al
	9MLpD1/LfutCv0OGZZm1O8dASxp2hBGmkcHP8JAW55fw9yvtmidF7L6Mv+SRZ8hm
	/KWPTbPr04E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 780CA4E211;
	Mon, 21 Mar 2016 13:53:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F2F544E20C;
	Mon, 21 Mar 2016 13:53:43 -0400 (EDT)
In-Reply-To: <1458499161-61642-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 20 Mar 2016 19:39:19
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA828338-EF8D-11E5-AA5D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289430>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v1:
> * reference external pages similar to git-bisect-lk2009 (thanks Luke)
> * fix quotation marks (you can see the error here:
>   https://git-scm.com/docs/git-p4/2.7.4 ... search for cp1252 )
>
> Thanks,
> Lars
>
>
> Lars Schneider (2):
>   Documentation: fix git-p4 AsciiDoc formatting
>   Documentation: use ASCII quotation marks in git-p4
>
>  Documentation/git-p4.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Hmph, this seems to break my build.

xmlto: /home/gitster/w/git.git/Documentation/git-p4.xml does not validate (status 3)
xmlto: Fix document syntax or use --skip-validation option
/home/gitster/w/git.git/Documentation/git-p4.xml:812: element xref: validity error : Syntax of value for attribute linkend of xref is not valid
/home/gitster/w/git.git/Documentation/git-p4.xml:1077: element anchor: validity error : Syntax of value for attribute id of anchor is not valid
Document /home/gitster/w/git.git/Documentation/git-p4.xml does not validate


On line #812 of the generated file I see this:

        Only Git LFS <xref linkend="1"/> is implemented right now. Download

And line #1077 I see this:

<anchor id="1" xreflabel="[1]"/>[1] <ulink url="https://git-lfs.github.com/">Git LFS - An open source Git extension for versioning large files</ulink>

It could be that mimicking git-bisect-lk2009 that never is formatted
as manpage is a bad idea to begin with?

$ xmlto --version
xmlto version 0.0.25
