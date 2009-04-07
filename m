From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 06 Apr 2009 17:55:44 -0700
Message-ID: <7vfxgl46zz.fsf@gitster.siamese.dyndns.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <200904052358.53028.markus.heidelberg@web.de>
 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
 <200904060117.24810.markus.heidelberg@web.de>
 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
 <20090406032457.GA14758@gmail.com>
 <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
 <871vs5kjfw.fsf@krank.kagedal.org>
 <7vy6ud4otd.fsf@gitster.siamese.dyndns.org> <vpqiqlh1p8t.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 07 02:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqzd4-0006VW-QK
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 02:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbZDGAz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 20:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZDGAz6
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 20:55:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZDGAz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 20:55:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BC3ECCAA;
	Mon,  6 Apr 2009 20:55:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C6693CCA9; Mon, 
 6 Apr 2009 20:55:45 -0400 (EDT)
In-Reply-To: <vpqiqlh1p8t.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 06 Apr 2009 22:49:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D8BBB61C-230E-11DE-A981-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115895>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> But that doesn't apply to "git diff". Both "git diff" and "git diff
> --cached" work with the index.

It is so often used against HEAD that it is the default for --cached mode.
If it confuses your students, do not teach them "git diff --cached"
without teaching "git diff --cached HEAD" first.

> ... which is everything but intuitive. The option name doesn't tell
> the user what the command is doing.

Surely, I already said that --cached vs --index are not the best words,
didn't I?

But the point was that introducing STAGE and other "ref-looking tokens"
not only does not help the situation at all, but makes it worse.

> I can understand the historical reasons, but I think finding a way to
> get rid of this historical terminology mess should be encourraged.

No, you should aim higher, if you are trying to change things.

Find a way to convey the concepts better, and come up with a way (i.e. set
of options---as I already explained why ref looking tokens is inferiour
than explicit options) that does not break the backward compatibility, and
help new people learn.  I am not interested in the "ref-looking tokens"
because they fail the latter test.

>>    - for all commands, working with work tree is the default, so there is
>>      no --work-tree option (we could add one, if you really want).
>
> Except "git checkout", which takes the index by default, and
> a commit if specified. It makes sense since checking-out from the
> working tree doesn't make sense,...

You say "except X" but you need to qualify "but that default makes sense
for X".  I'd say that is true for all X---so you are saying the default is
sensible, which is good.

> Except "git ls-files", too....

It is a plumbing that only works with the index.  What's your problem?

> See, you complain about special cases with the proposal, but the
> current UI _has_ tons of special cases like this.

The two example you quoted above are neither tons nor special cases.  And
I am not saying that "ref-looking tokens are bad because there are special
cases" anyway.
