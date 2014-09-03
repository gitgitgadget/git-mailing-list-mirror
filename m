From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Wed, 03 Sep 2014 12:18:00 -0700
Message-ID: <xmqqoauwy0lz.fsf@gitster.dls.corp.google.com>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
	<5406B4EF.3050301@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>,
	Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:18:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPG4M-0001V0-Ka
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 21:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbaICTSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 15:18:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57850 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897AbaICTSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 15:18:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69B4437CBD;
	Wed,  3 Sep 2014 15:18:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PIorgedM6fgk+GNtObEXOgyiLmU=; b=EEK52s
	c+WYDEqgko7xfI6yWsAqWNppcxdwBC73hOXTx6nw2J4pvbvX6cg/qlAPs0XBjk/z
	kL6WB31HzrNwCaEI/IFhdmIeaBb/RvPLL5KMyPxEntBIVa8fOT1EyfL6+rGsDFWB
	gss6T+J1BD01KMli7+D2v7ml/NEuQjb4SVtyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZiRLWbU2dejO+0/7BRx+aIA67YNclwkt
	ZJe4Cti0oe8rOiSbx/wM+GaIQx2XKMeh21gRjIF5ZkP6UZrfhrNoWfDN69VOCVlo
	WwW+DOHhnP29nkX5mj/r6O9bu+4MxroGudIGLPtdKCMtmzp26MwtYbHpKoTS1Lf4
	1/DK4olXL1E=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EE4737CBB;
	Wed,  3 Sep 2014 15:18:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D06CF37CB8;
	Wed,  3 Sep 2014 15:18:02 -0400 (EDT)
In-Reply-To: <5406B4EF.3050301@kdbg.org> (Johannes Sixt's message of "Wed, 03
	Sep 2014 08:27:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 066F27C8-339F-11E4-AA03-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256403>

Johannes Sixt <j6t@kdbg.org> writes:

> But IMHO, this topic goes in a wrong direction. "Avoid deprecated
> interfaces" is way overrated. It would be preferable (IMHO) to implement
> setitimer() in compat/ for systems that don't have it.

I think I agree.

Adding compat/setitimer.c that implements git_setitimer() in terms
of whatever is available on the platform and #define calls to
setitimer() away to git_setitimer() would be a lot less intrusive
change than the series posted.

Thanks.
