From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch --no-tags with and w/o --all
Date: Wed, 06 Mar 2013 16:41:44 -0800
Message-ID: <7vhakonirb.fsf@alter.siamese.dyndns.org>
References: <1879950.i2j8pjGADy@gandalf>
 <7vboawp4zy.fsf@alter.siamese.dyndns.org>
 <20130307002038.GA31571@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cristian Tibirna <ctibirna@giref.ulaval.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 01:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDOuU-0001Au-UI
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 01:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758440Ab3CGAls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 19:41:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758398Ab3CGAlq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 19:41:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A81ABBDE;
	Wed,  6 Mar 2013 19:41:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DvGwB5nuifsuRV98jLMND5DhjAU=; b=eshC4Q
	w8DQfMi5LNfayWAvnPLfm/0tV1oRYzVVkZBgWT4cPNXyLLPS1q00/yTvxlDYnY6n
	G0K7isA9TSDMIS+cqq01iDn1ot1NGX3cWrjGKQOxu+mHcGep+jhVQY4/FaF7+Blt
	shI3LDbNdpv58sbUXiSdj4fchsAmpPMHHKpJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ib98Uadjh5Q0ZCM0B1KmzXCSg4Ql/0RC
	zpvOl+MGiaKVQl+edW1p2DmKVyVqE/4RFju0L64oBZK3VVl20tSVme/MJa595f6x
	PQsQycw+T2YAwuiXr8xYtxxUSlNdETcdqxHKm3MoDhWLMOjqm9B/QxX3ARQzefow
	QYbzwZqdNeo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E54ABBDD;
	Wed,  6 Mar 2013 19:41:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8050EBBD7; Wed,  6 Mar 2013
 19:41:45 -0500 (EST)
In-Reply-To: <20130307002038.GA31571@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Mar 2013 19:20:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9B2A1C6-86BF-11E2-B423-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217565>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 06, 2013 at 01:56:01PM -0800, Junio C Hamano wrote:
>
>> Cristian Tibirna <ctibirna@giref.ulaval.ca> writes:
>> 
>> > Hello
>> >
>> > $ git --version
>> > git version 1.7.10.4
>> >
>> > $ git fetch origin --no-tags
>> > does what it says
>> >
>> > $ git fetch --all --no-tags
>> > still gets all the tags from the remote.
>> >
>> > Is this known?
>> 
>> Because --all (or --multiple) to iterate through all remotes
>> does not pass accept any command line refspecs, using these options
>> with --no-tags and/or --tags should be diagnosed as an error, but it
>> appears that the error checking is not done.
>
> Or we could just pass them through. Looks like this was already fixed by
> 8556646 (fetch --all: pass --tags/--no-tags through to each remote,
> 2012-09-05), which is in v1.7.12.2 and higher.

;-)  No wonder this looked somewhat familiar.
