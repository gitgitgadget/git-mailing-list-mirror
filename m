From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Mon, 26 Oct 2015 18:40:04 -0700
Message-ID: <xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
	<xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com>
	<20151027012336.GK31271@freya.jamessan.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: James McCoy <vega.james@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 02:40:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqtFe-0001xv-Mi
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 02:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbbJ0BkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 21:40:08 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751871AbbJ0BkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 21:40:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 258A227BD8;
	Mon, 26 Oct 2015 21:40:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DCiK3NcysBH4qnNZnjsNNafsBeU=; b=Rg25Gz
	vQDgo5ARp0LWTKV3aiKVyTFUijWb/8s35U+v/0DBKVw2cqKkVzkwL9htJChQ8KbU
	0YoxFPBKPe7DzqB9bncz3qdViDQD6Wefs4N5l44GViXJJVI6eEeE2mnA0IXloOFt
	OleX2pDbcPYALC+OyWCe9QlEqQ/gdaSes8Yu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UNEgLbSqG7grL+2p2kbW5+ls/GuQ6NMJ
	QuEQUtt7WnxNJikcM2S6KsxO4qQNsj9txASxcR3zNsKiw7enrouqkA6E392RFS0v
	PKGKPMpDUYTExS7sbIr8s/QCy6Q39pTdjLwlaaAYyOXRkPHDCkhmljNOJMJ/RxT0
	VnIHquDn18o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DE6527BD7;
	Mon, 26 Oct 2015 21:40:06 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9B56F27BD6;
	Mon, 26 Oct 2015 21:40:05 -0400 (EDT)
In-Reply-To: <20151027012336.GK31271@freya.jamessan.com> (James McCoy's
	message of "Mon, 26 Oct 2015 21:23:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A624C4E4-7C4B-11E5-B7F1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280239>

James McCoy <vega.james@gmail.com> writes:

>> The code looks OK but the last paragraph makes _us_ worried.  What
>> is the licensing status of the original at SO?
>
> According to Stackoverflow[0],
>
>   As noted in the Stack Exchange Terms of Service[1] and in the footer of
>   every page, all user contributions are licensed under Creative Commons
>   Attribution-Share Alike[2]. Proper attribution[3] is required if you
>   republish any Stack Exchange content.
>
> [0]: https://stackoverflow.com/help/licensing

Yes, and (please correct me if I am wrong--this is one of the times
I hope I am wrong!) I thought BY-SA does not mesh well with GPLv2,
in which case we cannot use this patch (instead somebody has to
reimplement the same without copying).
