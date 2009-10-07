From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: add dirstat and friends to diff options
Date: Wed, 07 Oct 2009 16:07:19 -0700
Message-ID: <7vmy42pzvc.fsf@alter.siamese.dyndns.org>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com>
 <1254905331-29516-2-git-send-email-bebarino@gmail.com>
 <1254905331-29516-3-git-send-email-bebarino@gmail.com>
 <20091007205059.GA16235@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 08 01:11:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvffN-0000TL-9Q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 01:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbZJGXIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Oct 2009 19:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbZJGXIP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 19:08:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbZJGXIO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2009 19:08:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B50326FA2F;
	Wed,  7 Oct 2009 19:07:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9tHfPRuhVhB+
	6r7bTP1SYgB88I0=; b=nljLurfd75bSyW6uKQG/kD/+IV6rUeiDnATo1rPUtux1
	Y3JZ4zqwnn8yyCKjwd0pMl2+uSvmdKsNX+CRM63rYSLuqYKoyvsVimnRvosgCSak
	vtIu4lqZrBasmFqUBELxPYA0HNfKJdJRHX5jAzvKKr9xnf7yQFnH4V4EgEsvNfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HVX/W1
	sYgAuWBWegFnzMetS417s4JU8GfjTYOWHA8pJXowRyQQU5N1ajA4SQI8exv1jgkt
	1UeAUfK49vBbfMljTNSgSl1NgxP1F+C4CM8Aj0S6WAvTa3eY+rg2E6cCVKg/KbIw
	ywxP7/dZW6emw0hi7Rw7esvZUhQ4/mj15eGLg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7E6196FA2D;
	Wed,  7 Oct 2009 19:07:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CBE916FA29; Wed,  7 Oct 2009
 19:07:21 -0400 (EDT)
In-Reply-To: <20091007205059.GA16235@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bo?=
 =?utf-8?Q?r=22's?= message of "Wed\, 7 Oct 2009 22\:50\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F1F6978-B396-11DE-92C0-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129663>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Wed, Oct 07, 2009 at 01:48:51AM -0700, Stephen Boyd wrote:
>> +                     --dirstat --dirstat=3D --dirstat-by-file
>> +                     --dirstat-by-file=3D --cumulative
>
> I'm a bit puzzled by having both --dirstat and --dirstat=3D, and
> --dirstat-by-file and --dirstat-by-file=3D.  How do we complete simil=
ar
> long options, where an argument and hence the =3D char is optional?

A similar example in "git init" completion (--shared vs --shared=3D) al=
ready
exists, no?
