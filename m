From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [BUG RFC/PATCH] git-cvsimport
Date: Mon, 16 Aug 2010 17:43:06 +0000
Message-ID: <AANLkTimXAZMfXWjcb7RKE2_y6_v7MHQRK7oxK42n-5C0@mail.gmail.com>
References: <AANLkTikxxqgNpmqfFQq+5GVd7VAW2DTaro5anRHcx6Tt@mail.gmail.com>
	<4C68BD66.9060506@alum.mit.edu>
	<7vpqxicyoy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 19:43:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol3iM-0007ps-Tt
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 19:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab0HPRnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 13:43:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35120 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab0HPRnH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 13:43:07 -0400
Received: by pzk26 with SMTP id 26so2003334pzk.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sB4piZsdd/ru9SciSHsFPN/oHb9R8t5cmDxwk5ZoTTE=;
        b=ol3wroRXmFyVrBPKa+QqQm/rr7hKs13GkoupdcDNSvV7ja0YYRNPzthmlgnbl+UjL3
         SpHRlLMVCMoSuDxtU2kixQpAFSuBQNJmHtA2lrU9DUJDkh9WHMvujVUWPduRRIm4Sr9F
         TePkHQq2fb/sw5eu2aZbGWRR7KITm/V1smGKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=szYKqQJwMJ4IiiYQEpaU3J1XlUgTNrIP3V7/9MJgzkqjQXO5oNEUtCESyw9+oYOuNV
         qzPXdRHIeHbAGp4uxevHF/Xc64ycYB50BVq8uezb7fbhk8hm4Kj8UZOPL+qpHOIf9dv5
         ed7N3cvYyYogdbe+q+5xS/9YpGsw+7K5RJ6E8=
Received: by 10.142.135.9 with SMTP id i9mr4702877wfd.336.1281980587133; Mon,
 16 Aug 2010 10:43:07 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 16 Aug 2010 10:43:06 -0700 (PDT)
In-Reply-To: <7vpqxicyoy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153667>

On Mon, Aug 16, 2010 at 16:25, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> My guess is that cvsps is using CVS commands to access the test CVS
>> repository, and that CVS wants to write to the file CVSROOT/history =
to
>> log what is being done. =C2=A0The logging behavior can be turned off=
 either:
>> ...
>> Apparently -R and "$CVSREADONLYFS" were added in CVS 1.12.1, which w=
as
>> released in 2003.
>
> That unfortunately does not solve much. =C2=A0t9602 seems to want to =
create a
> new CVSROOT/val-tags file, so if =C3=86var wants to keep the source t=
ree
> read-only, the test CVS repository needs to be copied to a scratch pl=
ace.
>
> Perhaps something like this? =C2=A0I actually have to wonder why cvsI=
MPORT
> needs to write into anywhere, though.

That looks good. It's pretty much exactly what I was going to submit,
but I was waiting until you applied my other patches to pu (since
they'd with that patch as I changed the setup code in the skip patches
too).
