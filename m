From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] plug a DIR buffer leak in rerere.c
Date: Thu, 26 May 2011 11:21:20 -0700
Message-ID: <7v7h9dxqzj.fsf@alter.siamese.dyndns.org>
References: <8762ox7ehl.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu May 26 20:21:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPfBl-0002TS-Ox
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 20:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758278Ab1EZSV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 14:21:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985Ab1EZSV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 14:21:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 530A75FCC;
	Thu, 26 May 2011 14:23:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9CLKq3nHUB+vrEHCBg9h2kp1b4o=; b=QQKUo1
	jQySe636x7YvovC38m3Rtf6RTLIosg/OK1UG+So7sCZ2GXCkqTg3DU8Vv/nDpERY
	lGK3n5O0Ek+gBQCasSme+D55REtvKqL9WkRzA01x/694PN0ZKTLYkBpjBKf+QsQf
	Tqfdg9oU1K9ugicNyOMbZXJd5ui6kQB/qWnac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lGJSVCOFtcbtw4p2i6iGrrJcu5T/+M66
	aRAnmSBnQzqyk3mdRzY4HrpYCPjgcCbvjjrUCayCMSG/57tTXyWv2mlAgOraZFim
	Fi26donxECvv77IyMzL+qR6qpvI7vQt3JTfo0ryV3XpOGww6RmHfo7qG+gjE5wuw
	oqOikHUvtlM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 297AD5FCA;
	Thu, 26 May 2011 14:23:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 55D305FC3; Thu, 26 May 2011
 14:23:29 -0400 (EDT)
In-Reply-To: <8762ox7ehl.fsf@rho.meyering.net> (Jim Meyering's message of
 "Thu, 26 May 2011 15:55:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42D73428-87C5-11E0-BBA3-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174554>

Thanks; I assume both of these are signed-off?
