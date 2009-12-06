From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3 0/3] git-gui: more robust handling of fancy repos
Date: Sun, 6 Dec 2009 14:43:47 +0100
Message-ID: <cb7bb73a0912060543x6e7b2d28xfcd9bef4db3af1b8@mail.gmail.com>
References: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<36ca99e90910270435h69c1e983j78ff9ec49e7e8eae@mail.gmail.com> 
	<cb7bb73a0912060014p548884e0g8c4510a5b562901b@mail.gmail.com> 
	<36ca99e90912060459u1073288bj2114f8ab56c7224b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 14:44:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHHPM-0007AR-7m
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 14:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbZLFNoD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 08:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbZLFNoD
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 08:44:03 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34722 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbZLFNoB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 08:44:01 -0500
Received: by bwz27 with SMTP id 27so2925636bwz.21
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 05:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VxSlv1eRTdkZbV9oxDke8lMggaXO44WMjLMrr2MtBwg=;
        b=DE3uxgG68HQkGqbxdGIVoJsYXT/vkhPHGrruSyUguWfy7xTkhlmaoK0T52EC2+bKg8
         uKvom6Jxse0mRmAhHMKGmGnky+DFYSyTCrxf9y5fHrnhiFdzqjxJT/qpamMENf2xO2X+
         rpq/boHzaQTmYAEtk/Oz++AcQBqwUO3MqZN8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UzeR21+JyKJMSnoPXHoNuI3xUbqPUN8W0kkIucvsvVXJMrPRLamHcoeSRky5n1roHE
         zb82+oupqyXUk9ScF7EPS2i37NujRsq60ts7YAn70OCOhQGMZ4feCWdTAcVMn7w9BwBg
         hsI5sNmn/ocQgpom8AkJqjMyvJpO7KHt065kM=
Received: by 10.204.160.154 with SMTP id n26mr5728486bkx.90.1260107047168; 
	Sun, 06 Dec 2009 05:44:07 -0800 (PST)
In-Reply-To: <36ca99e90912060459u1073288bj2114f8ab56c7224b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134660>

On Sun, Dec 6, 2009 at 1:59 PM, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
> Here it is:
>
> [guitool "exclude/Ignore file"]
> =A0 =A0 =A0 =A0cmd =3D echo \"$FILENAME\" >> \"${GIT_DIR:=3D.git}/inf=
o/exclude\"
> =A0 =A0 =A0 =A0noconsole =3D yes
> =A0 =A0 =A0 =A0needsfile =3D yes
>
> The purpose is simple: add the current file to the info/exclude file
> in the git dir As you can see, I have a workaround for not having
> GIT_DIR in the env, which should solve the issue. But it would be nic=
e
> to rely on this.

Yup. I'm thinking about setting both $GIT_DIR and $GIT_WORK_TREE once
and for all at the end of the repo setup. This should also spare us
setting it up specifically for gitk (and then separately for the
tools). The question is: should it be done the way it's done for gitk
(i.e. normalizing the paths), or just use it as-is? In the latter
case, the question would be why is the path being normalized before
gitk is invoked.

Ideas?

--=20
Giuseppe "Oblomov" Bilotta
