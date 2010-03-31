From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git push refspec to specify tracking branch
Date: Tue, 30 Mar 2010 23:24:50 -0400
Message-ID: <32541b131003302024n42994e3nddab7544c24f93bd@mail.gmail.com>
References: <13A69FD9-234A-4E2A-B83F-096DE304FA16@sb.org> <32541b131003301819x2cab23ffu84b65a0b4c553229@mail.gmail.com> 
	<5D7B2F13-760B-4EBE-93A4-06B9CDDC3976@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 05:25:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwoYQ-0007zz-SJ
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 05:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab0CaDZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 23:25:12 -0400
Received: from mail-yx0-f195.google.com ([209.85.210.195]:57402 "EHLO
	mail-yx0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab0CaDZL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 23:25:11 -0400
Received: by yxe33 with SMTP id 33so991850yxe.15
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 20:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cfBSxeoDvhhFMyHtYupH0gL06X87hul2LyrXMZtVSHU=;
        b=tG9xkFeXT9Jlu1UUCE6dIOS5uu1CMRTmneeDTDGiUPS7ViTZwvBgKwS3zaSnxpazay
         V7JDPdzo0HglNtnUCdRJLAvFMPVzyUW1flpAIGZmy3fvz10IN4/dsUUbWFEZpxMC7imr
         9t/I3dgScplyRd70WrvpMjc4dN3nTW2nw+H2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ToD0baW45NCQLJe+p5dbJUY2tDa67+XCsFvqq3aQszebG9GJkkOjJh7eKr6fU3s2vi
         tSmo/KQyf2ztvQRDC78AWnHUdDu0NNOrZGGeo+gty+vkRqWRL0GA46+MPwmlnc0dqkzD
         VBm9ZQF9rnma+OQrQ6G988CHweg3Yuug67hNk=
Received: by 10.150.203.4 with HTTP; Tue, 30 Mar 2010 20:24:50 -0700 (PDT)
In-Reply-To: <5D7B2F13-760B-4EBE-93A4-06B9CDDC3976@sb.org>
Received: by 10.150.236.10 with SMTP id j10mr3215072ybh.284.1270005910151; 
	Tue, 30 Mar 2010 20:25:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143642>

On Tue, Mar 30, 2010 at 10:24 PM, Kevin Ballard <kevin@sb.org> wrote:
> On Mar 30, 2010, at 6:19 PM, Avery Pennarun wrote:
>>=A0git push origin localbranchname:remotebranchname
>
> Yes that works, but it's annoying to type out every time, especially =
when my
> branch has a long name and I don't want to risk typos. Even worse, th=
e
> tab-completion in bash uses `git ls-remote` to complete the remote pa=
rt of
> refspecs, so it's even slower to type "foo:kba<tab>" than it is to ty=
pe
> "foo:kballard/foo".

You might consider creating a separate 'remote' entry then in your
=2Egit/config.  You should be able to reconfigure the refspec on that
one to use a particular branch name instead of a wildcard.  It's not
exactly pretty, but laziness will be laziness.

A similar option would be to just make a shell alias and be done with i=
t:

savebranch()
{
    git push origin $1:kballard-$1
}

Have fun,

Avery
