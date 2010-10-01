From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Fri, 01 Oct 2010 08:07:43 -0700
Message-ID: <7vlj6igdds.fsf@alter.siamese.dyndns.org>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-2-git-send-email-artagnon@gmail.com>
 <7v4od7hsqt.fsf@alter.siamese.dyndns.org> <20101001045713.GE20098@kytes>
 <20101001053721.GB6184@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 17:10:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1hFU-0002r3-EP
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 17:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab0JAPH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 11:07:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284Ab0JAPH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 11:07:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DC7BDB91A;
	Fri,  1 Oct 2010 11:07:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XKG4uOHhhHaZyAQ+6yZ0BiUD3bE=; b=Yv4w2n
	HNFbpTPfaH1y1kLgURn6EN7BEasCT/RNxkDaDQTONCem8Rctk7inIzciCny0+fZ0
	U827Xdd3YMh0QSWYqgOjL8xTpsQ1ZCZ4LzUVfa/ZPr3FN/MVtQZY2y1fojH4q/RM
	wWl66TyVKytwOJ6gahYxZ8RU6rVF27EHQpuDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=skzP5eQu23PQSvHiE20OHAhPQS8srFEP
	i5t4ciOdEIiE1LjYjdYxGu9PTDnKEXJvHALPf96thdU1yyPhzogx8diwOpwP6YuR
	2G5sMuPF2bnfA69x6N3S36rccdIV4Mr6gBQZIS6myfv17II7EEIOF8NtkfL0eGAX
	M0U6QXbny3s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F14DEDB918;
	Fri,  1 Oct 2010 11:07:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10251DB917; Fri,  1 Oct
 2010 11:07:44 -0400 (EDT)
In-Reply-To: <20101001053721.GB6184@burratino> (Jonathan Nieder's message of
 "Fri\, 1 Oct 2010 00\:37\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8AEE1A0-CD6D-11DF-81BE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157757>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Some noise about Cc and Reviewed-by tags:
>
>    Checking Linux's Documentation/SubmittingPatches, I find that
>    that is a misuse on my part (sorry).  A person passing on a patch
>    to Linus is rather supposed to _add_ a Cc line in the rare event
>    that they want to explain that a certain person had an opportunity
>    to comment but did not comment (so Linus can know about their
>    indifference to the patch, I guess).

Ah, that makes sense.  Thanks for an explanation.
