From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [http] Git error messages reveal password encoded in the URL
Date: Mon, 19 Jul 2010 14:16:10 -0700
Message-ID: <AANLkTilby7GWOuObh6W4z_caUG83O5A5Wh4Wb-JJnSdJ@mail.gmail.com>
References: <4C4484A4.5010009@gmail.com> <m3aapnmbid.fsf@localhost.localdomain> 
	<AANLkTikP3eNVs34ZcB9gHqV60-aqexfCPgcyBWSGn_Y7@mail.gmail.com> 
	<201007192310.56399.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ketan Padegaonkar <ketanpadegaonkar@gmail.com>,
	git-dev <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 23:16:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaxhV-0000ue-UE
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 23:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966811Ab0GSVQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 17:16:32 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50799 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966797Ab0GSVQb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jul 2010 17:16:31 -0400
Received: by qyk38 with SMTP id 38so2196703qyk.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ufWW6hfuYKKIR6BXUzoufB2YKvdW9PCEut3TBixZiTw=;
        b=TRLX1gaAwL3QqROBueHXOxTlgD25rDfzAmvxgE9pkRyPO5JVApHrclbmGITJ7XjNuz
         AvFCZUmjqN6TgCDWn8529yAcCTdrPUUqG1mL8p9JU6D4gfELRp6NvSBvgpgYzq7cct5T
         f5yXB7SEoVmIXrxVHt6eaQgdSoVSnjnYh4zFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fYIRpTbEeGpWCVbr5544YQse6jj4M79h/hbtLvdgVzfuAnOPClLI99yb10Sl9mKZ8q
         qRHzvv7VXlHpA8AI5CyxMGnFxoPfR1RGZ1gbUWO/YeP2WM/zbgiLukCrDIMIUsnFVPxp
         JXtIE6OsVQmW/p/Ellk3DoiA1GahZDVey8tSg=
Received: by 10.224.37.19 with SMTP id v19mr4717896qad.15.1279574190286; Mon, 
	19 Jul 2010 14:16:30 -0700 (PDT)
Received: by 10.229.236.210 with HTTP; Mon, 19 Jul 2010 14:16:10 -0700 (PDT)
In-Reply-To: <201007192310.56399.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151284>

On Mon, Jul 19, 2010 at 14:10, Jakub Narebski <jnareb@gmail.com> wrote:
> Dnia poniedzia=C5=82ek 19. lipca 2010 23:05, Jacob Helwig napisa=C5=82=
:
>> On Mon, Jul 19, 2010 at 14:02, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>> Ketan Padegaonkar <ketanpadegaonkar@gmail.com> writes:
>>>
>>>> We use http to serve our git repos, in order for git to not ask me=
 a
>>>> username/password everytime,
>>>
>>> Errr... WTF? =C2=A0Can't you configure SSH (use ssh-add, perhaps to=
gether with
>>> tool such as keychain) to use public key based authentication?
>>>
>>
>> I don't think SSH/ssh-agent/pubkey would actually help, given that
>> it's a https URL. =C2=A0Unless I'm missing something here?
>
> I was referring to 'we use http [...] _in order_ for git to not ask m=
e
> a username/password everywhere'. =C2=A0I just noted that you can make=
 git
> not ask a username/password everywhere when using ssh:// URLs.
>

Ah, I read it to mean "We use HTTP.  I encode the user and password in
the URL to prevent it from asking all the time", not "We use HTTP with
an encoded user and password to prevent it from asking".  If it's the
latter, then you're definitely right: Using SSH + pubkey
authentication is probably a _much_ better choice.
