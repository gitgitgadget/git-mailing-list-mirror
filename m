From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and update command.
Date: Mon, 03 Mar 2014 11:22:55 -0800
Message-ID: <xmqqmwh7ozn4.fsf@gitster.dls.corp.google.com>
References: <1393858066.7891.20.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:23:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYSU-0005AA-1o
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbaCCTXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:23:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48616 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459AbaCCTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:23:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EE74709FA;
	Mon,  3 Mar 2014 14:23:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tR9cjNPGinlcPhNfvcoWL3pPxfw=; b=nQylSG
	SWX1qkSvNRZmCzNMEIzGUdnOHbUwfzK4sNeRJu8knUUE2HtCEbr/Zi1jEIVq+9LM
	HtP6vPITU+PLsUCJdjMPMiq8XrdEdkmDf8dkRsiiTj2ksoJ64hYHnEkFgPFy+OSm
	ElV9JPBQ8gBvSX1zWA0mNu75GWmZWo5kaXwPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QnSJkGhpB/egBoZ/7H4OlnWkKKTCnDy9
	47ieDT6tKPVHHOuLj6ohYz9N7+QuyFua8u3dqBloRLPfmjucAa9ORCbao60sq1/J
	hUCfrIT6hau2fHk+9/SnPVZD2WsfeEcXCPb/rlZ+L8tBKWglEWRR/B8kvd3GRbRu
	KrYsa7gSzW4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CBC5709F9;
	Mon,  3 Mar 2014 14:23:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D596709D5;
	Mon,  3 Mar 2014 14:22:57 -0500 (EST)
In-Reply-To: <1393858066.7891.20.camel@Naugrim> (Henri GEIST's message of
	"Mon, 03 Mar 2014 15:47:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 426F9DC4-A309-11E3-8E39-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243258>

[CC'ing the submodule area experts.]

Henri GEIST <geist.henri@laposte.net> writes:

> This new option prevent git submodule <add|update> to clone the missing
> submodules with the --separate-git-dir option.
> Then the submodule will be regular repository and their gitdir will not
> be placed in the superproject gitdir/modules directory.
>
> Signed-off-by: Henri GEIST <geist.henri@laposte.net>
> ---

Thanks.

The above describes what the new option does, but does not explain
why the new option is a good idea in the first place.

Given that we used to directly clone into the superproject's working
tree like this patch does, realized that it was a very bad idea and
are trying to move to the direction of keeping it in modules/
subdirectory of the superproject's .git directory, there needs to be
a very good explanation to justify why this "going backwards" is
sometimes a desirable thing.
