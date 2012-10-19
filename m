From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 status
Date: Fri, 19 Oct 2012 13:13:53 -0700
Message-ID: <7vvce6i5j2.fsf@alter.siamese.dyndns.org>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
 <7vharpv77n.fsf@alter.siamese.dyndns.org>
 <nnglih0jotj.fsf@transit.us.cray.com>
 <7vfw78s1kd.fsf@alter.siamese.dyndns.org>
 <nngsjb8i30w.fsf@transit.us.cray.com>
 <7v6284qfw8.fsf@alter.siamese.dyndns.org> <20120827214027.GA511@vidovic>
 <nngr4qqhp7x.fsf@transit.us.cray.com>
 <7vvcg2zwvq.fsf@alter.siamese.dyndns.org>
 <CACnwZYe6BZVuqCCPho5+3dy=rzKqDv1A8uGAvhLm2JPO9b2LMw@mail.gmail.com>
 <CALkWK0=P7THaJduYFS1Sr6mxtNqAWQsDgwQyr_KEX4NA4kmVSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	dag@cray.com, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Andreas Ericsson <ae@op5.se>, greened@obbligato.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 22:14:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPIxM-0004Kh-DX
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 22:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759093Ab2JSUN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 16:13:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758621Ab2JSUN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 16:13:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12AB286C2;
	Fri, 19 Oct 2012 16:13:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WCFrUDHc9lamm0VUGqhPEMTOoRQ=; b=Bb4KFh
	iabRO+vdSrAeiqNUx5RzlU7udrAa7yKQgIZbyxxWjS58D/kSYg02S0PLfefa6XQ2
	wV+qKfUH75ysyslT8pRe3ySGNAcCh59bjjeyojMRMq8FVu9Vwc7hP6tPQ/AeyQPB
	/+JcFEqY5Pp2UvNFU28GOo3gIfD3er/HjliWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZ1Z6OLCFMsLlo9U52zBT3xq7xRRQ3lS
	vO0axF526U0gMPX/phXSBXiNUSxJTW5A784955aPNm/6aPpmrDV2uC8ddNMk/cgH
	jsnyCbbNZxzvjGSBwdznEbYSuUkAh2UhBYdLgFx6uduei0sprNUW8SgVRi58v7ls
	vDpYhG465uk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3B2986C1;
	Fri, 19 Oct 2012 16:13:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4122886C0; Fri, 19 Oct 2012
 16:13:55 -0400 (EDT)
In-Reply-To: <CALkWK0=P7THaJduYFS1Sr6mxtNqAWQsDgwQyr_KEX4NA4kmVSA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri, 19 Oct 2012 09:24:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82126BF6-1A29-11E2-938A-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208058>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Thiago Farina wrote:
>> [...]
>> With some structure like:
>>
>> include/git.h
>> src/git.c
>>
>> ...
>>
>> whatever.
>> [...]
>
> Junio- is it reasonable to expect the directory-restructuring by 2.0?

I actually hate "include/git.h vs src/git.c"; you have distinction
between .c and .h already.
