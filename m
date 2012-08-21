From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/16] remote-svn: add marks-file regeneration
Date: Tue, 21 Aug 2012 14:44:11 -0700
Message-ID: <7vfw7fdiok.fsf@alter.siamese.dyndns.org>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <7vehn1gocn.fsf@alter.siamese.dyndns.org>
 <7va9xpgngk.fsf@alter.siamese.dyndns.org> <1894713.otuKr9xS8H@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:44:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3wFK-0003Nl-OB
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 23:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758647Ab2HUVoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 17:44:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758482Ab2HUVoO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 17:44:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D249788DA;
	Tue, 21 Aug 2012 17:44:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bpPFQonosNIxTR5EBMoDekvbHu4=; b=kAy8OD
	Hq43oSAyj/GbKuUzSHMjF9k7YgGdxaEe3dY431Txh/ZQfT6gIZn3NwA2lsDCgziH
	CCMe8KN5OUd/tltGxT5iviiuJU9XUoua8A47lRHI+AHG1Ci0C6W1NlAq5iZa8HaW
	Le9VDv9grf50UQknm/wFN2E6taMoijRTeDTFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BtolbykTBG/HafXKA9Dql6FOww4b7dhc
	QL0zQPekJpzn3C2TDC2U5t3fh86GIPBZCWPQBUtpioCg+DMVMYyoCsvxiiXggh3D
	TMDJHhq3ZWunoqcWJm+CopVnmLV5jpZIT9Jq1RCsB/sEOAeBK8gSQlU4MxWnJfZ9
	IuVnHeH31Jo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF31A88D9;
	Tue, 21 Aug 2012 17:44:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DAA688D7; Tue, 21 Aug 2012
 17:44:13 -0400 (EDT)
In-Reply-To: <1894713.otuKr9xS8H@flomedio> (Florian Achleitner's message of
 "Tue, 21 Aug 2012 11:47:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5911FA56-EBD9-11E1-9818-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203992>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> On Monday 20 August 2012 16:20:27 Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> > I think you meant something like:
>> > 
>> >       init_notes(NULL, notes_ref, NULL, 0);
>> >
>> >         marksfile = fopen(marksfilename, "r");
>> >         if (!marksfile) {
>> >               regenerate_marks(marksfilename);
>> >                 marksfile = fopen(marksfilename, "r");
>
> Btw, this is FILE* is nowhere closed in your fixuped version in fa/remote-svn.

Please fix up things like that in your reroll.  I was doing minimum
fixes I noticed to get it compile before pushing it out as part of
'pu' (the alternative was simply not to merge and discard the
topic).

Thanks.
