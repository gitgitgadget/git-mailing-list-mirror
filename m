From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 14:39:06 -0700
Message-ID: <xmqqzispxoqt.fsf@gitster.mtv.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:39:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asdMZ-0001Ry-Kl
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 23:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbcDSVjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 17:39:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754583AbcDSVjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 17:39:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 13B23149D1;
	Tue, 19 Apr 2016 17:39:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iaOJREQ6Rzqvjbe937RWIqvCkiI=; b=NdHjVS
	aeiblwQdqVIPaD6HTfjmX/ZLM64SSX0hZQK2KGFsCh9gBk+5rGSllGmHKjjDu2T6
	MXj6gW3UeJmNHH3PpZYjy0tUlLjwwWj/dZ1z8Dhl+Ttmf2Hi7EzDH/uIfA5CwDBi
	A3qFqfHuPhh78E9DrOnYlFo94hX1mExjrT30Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhYEN1flWMl938VN7SMcWvp/Zs2vjkdv
	jAwm6l41pN7E+ul9zehK9uCevFaa7RqW4X5TYO0Tc2eg4PnddzjB182o0VQgXbci
	nnfVW1u03Iot4Dxut3GSSTQupYaAoGyECd0DC1XIQlzpzHU/BmUPWLPMmZXoXa8U
	r8VFiMozqEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B1FA149D0;
	Tue, 19 Apr 2016 17:39:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7176D149CF;
	Tue, 19 Apr 2016 17:39:07 -0400 (EDT)
In-Reply-To: <CABEqOBx4vCUpYTGYM9VF6QHxGGgQSG5APSHymtbV7uVxAbU+ow@mail.gmail.com>
	(Jan Durovec's message of "Tue, 19 Apr 2016 23:25:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 251AB230-0677-11E6-89BD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291932>

Jan Durovec <jan.durovec@gmail.com> writes:

> On Tue, Apr 19, 2016 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> For a series this small it does not matter, but anything longer it
>> would be easier to review with a cover letter (i.e. [PATCH 0/N]).  I
>> do not know if submitGit lets us do that, though.
>
> There's a comment on PR itself (in addition to individual commits) so
> theoretically it could.
>
> It seems that for [PATCH ... n/m] e-mails the commit messages are used,
> so there's no reason why the PR comment couldn't be used for a cover
> letter.
>
> In this case the PR comment was the same as for one of the commits.
> Maybe submitGit tried to be smart there? Or maybe it just really
> doesn't support it (yet?).

In any case, I've queued the updated ones as they looked good.
Thanks.

By the way, you may or may not have noticed that I've been
reordering the lines of your message quoted in my responses; around
here, top-posting is frowned upon.
