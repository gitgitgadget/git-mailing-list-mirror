From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Mon, 30 Aug 2010 11:00:23 -0400
Message-ID: <AANLkTimFx0DQb0Bq=00O5jSwbFpxU6TE53fMoiJd4Rdy@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
	<4C7B8E1E.6050708@drmicha.warpmail.net>
	<AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
	<20100830141602.GF2315@burratino>
	<4C7BC068.7030909@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 30 17:00:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5qY-0006Nb-U5
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 17:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab0H3PA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 11:00:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50507 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0H3PAZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 11:00:25 -0400
Received: by bwz11 with SMTP id 11so3752263bwz.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s5ytgMKmhY8gA9GqTuNCRcSa9ZWwS917b3gZn5vKPP8=;
        b=BL6HoficZNKTnCEQeIwL2dnI7DHBSa+F9IDelzdLd5j4+fA4t1eoj1tCTBkjiFkzE+
         eIw/gh+ZwxJoQWHEzFrOUX0i73k9DhmbeFOahzy4M5Mzf12bIWjaJmd6EqS13/fJCDkN
         6pZ7Qwmb8pMbXjOSCgk1G5/PAb5Y0FZvAregg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mQpZFlLrDmjQ8X3azbUTQH1OxL0T8BsvXatdebcdM5z/hJsHXmg00z3grvP3JRl+/I
         SRBjlocQos0t59YDK9XI6hdu6F5y+/Ah8OJMFveWvC610AmjLLlYjfiP2C8cq/tV71qo
         GEaTMd7g4uQQFHbvAfv9v3ZtkW6oyJPjmqUJY=
Received: by 10.204.84.230 with SMTP id k38mr3399735bkl.160.1283180423736;
 Mon, 30 Aug 2010 08:00:23 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Mon, 30 Aug 2010 08:00:23 -0700 (PDT)
In-Reply-To: <4C7BC068.7030909@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154820>

On Mon, Aug 30, 2010 at 10:30 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jonathan Nieder venit, vidit, dixit 30.08.2010 16:16:
>> Chris Patti wrote:
>>
>>> That's great, thanks! =C2=A0That gets me the file names. =C2=A0Now,=
 how do I get
>>> to the contents of each file?
>>
>> Why not "git diff --raw" (or its plumbing equivalent "git diff-tree"=
)?
>
> That's what I meant by "diff family" ;)
> In fact, "git diff --raw --name-only oldrev newrev" gives the nicest
> listing.
>
> It seems Chris has to check full file contents, i.e. he'll have to lo=
op
> over this list (as before), but I guess he'll need to replace his "sh=
ow
> $blob" by "show newrev:$filename" (or, alternatively, parse the outpu=
t
> of "diff --raw" without "--name-only" for the blob sha1).
>
> Michael
>

Exactly, I'm writing a regex to parse the diff --raw output and
extract the needed bits.  I was already doing this with ls-tree so I
don't expect any difficulties.

-Chris


--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
