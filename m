From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git commit: pathspec without -i/-o implies -i
 semantics during a merge
Date: Fri, 23 Jan 2009 09:01:32 -0800
Message-ID: <7vy6x2vtw3.fsf@gitster.siamese.dyndns.org>
References: <4978202C.3090703@viscovery.net>
 <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
 <49779521.9040208@drmicha.warpmail.net>
 <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
 <20090123094509.6117@nanako3.lavabit.com>
 <7viqo64kfo.fsf@gitster.siamese.dyndns.org>
 <7vy6x235ky.fsf_-_@gitster.siamese.dyndns.org>
 <53513726-CE1C-4487-B775-440C6DC93DD8@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Jan 23 18:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQPQz-0003jT-5O
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 18:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbZAWRBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 12:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753598AbZAWRBo
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 12:01:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbZAWRBo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 12:01:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 896E293AF2;
	Fri, 23 Jan 2009 12:01:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 32EBA93AF0; Fri,
 23 Jan 2009 12:01:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82C40378-E96F-11DD-87B5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106889>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> On 23 jan 2009, at 06:21, Junio C Hamano wrote:
>
>> This makes "git commit paths..." form default to "git commit -i paths"
>> semantics only during a merge, restoring the pre-v1.3.0 behaviour.
>> The
>> codepath to create a non-merge commit is not affected and still
>> defaults
>> to the "--only" semantics.
>
> Do you really want to do this? I think this is a pretty large change
> that can bite users if they don't know about this -- for example,
> because
> they forgot that they are in a merge (it happens..).
>
> FWIW, I'd much rather see a useful error message than this change. If
> this change does get in, I think it should be well-documented in the
> man pages as well as in the release notes.

As I said already in an earlier message in this thread, this is only a
weatherballoon series to help facilitate the discussion, and I am not
strongly in favor of this.  In fact, if I were, I would have done that
long time ago around v1.3.0, because there was a discussion about doing
this and the concensus back then was that the command changing the default
behaviour between -i and -o was too confusing, even though it may be
dwimming better.

The onus is upon those who argued that "commit paths" should default to
the --include semantics during a merge resolution in this thread to
improve the documentation, if they want this to go forward.
