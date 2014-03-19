From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5510: Do not use $(pwd) when fetching / pushing / pulling via rsync
Date: Wed, 19 Mar 2014 14:10:25 -0700
Message-ID: <xmqqy50528u6.fsf@gitster.dls.corp.google.com>
References: <5329F379.3010508@gmail.com>
	<alpine.DEB.1.00.1403192103300.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, thomas.braun@byte-physics.de,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:11:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQNlr-0002is-0v
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbaCSVL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:11:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaCSVLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 17:11:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE9B175D17;
	Wed, 19 Mar 2014 17:11:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E6J4ThmIYflIt98NwCTvPu4ACe4=; b=eXA6lN
	uOc/IHdmz25vBjZI+LVOC9sXCJNI0/ydPdxpY7y9cojfoUc+UDespho0J5x7dE8a
	h1H2VotOGT9HtDybWnIcfYba0sf5C6080B3UTzH+gkNtHfdY9sRCJs+TgaC4yzzM
	49qIpBF6Wm9w2LnF+eag3l8UZhGhLRz7CbA88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PT6t7n/ZfgsvH/lsIXtWv/mVTdu77NVd
	Ka2PUssvztrJDuGDlUe7/W0R+J+3qd8ASh7p9k6qwQr3vgBTXDebvkWL4Ujyhmov
	7a5Snd4eV+34dxscaYsKhBI2Ys/cQpAI0W+wTmW5b4FIrVcor26sSqymV2b/LYqO
	Uq3iWcESVhY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B4975D16;
	Wed, 19 Mar 2014 17:11:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3156175C4D;
	Wed, 19 Mar 2014 17:10:27 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1403192103300.14982@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Wed, 19 Mar 2014 21:03:57 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E4F9875A-AFAA-11E3-BD1D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244493>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sebastian,
>
> On Wed, 19 Mar 2014, Sebastian Schuberth wrote:
>
>> On MINGW, "pwd" is defined as "pwd -W" in test-lib.sh. This usually is the
>> right thing, but the absolute Windows path with a colon confuses rsync. We
>> could use $PWD in this case to work around the issue, but in fact there is
>> no need to use an absolute path in the first place, so get rid of it.
>> 
>> This was discovered in the context of the mingwGitDevEnv project and only
>> did not surface before with msysgit because the latter does not ship
>> rsync.
>
> ACK
>
> Ciao,
> Dscho

Thanks.
