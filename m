From: David Aguilar <davvid@gmail.com>
Subject: Re: git for change control of software deployment updates
Date: Sat, 10 Dec 2011 19:19:00 -0800
Message-ID: <CAJDDKr7+GeJTR986DSqKpQRWsXGFVzjBqg6WgRyG-EtycrQs7A@mail.gmail.com>
References: <jbugm2$afc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 04:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZZwY-0007qN-9p
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 04:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab1LKDTB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 22:19:01 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36658 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1LKDTA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 22:19:00 -0500
Received: by ggdk6 with SMTP id k6so91491ggd.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 19:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kvgMikfnN2ymuf6yxNc4QyhZCq83oC5DYBdzUA83Rog=;
        b=soZCYKvvz7MHOF5S6IKErqm3oBEsa9/JZImVa/ixpZeUNzT8MGW0U+56OixA2quFmV
         c1dJzkz55H7T/TBstC6R00mrExUKTHyKDZ42Mzb/lkIthyQY+72rQ/1fSHJ3OyUteNe4
         Pjs59os5t7WMq8ml4moMX8rZzjpQ/pEwLuAZU=
Received: by 10.236.185.133 with SMTP id u5mr19342801yhm.106.1323573540154;
 Sat, 10 Dec 2011 19:19:00 -0800 (PST)
Received: by 10.146.76.12 with HTTP; Sat, 10 Dec 2011 19:19:00 -0800 (PST)
In-Reply-To: <jbugm2$afc$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186798>

On Fri, Dec 9, 2011 at 6:37 PM, Neal Kreitzinger <neal@rsss.com> wrote:
> I am considering using git with submodules to deploy most of our upda=
tes to
> our customer linux servers (not including third party rpm updates alr=
eady
> tracked by linux distro rpm repository). =C2=A0Has anyone else done t=
his?
> Comments? =C2=A0(Sanity check.) =C2=A0(I am new to submodules.)

I wrote a script that converts a git source repository into a redhat
src.rpm.  We use it at my $dayjob.  How about doing something like
that?  After you have a src.rpm you can create rpms that you can
distribute using yum.  You are already using rpm which is why I
mention it.  Converting a directory of rpm files into a hostable
repository is as simple as `createrepo /path/to/rpms/`.

The git project has a 'make rpm' target in its Makefile that you could
use as an example.
--=20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 David
