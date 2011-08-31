From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: done feature in remote-helpers (was Re: [PATCH 2/2] Add a remote
 helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 15:16:06 +0200
Message-ID: <CAGdFq_gooPGQMa5D19-wag=X+mDntHF1MwXiYF0zovB=L-Sybw@mail.gmail.com>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr> <7v4o14dppz.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
 <7v4o1092hn.fsf@alter.siamese.dyndns.org> <CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
 <vpq1uw13hx3.fsf_-_@bauges.imag.fr> <CAGdFq_jyVK3_THYXzCOLDpNww0Npn2qzZ1qv-BMuLbg1vgVjZw@mail.gmail.com>
 <vpqk49tviza.fsf@bauges.imag.fr> <CAGdFq_hFPBeogpX0Qp8Knfssw8QzV+GwCAyH+zZhM2iEJfFYMw@mail.gmail.com>
 <vpq4o0xpvwy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 31 15:16:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qykey-0000vS-1R
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 15:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549Ab1HaNQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 09:16:47 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56723 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab1HaNQq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 09:16:46 -0400
Received: by pzk37 with SMTP id 37so1307227pzk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=toX911NijGR7ele+3LfPmso0pGc/HHu05CqMqWVoop8=;
        b=qBjtXpzQ7QPDqUbpX6/duu8NjPoDrL1vG7LZUnv0Kb3gzQLZPRW6pCM7jS5uYC0YYU
         thIKlo1bFEDzXfl8mHh4pcYFNFS6PsfewkvUofcctOARdGvUYHX4UU2KUfWXlPpt+LzF
         mBbNs9aDg7kjaJpsi67f1vXDw3DpZxve6GsHM=
Received: by 10.68.5.168 with SMTP id t8mr516832pbt.93.1314796606148; Wed, 31
 Aug 2011 06:16:46 -0700 (PDT)
Received: by 10.68.55.7 with HTTP; Wed, 31 Aug 2011 06:16:06 -0700 (PDT)
In-Reply-To: <vpq4o0xpvwy.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180468>

Heya,

On Wed, Aug 31, 2011 at 15:12, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>
>> You can have multiple imports in the current system, you just need to
>> remember to add the trailing newline.
>>
>> import refs/heads/master
>> \n
>> import refs/heads/next
>> \n
>
> Then I'm lost. Isn't \n supposed to mean that the list of commands is
> over, and that the remote-helper should terminate?

No, a list of 'import' statements has to be followed by a \n, similar
to the push command. You can have multiple 'blocks' of import/push
commands, but each block has to be followed by a newline. Again, you
should read:

import A
import B
\n
import C
import D
\n

as:
import
A
B
\n
import
C
D
\n

> Also, who is "you" in your sentence? It can't be the remote helper
> (which reads this sequence), so it has to be Git's transport-helper.

Correct.

> Are you saying that the transport-helper should be modified to add \n
> after sending an import command?

As said above, it already does that. Each group of import statements
is terminated with a \n.

-- 
Cheers,

Sverre Rabbelier
