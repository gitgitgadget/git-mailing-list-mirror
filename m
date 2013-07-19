From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Fri, 19 Jul 2013 09:15:43 -0700
Message-ID: <7v38ray18w.fsf@alter.siamese.dyndns.org>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
	<51E436B5.6000303@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 19 18:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0DLT-0007Lo-Eb
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760602Ab3GSQPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:15:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760594Ab3GSQPq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:15:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AFFA2ED13;
	Fri, 19 Jul 2013 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pI0nMPPNP8/+fqna/G1Aa0iXqi8=; b=Y413LF
	eJbNDW1aiG1LYcO2fWADPDQsaya2Aw40FhRejPM1RM+/TMesRtE6nWiBHZAxV3NO
	ekPRKRKkGx2tBaIv/kGhlhEfo/s1oQtVfi3gkEVclvQb5A6Qy7w7uMw6Y33ZfFLj
	N4wGDDFwqCQC3YdWgObLKPIoCgbDl/sPoXS1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SAhrY5/lmlG053fkALa5xWTiTNFu6zJX
	L4djWQx1wNW9Q4e15/wV/vW2pdLNFaFIwJgPxgVvKeasKQNGeIInSmQpMKXNok9i
	bGYb2SACIvnKGb6vPj+oLynZCvu1xfiiFQD/9atPx/UE8TmgooKt1jt9gMXtPsK7
	hasBgDpMdcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C9C92ED12;
	Fri, 19 Jul 2013 16:15:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 457192ED0D;
	Fri, 19 Jul 2013 16:15:45 +0000 (UTC)
In-Reply-To: <51E436B5.6000303@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 15 Jul 2013 18:51:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 775A0AFC-F08E-11E2-B72E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230822>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Junio C Hamano wrote:
> [ ... ]
>> * rr/send-email-ssl-verify (2013-07-06) 6 commits
>>  - SQUASH??? update to support SSL_ca_file as well as SSL_ca_path
>>  - SQUASH??? send-email: cover both smtps and starttls cases
>>  - fixup! send-email: squelch warning from Net::SMTP::SSL
>>  - SQUASH??? send-email giving default value to ssl-cert-path with ||= assignment
>>  - send-email: introduce sendemail.smtpsslcertpath
>>  - send-email: squelch warning from Net::SMTP::SSL
>> 
>>  The issue seems a lot deeper than the initial attempt and needs
>>  somebody to sit down and sort out to get the version dependencies
>>  and lazy loading right.
>
> This causes test failures for me, since send-email can't load the
> IO/Socket/SSL.pm module. (on Linux, cygwin and MinGW!)

Good ;-).

Can you try the more recent 'pu' with 35035bbf (send-email: be
explicit with SSL certificate verification, 2013-07-18) that was
updated with help from Brian Carlson?

> [ ... ]
>
>> --------------------------------------------------
>> [Stalled]
>> 
>> * rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
>>  - ### DONTMERGE: needs better explanation on what config they need
>>  - pack-refs.c: Add missing call to git_config()
>>  - show-ref.c: Add missing call to git_config()
>> 
>>  The changes themselves are probably good, but it is unclear what
>>  basic setting needs to be read for which exact operation.
>> 
>>  Waiting for clarification.
>>  $gmane/228294
>
> Sorry, still on my TODO list. (Having said that, I'm no longer sure
> that these patches do the right thing! ;-)
>
> ATB,
> Ramsay Jones
