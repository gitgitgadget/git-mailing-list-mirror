From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4 v8] config: write to $XDG_CONFIG_HOME/git/config file
 if appropriate
Date: Fri, 22 Jun 2012 14:20:29 -0700
Message-ID: <7vwr2zm4bm.fsf@alter.siamese.dyndns.org>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
 <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340355806-6894-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 22 23:20:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiBHQ-0004kW-7h
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 23:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337Ab2FVVUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 17:20:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756001Ab2FVVUb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 17:20:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C657880A;
	Fri, 22 Jun 2012 17:20:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=w5fLNcSrJHwoedDRaHC7KVgUSX4=; b=VfzC+9IqRUfLgLyABaFD
	CKlImtwtJZDQtzP3SOZYHj0M/99ofpixwTX4GkOCqhTVitasuZGbj5tQ9wyE9ztV
	GoVzXZTnsSFyUsHBBK75fKFztGyaLzb7f/4WaQSW5ehiwhuwKTlSQYYD+kfjq+pJ
	kT2sa0coa4PWBYyN11PY+ZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VawBAdpULGIHf1qp8APEDL4Q6cmRu9EYxSzYwr/au42iYc
	rYBGYrnA7AIGsztRlU/sAg819vOHZxIAjG6mpJdUw8J49qqWBMMh067nlJ/LRx6T
	IHs5rBaEknbHEoluW55hjap3S/NaOOLwstQE0X9dSlEI26XZMhiHMIwn8Itzg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42BA28809;
	Fri, 22 Jun 2012 17:20:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADD808807; Fri, 22 Jun 2012
 17:20:30 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1867F184-BCB0-11E1-BB24-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200472>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> From: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
>
> Git will be able to write to $XDG_CONFIG_HOME/git/config, a new
> ...
> Advice for users who often come back to an old version of Git: you
> shouldn't create this file.

Hrm, is there a better way to give this advice to the _users_?  The
log message is primarily for people who need to dig the development
history of Git, and they are not the people who will be hurt by this
change.  Perhaps the change to Documentation/git-config.txt in this
patch needs to be a bit more detailed?

Ideally, it would be nice if we could do the usual "advise" thing
by detecting a possible confusion, but I do not offhand see a clever
way to do so.
