From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/16] trailer: process command line trailer arguments
Date: Tue, 21 Jan 2014 14:50:52 -0800
Message-ID: <xmqq4n4xt0dv.fsf@gitster.dls.corp.google.com>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
	<20140119085355.2734.58646.chriscool@tuxfamily.org>
	<xmqqd2jlt0ua.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 23:51:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5k9s-0000bJ-UE
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 23:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbaAUWu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 17:50:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaAUWu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 17:50:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6246560B;
	Tue, 21 Jan 2014 17:50:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=13+JSxavpwYFVNrt3oqKdL7jUiw=; b=xKLgGY
	Wu1UjyjxKpIL9YNzX5DVBGM1gKV2wHUqBWJo2MrTZF6w0WXjykwTetfIMQ6mqbsy
	u8qpPHwDRMfLxhk6IW067jrCwvs9p/VBl5fe71usN+/rcriWPfif67/cxEKR2+fw
	QSmyU2Q2FG/33chn/yIr36qtqArnO/8lSMA9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L/h/kGuHvy6r2UWo50WHbpubugLXNUhC
	B5wXMpa5r1hfSHhGng8kswTHw5uOBDgwTfGtw/lJDgr2CPob3gvSOkZDq2pSekOd
	u/T9hDOtUcUJZHLKwGTHhGawVIBSPr0E+/srPJYDCU5wxskL3sA5udb5kuC9sUkX
	6ViHQLR0iBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC6856560A;
	Tue, 21 Jan 2014 17:50:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADB9E65609;
	Tue, 21 Jan 2014 17:50:54 -0500 (EST)
In-Reply-To: <xmqqd2jlt0ua.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jan 2014 14:41:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7C341F66-82EE-11E3-907B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240785>

Junio C Hamano <gitster@pobox.com> writes:

>> +static struct trailer_item *create_trailer_item(const char *string)
>> +{
>> +	struct strbuf tok = STRBUF_INIT;
>> +	struct strbuf val = STRBUF_INIT;
>> +	struct trailer_item *new;
>> +
>> +	parse_trailer(&tok, &val, string);
>> +
>> +	int tok_alnum_len = alnum_len(tok.buf, tok.len);
>
> decl-after-stmt.
>
>> +
>> +	/* Lookup if the token matches something in the config */
>> +	struct trailer_item *item;

ditto.

>> +	for (item = first_conf_item; item; item = item->next)
>> +	{

Style.

I wonder if Cc list is being a bit too wide for this series, by the
way.
