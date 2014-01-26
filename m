From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 04/16] trailer: process command line trailer
 arguments
Date: Sun, 26 Jan 2014 18:28:41 +0100 (CET)
Message-ID: <20140126.182841.788650091041834492.chriscool@tuxfamily.org>
References: <20140119085355.2734.58646.chriscool@tuxfamily.org>
	<xmqqd2jlt0ua.fsf@gitster.dls.corp.google.com>
	<xmqq4n4xt0dv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 26 18:28:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7TVn-0006GQ-PV
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 18:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbaAZR2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 12:28:43 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:44236 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbaAZR2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 12:28:42 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id D428566;
	Sun, 26 Jan 2014 18:28:41 +0100 (CET)
In-Reply-To: <xmqq4n4xt0dv.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241111>

> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> +static struct trailer_item *create_trailer_item(const char *string)
>>> +{
>>> +	struct strbuf tok = STRBUF_INIT;
>>> +	struct strbuf val = STRBUF_INIT;
>>> +	struct trailer_item *new;
>>> +
>>> +	parse_trailer(&tok, &val, string);
>>> +
>>> +	int tok_alnum_len = alnum_len(tok.buf, tok.len);
>>
>> decl-after-stmt.
>>
>>> +
>>> +	/* Lookup if the token matches something in the config */
>>> +	struct trailer_item *item;
> 
> ditto.
> 
>>> +	for (item = first_conf_item; item; item = item->next)
>>> +	{
> 
> Style.

The decl-after-stmt and style problems are fixed in the new v3 series
I just sent.

> I wonder if Cc list is being a bit too wide for this series, by the
> way.

I included only people who where part of the discussions at some
point. I guess that if they are not interested anymore they can ask to
be removed from Cc.

Thanks,
Christian.
