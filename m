From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to manage parameter files and code separately using git?
Date: Sun, 02 May 2010 08:52:14 -0700
Message-ID: <7vmxwiuwr5.fsf@alter.siamese.dyndns.org>
References: <op.vb0195s1a8ed4e@dellschleppa>
 <7vmxwj5ym8.fsf@alter.siamese.dyndns.org> <op.vb2ms4r8a8ed4e@dellschleppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tilo Schwarz" <tilo@tilo-schwarz.de>
X-From: git-owner@vger.kernel.org Sun May 02 17:52:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8bT2-00078I-US
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 17:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777Ab0EBPwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 11:52:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab0EBPwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 11:52:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E4ACB09E8;
	Sun,  2 May 2010 11:52:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ObguubzK7qstbj4c8/goALfTXXY=; b=OpCAdQ
	Tjej/w+QwLLIu1eLBMwQukG74oW7RA09CyuoPe4HLSNARSxuELzH48rtSA3THAav
	siNGKxuNJ9Mt8wobA59eNlFt0eXFxQuSkExBivpwK47/KoUW0/bucZoN+lZrImPe
	NTvkKSyoUAxCLktbvWSErymXqc2Jg8guXoh+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=juYLr6C/4nIe6JY4C9jihanlD8TvKuzh
	qiht23AJ7T+BiaLh7OulhFylsCKL8KsclysmDiZJ+oTXOsC8aA8c99A/xNK2WnzU
	HFLLQKK75gyz2ZOXTQrTyWZd+1m+C1yEo0xosjPY7xhvvQpu+I6okBqPGZHN1DTT
	vz5mCYS/8lg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CD20B09E4;
	Sun,  2 May 2010 11:52:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B53E2B09E3; Sun,  2 May
 2010 11:52:15 -0400 (EDT)
In-Reply-To: <op.vb2ms4r8a8ed4e@dellschleppa> (Tilo Schwarz's message of
 "Sun\, 02 May 2010 11\:18\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AFBDC62E-5602-11DF-9194-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146186>

"Tilo Schwarz" <tilo@tilo-schwarz.de> writes:

> I see. So if I want parameter file history the only proper solution is to  
> have a separate parameter file git repo, right?

I wouldn't say it is "the" "only" proper solution, but under your design
constraint that dictates that the part that is left in "config" (which
includes the tracked-and-tied-to-the-software-version "config.sample")
must have a history that is independent from the software history, it is
one workable solution that would be the easiest.  I can imagine a more
elaborate implementation that stores the history of that config file on a
separate branch in the same repository and manipulate that file with
custom scripts, and that also would be another workable solution.
