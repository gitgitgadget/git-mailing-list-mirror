From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: support --sort=version
Date: Fri, 21 Feb 2014 09:48:03 -0800
Message-ID: <xmqqvbw84ass.fsf@gitster.dls.corp.google.com>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
	<20140219140909.GA20128@sigill.intra.peff.net>
	<CACsJy8CL3rQx=QHf_eABCUqS+9kZXEmopUuCMiNCL+UPyvtbyw@mail.gmail.com>
	<20140220204345.GA3374@sigill.intra.peff.net>
	<CACsJy8BrfKckHzgwRnW_UMTjipuYWGVcumvCmQC9EG1Eq-MScA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 18:48:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGuCy-0001MX-2g
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 18:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbaBURsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 12:48:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933092AbaBURsN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 12:48:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 510D46DB7F;
	Fri, 21 Feb 2014 12:48:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=btFZddr7VldQ+wqld7qJmZb+ydU=; b=L6lBxv
	qp/wsnwjh1cOXEpzSr9U4J/ULDgy7kh2Ep/bqteQwfLhaeGhFBSeyXCPVt7IA7bI
	rxaemaPp0k8LaXnr/+mPnQT5VIgAOp/A4Ah+9v6yxxx5k6lHPAoalXzUR7Ex2jcn
	vUgvLkJDaH8uHM/C9KUh17hHQa+eA3lVKxxSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QruYgB/+vAnGPjpPDXhXStioLnWEZgjV
	T76AYkqDsEWqYsvdyw4q4Q/3+V0uPfXXqcszBaJDlkjZ5aPF+nq1flHlGoIfHd+F
	dpLPDM4RfV60VZPvQ2NJHu7Mh2Qp6R+n9HynRpf9g42yeD9kSsnz3at1fgF3wKRV
	TZzsVSspmpI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23A526DB7C;
	Fri, 21 Feb 2014 12:48:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37A926DB79;
	Fri, 21 Feb 2014 12:48:10 -0500 (EST)
In-Reply-To: <CACsJy8BrfKckHzgwRnW_UMTjipuYWGVcumvCmQC9EG1Eq-MScA@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 21 Feb 2014 18:58:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 553A20FA-9B20-11E3-AEB1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242482>

Duy Nguyen <pclouds@gmail.com> writes:

> Why not reversed order? So its syntax could be
>
> [ "-" ] FIELD [ ":" [ "version" | "v" ] ]
>
> It fits better to current f-e-r syntax where modifiers are after the
> colon. And it avoids the possibility that someone adds field "version"
> and we can't tell what "version" is what.

I think that reads well.
