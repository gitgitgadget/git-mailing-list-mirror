From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/23] Add reflog_expire() to the references API
Date: Thu, 04 Dec 2014 15:47:20 -0800
Message-ID: <xmqqtx1bq8on.fsf@gitster.dls.corp.google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:47:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwg7K-0007DL-VD
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbaLDXrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:47:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754730AbaLDXrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:47:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2030024C9F;
	Thu,  4 Dec 2014 18:47:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zsst3W7vf4DkAtU9Vy/JdI6xSY8=; b=xy7eb4
	NIjVPmKa0EI4AOrdrzywXZuLKMWVeSsrH58OpQkqWdCwsNt2JaPZLSgLtZM/4aLR
	2MyjWkbkDjXBoS09NHU5RXu0sao8jgTx4ViMudT7CknK+vw3PLjh40xPHvkLRPiO
	haXPSZ6mgLgjaYAxs0DlghDMFk/wQm/AF2Btg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LqMSAWF00FJOF/o2/4fun+QKhD+RzRMG
	FrO/EUnHnyRkHK+zAz2YXsCjs07yVEeMv616IyJ6o76kjaY8/l+aslO36v33akMv
	a9psvULKHLG2Ac+foAc1ECuga+FKubdFcQ27B7d3Fcv/tPRbjfWtjAiLdQmYbcGM
	dwWrTuLTXBw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 145E024C9E;
	Thu,  4 Dec 2014 18:47:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A034024C9D;
	Thu,  4 Dec 2014 18:47:21 -0500 (EST)
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 5 Dec 2014 00:08:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3D467B4-7C0F-11E4-BC5B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260842>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I propose this patch series as an alternative to Ronnie's "reflog
> transactions" series.

After coasting my eyes over individual patches, it was delightful to
look at the endgame state of the expiry codepath in builtin/reflog.c
that is left ;-)
