From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1503: test rev-parse --verify --quiet with deleted reflogs
Date: Mon, 15 Sep 2014 11:17:31 -0700
Message-ID: <xmqqy4tk7npg.fsf@gitster.dls.corp.google.com>
References: <1410683442-74523-1-git-send-email-davvid@gmail.com>
	<5415C069.9000702@gmail.com> <20140914185403.GA93515@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:18:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTarN-0005yx-RD
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 20:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbaIOSSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 14:18:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52898 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468AbaIOSRe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 14:17:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51CC3390FC;
	Mon, 15 Sep 2014 14:17:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0GL1yOAWexHjjtHDCXbF5iCjTPs=; b=C5cGqF
	ICGCXWd2aO+EB7yP2ObwguJlCQn7C5einmMya4oPQGReRB5wFLRPb7V1XnSrAIOo
	+ObvoIEgvdVEIi3QnhuEDKQbsgfkdDEKSzczflKIOsBImWEYM4woTKPVUz+Ry3SR
	pm6T9t4A/oH2yTnSeMzblv5EjJhVqWJsSKSKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rdme3nHeM4XdB2ROhjE4I61BOZ72FPeK
	oISdA1qLvQlZOyi4+zoPdE5jNY1v1gAY5zqR1UBvU61pLTRXgN6OiIrqDz7YxZAD
	M3axDDowL2oMmezysbeHhpFIT7nho0Xg85gBQ11ah86jmV/hkJg+W9pcOOC2oq5M
	r/fpvBitXxE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45E3B390FB;
	Mon, 15 Sep 2014 14:17:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B2924390FA;
	Mon, 15 Sep 2014 14:17:33 -0400 (EDT)
In-Reply-To: <20140914185403.GA93515@gmail.com> (David Aguilar's message of
	"Sun, 14 Sep 2014 11:54:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9042E0D4-3D04-11E4-8F40-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257062>

David Aguilar <davvid@gmail.com> writes:

> Good point. The --quiet spec doesn't say anything about stdout,

Please correct it while at it in the doc ;-)

I think I had to look it up in the documentation and then in code if

    git rev-parse --verify --quiet "$object"

the right way to check if the object is a good name without output
when it is, and get diagnosis in an appropriate error message when
it isn't.
