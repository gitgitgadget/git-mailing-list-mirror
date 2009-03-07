From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Fri, 6 Mar 2009 20:56:21 -0500
Message-ID: <76718490903061756g4ca88c21h8bf786048d4ad05@mail.gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
	 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com>
	 <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com>
	 <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com>
	 <7vr61aqngu.fsf@gitster.siamese.dyndns.org>
	 <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
	 <7v63imqhcz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jean-luc malet <jeanluc.malet@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 02:58:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfloR-0007uy-0H
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 02:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbZCGB4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 20:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbZCGB4X
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 20:56:23 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:56240 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZCGB4W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 20:56:22 -0500
Received: by rv-out-0506.google.com with SMTP id g37so762668rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 17:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7DAJJAnd8FxgH+1MKPWqUDibHspgNAoOq+KqJE69l2g=;
        b=rENdUC8rUya/UpNl6WUeM4WOBWvOoKX1z8xRHqW4JqUOpGjTc+TMItvKbBNGwdvhfP
         68k1fayY9us7SeWB6jthnF6A0AwqlZeu/CJjuC700VbnZiX1U9OvX1yDofCs0kIPlXgD
         oZzX1XO69aX3F6sA4Fe0btrUxIRaL2usESpQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BTvXxRlPjCq1TUTCxjxP2hm5OouZbIOKWe60lzzYKvRqOybZxlv1P6ydjl7cI/QV1G
         J7EyBZnhCfzkA/3JkwbAmedj5wx2EX3hnccTWyK4cXWB8MU5El3pA84scfeNxpz89nI1
         cH25Ypoc5tNHvAiiqX7ZsXMEG6nyvNa+Lfzts=
Received: by 10.141.209.6 with SMTP id l6mr1594434rvq.192.1236390981031; Fri, 
	06 Mar 2009 17:56:21 -0800 (PST)
In-Reply-To: <7v63imqhcz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112502>

On Fri, Mar 6, 2009 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> I think it would be much better if you did not introduce a new
> configuration merge.options which is not consistent with everything e=
lse
> to begin with.
>
> Instead, if your addition was literally to allow saying things like t=
his,
> it would be much easier to understand.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[branch "*"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mergeoptions =3D=
 ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote =3D ori=
gin
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rebase =3D tru=
e

Okay. That's probably a more invasive patch, because a lot more code
paths look at [branch ...], but I'll look into it.

> So overall, cumulative configuration tend to be more cumbersome for t=
he
> end user to manage.

Okay, you've convinced me.

j.
