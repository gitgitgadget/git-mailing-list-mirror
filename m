From: Deskin Miller <deskinm@gmail.com>
Subject: Re: reviving a git-svn clone
Date: Tue, 21 Apr 2009 02:09:31 -0700
Message-ID: <86d4c5e00904210209v3f1b8fd3t6a991fe44455941@mail.gmail.com>
References: <20090420104316.GA11433@lapse.rw.madduck.net>
	 <1240296712.3424.8.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 11:11:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwC0b-0007d4-Ec
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbZDUJJe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 05:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbZDUJJe
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:09:34 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:62433 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZDUJJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 05:09:32 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1579510ywb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VLBqmNywV9RM3EFlvmz4txijktgwBCNDVeX6TC+t0Ck=;
        b=X9DN8IpAkcN31AQVdRmi9Eik70Yf+hWITTk6gDHE0FQHy0zGrjVgefkHvHeHc6vDF/
         It1Sfnqgduai7ZCacqEoSQPbRz5RhjBTDGqldMuh3CpkJnRdmNZRi2wVFlUa8mPNh6aM
         6ZtPt3d3A9kjpLb4aKkKwaEzK2J7wrVNcGwQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wBJM55fg0PwhhvXcK2TmQ+HLThmUpFXBFnuR+1ASHrtC+MNwt/f+zMVmifbDDg5I17
         MVhsxhegI+tHSY0ffo1cKEWK1tQJZYRtryfQZSwFEacYBeANuLMQ+eMiK+HvKopOhHBe
         iJL9SZxRNlPoCxmM92HJ84AXT029cbQOTEcAY=
Received: by 10.150.122.21 with SMTP id u21mr8119297ybc.11.1240304971894; Tue, 
	21 Apr 2009 02:09:31 -0700 (PDT)
In-Reply-To: <1240296712.3424.8.camel@maia.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117112>

On Mon, Apr 20, 2009 at 23:51, Sam Vilain <sam@vilain.net> wrote:
> On Mon, 2009-04-20 at 12:43 +0200, martin f krafft wrote:
>> I am now trying to revive the clone, but git-svn remains "unable to
>> determine the upstream SVN information from the working tree
>> history". This baffles me.
>>
>> Here are my steps:
>
>> -8<--8<--8<-
>> alioth:~|master|% git clone /git/collab-maint/hibernate.git hibernat=
e-svnsync
>> Initialized empty Git repository in /srv/alioth.debian.org/chroot/ho=
me/users/madduck/hibernate-svnsync/.git/
>>
>> alioth:~|master|% cd hibernate-svnsync
>>
>> alioth:~/hibernate-svnsync|master|% git branch --no-track upstream o=
rigin/upstream
>>
>> alioth:~/hibernate-svnsync|master|% cat >> .git/config <<_eof
>> heredoc> [svn-remote "svn"]
>> heredoc> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D svn+ssh://svn.suspend2.n=
et/svn/hibernate-script
>> heredoc> =C2=A0 =C2=A0 =C2=A0 =C2=A0fetch =3D trunk:refs/remotes/ups=
tream/trunk
>> heredoc> =C2=A0 =C2=A0 =C2=A0 =C2=A0branches =3D branches/*:refs/rem=
otes/upstream/*
>> heredoc> =C2=A0 =C2=A0 =C2=A0 =C2=A0tags =3D tags/*:refs/remotes/ups=
tream/tags/*
>> heredoc> _eof
>
> for git-svn to resume, it needs the refs all in the right place. =C2=A0=
If you
> clone a git-svn repository they will be in the wrong place.
>
> eg for this use case something like this to copy the
> refs/remotes/origin/* refs to refs/remotes/upstream/*:
>
> =C2=A0git for-each-ref --format=3D"%(refname)" refs/remotes/origin/* =
|
> =C2=A0 =C2=A0 perl -le '$x =3D $_; $x =3D~ s{origin}{upstream};
> =C2=A0 =C2=A0 =C2=A0 system "git update-ref $x $_"'

Sam is on the right track.  I got the rev-map to rebuild with the
following steps (sufficient, perhaps not all necessary); enter these
after you hack .git/config with the svn info.

=46irst, we need the backend .git/svn/.metadata file, populated with th=
e
right URL and svn uuid; the uuid follows the URL and revision on log
messages:

$ mkdir .git/svn
$ cat > .git/svn/.metadata << EOF
[svn-remote "svn"]
        reposRoot =3D svn+ssh://svn.suspend2.net/svn
        uuid =3D c12ee44c-9ede-0310-94ea-d4716f4f7118
EOF

Now, make the remote-tracking branch upstream/trunk at the right
commit, and check out a local copy; the commit ID is the latest commit
from svn, also known as master^2 (at the time of this writing) if you
do a normal git clone from your provided url:

$ git update-ref refs/remotes/upstream/trunk 1784ac6d
$ git checkout -b upstream upstream/trunk

Now, do git svn info or your other favourite local command to rebuild
the rev-map:

$ git svn info

If you have access to the svn remote, you should be able to avoid
hacking config and .metadata entirely by entering

$ git svn init --stdlayout --prefix=3Dupstream/
svn+ssh://svn.suspend2.net/svn/hibernate-script

This doesn't fetch any commits, but will contact the svn server to
obtain the uuid.  Plus, it's much easier to type.  At any rate, the
commands prior to that rebuilt the rev-map metadata for me; I can't
guarantee the alternative last one, since I can't test it myself.

> It's a bit hard to test without access to the upstream svn!

I concur :)  Hope that straightens things out.

Deskin Miller

P.S. Thanks Dscho for the excellent msysgit package
