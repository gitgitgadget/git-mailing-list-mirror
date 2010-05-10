From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git branch descriptions
Date: Mon, 10 May 2010 18:26:12 -0500
Message-ID: <20100510232612.GA6890@progeny.tock>
References: <657A681BEF27534399890012B8C8E50E1AD63D1FEA@lcs-exchange01.Lantekcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Joel Reed <jreed@lantekcs.com>
X-From: git-owner@vger.kernel.org Tue May 11 01:27:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBcNT-0006C0-9c
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 01:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616Ab0EJX0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 19:26:16 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:53933 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932569Ab0EJX0K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 19:26:10 -0400
Received: by qyk13 with SMTP id 13so7019629qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 16:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yUyhVehsHiHGJfZFxIoZmXZb800NoooEDW3/P7BzbVs=;
        b=T7AFKe+rs0Tgu+MFoGAaCFTAE+2kUe+WLIpxmPzCIdWzjeYN5xyIg1mFd+pYioBamS
         c2VtW0dRtYvYVOlRapImGsvWosKM9pcPPG3KZE8JR8GXtoqpvgSb9YCL6QWMdsmpoFVN
         MipdRoFGIJgXKGNJw350b7xasjZXZBdU2ttWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DNu2uMa/T0QmvuAC41L/0Js5f8RSfxW31xljEQe1Ah1vs+h+p0pKh0ZSTUx3YkgWAH
         N4N0GAA6xQz4yd8EqbCVxhy1BTVuXBJOQS2xXYK1cxVKtylT0whhwazLn/BAvFdCW37i
         jWP+4LNIWDC08NtD8z8YBzWGm/De0yq3guN1A=
Received: by 10.224.71.130 with SMTP id h2mr3237817qaj.90.1273533969425;
        Mon, 10 May 2010 16:26:09 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f5sm4342002qcg.20.2010.05.10.16.26.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 16:26:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <657A681BEF27534399890012B8C8E50E1AD63D1FEA@lcs-exchange01.Lantekcs.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146861>

Hi,

Joel Reed wrote:

> Working on a wide range of topics/branches from week to week and
> project to project, it's sometimes difficult to quickly remember
> what each branch is about, without doing a git diff master <branch>.
> =C2=A0I like to keep branch names short so they're easy to switch to =
and
> from, but being able to attach a description that would display when
> doing a "git branch" would be a huge help.

I think the closest thing we have now is =E2=80=98git branch -v=E2=80=99=
, which tells
the subject of the commit at the tip of the branch.  =E2=80=98git notes=
=E2=80=99
annotates commits rather than branches, so it occupies a different
niche.

Your request is a reasonable one, and it has come up a few times in
different forms over the years:

 . per-branch descriptions in .git/description[1]
 . per-branch descriptions in .git/config[2][3]
 . README branch whose files describe the branches[4]

Number [2] is my preferred choice (and comes with code!), for what
it=E2=80=99s worth.

That doesn=E2=80=99t address the problem of how to _share_ branch
descriptions.  That could be dealt with by extending the wire protocol
as in [1], I think.  Just sharing a list of branch descriptions is a
bad idea imho, since related repositories need to be able to name
their branches independently to avoid painful coordination problems.

> My only intention with this email is to say "thanks" and put in a
> vote for git branch descriptions.

The best vote is to write a sample script for yourself, try it out,
and tell us how it goes. :)

Thanks for bringing this up.
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/8130/focus=3D=
8187
[2] http://thread.gmane.org/gmane.comp.version-control.git/33528/focus=3D=
33563
[3] http://thread.gmane.org/gmane.comp.version-control.git/46855/focus=3D=
47077
[4] http://thread.gmane.org/gmane.comp.version-control.git/93333/focus=3D=
93491
