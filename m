From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Fixing branches from a (really messed up) subversion repository
Date: Tue, 15 Jun 2010 16:29:47 +0000
Message-ID: <AANLkTink-Rm44xnzBHVo6W_29YCPrjScnolqx_9B8A5G@mail.gmail.com>
References: <AANLkTinmU3tOkv9usjGogHn5cXm07FMde8ryDKuWNKD_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:30:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZ1Q-0006d1-OB
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab0FOQ3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 12:29:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34342 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab0FOQ3t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 12:29:49 -0400
Received: by iwn9 with SMTP id 9so4691378iwn.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z4t5B2nuBOYpdJqH/IzidmZRP47X2TjLKb7YjPJPOc0=;
        b=iAiOYryIAH8JzM9gsOYXmAqpJQRfDi8OLxlbLdBJOfzAoUz2UtEIeeuiU8vzRTmq6f
         AIsazd7qCXl+pUSwW9iOqUj3AHfy18f2TzjrXNXoVhccrOxiHFC7V0LcKEnukK0tsRGa
         nJ8ZPta6rqX4SO0KmvQoT7LjHL2/PlsTB0xuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PFt2JPckOkCuBEDLw0VXQTLze0XwCADMdErYsHVYRbICGb+Kdira6veQwrpxYIwDjc
         2txqlazmByqqRD/02y5zWLGKmhqaUQw7LAbxKeTLCUF9HIzBkD/16j5j4S8/bVaW2A/N
         X0xIuMhHLXtXA83nCU+bRlU2wrPlyfCS+KSSU=
Received: by 10.231.145.79 with SMTP id c15mr8762900ibv.102.1276619387836; 
	Tue, 15 Jun 2010 09:29:47 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Tue, 15 Jun 2010 09:29:47 -0700 (PDT)
In-Reply-To: <AANLkTinmU3tOkv9usjGogHn5cXm07FMde8ryDKuWNKD_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149200>

On Tue, Jun 15, 2010 at 16:26, Joshua Shrader <jshrader83@gmail.com> wr=
ote:
> I've finally convinced my project to switch to Git... =C2=A0However, =
when
> my project first began, the people responsible for branching/tagging
> were fairly unfamiliar with standard procedures. =C2=A0As such, the
> beginnings of our repository look a little something like this:
>
> .
> `----project
> =C2=A0 =C2=A0 |
> =C2=A0 =C2=A0 `branch1
> =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`----project
> =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0`src
> =C2=A0 =C2=A0 `branch2
> =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`----project
> =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0`src
> =C2=A0 =C2=A0 `src
>
> That is, the branches were essentially inside the trunk. =C2=A0In ord=
er to
> check out the "mainline" of development, you also got all of the
> branches. =C2=A0After a few branches, they realized that this was a
> problem, and someone found out about the trunk/branches/tags paradigm=
=2E
> =C2=A0Our branches were svn mv'd to separate directories under "branc=
hes",
> and all was well. =C2=A0Now everything looked like a sane version con=
trol
> repository.
>
> Now, we want to import this into Git. =C2=A0I tried git svn import
> --stdlayout..., but this just stalled. =C2=A0I'm assuming because the=
 first
> version didn't have a trunk/branches/tags structure. =C2=A0So, I had =
to
> import it leaving off the --stdlayout option. =C2=A0Is there any way =
to
> manually fix this in Git? =C2=A0After the import is complete, my mast=
er
> branch will have a trunk, branches, and tags directory in it. =C2=A0C=
an I
> create real branches out of the directories under the branches
> directory and then remove them from master?
>
> Any help is greatly appreciated. =C2=A0I've been hoping for a while t=
hat
> we'd switch to Git, and I don't want this to hang us up.

I have the same problem on another project, and after looking at the
components involved it seems that the easiest way is to filter the SVN
dump, then import it into Git.

It's quite easy to write a filter with SVN::Dump that does this,
i.e. just do a few string replacements on the paths before a given
revision, and drop the revision where you moved things.

A lot easier than convincing git-svn to do what you want, anyway.
