From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] contrib/git-credential-gnome-keyring.c: small stylistic cleanups
Date: Tue, 10 Dec 2013 06:13:32 -0500
Message-ID: <CAEBDL5Wb+fU=qX4eypt3SrAKQjWRqf9KkNDoutbt7fTsdk02rw@mail.gmail.com>
References: <1386066764-49711-1-git-send-email-john@szakmeister.net>
	<xmqq38m1292g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 12:13:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqLG0-0001GN-51
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 12:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab3LJLNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 06:13:34 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:55773 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013Ab3LJLNd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 06:13:33 -0500
Received: by mail-wg0-f52.google.com with SMTP id x13so4698541wgg.31
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 03:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GYE+cFhexIuSt/M/MrnAx+SJ+m0SS9GiqQUxJ6jTeVI=;
        b=Rv2eIuGdIMPUrw5Agk7iXYz/zsTIjRtEaUtg45zbw39l/SAHnG0pS3/VlBuOJoGagS
         gVUY3/WknCKa97knUrTSKIie7iDkWu6Mo6AHXErpxI9AxmmwHeg+vxJ0Jthr7IEp7YEG
         cbifDkNxy90LSsIprzSC1gSaM3uxZtWjRirMBmvZTGGxQNDpgjZk9xSqhsux46JzX2ji
         bBOvrkn13AWGHu2x53TQ4GZ/h0+pbknboM0pOF3y03DPb0EBktDNgiE4WfJB89ToSpS9
         Vde5lr7oApuz718sZ2wmXVHNCQdJ9IUStcLPxtd2pEbb/M/GfspN86O62JNWWX/p+isl
         eoAQ==
X-Received: by 10.180.183.72 with SMTP id ek8mr18543050wic.31.1386674012746;
 Tue, 10 Dec 2013 03:13:32 -0800 (PST)
Received: by 10.180.99.169 with HTTP; Tue, 10 Dec 2013 03:13:32 -0800 (PST)
In-Reply-To: <xmqq38m1292g.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: o7thKQxFqssILwVy7eHZI3gMjHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239136>

On Mon, Dec 9, 2013 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
[snip]
>
> I thought we cast without SP after the (typename), i.e.
>
>         gpointer *data = (gpointer *)user_data;

I've found a mixture of both in the code base, and the
CodingGuidelines doesn't say either way.  I'm happy to switch the file
to no SP after the typename if that's the project preference.

> It could be argued that a cast that turns a "void *" to a pointer to
> another type can go, as Felipe noted, but I think that is better
> done in a separate patch, perhaps as a follow-up to this "small
> stylistic clean-ups".
>
> I said "it could be argued" above, because I am on the fence on that
> change.  If this were not using a type "gpointer", whose point is to
> hide what the actual implementation of that type is, but a plain
> vanilla "void *", then I would not have any doubt.  But it feels
> wrong to look behind that deliberate "gpointer" abstraction and take
> advantage of the knowledge that it happens to be implemented as
> "void *" (and if we do not start from that knowledge, losing the
> cast is a wrong change).

To be honest, I'm on the fence myself.  Let's just leave the original
patch queued, and if the no SP is preferable, I can do that as a
separate patch.

-John

PS  Sorry about the repeat message Junio.  I forgot to CC the list.
