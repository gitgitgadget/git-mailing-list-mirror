From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: show branch name if possible in in-progress info
Date: Tue, 29 Jan 2013 08:18:27 -0800
Message-ID: <7vobg8rmi4.fsf@alter.siamese.dyndns.org>
References: <1359461450-24456-1-git-send-email-pclouds@gmail.com>
 <vpqy5fcrwzq.fsf@grenoble-inp.fr>
 <CACsJy8DLdG9O+HaWS8u4n+imdaSZe=GrbYbPOhcMsYMWDq9NZw@mail.gmail.com>
 <vpqd2worv23.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jan 29 17:18:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Dtd-0002PQ-29
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 17:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab3A2QSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 11:18:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab3A2QSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 11:18:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F6A5CE87;
	Tue, 29 Jan 2013 11:18:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7wlh+SoF/S47291xfoy91CwC6Ws=; b=KYe6hr
	Cku0qUtvsRlM9hUMf+7AFiJj7QkgrElfOiliSkkMrCuZTF3ccxTZMrbwuAGXrAiR
	vkIP0ApccLBG2rf0GVpGyz38idI5x/NxO/ztiHPLyuD6nQE5yh/RdJre2uwQHjTU
	2n++tTYYhkDOdp8pSrYExnrJvtF6NSw16nnjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PrLt7uujcjXJuc2UqJTle8ipLaWyygx4
	sY0XoSQvQ2qULJHDxMz3JL4Tplqx467OWslHTEoe0g/YmSqMAUZFZDbGpS7MPbjm
	Dswu88txStDMc0SDL8GjZjOGrmHaPIZnuPXYACyOYz0BY75HhXmW/x9niWrl0Gpi
	jlI7HT4P25E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0C9ACE85;
	Tue, 29 Jan 2013 11:18:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60F1ACE83; Tue, 29 Jan 2013
 11:18:29 -0500 (EST)
In-Reply-To: <vpqd2worv23.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Tue, 29 Jan 2013 14:13:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84881236-6A2F-11E2-ACC3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214944>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Not HEAD, but .git/rebase-merge/onto, i.e. the target of the rebase.
> Ideally, I would have loved to see "rebasing master on origin/master",
> but I do not think the target ref name is stored during rebase.

Perhaps do it with --format=%s then.  It often is useless to know
only the commit object name (or the branch name for that matter, as
you wouldn't know what exact commit the branch tip happens to have)
you are rebasing onto.
