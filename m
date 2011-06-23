From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] git-remote.txt: fix wrong remote refspec
Date: Thu, 23 Jun 2011 15:17:29 +0900
Message-ID: <1308809849.1338.11.camel@leonhard>
References: <1308804319-6354-1-git-send-email-namhyung@gmail.com>
	 <7viprx3yay.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 08:17:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZdET-0001Ik-CF
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 08:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab1FWGRg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jun 2011 02:17:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64378 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1FWGRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 02:17:35 -0400
Received: by iwn6 with SMTP id 6so1315851iwn.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 23:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=SJ4nnGKU4GYTXVeS+1hcxLNPNzO7jlDTtoAEmu2M29U=;
        b=mjifWXlkfK9Q4aGM8eYB52MGoSwjeac4wn3uZBEtoWkRL++DbvRdTNptBLFMeh47Xd
         QL5T8g+KP3iY70hzR/GgXPH/L8QsU+HoAE84XnO7ofgJLNxb3y67xK3DDM9IBIscptUV
         E71XpJe0jJm970inDH3+4QLwqb/2lXNWNuEX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=vMV2oJNkp4V7pOGlnHbAX6JwdzxvP8A8/sm9xjppoFeVcm+g+iC75HfF3613MUoT/l
         BAwZSO0rUKTPeU9m+SX92W+YJvFfv8uG+hg1aHtObpfvqVQGVkNfGFHYArQUVl1VzQ6/
         E6JIRMhUYs3aJGX2MnNLpmLE3Ikw/V9L2nOyo=
Received: by 10.42.161.138 with SMTP id t10mr1712888icx.3.1308809855062;
        Wed, 22 Jun 2011 23:17:35 -0700 (PDT)
Received: from [192.168.111.3] ([118.176.77.244])
        by mx.google.com with ESMTPS id ly7sm1330378icb.0.2011.06.22.23.17.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 23:17:34 -0700 (PDT)
In-Reply-To: <7viprx3yay.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176264>

Hello,

2011-06-22 (=EC=88=98), 22:35 -0700, Junio C Hamano:
> Namhyung Kim <namhyung@gmail.com> writes:
>=20
> > $GIT_DIR/remotes/<name>/HEAD should be
> > $GIT_DIR/refs/remotes/<name>/HEAD.
> >
> > Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> > ---
>=20
> Obviously correct; thanks.
>=20
> There is another questionable one you did not touch, though.
>=20
>     With `-t <branch>` option, instead of the default glob
>     refspec for the remote to track all branches under
>     `$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
>     is created.  You can give more than one `-t <branch>` to track
>     multiple branches without grabbing all branches.
>=20
> The above says "$GIT_DIR/remotes/<name>/", but it should say
>=20
>     ... all branches under refs/remotes/<name>/ namespace,...
>=20

Oh, I didn't aware of that. Will send v2 soon.


> Also we should try to see if we can come up with a way to say the thi=
ngs
> the part your patch touched describe _without_ mentioning $GIT_DIR at
> all. "Store in $GIT_DIR/refs/$X" talks too much about the implementat=
ion
> detail that the ref in question is implemented as a loose ref. We wou=
ld
> pack it into a single entry in $GIT_DIR/packed-refs file when we run =
gc,
> and at that point "$GIT_DIR/refs/$X" is no longer a correct descripti=
on.

I see. But I think it is a different issue and should be treated by
another patch(es). Just omitting $GIT_DIR is not enough? I don't know :=
)

Thanks.


--=20
Regards,
Namhyung Kim
