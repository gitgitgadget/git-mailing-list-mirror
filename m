From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Wed, 20 Apr 2016 08:51:38 -0700
Message-ID: <xmqqtwiwwa5x.fsf@gitster.mtv.corp.google.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
	<CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
	<xmqqd1plz4p5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBx4vCUpYTGYM9VF6QHxGGgQSG5APSHymtbV7uVxAbU+ow@mail.gmail.com>
	<xmqqzispxoqt.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7_7TeJDekoubzJ=ZPT_JUwQVyGczDt5yORZES89Qo=VjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Durovec <jan.durovec@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 17:51:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuPr-00011p-LL
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 17:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbcDTPvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 11:51:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751608AbcDTPvl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 11:51:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C7CA12298;
	Wed, 20 Apr 2016 11:51:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GrtOmUu2ZR0lSIDoo8CrhCit5uA=; b=T493Bl
	rz6zveLTapt8nlJ5/0sT3oZQZGpm15Go0C3RnJozTidsDw50dzFTnvCcVTOQnZrc
	DFHJYi/5FAcv6WTHpHdDpG0LqH3Smw/0Sod6zOR5hdL5+PVmFG9sXuOkEHLhoPXu
	O7ueyf6i5nS4AyoZEWqwVk54/HOUdOw8rLNHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g99TZGbEwK0kLqERqSTI/5fIiUDfpmrz
	32SS5xYx7xjhCOWSAW8+S3epR2uzRNn/UaaghDuGk5kcEDB4KxYd0vqXqSah7ZKV
	g13LxI97hb4fpNPVoOlFeoG9v5WgpYg05fYi8w4cgsmSLZ2kO5VPOl+Amqx2Ax/A
	+Ble9axTEvQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2464412297;
	Wed, 20 Apr 2016 11:51:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8860412296;
	Wed, 20 Apr 2016 11:51:39 -0400 (EDT)
In-Reply-To: <CAE5ih7_7TeJDekoubzJ=ZPT_JUwQVyGczDt5yORZES89Qo=VjA@mail.gmail.com>
	(Luke Diamand's message of "Wed, 20 Apr 2016 08:58:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5333556-070F-11E6-B0B9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292033>

Luke Diamand <luke@diamand.org> writes:

> One thing I wondered about is whether this should be enabled by
> default or not. Long-time users of git-p4 might be a bit surprised to
> find their git commits suddenly gaining an extra Job: field.

Ahh, I didn't even wonder about but that is not because I didn't
think it matters.

Does this change affect reproducibility of importing the history
from P4, doesn't it?  Would that be a problem?

How common is it to have the "extra" Job: thing in the history on P4
side?  If the answer to this question is "on rare occasions and only
when there is a very good reason to have 'jobs' associated with the
changelist", then the 'might be a bit surprised' brought by this
change can probably be explained away as "a fix to a (design) bug
that used to discard crucial information" that (unfortunately) have
to change the resulting Git object names.
