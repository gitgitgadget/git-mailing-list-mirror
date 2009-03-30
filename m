From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 23:20:00 +0800
Message-ID: <46dff0320903300820u3efb26c2x5658afc71096d180@mail.gmail.com>
References: <200903301024.08848.brian.foster@innova-card.com>
	 <49D09207.9080407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Foster <brian.foster@innova-card.com>,
	git mailing list <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 30 17:21:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoJIw-0005GL-Hr
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 17:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbZC3PUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 11:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZC3PUE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 11:20:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:51759 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbZC3PUC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 11:20:02 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1344243wah.21
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wLwBKBPx6PP1jwd+/DKQGGybhW9p1qNMlBOC9EPusq0=;
        b=WLKYh6n7wTG6kyci+ZNe3F7pL4XMz2+NSosg7VUJ+F0rPbQJT7G3A6QZOgoZ2h2d3e
         13vtyAVu+YVWkJZBSjExhdmxWzrGPmyPDIPUcE+UwqBWUu1r4AdJEJ27x+Pdj2EZmGvj
         5v3oP7ue107NrfrjXfQ6v904LbH9bNpW8a05w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fjElPLHL/rVqDsxjEMXGTaD+8g4B1VU6XV61qYn533pkUTdUkdf1zA1RERNRoD8lQg
         KgZkQCjo4qMN8Xb7QUtIWOptjYwZYuw+OjzE8J+arOGyeFD5aWjdviKnqIkMb8gZ2kco
         NhEvgQ6yhbCTM6PnXMuoOMbRl4H+uDndMISTk=
Received: by 10.114.148.2 with SMTP id v2mr3636617wad.169.1238426400371; Mon, 
	30 Mar 2009 08:20:00 -0700 (PDT)
In-Reply-To: <49D09207.9080407@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115163>

On Mon, Mar 30, 2009 at 5:33 PM, Andreas Ericsson <ae@op5.se> wrote:
> Brian Foster wrote:
>>
>> =C2=A0Whilst this question involves linux(-mips) kernel tree,
>> =C2=A0it's a git(-related?) question, not a kernel question ....
>>
>> =C2=A0We are currently in the process of upgrading our embedded
>> =C2=A0system from kernel 2.6.21(-ish) to at least 2.6.26.8; =C2=A0an=
d
>> =C2=A0later, at some time in the future on to 2.6.3x or something.
>> =C2=A0Going from 2.6.21 to .22 to .23 and so on to .26, then to
>> =C2=A0.26.1 and so on to .26.8 is =E2=80=9Ceasy=E2=80=9D in the sens=
e there are
>> =C2=A0very few conflicts with our existing baseline (e.g., just
>> =C2=A02 or 3 in 2 or 3 files).
>>
>> =C2=A0.21 --> me --> .22 --> .23 ... --> .26 --> .27 --> master
>> =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=
=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =
=C2=A0\
>> =C2=A0 =C2=A0 .21-stable =C2=A0.22-stable .23-stable =C2=A0 \ =C2=A0=
 =C2=A0 .27-stable
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.=
26.8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .26-stable
>>
>> =C2=A0But (using 2.6.21-stable and 2.6.22-stable as proxies),
>> =C2=A0tests indicate that going from .26.8 to .27 or anything
>> =C2=A0later will have numerous conflicts (100s? in more than
>> =C2=A030 files). =C2=A0Thinking about it, this isn't too surprising
>> =C2=A0since the -stable branches cherry-pick important/benign
>> =C2=A0fixes from later revisions.
>>
>> =C2=A0What's frustrating is that in essentially all =E2=80=9Cconflic=
t=E2=80=9D
>> =C2=A0cases, the resolution is simple: =C2=A0Use the later version.
>
> The trouble is "essentially all", as opposed to "all". Git
> can never know which of the conflicts are which, so it will
> leave it all up to you.
>
> A possibly better approach for you is to "git format-patch"
> your own changes and apply them to a clean 2.6.26.8 tree
> instead of trying to merge 2.6.26.8 into 2.6.21.

Or just (say, always use rebase instead of merge)

git rebase -i 2.6.26.8 --onto 2.6.27
