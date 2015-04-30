From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array
Date: Thu, 30 Apr 2015 10:54:05 -0700
Message-ID: <xmqq8ud91ozm.fsf@gitster.dls.corp.google.com>
References: <1430397854-28908-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqd22l1pkl.fsf@gitster.dls.corp.google.com>
	<20150430174440.GC21800@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 19:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynsf7-0003qB-8g
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 19:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbbD3RyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 13:54:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752193AbbD3RyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 13:54:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E4494D4CC;
	Thu, 30 Apr 2015 13:54:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ld8xHbbALy1ssm+amMNcC0ShHEY=; b=tjvk/g
	4fqDfjQL0NeyKz2pp/sBBa5DEPLSblrPF8pNpHfHrmAWzWCRZACGEfyXvwsBTFiJ
	xUtZJCivrCytDSrT0ZOXHqy3mkid9mZIP5Us31xs5nDa+nBEcli05rVOFswFoOMJ
	SSozNwomtP64jf3gtU9kwRAWXPeAm0UGxXZjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hffV6pxeUDX27/RL4G+pxHBkotJq/zsm
	QYXA1DqYvUcmyP0DmIsDwT/qxmA4kM1i/+I/Wpo4x4U6GJN19FtOXZJ8B2/SsDKP
	23jlNfcM0dxl0zfj8rI5YctkXQ0xsFxw0NF4qikltln58ijEMiuKs2ZWwbgU9z2k
	HHzDqmUUSb4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05DCB4D4CB;
	Thu, 30 Apr 2015 13:54:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C31E4D4C9;
	Thu, 30 Apr 2015 13:54:06 -0400 (EDT)
In-Reply-To: <20150430174440.GC21800@peff.net> (Jeff King's message of "Thu,
	30 Apr 2015 13:44:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5256684-EF61-11E4-A623-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268082>

Jeff King <peff@peff.net> writes:

> ISTR that you compile with "-std=c89". typeof was added in c99, I think
> (and was a GNU extension before that). I wonder if that is fooling the
> gcc version-check.

Yeah, I think that is very likely.
