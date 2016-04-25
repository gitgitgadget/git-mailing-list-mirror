From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 12:46:38 -0700
Message-ID: <xmqqpotdjwtd.fsf@gitster.mtv.corp.google.com>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
	<vpq37qeovu4.fsf@anie.imag.fr>
	<xmqqinz9pl3l.fsf@gitster.mtv.corp.google.com>
	<EDD0757C-2BD3-476F-B703-147D35BB1FAC@gmail.com>
	<xmqqh9epmxtj.fsf@gitster.mtv.corp.google.com>
	<xmqq37q9ldd9.fsf@gitster.mtv.corp.google.com>
	<vpqwpnlpjrf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 25 21:46:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aumT3-0007LG-Hw
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 21:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbcDYTqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 15:46:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933446AbcDYTqm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 15:46:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 968BE16000;
	Mon, 25 Apr 2016 15:46:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3TB3XBjeS/lns4uCQYCQst+qWjM=; b=C7xICp
	vPimC67bV+3PgER5HAGZ+Xl7lQilcvYKCMLgXN0ak3t82IQchNh9MhGkfmo6RSsD
	QBUHqYaXTD9Jsa8mtKO+eDidB21EOfSKD15KPXMAXQDgyNPLDIeahJE3LFSsGRor
	h4KY83jbM3szImQkeXVOv67YxclRxvcm/qPxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fk0mwbY2z+Qh2YVlMI1/PasjeAz6RAI5
	BvYOQRYdDN+84H/w3JQTv00Bv+K7i0st8GO9fyOIcIghmvrHfRGuCtBpzG86sFGk
	53UXmVhQcUrW/HZmo56fHuEpnrj334/bo9YXVhr1APvxhZDdYqrmDq/hcnXJyQVk
	Tl5e2wMEzJc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C8FD15FFF;
	Mon, 25 Apr 2016 15:46:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D764E15FFE;
	Mon, 25 Apr 2016 15:46:39 -0400 (EDT)
In-Reply-To: <vpqwpnlpjrf.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	25 Apr 2016 21:32:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6DB6648E-0B1E-11E6-A509-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292551>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, this may also be a motivation to move anything non-trivial out
> of .travic.yml and to start using separate scripts (to avoid writting
> shell within a Yaml syntax).

Excellent suggestion.  I do not mind if we added a new directory at
the top-level of the tree to hold helper scripts for CI (perhaps
call it ci/ not travis/ so that people may later add helper scripts
for other CI systems of their liking if they wanted to).
