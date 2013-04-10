From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 09:38:26 -0700
Message-ID: <7vzjx6mjct.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <20130410035039.GA795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Ngu?= =?utf-8?Q?y=E1=BB=85n?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 18:38:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPy2c-0001Bb-FV
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 18:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937071Ab3DJQi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 12:38:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932468Ab3DJQi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 12:38:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8137D12C4D;
	Wed, 10 Apr 2013 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j1TtwdJ7V3JcrUfo0kbJjwardYI=; b=LzFKcc
	queMMm1PSZ7IPqfqXoyY31uug20I5PCw1wntIll1l7Prv7nbQj4fBBJlUPFXqUtf
	DQYB/81jyBQTTUp9pBxPS5wZndmOriJxJ2Vvv6ZhmHd49YeDq1PvPDt8AI0FPdhN
	wYQCZdpw1CpLcNlymC48+chgI5Q33av+vLngU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=am3jIBxqqnpFtdMSSX+M6WZYHMqAkalU
	bD519sGCwqzkSFK5SjClqa3Vx0619im8FliVTtxG1GF3H7yoypa5it3KKxrmtedB
	O0dY84UOaNWBe/tP74PaanV69IvLgJ8g2vP8QZYKuUp7hkFQPks00IxuClY8tPSz
	CKMnhFbQAkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 746A212C4C;
	Wed, 10 Apr 2013 16:38:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A83D812C4B; Wed, 10 Apr
 2013 16:38:27 +0000 (UTC)
In-Reply-To: <20130410035039.GA795@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 9 Apr 2013 23:50:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12199E08-A1FD-11E2-991D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220703>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 09, 2013 at 04:13:32PM -0700, Jonathan Nieder wrote:
>
>> Random idea: today you can do
>> 
>> 	git push origin master; # push branch master to remote origin
>> 	git push --multiple origin korg; # push default refspec to 2 remotes
>
> Can we do "git push --multiple" today?

You can have multiple destination URLs for a single remote nickname.
Wouldn't that be sufficient for regular publishing purposes?
