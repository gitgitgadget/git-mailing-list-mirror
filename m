From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Tue, 03 May 2016 11:31:25 -0700
Message-ID: <xmqqbn4nngci.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461942126-16296-1-git-send-email-tboegi@web.de>
	<xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
	<a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de>
	<xmqqtwigtjfg.fsf@gitster.mtv.corp.google.com>
	<xmqqpot4s1ap.fsf@gitster.mtv.corp.google.com>
	<55d60bb1-8626-4c97-630c-1a9f114c46b4@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 03 20:31:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axf6c-000187-OL
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbcECSba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 14:31:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755635AbcECSb3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 14:31:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C7719D29;
	Tue,  3 May 2016 14:31:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WOchAoWlTCMn
	kwgGvw/gUBEvRDc=; b=Hlvf5+K1xrwsjxVWDbl23CGesf4r5lX830NNUXzbC8vV
	LjQwCKKkx7F3oQllaa1HOsT5svikwON1z/oXPTInp61TSAMpsiY6sD80bdWDR+fw
	hXsLsbmoEtt8c+N6WqFpelG1HWDIZt60/1MlceGmTN/b+BND71z2AuTo6Whonao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eV18UC
	Smnxg/bxfNAS4Reu17qq2Qj1rSl7dK/phoAGARU81IDRfGIHTANIKzDuriSibWjK
	zfpTJ350sbYE6zsENEBavDx/K/8zaYiosMUOUE8ysv6NulcciRwppSpIZpa70Q9B
	cDRSvAlSpekEMa83d/GlzZAEyRPDhcXuFFvGw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FD9019D28;
	Tue,  3 May 2016 14:31:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE56819D27;
	Tue,  3 May 2016 14:31:27 -0400 (EDT)
In-Reply-To: <55d60bb1-8626-4c97-630c-1a9f114c46b4@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 3 May 2016 18:02:07
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3F8DA4CE-115D-11E6-AE67-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293431>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> This will probably take some time, so that's why I asked if 1/10..4/1=
0 could
> proceed as is ?

Sure, I wasn't saying 1-4 looked wrong at all.  I was wondering why
the ones in the middle, especially 7, shouldn't be moved forward
together with them.
