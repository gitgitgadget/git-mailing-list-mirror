From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/48] merge-recursive: Fix sorting order and directory
 change assumptions
Date: Wed, 13 Jul 2011 13:34:37 -0700
Message-ID: <7v62n57wde.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-23-git-send-email-newren@gmail.com>
 <4E1AA085.9010908@viscovery.net> <4E1BF77C.2020207@viscovery.net>
 <4E1D482E.4090403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	jgfouca@sandia.gov
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 22:34:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh68t-0006F7-B5
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 22:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab1GMUel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 16:34:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1GMUej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 16:34:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C9B864B8;
	Wed, 13 Jul 2011 16:34:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4i5+wVc6sE10SjSGWfWcPmkF7v0=; b=l6vGIM
	qGJrINiXNVkmeXt0/tq2ts+wgThb/MRi1OOGVlsv+eskMHRDtSdfziX24KBr903U
	sXm6RmU6aH6g/lbh2gbwFoCBgbJuKfbnLQGnS2zSWS0yGUmBH6k1bzO1VrUd8h6k
	NKHmhykuBcsAANQckFOeRmXMeqUqcIVLvjAUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kAGYZ4im+rD2HWevuoQTmL8av305OzoY
	qYHvetIBxvvjrSuYkRwx8uk9+CfH54uPOOEPkd/l5dCBAf56M6KGsH+r90/irx/Q
	0onjCJgh7r6Sesl4+haKDewwICW3GJmTfJ3R9bRolmj1mDRCs7M3Gkl9BSbxitSr
	s8ncrtpl/P8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2605A64B7;
	Wed, 13 Jul 2011 16:34:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7892C64B6; Wed, 13 Jul 2011
 16:34:38 -0400 (EDT)
In-Reply-To: <4E1D482E.4090403@viscovery.net> (Johannes Sixt's message of
 "Wed, 13 Jul 2011 09:24:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 876BB542-AD8F-11E0-B1CE-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177078>

Both good comments; thanks.
