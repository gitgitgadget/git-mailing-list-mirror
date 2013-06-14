From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] git-remote-mediawiki: remove hardcoded version number in the test suite
Date: Fri, 14 Jun 2013 11:09:27 -0700
Message-ID: <7vsj0ko97s.fsf@alter.siamese.dyndns.org>
References: <1371205151-13549-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Fri Jun 14 20:09:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnYRK-0004Y0-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 20:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab3FNSJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 14:09:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab3FNSJa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 14:09:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A072528624;
	Fri, 14 Jun 2013 18:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OZh6XB0f/XzX06WtN5s8BPmq1as=; b=ir7/q+
	4vEXqkJjUvXBqddKNGHwVPQbp38onyjKzKKDvxueJ0AJEJLCn3touLkaDVUb0d2L
	iC4H4VxuCtT8eagaVMNdtqN73PtewlOWInBVJ1YkZLeS1M01E6XKqbTFw5EkO57z
	797XH/bw0duTQP4ZN35Wbz0SlDel2NjmSovgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UbY2iwIe4At20TaEyQh0R6ZStwBzKrpr
	QoM7HK66r69ROLj2s9loIYPQ04gSBlR8W7q6YdJ/edOgh18CREIvYRrhtllaR0oO
	6MQxRFu1idMaSLk81tv9yV9Bg5BPMxX00N6NdJ/361KQT1q7UUJRNFESFFgB8op+
	55sDhrMSF24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9580528623;
	Fri, 14 Jun 2013 18:09:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2046928621;
	Fri, 14 Jun 2013 18:09:29 +0000 (UTC)
In-Reply-To: <1371205151-13549-1-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Fri, 14 Jun 2013 12:19:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E39433C-D51D-11E2-B4E8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227906>

benoit.person@ensimag.fr writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> Updates the code to make it more easy to switch mediawiki version when
> testing. Before that, the version number was partly hardcoded, partly
> in a var.

This definitely goes in a good direction; you no longer have to
touch random lines in test-gitmw-lib.sh and what you have to edit 
is very much localized.

It seems t/test.config that is tracked is also designed to be
randomly edited to suit user's needs.

The patch does not make things any worse, but I would imagine that a
better longer term structure would be for contrib/mw-to-git/Makefile
to create contrib/mw-to-git/t/test.config by replacing variables in
contrib/mw-to-git/t/test.config-template, so that the user could say

	cd contrib/mw-to-git
        make MW_VERSION_MAJOR=1.20 MW_VERSION_MINOR=0 test

or something like that.

But of course, that is a totally unrelated issue.

Will apply.  Thanks.
