From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Wed, 14 Nov 2012 15:58:54 +0100
Message-ID: <CAB9Jk9DAwaLw2bTqj5x_zxRcFqn7s=nmGi=Jc_SD38vFoszBZg@mail.gmail.com>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
	<7v4nktdwtp.fsf@alter.siamese.dyndns.org>
	<CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
	<CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
	<7v390ccoak.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Rorvick <chris@rorvick.com>, git <git@vger.kernel.org>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 15:59:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYeQn-0006QZ-9k
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 15:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332Ab2KNO64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 09:58:56 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52382 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab2KNO6z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 09:58:55 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so418647pbc.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BfyhR5PZrAOeINpaN1vJb3Ih+TXEvuDw6YPjoKdEDB8=;
        b=a2te4SwVxUc1Yh/rCzEf+aGbGj19sJ+J7UdjO2Qb1JNsqP8IDiCMOnRW5KovvhBRKi
         iKGi7ZfwyYCWY2IKfcd2o9hrSEPkA8phB7fnCyK9LkidlqZjjAAh+1u0DQifrfhCSBvv
         ON1/aD4MPI+hzrMZDZhuFuN3jkZ1DbQ8MiZ/a51ZdanaRTRfsrNOppJQRav6aALTxXRX
         GPoyjUUk45tF0CbCz9BaXMnrWiYzZxOUo6VaOSEtTftoji3w2smqQPhwXPvR6kePgLhG
         /YkDTHna8XrZRsM1xKB9BAp7b7FHrE1Qb5VfhlJG33xGT+2QQONTF9joZt3Ftfxx+6V7
         ZcOg==
Received: by 10.66.87.130 with SMTP id ay2mr6831972pab.58.1352905134892; Wed,
 14 Nov 2012 06:58:54 -0800 (PST)
Received: by 10.67.3.101 with HTTP; Wed, 14 Nov 2012 06:58:54 -0800 (PST)
In-Reply-To: <7v390ccoak.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209722>

Hi Junio,

actually, I proposed to add a key in config files, e.g.
pushTagsNoChange to be set in the remote repo do disallow changes to
tags, similar to pushNonFastForward that disallows non-fastforward
changes to branches. I still have the impression that this is simple
and clear, and allows the owner of the remote repository to enforce
the policy s/he wants on her/his repository.

-Angelo

On 14 November 2012 14:22, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Rorvick <chris@rorvick.com> writes:
>
>>> "Do not update, only add new" may be a good feature, but at the same
>>> time I have this suspicion that its usefulness may not necessarily
>>> be limited to refs/tags/* hierarchy.
>>>
>>> I dunno.
>>
>> Are you suggesting allowing forwards for just refs/heads/*?
>
> No, it is a nonsense to unconditionally forbid fast-forwards to refs
> outside refs/heads/ hierarchy.
>
> I was imagining a more general feature to allow the *user* to ask
> Git not to fast-forward some refs (not limited to refs/tags/) during
> a push.
>
> If such a general feature were in place, you can think of your patch
> as automatically making the user to ask Git not to fast-forward refs
> in refs/tags/, which would be a mere special case of it.
>
> And I was wondering if such a general feature makes sense.
>
>
>
>
