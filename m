From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: My custom cccmd
Date: Fri, 30 Oct 2009 10:39:18 +0200
Message-ID: <94a0d4530910300139l2f20e3aaw2f89e0b809a7246c@mail.gmail.com>
References: <94a0d4530910150620g733bdf0aq88660053f869b0a9@mail.gmail.com>
	 <7vk4yw4dy3.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910151437s780bd96anca82d2b26ef99e0a@mail.gmail.com>
	 <94a0d4530910250804w3a7da36eke10710eb1cbb03c1@mail.gmail.com>
	 <7vzl7c4i81.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 09:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3n1F-0003Sm-Sf
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 09:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbZJ3IjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 04:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756365AbZJ3IjP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 04:39:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:21750 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351AbZJ3IjO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 04:39:14 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1425705fgg.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oyGf5f/qkBUaffOls0srcMPoM2XdGY3mz7pk5/JuhG0=;
        b=tnI+4rlMdRLfXF2Pjx3VYO9QZtoA1Mf2sd4HkOc/VhLcKbnCFm1d7PK8B2K+TSSLfd
         8QAiUBlgo1Es5dFVPiVPwiFT+rZmrL/H+7EUdEb32C9oeLhleJTLyH164cYGnzEpOFYJ
         ORekyeeI+4LQwLZ6sbn/4G+Ob7J1Ewm4eFAbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pPKW35HPpOcZEDVDgbxGEH9215FuoryZgo4/zoju8Jm2vUVWHy3Z4MAvEPdkP8uS9M
         oK+h2U3GN813614mVsl09Tn+tzNOdjkpzd0hQmPT22JgOgdl7kB8dtOXkQ6r/Zw7ximK
         to062grFmlp039xEFyZVckNVb4DpAP1Uv2OIA=
Received: by 10.86.106.21 with SMTP id e21mr839929fgc.67.1256891958196; Fri, 
	30 Oct 2009 01:39:18 -0700 (PDT)
In-Reply-To: <7vzl7c4i81.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131682>

On Tue, Oct 27, 2009 at 11:53 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I explored this a bit more and I've come to the conclusion that we
>> actually don't wand to discard the previous commits in the patch
>> series. Let's think about this example:
>> 0001 <- John
>> 0002 <- Me overriding some changes from John
>>
>> In this case we want John to appear in the CC list of 0002, because =
we
>> are changing his code.
>
> There are two cases: your patch partially overrides his code, and you=
r
> patch completely rewrites/removes his code.
>
> Obviously in the former case you do want to Cc, but there are parts o=
f his
> change that remain in the final result, so this case does not matter =
in
> this discussion. =C2=A0You will Cc him because of these remaining lin=
es anyway.
>
> In the latter case, the only contribution that remains from him is a
> commit with his log message that does not help describing anything in=
 the
> end result, cluttering the history.
>
> In such a case, I would imagine that the reviewers would want to see =
a
> cleaned up series that does not have his patch that is irrelevant for
> understanding the final result. =C2=A0John might want to know about i=
t, if only
> to raise objection to the way how you arranged your series. =C2=A0For=
 that
> reason, I think it makes sense to Cc him.
>
> But it is a rather a convoluted logic, if you ask me. =C2=A0You find =
John and
> Cc him, primarily so that he can point out that you should be redoing=
 the
> series not to have his patch as an intermediate state in the series t=
o
> begin with, because his commit does not contribute to the end result.
>
> It might make more sense if your tool told you about such a case dire=
ctly,
> rather than helping you find John so that he can tell you ;-).

But that's not the purpose of the cccmd tool.

I agree that such "patch series simplificator" tool would be very
useful, but that's out of scope for this. Isn't it?

--=20
=46elipe Contreras
