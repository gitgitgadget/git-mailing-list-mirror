From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Wed, 6 Jun 2012 20:17:36 +0200
Message-ID: <CAMP44s2VGLj8kRih-95A0VDq86WKWHF3EhLvz0etyHHtP27qLA@mail.gmail.com>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
	<CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
	<7vbokwmifp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 20:17:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScKnf-00019J-FW
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 20:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779Ab2FFSRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 14:17:39 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53489 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab2FFSRi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 14:17:38 -0400
Received: by lbbgm6 with SMTP id gm6so4970489lbb.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fU2LdslI7dc9+m5gpExxyQvVEuf+KaCqQI5L7O0Sfng=;
        b=01l294O4mhvOEYkzb/VvzpUcDwfIyUPM/QCFRklML5/1VHPd9RDGV51WpBmKy41bG5
         1uUV27zSkXg6n3+viMyImXbwHTtmSPMU/DQnC/IWS0ZmIBNQCk+0TKg5oN9RaHz/bs37
         q/WFumuHL2rzYdw1ZRRsTE7cqdBAxTI4DiDGdCFafh5vGk5pE5JqpGDiogjeUZcZ567K
         GdIVzLYoOcezMaPEskujYE4WD7rUIs+rALUwIsAgelQtTOoY09slpdJMrUuDt7HZjWFY
         U5SX8/7f5hPfeNKf8olzwX+t1M/Cxmn0ffKdfPqDp5pi1Dyldp0WK2uzvw7wotdhh/Oe
         BwFQ==
Received: by 10.152.103.109 with SMTP id fv13mr22605433lab.33.1339006656420;
 Wed, 06 Jun 2012 11:17:36 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 6 Jun 2012 11:17:36 -0700 (PDT)
In-Reply-To: <7vbokwmifp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199343>

On Wed, Jun 6, 2012 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> The last remaining sticking point is what to do with the duplicated=
 shell
>>> function.
>>
>> What is the problem with leaving it as it is; having it as a duplica=
te
>> function. It's not a *huge* maintenance burden, and it's a big probl=
em
>> if the functions diverge.
>
> It is not even funny to see these two conflicting claims made in a
> single sentence. =C2=A0Given that you are aware that it will cause a =
huge
> problem to the end users if they diverge,

What would be that *huge* problem?

Suppose __gitdir() in git-prompt.sh is never updated again; it won't
be any worst than it is currently, would it?

Sow what would be this _theoretical_ problem?

> I did not see anything like these.

Nor is it needed *right now*. You could release v1.7.11 without any of
these, and then v1.7.11.1 or even v1.7.12 with a solution; I bet
__gitdir() would not have changed by that point.

But more importantly; the world would not end.

> I think I've sent out a patch along the line of (1) in an attempt to
> help, but I do not recall you responded to it in any way.

I just saw it now, and I think it's unnecessary extra complexity.

> And the
> first thing you do is to complain. The maintenance burden could be
> made into "not huge", but what you are doing is to actively make it
> more burdensome than necessary.

I don't think it's needed *right now*. It's more important to fix the
dynamic loading, which is a *real problem* users are experiencing
*right now*.

>> I still plan to add a native helper for this, but I don't see what
>> that would block these patches.
>
> I do not want to see a native helper, if other approaches would
> equally work to prevent divergence from happening, in which case
> such a change to the core would be a useless code churn.

=46eel free to reject my patches and implement whatever you want, but I
think this is the cleanest and simplest solution, and I will give it a
try. But not right now.

Cheers.

--=20
=46elipe Contreras
