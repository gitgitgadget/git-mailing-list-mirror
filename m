From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] remote-bzr: reorganize the way 'wanted' works
Date: Thu, 16 May 2013 11:35:02 -0700
Message-ID: <7v7giy6aeh.fsf@alter.siamese.dyndns.org>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
	<1368693407-21267-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 20:35:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud31E-0004MH-MD
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 20:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab3EPSfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 14:35:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277Ab3EPSfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 14:35:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A4F21F50A;
	Thu, 16 May 2013 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pziFZgtRL9sU/XVOgYcC9OIilKg=; b=TAqYg4
	h3InlPoTk8HfLtsn3i2p2dLltYoPE9scnnBWk/LJFFBACsX1HOojz+XoW+Qj/Npw
	3agGHQ6oRuAd1fThRL+AY6HqJVy0WNS+DJsBUrui/vU8muuGKsPhUvMg5kYxj9fZ
	pVT40ZSdWe6nQ4z23Oia41iHWcTzZdhxkqZ7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hyq4cTfGx5ols9JesHZ7KlwVHm3dpxfZ
	5IOeRmdDkt5EtR2r7wWjoAvcZ0NdizBHC56LsoAtzSFZh95nZhvf6a/aIbmxzy7F
	mmbFGofP796kYCZO5iwo346rjQL+d4wFvn9hHr/dgwuOkgYzYbG6UbHOLHfR+Egu
	a6i69cYAXTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DFCC1F507;
	Thu, 16 May 2013 18:35:04 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04D721F505;
	Thu, 16 May 2013 18:35:03 +0000 (UTC)
In-Reply-To: <1368693407-21267-8-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 03:36:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 531BC0F4-BE57-11E2-BA10-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224608>

The series fails to apply (on top of the hotfix for 1.8.3 you sent
earlier today) at this point.  It wants to remove the code added by
the hotfix but I do not see a corresponding check for listable,
which may make sense, as the log message says, when the user
specified a list of branches:

    If the user specified a list of branches, we ignore what the remote
    repository lists, and simply use the branches directly. Since some
    remotes don't report the branches correctly, this is useful.

but it is unclear if the listable code needs to go somewhere else
when the user didn't.

I'll stop at 6/8 for now, as this is not urgent before the 1.8.3
release.
