From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: CRLF behavior
Date: Wed, 21 Jul 2010 17:51:33 -0400
Message-ID: <AANLkTinyTlrkALbfVqdqzr_O4ClN-JGS9zsYwH1Upe1v@mail.gmail.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com> 
	<AANLkTil5hUWwSXcz9T7cgeU_LwYtx8Nio7lUaUebJ5YM@mail.gmail.com> 
	<1A9EA7E081C3FE46A0F446FFB66D10EB9398FF@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 23:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObhCr-0002Fg-VR
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 23:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758816Ab0GUVvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 17:51:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40784 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186Ab0GUVvy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 17:51:54 -0400
Received: by wwj40 with SMTP id 40so2843224wwj.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hb+LRrjk+3/nym/ffO51sQUP38dGnuBE+AMP9DVGtsE=;
        b=XO2YOUGNbJ7lNwtg6yZBIv3ftc0lxGttDwDEJIoz6rz386mYGI1Hf5wxgJSHA2bqB9
         Ii4Z2BQ6++tmcqsIrT/59MM1h+/ABc21HviVw5jdvX+4J1Z8IZeV6KXp1QVNeU7wXO2j
         2HiaD9ywMhNzyQRc2dfQe9dOwPuOrPBdyEoqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oi0PEI2uDE6MG2872Oa4YP6yhOponxCaaUAJb6QLAoqp/+NBjEOhwVWwKf/LiGAxwQ
         AXdGIhfDt0ZR1L/B1/+QBtiTq8NDjQWJTyJXfQwYHCFvnwkRr3Zp5l7+b/58RK8LyoMC
         wqERWD+F/ksZANX9rZakaU0u6tjsAuHudyX94=
Received: by 10.216.187.21 with SMTP id x21mr763318wem.51.1279749113225; Wed, 
	21 Jul 2010 14:51:53 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 21 Jul 2010 14:51:33 -0700 (PDT)
In-Reply-To: <1A9EA7E081C3FE46A0F446FFB66D10EB9398FF@FL01EXMB01.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151423>

On Wed, Jul 21, 2010 at 5:35 PM, John Dlugosz <JDlugosz@tradestation.co=
m> wrote:
>> > Running git config --list shows nothing that would suggest any suc=
h
>> setting.
>>
>> Try 'git config --global --list'
>
> I thought that --list tells me the sum result of all the settings in =
force; i.e. the final result that should be used here and now.

Sadly not.

>> Try 'git config --global --list'
>
> I get: =A0fatal: $HOME not set

Yow, that's kind of bad news.  It implies that if you run git from one
shell, it will be able to find your global .gitconfig (and thus use
autocrlf), but if you run it from a different kind of shell, it won't.
 This could be the root of your problem.

One "solution" would be to change git to always die immediately if
$HOME isn't set.

> So, assuming it's been that way (the file is dated March), what's the=
 repository "really"
> doing? =A0When things started acting funny, my co-worker found this s=
etting and removed
> it from his. =A0If that's not it, I can only wonder why it started sh=
owing all-lines-changed ?

I don't know.  One thing I do know is that changing the autocrlf
setting on an active repository makes git go bonkers and there's no
(as far as I know) well-documented way to un-bonkers it other than to
just check out everything again.

If your problem really is that the ~/.gitconfig comes and goes (as far
as git is concerned), it could certainly have caused this problem.

Have fun,

Avery
