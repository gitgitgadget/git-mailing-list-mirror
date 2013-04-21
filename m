From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/1] git-multimail: a replacement for post-receive-email
Date: Sun, 21 Apr 2013 15:12:04 -0700
Message-ID: <7va9orsfd7.fsf@alter.siamese.dyndns.org>
References: <1366541380-10786-1-git-send-email-mhagger@alum.mit.edu>
	<20130421105612.GA28959@elie.Belkin>
	<7vhaizu3j5.fsf@alter.siamese.dyndns.org>
	<517445E5.3080304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 22 00:12:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2UZ-0007Fu-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 00:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab3DUWMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 18:12:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55620 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab3DUWMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 18:12:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5A7818D75;
	Sun, 21 Apr 2013 22:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EJvRO0tmU/aKfZI94/phTaS7z5M=; b=yZz9cE
	ksjJV1uoWdxep2d0MJURk00c1w/cRpoBUCsrZbHx9PMOran4LBn3i9lsAqyRV3O6
	56gAhi1oE2mWpmp3CBzmcaP2su+KIRlo838BttoQ4clshufRgzmOoLKqy4C8PnaX
	oDGSbGWVeqchpJ4c9PbXFQsKqCIXOjwxlISFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RgQf8u8biN9wO8Ogg+KNVQT35NdvUdq2
	d6HOg66n3C3sg/O/9irF75cLTA+7p5pb++HcKzt8gKd/vgY5iohwx1PSBay6WPUC
	JQyr2hYQK2c5srT5Txoiu34ecE5TftLqi6LZVEzyXJmdKaB4LUpHWGfIT3WYFiNI
	WZ0InJBlimk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A71C718D74;
	Sun, 21 Apr 2013 22:12:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E23D018D70;
	Sun, 21 Apr 2013 22:12:05 +0000 (UTC)
In-Reply-To: <517445E5.3080304@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 21 Apr 2013 22:02:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8080E6E0-AAD0-11E2-A174-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221979>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> That seems very workable.

That is pretty much it.

> What is your preference regarding the history to date?

The only thing I deeply care about is that initial and subsequent
"git pull" I'll do from you [*1*] will pull in commits that touch
only the "multimail" part in the contrib/ area and not mixed with
unrelated changes to other areas.

If the history you have so far would later help others learn the
motivation, design, constraints etc. while developing it, which
cannot be easily read from the resulting code, i.e. help maintaining
it in general, it's a good idea to keep it.  In such a case,
however, people may want to review that history as well.

If it is the "oops, it didn't work, let's try another" kind of
"record as we build" type of history that may not help the future
maintainace that much, you may instead want to start with a single
code-dump "here is the first public version" (which is reviewed in
this thread, I think) without the history behind it.

Your choice, in other words ;-)


[Footnote]

*1* This does not even have to be a stable URL I would place in
remote.multimail.url configuration; it does not even have to be a
non-rewinding tree.
