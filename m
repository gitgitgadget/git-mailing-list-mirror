From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Mon, 11 Jun 2012 14:51:23 -0400
Message-ID: <CAA3EhHLDwiCixY2xPRQOsvSv+AAKWUEWo1QgnpZrgDeeMe8wTg@mail.gmail.com>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <7vr4tnab9e.fsf@alter.siamese.dyndns.org> <CAA3EhHLWDtUeNB+RZA064Omwxh7SEYhSc53U0nuiSTNzioKnug@mail.gmail.com>
 <7vehpl7pn0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:51:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9iQ-0005KQ-KC
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab2FKSvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 14:51:45 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40636 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2FKSvo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 14:51:44 -0400
Received: by vbbff1 with SMTP id ff1so2446185vbb.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nGN8m+IZBmstAb0WL+FeqsUYcrhFaf4JCmDGofApbn4=;
        b=NPNrm+jS2QxAvaHn/I+JXW2UqF50H4mjmJML0cPVS+Wpbq3pCnqbfzPVxIoIb9Gt2X
         7DE1tren9SImXGXQOpdM0Zud2NuFQfzA38p4W3PM7KIqCm+uP0jKX836yF3C2erd/R5y
         Z9DCPzxXRGPE8282SMzHx7uYCsKlWDu8egx3ZgSGwc4cKbLJNBWzynjnbwKAbPAjojfu
         30/2iC1igcBLZ4Rzwt+w1G6s/nNF3J/jejC8XD/kHqhIU13EA5PIfCrjpZ8ATptD9Ba2
         co5cREUMjdjRZLVT6QOjbU1924V60Iin5fHI+qE3Eovp0VxSAc6WuPnUd2NsBvkiWGRO
         LG9Q==
Received: by 10.220.155.197 with SMTP id t5mr13179262vcw.6.1339440704116; Mon,
 11 Jun 2012 11:51:44 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Mon, 11 Jun 2012 11:51:23 -0700 (PDT)
In-Reply-To: <7vehpl7pn0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199695>

On Mon, Jun 11, 2012 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Leila <muhtasib@gmail.com> writes:
>
>>> Having said all that, I personally doubt this is a useful change. =A0=
I
>>> may have thought of adding a README file to a relatively new projec=
t that
>>> does not yet have one while in shower but I haven't even created th=
e
>>> file in the working tree. =A0And I forget about it once I get to th=
e
>>> office. =A0Should the system remind me to create README and then ad=
d?
>>> Your patch would not give me such a reminder once the top-level
>>> directory is populated (because it is no longer empty). =A0Even if =
I
>>> were planning to add Documentation/README instead, I would get such
>>> a reminder only if the Documentation directory is empty. Once the
>>> directory is populated, I wouldn't get "create README and then add"=
=2E
>>> Why should an empty directory so special?
> Please read what you quoted again. =A0I may have forgotten to create
> and add README
>
> =A0- at the toplevel directory; or
>
> =A0- in the Documentation directory that already has other tracked
> =A0 files; or
>
> =A0- in the Documentation directory that does not have any file yet.
>
> Why do I get a reminder for only the last case? =A0Also please realiz=
e
> that at no point in the scenario I am interested in adding an empty
> directory. =A0"How does one add empty directories" is irrelevant to m=
y
> question.
>
> A more reasonable answer would have been "the reminder is not about
> a yet-to-be-created README file, but is about an empty directory you
> might have wanted to place something---there is no way for Git to
> guess that you wanted the new file to be README, but at least having
> a totally empty directory laying around may be an indication that
> you wanted to do something intereseting in it but haven't yet". =A0If
> the proposed commit log message justified the behaviour to treat
> only the third one specially that way, I suspect it may make some
> sense.

I apologize, I misread the scenario and thought you were asking a
different question.

The patch/new implementation I put forth reminds you that you have an
empty dir. The reminder that you have an empty dir  isn't about a
yet-to-be-created README file, but about an empty directory that you
may have wanted to do something interesting in but haven't yet (like
create a README/some other file or delete it even). It servers as
helpful reminder to do something with that empty dir. Is that better?
