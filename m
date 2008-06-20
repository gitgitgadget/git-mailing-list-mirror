From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph.c: make many functions static
Date: Fri, 20 Jun 2008 00:37:00 -0700
Message-ID: <7vmylgo8v7.fsf@gitster.siamese.dyndns.org>
References: <20080619082110.6117@nanako3.lavabit.com>
 <7vhcbptev8.fsf@gitster.siamese.dyndns.org>
 <20080620060035.GA22345@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 09:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9bCH-0001t6-Lg
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 09:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbYFTHhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 03:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbYFTHhS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 03:37:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYFTHhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 03:37:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 204761E73E;
	Fri, 20 Jun 2008 03:37:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5D4671E73D; Fri, 20 Jun 2008 03:37:08 -0400 (EDT)
In-Reply-To: <20080620060035.GA22345@adamsimpkins.net> (Adam Simpkins's
 message of "Thu, 19 Jun 2008 23:00:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2C69628-3E9B-11DD-A7BF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85600>

Adam Simpkins <adam@adamsimpkins.net> writes:

> On Thu, Jun 19, 2008 at 12:16:11PM -0700, Junio C Hamano wrote:
>> しらいしななこ  <nanako3@lavabit.com> writes:
> ...
>> > +/* Internal API */
>> > + ...
>> > +static int graph_next_line(struct git_graph *graph, struct strbuf *sb);
>> > +static void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
>> > +static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
>> 
>> I think these are probably fine, not in the sense that nobody calls these
>> functions _right now_ but in the sense that I do not foresee a calling
>> sequence outside the graph.c internal that needs to call these directly,
>> instead of calling graph_show_*() functions that use these.
>
> Documentation/technical/api-history-graph.txt should also be updated
> to remove the discussion of these functions if they are no longer
> publicly exposed.

Actually, I was expecting (not necessarily _hoping_) you to defend these
public API by providing examples that illustrates when calling these from
outside graph API implementation could be useful.
