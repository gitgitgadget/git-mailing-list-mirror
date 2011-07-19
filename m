From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/17] revert: Inline add_message_to_msg function
Date: Tue, 19 Jul 2011 22:38:38 +0530
Message-ID: <CALkWK0n62+bk1iWgxftfG5KS4xt41bddVuYXe6djrA5CWiFkAw@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-3-git-send-email-artagnon@gmail.com> <20110712165302.GA13578@elie>
 <CALkWK0kHutr41aH7OrmW3REV+YBUeHSryA9n62yxyF0qRd1FEw@mail.gmail.com>
 <20110713064240.GC31003@elie> <CALkWK0mmPeYawqF-Dd3Sv_0qYjfYA-36POengYupfjwNBRDj-g@mail.gmail.com>
 <7vfwm29pqz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:09:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDn6-0006iC-Vq
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab1GSRI7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 13:08:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44715 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1GSRI7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 13:08:59 -0400
Received: by wyg8 with SMTP id 8so2933756wyg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NQZ0hEdIXi69MBcP6dJ6NGBffbE/jE8d6COHCfOy01o=;
        b=c1Ws6cFQSysYrX7vMRC07UdhS+dy9XVvxI2fhvcajk4Ms6P9QSjnsoPBBkm329nXMQ
         VUkKNEHJsXs4MC1efS7VzTGLb+2bYQx8hOD/9dwAE+Lu0ZtlNqvH9gC5OCXW4xJekWcH
         kEfKffokzVRW6b4ahkVaD755L0vZK+F0iMwPE=
Received: by 10.216.143.66 with SMTP id k44mr929341wej.81.1311095338172; Tue,
 19 Jul 2011 10:08:58 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Tue, 19 Jul 2011 10:08:38 -0700 (PDT)
In-Reply-To: <7vfwm29pqz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177464>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> The strstr(msg.message, "\n\n") actually stops after the 0 in the
>> committer line. =C2=A0It's trying to find out where the commit messa=
ge
>> actually begins. =C2=A0I even created a commit using commit-tree (no=
t using
>> porcelain), but it's impossible to find a msg.message that doesn't
>> have a "\n\n" -- even one with an empty commit message looks like:
>> ...
>
> ... with current git, sure, but I think the code to check for "just i=
n
> case we didn't find \n\n" is there because prehistoric versions of gi=
t
> could write such a commit object.

Ah, I see :)

> I would prefer to have if (p) { ... } around the two lines below.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p +=3D 2;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addstr(&ms=
gbuf, p);

Done.  Thanks.

-- Ram
