From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] post-receive-email: deprecate script in favor of git-multimail
Date: Mon, 15 Jul 2013 06:38:22 -0700
Message-ID: <7vip0cdju9.fsf@alter.siamese.dyndns.org>
References: <1373789343-3189-1-git-send-email-mhagger@alum.mit.edu>
	<1373789343-3189-3-git-send-email-mhagger@alum.mit.edu>
	<20130715060245.GD2962@elie.Belkin> <vpqoba4gr9h.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 15:38:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyiz0-00052T-RR
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 15:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab3GONi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 09:38:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349Ab3GONi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 09:38:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33DF92FD51;
	Mon, 15 Jul 2013 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=32OLM8PoNQ6MSvc4HAAru2Rl19c=; b=ZohFTA
	tXgzJnuln/qOQ0o4jKOoyBTKMBfXsd+ay6s6XHziNyf18Up8op7i8qH+gafNFIZ9
	o9HT6ScXeTRLmeQ1deHpwPbLHgzYMW1TVerHy899EUquyToHBJ8Q3u6J5aVtsYUd
	kVEoCoItTjS7uki7gmiPc5g1YmamuCQ8dhTEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ngi16AfKuUOfBhRpdvDhEKIMFEVjM8Ww
	g95rPQKssjPbYAUhVsiuN5JdPLKPMZPXC2RV9hXb7v6SZsdc6jqvBZWHSUnDjETo
	sCZDlAzojCPxxGMCyD+pl0kYfcZ1VsdkITAuRdhWke952tYHNPkKS+BbR2Gpw7qH
	th6l9SnAxtE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26CF82FD50;
	Mon, 15 Jul 2013 13:38:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 678062FD4E;
	Mon, 15 Jul 2013 13:38:24 +0000 (UTC)
In-Reply-To: <vpqoba4gr9h.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	15 Jul 2013 10:29:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D28EEEB2-ED53-11E2-A8FB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230469>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> (3)
>> 	# An example hook ...
>> 	#
>> 	# Warning: this script is no longer actively maintained.  Consider
>> 	# switching to ...
>>
>> I prefer (2), which makes it clear to the reader that it is dangerous
>> to keep using the script (since no one is actively chasing down bugs)
>> while also making it clear why a potentially buggy script with a good
>> natural successor is still in contrib for now.  What do you think?
>
> I don't think it is dangerous to keep using the old script. If you look
> at its history, it's pretty stable these day. I think it has known bugs
> in new revision detections that are fixed by git-multimail, but nothing
> really blocking IMHO.
>
> There are two good reasons to use it: 1) you already use it, and you're
> too lazy to change (e.g. because it's packaged by Debian and is already
> there on your server), and 2) you don't have Python on your server.

Well said.

> I think the notice still deserve the "***NOTICE***" or whatever makes it
> visible enough to distinguish it from the traditional licence &
> non-warranty header, but I don't think we should kill the old script too
> early.

True.  I personally felt that Jonathan's (1) read the most natural
(i.e. showing no strong preference, just let the users decide).
