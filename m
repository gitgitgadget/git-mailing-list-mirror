From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add CC to TRACK_CFLAGS
Date: Sun, 19 Sep 2010 18:46:16 -0700
Message-ID: <7viq21uqzb.fsf@alter.siamese.dyndns.org>
References: <1284331065-3394-1-git-send-email-avarab@gmail.com>
 <AANLkTikBP3pJ7ZN9jC9yQeVKssgr2KMpaY-nQtpJZiP-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 03:46:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxVSh-0008Ag-0r
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 03:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0ITBq0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 21:46:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245Ab0ITBqZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 21:46:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B159D7A23;
	Sun, 19 Sep 2010 21:46:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=LOV5GiXQ8GTYe0hwEq0fEUFHX
	S0=; b=s8Kn8KHLJB0YQgUKTB4vxW2pwpgyQpmVzZrq3MEt7BaoSeH4pDzD8aOXY
	tQiYNtbSS0LAQXgDlmvbnELKuAcirCzKxGrF6c2sxpqiNl98HqAdEi6bHoiY70uN
	jvlkr6OrJ6FSURrg3UlYEZlvwYydqDuTp3HH38A4s9/b4TtWk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=MBy9TPw/EY+TW5eSDr/
	yvuUDWfMclYZJrDnclId6jbuTwSoJsnret10mfgSqGStDEhOfMADaQGSjdVHpkOp
	Nbo/KikgG6e/455J2QbFHZkGekj7bCZAqKGBSbLhFrLJ4F53B+AZiL63UfCL7VN5
	Y7A4oMOmMMgYGmWNM0tDCFhc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC50BD7A1F;
	Sun, 19 Sep 2010 21:46:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 334C3D7A1D; Sun, 19 Sep
 2010 21:46:18 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE3780A2-C458-11DF-A39E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156545>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Is there a reason for why this didn't get picked up other than fallin=
g
> through the cracks?

Simply because I wasn't actively collecting new topics during feature
freeze, especially for small stuff that I knew that resending after
release would be trivial and more efficient use of my time than queuing=
 it
in 'pu' and having to look at it every time I do another push-out in or=
der
to decide when to merge it to 'next'.

After a feature release like 1.7.3, my preference is to do these in thi=
s
order:

 (0) take a deep breath and have bit of break ;-);

 (1) rewind 'next' to match 1.7.3 with selected topics that has been
     cooking there, rename 'maint' to 'maint-1.7.2', and start 'maint' =
at
     1.7.3;

 (2) have a quiet period for at least a few days, not touching 'master'=
 at
     all, to make sure things are stable, giving users time to give us
     feedback, and giving us time to assess potential damages caused by
     unanticipated regressions;

 (3) collect brown-paper-bag regression fixes, if necessary, during the
     period overlapping with (2), queuing them to 'next';

 (4) have (3) graduate and issue 1.7.3.1 out of 'maint';

And after all that, open the 1.7.4 cycle, queuing new topics.  That wou=
ld
also be a good time to backmerge the safe fixes (but not new features)
that went to 1.7.3 to maint-1.7.2, and cut 1.7.2.4, so that it will be =
a
reasonably solid base to apply later security fixes if necessary.
