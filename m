From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule: handle multibyte characters in name
Date: Wed, 12 Jun 2013 15:57:52 -0700
Message-ID: <7vk3lzym1b.fsf@alter.siamese.dyndns.org>
References: <1370991854-1414-1-git-send-email-iveqy@iveqy.com>
	<1370991854-1414-2-git-send-email-iveqy@iveqy.com>
	<7vppvr11kg.fsf_-_@alter.siamese.dyndns.org> <51B8EA67.7040801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	hvoigt@hvoigt.net
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 13 00:58:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmtzX-0002sI-4N
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 00:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246Ab3FLW6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 18:58:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab3FLW6E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 18:58:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DC682725F;
	Wed, 12 Jun 2013 22:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l50J+kZZ2FpyqdlDxqIGB2+yhCo=; b=pCVZ6n
	Iz4YVc0xK7yVPZMFpvpQdIY+xHn5G0J9aK3UtsgrbfoInCvKfuY0fHzSAFR2X9nu
	ce4tvxSAhcfa2mkzwOktUs+zeWnKZyOM8vXQFW4xGtF85pFL8mXq8g2n/Tl5XYJ6
	WdvrkMorZiUIHk6YzFNwhr28ZqeY55yhwf9hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UmZnOzlNA75UriVKf1bEnFHtNnMiYv88
	JswFddh7CTCfOHV9PCdY6Lie5qwU6ayUCVxvitptM/6+RvbtGxaDKyAzgR18VUdg
	oWgcYCOOkMWbr6ShbkD9tKuCB2iZsPdTcTsR1DEn250QWYekoGQ5qKs3dq2Jdk+a
	TFSExIxi4WU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21EBB2725E;
	Wed, 12 Jun 2013 22:58:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73AC62725D;
	Wed, 12 Jun 2013 22:58:03 +0000 (UTC)
In-Reply-To: <51B8EA67.7040801@web.de> (Jens Lehmann's message of "Wed, 12 Jun
	2013 23:38:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89A22D18-D3B3-11E2-8CEE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227690>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Hmm, I just came around to test that patch, and for me the new
> test even succeeds without the changes to module_list(). So I'm
> not convinced yet what we are fixing here ;-)

My guess is that you have core.quotepaths set to false.

> The original poster reported that the submodule just added locally
> is not showing up in a subsequent `git submodule`. And it doesn't
> for me either, no matter if the path contains umlauts or not. Will
> take a deeper look when I find some more time to do that, maybe
> recent changes to "git add" play a role here too.

Thanks.
