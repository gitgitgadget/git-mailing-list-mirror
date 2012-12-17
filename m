From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Makefile: remove tracking of TCLTK_PATH
Date: Sun, 16 Dec 2012 20:31:06 -0800
Message-ID: <7v4njlpaet.fsf@alter.siamese.dyndns.org>
References: <20121216193850.23461.28099.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 05:31:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkSMS-0004M0-7P
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 05:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516Ab2LQEbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 23:31:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab2LQEbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 23:31:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 174EDA83D;
	Sun, 16 Dec 2012 23:31:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8NJcTkNzg50IHy1yz2+Gllsl62U=; b=SNceHW
	MIcKefehgnZfB+6tgfIpRgmu8yQGvN9iw5kBxoc2S6qtZwpc1ILNYD5vTCJxe+Ed
	kUUZcjKIFVWZs7D9wMR2LG7cpVhtvfrmvBWVcRjiJlZIOhravhXIvOB9ax6S0p7V
	EhwOuCPf/ST+Bxm63TedMxI5bFoSbhFdMmzmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bzluBaIb0pkGEtbCcD7mxk1zjFgcE2Qo
	ORoSzBY7g9c914+DKDLLCmQdl38uQkb652qHBDvztAmOXiWfMoJdCF/LYFZs2zKG
	vpdsmxwNKyfY//v2X0aIYTzy0JiwUkFDVFgCJh1667JaO2+aqNUT9YaZhzKMZYW4
	I6Eci9xxSY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 055DFA83B;
	Sun, 16 Dec 2012 23:31:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77FE4A838; Sun, 16 Dec 2012
 23:31:07 -0500 (EST)
In-Reply-To: <20121216193850.23461.28099.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sun, 16 Dec 2012 20:38:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 936BD57A-4802-11E2-B23E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211627>

Christian Couder <chriscool@tuxfamily.org> writes:

> It looks like we are tracking the value of TCLTK_PATH in the main
> Makefile for no good reason, as this is done in git-gui too and the
> GIT-GUI-VARS is not used in the Makefile.

This was added to the main Makefile when we slurped gitk to our
project at the top-level, so I am not surprised if git-gui were
not depending on it at all.

A better explanation is that t62ba514 (Move gitk to its own
subdirectory, 2007-11-17) should have moved these lines to
gitk-git/Makefile (and I think we should move them there in a
separate patch).
