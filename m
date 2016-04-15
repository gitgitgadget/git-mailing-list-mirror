From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/21] bisect: use struct node_data array instead of int array
Date: Fri, 15 Apr 2016 14:47:29 -0700
Message-ID: <xmqqvb3i8rym.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-12-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:47:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBaT-0007FM-63
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbcDOVrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:47:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbcDOVrc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:47:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CB8913CF6;
	Fri, 15 Apr 2016 17:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3D7u6qOgzDsUz1v0wXXk2zUL9Dw=; b=OSUl8A
	D/Sm9uZajzZKwThCDGzi8E2jZpTP+t5CBzhPd5mX5HqRmXifEm5H+4+cD7Cuc5MT
	jk8OKrKgMO07GH1AJM1WuhwMwzUtpMrCK4R4heH8B3a38Dve8+sr2wgk32yk3FT1
	sHvyh4zLsctafgkcd7W45mmuhyM4QEYN5R2Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M7uGxgjNKuTaKWbrYc07QKcbrlkmTsd8
	5GYDV4OgOUnzaCDkbNyQcyzvoR3yrM7C6JIA723DvprjBqc7VMtpXDhsTthYtByJ
	/7MCQn/2RaDO1HB0QOpTsWGMDHWMiC9jCNPErfOTVWdcNMbCVOp2I6NxEavlzE6M
	wJ1qmlLf9AE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 654D813CF5;
	Fri, 15 Apr 2016 17:47:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D092613CF4;
	Fri, 15 Apr 2016 17:47:30 -0400 (EDT)
In-Reply-To: <1460294354-7031-12-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A77F2F70-0353-11E6-8128-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291671>

Stephan Beyer <s-beyer@gmx.net> writes:

> This is a preparation for subsequent changes.
> During a bisection process, we want to augment commits with
> further information to improve speed.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---

Makes sense.
