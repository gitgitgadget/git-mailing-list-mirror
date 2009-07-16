From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make a non-bare repo bare.
Date: Thu, 16 Jul 2009 13:51:44 -0700
Message-ID: <7v8wio8i73.fsf@alter.siamese.dyndns.org>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
 <7vbpnlbbln.fsf@alter.siamese.dyndns.org>
 <2e24e5b90907160439i29171e9fka3baf6bf871a6011@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:52:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRXvt-000409-Cj
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 22:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352AbZGPUvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 16:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933346AbZGPUvy
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 16:51:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933345AbZGPUvx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 16:51:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C44F48964;
	Thu, 16 Jul 2009 16:51:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 23E758963; Thu, 16 Jul 2009
 16:51:45 -0400 (EDT)
In-Reply-To: <2e24e5b90907160439i29171e9fka3baf6bf871a6011@mail.gmail.com>
 (Sitaram Chamarty's message of "Thu\, 16 Jul 2009 17\:09\:37 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7CF8E3FA-724A-11DE-BD49-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123422>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> On Thu, Jul 16, 2009 at 8:03 AM, Junio C Hamano<gitster@pobox.com> wr=
ote:
>> Tim Visher <tim.visher@gmail.com> writes:
>>
>>> Hello Everyone,
>>>
>>> I recently had occasion to make a previously non-bare repo bare. =C2=
=A0Is
>>> there any way to do this? =C2=A0It will not allow me to delete a br=
anch
>>> that I'm on so I wasn't sure how to proceed.
>>
>> Funny.
>>
>> =C2=A0 =C2=A0http://article.gmane.org/gmane.comp.version-control.git=
/123303
>>
>> It is posed as a question but describes the correct (and officially
>> supported) procedure.
>
> The linked procedure uses git clone --bare.  It is my belief (and
> please correct me if I'm wrong) that only a git clone --mirror
> actually does what you want here -- a mere "bare" clone would lose
> your remotes and their tracking branches would it not?

Depends on "what you want here".

I assumed that the request was to set up the most typical use of a bare
repository, that is to prepare a distribution point, separate from your
primary working repository with a work tree, from which you push your
updates into this new bare repository.

And in such a distribution point, you do not need nor want remotes.  Th=
e
point of remote tracking branches is to let you peek what others are do=
ing
and merge with them, and that is done while you advance your history in
your primary working area with the work tree.  It does not happen in yo=
ur
distribution point.
