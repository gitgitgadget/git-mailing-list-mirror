From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Tue, 12 Aug 2014 11:31:49 -0700
Message-ID: <xmqqd2c55zl6.fsf@gitster.dls.corp.google.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHGrl-0004MS-8H
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 20:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbaHLScI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 14:32:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54932 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbaHLScG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 14:32:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E1A330A08;
	Tue, 12 Aug 2014 14:32:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yiwFm4HO5Dc+oaA0fuLDWDKrrTM=; b=hOL7+g
	PtPkNyWNLn+zLE0FEphSgq2HE47m4JxvuXcOzIRFvzYqr+xn31305j0UUWyPvobn
	7ehUq9utCXel1LZ1FGQpclm/f7tBBVkIN0k1AYtzEFbosyn7leYjVzqt2HZ2ache
	AiJf7WAS7/xx36xMsbgYqKjhNTUC5H3XTquk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oy58j7BbAXe4On5KIJxoyRREbphPBpPv
	fxGpqLuqC7F3VlG0Am9H07GzE6IgtNpMYNG0cil0XsDXDvnn8rptGX7+UC35JQL/
	bWAI8GmzsLuuo5NPu/AcnZihMwbTvHTjPBhYWhh3HQc/ZgTLGzkTF9kuaXCIb3s6
	RmAHbq4wCnc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5BAA230A07;
	Tue, 12 Aug 2014 14:32:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC2BC309FA;
	Tue, 12 Aug 2014 14:31:51 -0400 (EDT)
In-Reply-To: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	(Jaime Soriano Pastor's message of "Tue, 12 Aug 2014 17:31:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EDA58392-224E-11E4-BE15-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255159>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> A file in the index can be left as merged and unmerged at the same time
> by some tools as libgit2, this causes some undesiderable behaviours in git.

Well, doesn't it mean that libgit2 is broken?  Have you filed a bug
over there yet?

Having said that, protecting ourselves from insanity left by other
people is always a good idea, provided that it can be done without
bending overly backwards.
