From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 6/7] correct blame for files commited with CRLF
Date: Tue, 29 Mar 2016 12:58:19 -0700
Message-ID: <xmqq1t6txdic.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459257938-17389-1-git-send-email-tboegi@web.de>
	<xmqqa8lhyzbq.fsf@gitster.mtv.corp.google.com>
	<56FADCAB.1010201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:06:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzmV-00021X-00
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbcC2T6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 15:58:23 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753667AbcC2T6W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 15:58:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2022650B25;
	Tue, 29 Mar 2016 15:58:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HNlsAXpWQQ/M
	XW2p7opOJHqNIVE=; b=TY3j0naEpi7XXsAmlQEOAeNfzo5k6PSHb0bp1FxXzE+O
	cvAW88DTGKRrd2s64xru9uGxz/tEOKBCSJEJI7FgKxHa//x1HtyugQHIs5hqlO5u
	EycHyUdBIkQ0mXcZEcgm6tyfPi0SRIVSUQC6Q5Xk+6HUhBLLVSX/4WAIYNF1bH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Btyt4U
	CVvOCPs8TqS5RESy8RuRJXrHFIswQ+DPGQNYlg9BJKlaaeXpWRh/DPmssvXozpzB
	KMDFb2LChCFMx9O5GAU/uNVPRfMMf1CJjrsrFF7Yu1EQ330K3LcgqbPd7KVSsZ1V
	80N6Kb5rKtKFFId5ziLTDtz6NkVehCsRm+A6A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16B3850B24;
	Tue, 29 Mar 2016 15:58:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7C80850B22;
	Tue, 29 Mar 2016 15:58:20 -0400 (EDT)
In-Reply-To: <56FADCAB.1010201@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 29 Mar 2016 21:51:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9629E4F4-F5E8-11E5-8B4B-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290179>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> # Here the lines are not going to be normalized at the next commit.
> # They stay CRLF.

Isn't that the real source of the problem?  Why don't we fix that
then?
