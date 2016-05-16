From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 14:50:57 -0700
Message-ID: <xmqqh9dx1xku.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
	<xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZyPvAFG1TjSm76LuDLpch=7iuL_-8LYqysSESFQj-YjQ@mail.gmail.com>
	<xmqqlh391z2v.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuMdWdw2kcfs_P-_Ax1zXpKNHqMjNL80hBj3=SSp2zSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 16 23:52:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2QRB-0003kR-Sc
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbcEPVwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:52:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751413AbcEPVvC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:51:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 21A481C9C7;
	Mon, 16 May 2016 17:51:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFXMOCooE8STKsTmEvMIQ8m78Lg=; b=syGT+h
	HnYYK/m7HE6sqvjlIORzd8h0zsXSUTOh3rLMkws3bgJeQhi1HFz8i18uXEe7ByU6
	cRNcQrniUdEQl4dQ/vgLGB9X9OGQDioGzuqStk+e4XN6Hi4yjdQWP03rzjhz6Nvo
	xnVAsm67WjY/EoCrQVS4rDdoN7PVIzbsHu2qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P8Hnc3f0rkF9/rsthpOTIOoKMawrNDq5
	Tpa2CgwC68GSTNPUQvGx6SwzwnIvNtPxYyZe5IrcPP3as98Js+CjGfbP0icZE1Zi
	pmkIpjHDdotBdt3jjsYqyLPmXRhNyHFBN/ySzVAEq3b6bBx65Ohx4z3ei89Qlnn9
	knzu85z/MYI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 17FBE1C9C6;
	Mon, 16 May 2016 17:51:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 652641C9C5;
	Mon, 16 May 2016 17:50:59 -0400 (EDT)
In-Reply-To: <CAGZ79kZuMdWdw2kcfs_P-_Ax1zXpKNHqMjNL80hBj3=SSp2zSQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 14:36:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 46A7CF02-1BB0-11E6-A097-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294801>

Stefan Beller <sbeller@google.com> writes:

> And we want to have both "label=A B C" and attr:label=A B C" or *just* the
> attr query?

I think the choice at this point is between supporting just "label=A
B C" or supporting just "attr:eol=crlf text=auto !diff".

I think "attr:label=A" is merely a degenerated case of the latter.

> We should not allow the user to add arbitrary attributes (i.e. labels).

Hmph, why not?

> Instead each of the "attr for labeling purposes" needs to follow a clear scheme
> that allows us to add attributes later on that are outside of that scheme.

That was my initial reaction when I saw Duy's "attr:crlf=auto" (by
the way, there is no such setting; crlf should be one of TRUE, UNSET
or set to string "input") idea.  But I do not think of a good
argument to justify that arbitrary attributes are not allowed.
