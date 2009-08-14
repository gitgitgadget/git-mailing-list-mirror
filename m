From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: RE : trailling whitespace with git am ?
Date: Fri, 14 Aug 2009 22:31:01 +0200
Message-ID: <81b0412b0908141331q1783306fwbcf91769379ca517@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?PICCA_Fr=C3=A9d=C3=A9ric=2DEmmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:31:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3Qr-0000VX-G5
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864AbZHNUbC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 16:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932855AbZHNUbB
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:31:01 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:63986 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844AbZHNUbA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 16:31:00 -0400
Received: by fxm11 with SMTP id 11so1377108fxm.39
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=QqyoA0on5MOmJIBg+l0CeqBtwfS3nTf3iWx6tIAx19w=;
        b=tMAr7kl4lrxr6vziXMbLwOCVQFKU7Ixy89p+FqK5+YQNk6lBzOHh2Z8La75A2POlQW
         Bs2+33B9paVrhq8qXFS7fmQqe3Vp+TPNQKws2Jge/sFR4r6NULwOW9SoLWn5ibm2N/u6
         5H0pIDX84ePG8JGqFQuQr7aWXcaJplJ5ONN8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=qF92SAXeNuQVWkPKGbWrwWcCbtBSSu1AIm8YYRgwvT45BXQ/AKQEsBLfoWZg8bAhlG
         OVx2QKg5ZNB00U1jc2hOntCWiPB+3Umg3uPeFEyftAEH7HmXDYMzKnKs3gg5WpZ86peP
         roeQqNOzjZOidC0jk1aw4s6E/x4tGRlOhIzL4=
Received: by 10.204.114.9 with SMTP id c9mr1348976bkq.161.1250281861054; Fri, 
	14 Aug 2009 13:31:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125948>

On Fri, Aug 14, 2009 at 22:21, PICCA
=46r=C3=A9d=C3=A9ric-Emmanuel<frederic-emmanuel.picca@synchrotron-solei=
l.fr>
wrote:
>> This patch has DOS line endings (like CR, followed by LF).
>
>> You can either use dos2unix (or your editor of choice), or update yo=
ur git
>> to current master branch, where "git am" handles such patches transp=
arently.
>
> I am using git 1.6.3.3 debian unstable is it ok ?

No. I just checked - it is not even in master yet. You can merge
the commits at c2ca1d79dbd54b06. That's what I am using. These
are merged in Junio's next already, so you'll see them in master
someday. Meanwhile I can have it like this:

$ git clone git://git.kernel.org/pub/scm/git/git.git
$ cd git
$ git merge c2ca1d79dbd54b06
$ make && make test && make doc
$ make install install-doc

This will install the freshly compiled git in your home (~/bin,
~/share, ~/libexec, ...)

I would recommend to remove the debian's git first, BTW.

> how can I do the difference between a patch with normal CR+LF (the au=
tor use this format)
> and a patch without CR+LF due to the webmail ?

Just replace the trailing CR+LF with just LF. The program named
"dos2unix" does that.
