From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] handle_alias: provide GIT_CWD to !alias
Date: Tue, 26 Apr 2011 15:22:44 -0700
Message-ID: <7v1v0od557.fsf@alter.siamese.dyndns.org>
References: <4DA59B27.50506@ge.infn.it>
 <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matej Batic <matej.batic@ge.infn.it>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:23:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEqer-0001Er-Nl
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 00:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab1DZWW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 18:22:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1DZWWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 18:22:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E949056BC;
	Tue, 26 Apr 2011 18:24:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=llw6SrTIbWpv+iwSUJN9DpGGado=; b=q1j8Nh
	QdSAks7nft/yQ3vV5XSqXmkKdrU69BthYEgDbVfrInPnMRLyndm1B0+/IttiXrLM
	K1zPhok5/53mloDL0daUWp6g1z4rcKW2iOZNDjeZEZ7RJY5w7y8ZlDHDM48QCuPD
	ChZxu/Fo6oMfQzcI/y0WF5WZe1ibS/CjjhEOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vmFQfwgY4UEeV92l9yAqqJacmteyKjEC
	Irn5Cn+o/+wXkl9OZ3tHqpMGgEtI/ptWsd4RtDSZ5eg1TDIilti9QvCU9rmJf2lQ
	RoGf7mgIfmJCcBzrilospMHHWFjeFiQuJ7e3ZZq3/ST8L7qDg62kWF+1MlhxwiiT
	FdLjgJfkkKk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6AC756BB;
	Tue, 26 Apr 2011 18:24:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9106656B5; Tue, 26 Apr 2011
 18:24:47 -0400 (EDT)
In-Reply-To: <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed, 13 Apr 2011 15:05:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00F0BA94-7054-11E0-8B8B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172131>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Provide an environment variable GIT_CWD which contains the subdirectory
> from which a !alias was called since these cd to the to level directory
> before they are executed.

Isn't this what we usually call "prefix", though?
