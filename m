From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/19] new git check-ignore sub-command
Date: Fri, 28 Dec 2012 10:50:46 -0800
Message-ID: <7v38yqj9ix.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 19:51:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tof1V-0003km-Nh
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 19:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab2L1Suu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 13:50:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33385 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab2L1Sus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 13:50:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AF95A631;
	Fri, 28 Dec 2012 13:50:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JayWkex7J9+UaRCG2NIyYWs386o=; b=xWOG4a
	U6E3iC0QFHLctvLN9AQjqoDD1Sa3hg/vaInruT4WAeXSVO7zp5Ha0DElK5u5mUrY
	LJ7nc4TILf0PMDwDFGvLJtMeRUP/dOIBy8QlRfnhRNVnQ0HgwsSVzU5udB5cTFjZ
	KpaAbVv5B/fvcguWGggFD09I+OukyO3Ce7lQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gAcyeYUYjTz4Cxf6wDrRPFe+qx+BDXZL
	qir3n910ZQZ9v0+4dtdGs5lIL3OLRs+f7XZoTjXffjUs5Gh6+B8qq095sNY2m2SM
	AAslzqbaPX56kAThpS+J6X+RoGJfxN3f7nL8uhvEuuJ75ZVyLKqIaZmyUjTBTw0a
	s12wSZRU0e0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38BEEA630;
	Fri, 28 Dec 2012 13:50:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9CF3A62C; Fri, 28 Dec 2012
 13:50:47 -0500 (EST)
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 27 Dec 2012 02:32:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E29ACFC-511F-11E2-869E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212250>

Adam Spiers <git@adamspiers.org> writes:

> This v3 re-roll of my check-ignore series is a reasonably substantial
> revamp over v2, and applies on top of Junio's current
> nd/attr-match-optim-more branch (82dce998c202).

Thanks.

Does this (and should this, if it doesn't) interact with the more
recent discussion around "git status --untracked/--ignored" [*1*],
which also wants to touch the recursive directory traversal logic in
"dir.c"?



[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/212127/focus=212136
