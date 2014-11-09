From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] replace: fix replacing object with itself
Date: Sun, 09 Nov 2014 09:35:52 -0800
Message-ID: <xmqqy4rkcm4n.fsf@gitster.dls.corp.google.com>
References: <1415491531-29913-1-git-send-email-manzurmm@gmail.com>
	<20141109055842.GB13445@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Manzur Mukhitdinov <manzurmm@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:36:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWP9-0004Gk-JI
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbaKIRf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 12:35:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751334AbaKIRfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 12:35:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7E711ABE1;
	Sun,  9 Nov 2014 12:35:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YXZ26gJPK1AbO7yLi4kc4ydJTb4=; b=ZjOy6w
	FZukbpzQKTu7PO7IuAdSf2ZLB5pcNAYX10hAhXeJQ/VCF9gZdGgcbQmvG2y/IvOE
	VskvCPdXbfWG4LP3A2UGbHWzTqWx2yDA8sf57kKm5M+AdprHHpc6WyuErRSQGRr2
	tI4Xcm2EFgMGbDk3MzMB7C7u2u/npiWG4zQOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aah3BVAQ7nVJp+AubVSkCq1hnVCAZ9Gr
	k95FQD6fmWuoMoYVx1gMeRsJotpCFGnSTzKpDXxR1hWSQIYnYrW1dF93n3JusdaU
	VNzv30fS9/Gk02mO282RLkd1rtg2D406JJK/NRedIWk0PECEpYg4I7wd7d5BhgKm
	DV5/CgEZzuk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD4ED1ABDF;
	Sun,  9 Nov 2014 12:35:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C0C81ABDD;
	Sun,  9 Nov 2014 12:35:54 -0500 (EST)
In-Reply-To: <20141109055842.GB13445@peff.net> (Jeff King's message of "Sun, 9
	Nov 2014 00:58:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB2BA86C-6836-11E4-9D3D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think all of the callers of replace_object_sha1 do this same check
> now. Can we just move the check into that function instead of adding
> another instance of it?

Good thinking.  Thanks.
