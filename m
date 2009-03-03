From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] send-email: add --confirm option and configuration 
 setting
Date: Tue, 03 Mar 2009 08:48:20 -0800
Message-ID: <7vvdqqblij.fsf@gitster.siamese.dyndns.org>
References: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
 <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
 <36ca99e90903030354j33de0313n41d8a95ff898798b@mail.gmail.com>
 <76718490903030822j690cb97blea292d391c0d0112@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:50:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXoe-0005u7-8m
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbZCCQsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZCCQsc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:48:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbZCCQsb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 11:48:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B72E13581;
	Tue,  3 Mar 2009 11:48:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B40383580; Tue, 
 3 Mar 2009 11:48:22 -0500 (EST)
In-Reply-To: <76718490903030822j690cb97blea292d391c0d0112@mail.gmail.com>
 (Jay Soffian's message of "Tue, 3 Mar 2009 11:22:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F21D62A-0813-11DE-988D-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112116>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Tue, Mar 3, 2009 at 6:54 AM, Bert Wesarg <bert.wesarg@googlemail.c=
om> wrote:
>> On Tue, Mar 3, 2009 at 05:52, Jay Soffian <jaysoffian@gmail.com> wro=
te:
>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>> index adf7ecb..57127aa 100755
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -837,6 +837,37 @@ X-Mailer: git-send-email $gitversion
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unshift (@sendmail_parameters,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0'-f', $raw_from) if(defined $envelope_sender);
>>>
>>> + =C2=A0 =C2=A0 =C2=A0 if ($needs_confirm && !$dry_run) {
>> So, the output is now differnt with and without --dry-run?
>
> There doesn't seem to be any point in having the user confirm before
> sending the message if the message is not actually going to be sent.
> Am I missing something?

I do not think you are missing anything.

IIRC, the --dry-run mode shows more clearly to whom you would be CC'ing
the messages; in other words, the behaviour would be different, but it
gives an uninteractive way to confirm, and not pausing for confirmation=
 is
a good thing.
