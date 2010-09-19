From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: tig show <commit> not working anymore?
Date: Sun, 19 Sep 2010 14:46:22 -0400
Message-ID: <AANLkTinwTSOVfdZkt8CM9DHy9mm9nPt133nvUNjUcQO1@mail.gmail.com>
References: <20100916125337.GG5785@bowser.ece.utexas.edu> <4C922112.404@drmicha.warpmail.net>
 <20100918050122.GA24656@bluemoon.alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Sep 19 20:47:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxOui-0000YV-7L
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 20:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab0ISSqn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 14:46:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35386 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab0ISSqn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 14:46:43 -0400
Received: by iwn5 with SMTP id 5so3610250iwn.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=mnYCzimEF1rK/14dUt4jYIpeME/7O16TBQOyPHR3edE=;
        b=F41OqySK4BgbOj16A5urLnmTHht8+turWzZ6GWTDqPmGv++6hzkB6C4X6C3mjSJP3y
         0X+RHHm/igoIzhJE2HUNBGOMGcwi/m0cce54VoP/ZcFbFEK5iP0ZHKpVwNDDz2z49oDY
         vaaWt9mlGkuZ1+fI6M3+NvN+5aOPHZhjiQYds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=Uvkfdd2JR9T73PVR+F/KF5l1evKj6S3MHLXdU0ZjK1kPzx6BzdO3Zv9qmxZ0HFajJf
         SbrpwBpc2MGrNawHMv/3sxTxqWE3/orjNsCbsqV483OJVJm5wgvUVF6n3ux8J7nAomBi
         MAbR3OoMpPYIhiOLVAlgBW9sKMA7qKGUo63Xk=
Received: by 10.231.194.219 with SMTP id dz27mr7897150ibb.104.1284922002191;
 Sun, 19 Sep 2010 11:46:42 -0700 (PDT)
Received: by 10.231.39.138 with HTTP; Sun, 19 Sep 2010 11:46:22 -0700 (PDT)
In-Reply-To: <20100918050122.GA24656@bluemoon.alumni.iitm.ac.in>
X-Google-Sender-Auth: W49crtowyMKcut9_9-owoZgA2b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156509>

On Sat, Sep 18, 2010 at 01:01, Kumar Appaiah <a.kumar@alumni.iitm.ac.in=
> wrote:
> Please bear in mind that I am totally new to the code, and not a powe=
r
> user of git either. So please don't club me! ;-)

OK, I will give you a hug. :-)

> Well, I was exploring the code a little, and I could not understand
> some aspects fully. First, I discovered that the following hack fixes
> the problem to an extent:
>
> [snip]
>
> However, I am pretty certain that that is not the intended use of
> opt_rev_args and ref_commit, and that they should be used in a
> different way. For example, tig show HEAD^^^..HEAD should show me
> three commits combined, but it shows me only one, since I haven't run
> it through rev-list or the like=C2=B8 probably.

You fix is not that far off but to fix the second issue I had to do
change the function responsible for expanding %(commit). Anyway,
should be fixed in 0.16.1.

--=20
Jonas Fonseca
