From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Wed, 21 Sep 2011 16:02:35 -0400
Message-ID: <CAG+J_DyxGW8MSYaRj2-fepFDeQDTsuy1S0VDgsu7u2CY+ZCZDQ@mail.gmail.com>
References: <4E7A3BDE.3040301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 21 22:02:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6T0D-0005E9-JT
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 22:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab1IUUCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 16:02:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60328 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab1IUUCf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 16:02:35 -0400
Received: by ywb5 with SMTP id 5so1461609ywb.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Npe81jNSSwX99PBo9hGuCIBseaCor5XcJuSb0SJZ/q4=;
        b=vhIP2MWiLdmIaKYH3/gmI/P+U0r3VV9knh1DVO9m3wrMm+KCNCmUVDDETxDXtMeQyU
         rTdMVl0BD9xf3WLrh3XKaSbRaeI3vLwzNoFs7W2Pld8zjHHIIpcGBYX5/wmqM3AkOFgO
         ckgsr9/c4hc/5x17IscwwGDNwGr8gor64t+pE=
Received: by 10.146.60.29 with SMTP id i29mr1280642yaa.26.1316635355075; Wed,
 21 Sep 2011 13:02:35 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 21 Sep 2011 13:02:35 -0700 (PDT)
In-Reply-To: <4E7A3BDE.3040301@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181859>

On Wed, Sep 21, 2011 at 3:32 PM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> I was thinking of using git attributes to configure a server-side
> "update" hook that does some basic sanity checking before accepting a
> push. =C2=A0I thought I could do something like
>
> ~/.gitattributes:
> =C2=A0 =C2=A0*.c whitespace
>
> ~/crappy-vendor-code/.gitattributes:
> =C2=A0 =C2=A0# This code doesn't conform to our standards; disable ch=
eck:
> =C2=A0 =C2=A0*.c -whitespace
>
> This would allow fine-grained specification of which checks are appli=
ed
> to which files, and ensure that the hook configuration is kept
> synchronized with changes to the content.

I do this by running diff --check. I'm actually doing it via Jenkins +
Gerrit, but it's done against a bare repo, so the idea should work
just the same via a git hook. Here's the code I run in Jenkins in case
it's at all helpful - https://gist.github.com/6b230f9bd8d4d2fd9895

j.
