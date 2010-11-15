From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_sha1: support relative path ":path" syntax
Date: Mon, 15 Nov 2010 10:59:33 -0800
Message-ID: <7voc9ql8fe.fsf@alter.siamese.dyndns.org>
References: <AANLkTimJKQ=xc7az+FEM+18aTxQ5zQ24q7pfChnSwt6f@mail.gmail.com>
 <1289793369-10653-1-git-send-email-pclouds@gmail.com>
 <AANLkTi=aVyOiRkE-+y8DDwcBQK36bVFrAX5PFw3TjCey@mail.gmail.com>
 <7v4obimr5l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	tfransosi@gmail.com, Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 19:59:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI4HW-0006lb-6n
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 19:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031Ab0KOS7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 13:59:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067Ab0KOS7v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 13:59:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E931925CD;
	Mon, 15 Nov 2010 13:59:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MI4iUHJGQPGbb6PIEsNH+bU70Sk=; b=w4dRsv
	dZpK7OnonBZM7qOnE69IhHGRkdzS2F8ZO4ZHf7DLtNj/20/1WiUTYexeliMZNvML
	nxtMQvfKEdEKyFvJCLtrDn3eclHOTuVzGUQvizavXZBq1HwRvS+DmYvOtpJtOmRa
	Kkm0U6jqxOx8YY9bSn81xXfdQda64Wwy24/LA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CoWbLeYgUntQRc2DiesdmR23QE2hfk7e
	qlvz22x8d54ZUJeXGoVaC8q91uo830re+UwhdhBCIW4fedm9f1Cfbji8xtD/8Y9f
	vAm4EjyiZ8Q/uTihZ3JO9VmesovSPEAJalg5Mr+Ao5qKGgGdNpT5aomCU2APrrwX
	cZ/H/R0JFLY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8761325C6;
	Mon, 15 Nov 2010 13:59:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CDAE925B7; Mon, 15 Nov 2010
 13:59:42 -0500 (EST)
In-Reply-To: <7v4obimr5l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 15 Nov 2010 09\:29\:42 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85F9C4EA-F0EA-11DF-867C-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161501>

Junio C Hamano <gitster@pobox.com> writes:

> In the absence of programming errors, should all git command support
> <tree>:./<path> syntax to name an object, or are there cases where the
> relative does not make any sense?
>
> What I am trying to get at is that if this is diagnosing a user error, or
> if this is showing that the mechanism to implement the relative path is
> unnecessarily hard for the programmers to misuse.

The mistake should be obvious from the context, but I wanted to say with
the last sentence "the mechanism is too hard for the programmers to use
and easy to make mistakes."
