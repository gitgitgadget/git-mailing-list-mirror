From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:17:24 -0800
Message-ID: <7v8v6vpbej.fsf@alter.siamese.dyndns.org>
References: <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
 <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <20130211071235.GL15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:17:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4neA-0000g0-EL
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab3BKHR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:17:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab3BKHR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:17:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE6B9BFDD;
	Mon, 11 Feb 2013 02:17:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h3ZgE1xyouvETH2/QvbjLmC+QdE=; b=Vbq+bR
	CmEAmgtXm+8dJMLBmA3kphhwx/PMr3KVmtK5xLBvhEHrKXaiyV8E7B2fAjHoQZLb
	8Hd7lnj8qAzpU/zSzA6WcoQ3izud9ocSgFHO3zTcINoMEoxref/PCWOLDwcxL7fk
	3lk9HzfQLwrBdwDZsb+YJSyCv7gsQQTdWv6WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dbuq9+FKzllZKoBiJL3avZpxUoEyby2U
	OLbt30qV3q2xReHyfiEMIyiD74wTsAM/74+p57jdhA37CdLeepclD5J67vIbcgdf
	JXE3NADNQL+hS4rYBbrouLGvMkg+RaEKL+UARnIgKB7KvI0EHZjqXkjWKlAfnQRF
	qQNjBntVKOQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D38C2BFDC;
	Mon, 11 Feb 2013 02:17:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 663E7BFDA; Mon, 11 Feb 2013
 02:17:26 -0500 (EST)
In-Reply-To: <20130211071235.GL15329@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 23:12:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16796BD2-741B-11E2-B1B7-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216012>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Isn't that a criticism of the git-shell-commands facility in general?
> If it is common to have a lot of users with distinct home directories
> but all with git-shell as their login shell, then the
> git-shell-commands should not go in their home directory to begin
> with, no?

You can give one set of commands to some users while restricting
others, no?
