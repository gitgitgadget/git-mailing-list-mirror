From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Mon, 30 Aug 2010 13:37:27 -0400
Message-ID: <AANLkTi=VPf9CWNJcce6d20HQChi0mHgTG1F=jakzNT-O@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
	<4C7B8E1E.6050708@drmicha.warpmail.net>
	<AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
	<20100830141602.GF2315@burratino>
	<AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>
	<20100830163302.GA13336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 19:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq8Ia-0004Rq-EC
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 19:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326Ab0H3Rha convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 13:37:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65031 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab0H3Rh2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 13:37:28 -0400
Received: by bwz11 with SMTP id 11so3889211bwz.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mP7VLf7n0EllvkKQXsj5DyqfjRGPax7prSwNBCUITr8=;
        b=uzwfJfGkO4MPf9EoGWLbZ4YHfG8I4nwf1FA9SWv1/fxC2jwHz3Sa/dAB98tNw/LD46
         VI4B3z73XkTzduvypEV9gPKiHoFxCjXuOSm8OEiVCaVF9K2L6nQtRQp8htXfdb68PCaM
         w9BkNBNMoEa6yiwnN5XyBR45aa2X6fPFRa/9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Izx6NGuuE8aWg56x0sX6QBeAuOwWJJrq/s8vJywWxqCjJZ/suYKRolKEFDdaDrW0sV
         V6FkiwzlVxecIzkl8lIkzE4CuPH3PAiIuUki1EH1d1SFKEIvkl6rR45IWFbTdWupNPFL
         Vg1xAw9n7Qg0RA6AXXg0UWhRmfXAkATio7YHo=
Received: by 10.204.68.136 with SMTP id v8mr3594798bki.88.1283189847117; Mon,
 30 Aug 2010 10:37:27 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Mon, 30 Aug 2010 10:37:27 -0700 (PDT)
In-Reply-To: <20100830163302.GA13336@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154834>

On Mon, Aug 30, 2010 at 12:33 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Chris Patti wrote:
>
>> What if this is the
>> first time a new ref is being pushed? =C2=A0Then, old-ref is 000000 =
and git
>> diff --raw throws up a hairball :)
>
> Can't you check for 0{40} and use $(git hash-object -t tree </dev/nul=
l)
> in its place?
>
> In general, the "LOW-LEVEL COMMANDS (PLUMBING)" listed on the git man
> page are meant to be useful for scripts. =C2=A0They have simple input=
 and
> output formats, they don't try to introduce weird exceptions for user
> convenience, the git developers are more conservative about changing
> them, and so on.
>

Maybe I'm not understanding your intent here, but, this is a
pre-receive hook, where you get handed two refs, the old (pre-push)
ref, and the new (after push) ref.

git hash-object computes a hash from the file's contents.  That's my
whole point, I don't *have* the file to compute! All I have is those
two refs.

Thanks,
-Chris


--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
