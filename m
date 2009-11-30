From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 00:49:36 -0800
Message-ID: <7vr5rgv1lr.fsf@alter.siamese.dyndns.org>
References: <20091130075221.GA5421@coredump.intra.peff.net>
 <fabb9a1e0911292355v260b9f0ck79d993e25f0c5c61@mail.gmail.com>
 <20091130075927.GA5767@coredump.intra.peff.net>
 <fabb9a1e0911300004w36c5da45q354aa4ff3153b6f4@mail.gmail.com>
 <7v4oocwh5o.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911300035o532153b7qdc2ecd768200ce09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:49:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1xF-0002HA-KK
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbZK3Itq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 03:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbZK3Itq
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:49:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZK3Itp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:49:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE3EE182F;
	Mon, 30 Nov 2009 03:49:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zkFY1k3dAlkTr+FE6uEquEw8rrE=; b=a8zRd8
	dFc4Q/tm1UEiAekn490GImQf7yCkfslRB9hlTrHAVFLrhwyrli7UyJf7tzGvSOvk
	MBGAf3ikY9GbTXdkXJsosB4YdLJ9dzffpJpzzB5ZlXSesiospbuhWz6aABTTWX1g
	GtdsGng7HVnv9YxiRD4iMPY80TtZNrIrlfZqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VbxSWujVP241HNu9zb3xAKSfWJ9OQRcm
	Kzy7Q1qIf45+PV0fhrbrz/cPzdmbGSPbIkZH9kW4YzRBmtJtayot2SRJbWAKzkaX
	dbsU6N4QnfwqPxBuXFw0ez9oT1vteQwnJafE+sqNMDBXOK0aeVsjMXJteXZX18QN
	uxbhSo9GE64=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 833EC1822;
	Mon, 30 Nov 2009 03:49:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FF271821; Mon, 30 Nov
 2009 03:49:38 -0500 (EST)
In-Reply-To: <fabb9a1e0911300035o532153b7qdc2ecd768200ce09@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 30 Nov 2009 09\:35\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E82FF84-DD8D-11DE-A2AD-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134085>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, Nov 30, 2009 at 09:28, Junio C Hamano <gitster@pobox.com> wrote:
>> Sverre Rabbelier <srabbelier@gmail.com> writes:
>>> I don't think that's true, git.git currently does not have such a
>>> structure (everything is just dumped in the root directory). The only
>>> reason git_remote_helpers exists is to make it easier to create a
>>> python egg out of it and install that.
>>
>> If that is the case, shouldn't each of the helper written in Python need
>> to have a separate directory, not just a single git_remote_helpers
>> directory shared among them?
>
> I don't understand why that would be needed? The reason we added a
> single git_remote_helpers directory is because we wanted to share
> common code, having a single python package makes that easy.

Sorry, I don't understand that.  With that reasoning, isn't having a
single git package, be it python or not, even easier?  Why would anybody
want a separate egg that includes everything that _happen_ to be written
in Python in the first place?  It doesn't make sense at all from packaging
point of view to me.

A separate egg per remote-helper that you can pick and choose which ones
to install and which ones to leave out would make perfect sense, exactly
the same way that distros already split git into "git-core", "git-svn",
etc., though.  Your "git-hg" may consist of a single egg and perhaps some
other supporting code, and people who want to convert away from legacy Hg
repository may want to install it, but it is entirely up to them if they
also want to install "git-cvs" that is implemented as a remote-helper that
happens to be written in Python, no?
