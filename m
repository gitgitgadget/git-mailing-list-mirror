From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: deleting non-existent ref via push
Date: Sat, 24 Sep 2011 08:41:28 +0530
Message-ID: <CAMK1S_jjr5Lr1_N1aeTxRiaebdxu5b6Y6LiryMSq6NmfArc=0g@mail.gmail.com>
References: <CAMK1S_gksrR800yJHSnQWDNeDvD75+3Rp+qRWCuUrQyWmNDMsA@mail.gmail.com>
	<7vmxdvunto.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 05:11:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7IeN-00016G-FX
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 05:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab1IXDLa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 23:11:30 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64199 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab1IXDLa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 23:11:30 -0400
Received: by vcbfk10 with SMTP id fk10so1724387vcb.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 20:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yLdugfR89agxERqwUCwqk6D7XW4PXSmehrATofADUc0=;
        b=O8Rl8Qt6iTIEF2ZBrtaSUrhY9YcK108nbPMD5whJa59vv1uIax8AjK5p0AFd1QDoy+
         vgb+BbA3QuEfmk0rHamM+7pQrMbuYVV/fxn3pZQlzdvDjLE7diZ2oLrkKCYyfg1WKSkU
         tLX08fB9rU5Zfg3+9Dq4aRShFwTDQlNOMm1vk=
Received: by 10.52.97.72 with SMTP id dy8mr3991621vdb.272.1316833888419; Fri,
 23 Sep 2011 20:11:28 -0700 (PDT)
Received: by 10.52.161.197 with HTTP; Fri, 23 Sep 2011 20:11:28 -0700 (PDT)
In-Reply-To: <7vmxdvunto.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182016>

On Fri, Sep 23, 2011 at 11:46 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> Pushing to delete a non-existent ref (git push origin :refs/heads/fo=
o)
>> works without error, except for a warning that the remote is "Allowi=
ng
>> deletion of corrupt ref". =C2=A0By "works" I mean all hooks are also
>> executed.
>>
>> Is this expected/supported behaviour? =C2=A0Can I rely on it continu=
ing to
>> work, especially in terms of executing hooks.
>
> This most definitely is just "we didn't bother checking the error too
> carefully, especially because the result of deleting something that d=
id
> not exist in the first place is a no-op; anybody who tries to delete =
a
> non-existing thing is a moron and deserves whatever random result he

I'd better hide behind the fact that I am only doing it for the
side-effect then ;-)

> gets".
>
> It would be a good idea to tighten it.

Thanks.  I just needed to know if I could rely on it long-term or not.
 I'll find some other way to "poke" a remote repo to run the hooks.
