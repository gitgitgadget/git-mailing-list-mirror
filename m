From: Mike Linck <mgl@absolute-performance.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 18:16:29 -0700
Message-ID: <69b754db1001281716i605c5c0fl50031ec008e2d216@mail.gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
	 <7v636lls8d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 02:16:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NafTR-00059U-AY
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 02:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541Ab0A2BQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 20:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756540Ab0A2BQa
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 20:16:30 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:47648 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab0A2BQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 20:16:29 -0500
Received: by pzk27 with SMTP id 27so1056514pzk.33
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 17:16:29 -0800 (PST)
Received: by 10.142.249.22 with SMTP id w22mr96768wfh.52.1264727789302; Thu, 
	28 Jan 2010 17:16:29 -0800 (PST)
In-Reply-To: <7v636lls8d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138288>

On Thu, Jan 28, 2010 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Mike Linck <mgl@absolute-performance.com> writes:
>
>> I understand that there are mechanism kind of available to address
>> this problem. =A0If we (all developers in my company) remember alway=
s to
>> rebase -i before they merge their topic branches back in, then it
>> could be squashed making it easier to identify and cherry pick onto
>> other branches, or *if* we always remember to rebase before we merge
>> and then create a patch set and store that on the topic branch, we
>> could kind of organize our change sets that way.
>
> On the quite contrary, probably an easier way is to pick a the oldest
> commit that a fix or enhancement would apply, build a topic that deal=
s
> with only the fix or enhancement in question without doing anything e=
lse
> on top of it, and merge the resulting topic. =A0The choice of the for=
k point
> needs to be made wisely in such a way that the resulting topic would =
not
> cause too much undue conflicts when merged to a modern mainline but o=
ld
> enough that you _could_ merge the result to any older maintenance bra=
nch
> if you choose to.
>
> One implication is that you do _not_ rebase the series to newer codeb=
ase
> because doing so would make the result unmergeable to older releases =
even
> if you later realize that the fix/enhancement would be suitable to th=
em.
>
> And if you fork from older commit than tip, you will automatically ge=
t a
> non-ff merge when you merge it back to the mainline, which would deli=
neate
> the history of the side branch from the integration branches rather
> nicely.
>

nice!
