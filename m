From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.c: change the function signature of `git_config_string()`
Date: Tue, 22 Jul 2014 08:53:01 -0700
Message-ID: <xmqqoawhgzky.fsf@gitster.dls.corp.google.com>
References: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>
	<20140722110720.GA386@peff.net> <vpqsiltsjm7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Tanay Abhra <tanayabh@gmail.com>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 22 17:53:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9cNQ-0004Qy-CL
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 17:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbaGVPxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 11:53:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52059 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359AbaGVPxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 11:53:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC5D72A028;
	Tue, 22 Jul 2014 11:53:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXXF1OpVfV5RE71GorcMYSgJ/hw=; b=XupO6A
	nrimBvmLcndB9+YpjtbI+shLgehQkKNaWqNeaaK+/vUcYW/dFF2Jgo1oYMpEJIsW
	wnCZipPTn2IXtntHpj2z1YdDEgQEzxPMHGnlozb4wvh6f/gCQYxsSttHN1A0CyZW
	PI2A2HdJyrWgGHAlJkOyWXWlD+ZtLKEP7dNb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQI7cnR9zRAzdRcF5sNJhtnwjArjD4ve
	HhqMfFNWR2kP0XhDd73NTLcpFju7nG9RKJL47CzPxWctwex2Jmnje8IUbfqN1xes
	kI72cUNS61PShSqRvBWwruKhDN/gf/Xg6eAnhs0GnEHT+7JHF+u6WYYmApMkVEsD
	dy/IDWdkz6s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF7D12A027;
	Tue, 22 Jul 2014 11:53:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A58E12A017;
	Tue, 22 Jul 2014 11:53:03 -0400 (EDT)
In-Reply-To: <vpqsiltsjm7.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	22 Jul 2014 13:44:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 43C9D5C2-11B8-11E4-B1ED-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254017>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> OK, it seems I got convinced too quickly by Junio ;-). The function
> produces a char * that can be modified, but it also receives a value,
> and the function should keep the "const" to allow passing "const char
> *".

Don't blame me. I never suggested to touch that existing function,
with existing call sites.
