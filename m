From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stg pull/rebase
Date: Tue, 10 Jun 2008 16:43:27 +0100
Message-ID: <b0943d9e0806100843j28bb3353y5889a50712377959@mail.gmail.com>
References: <20080607172202.GA5179@diana.vm.bytemark.co.uk>
	 <b0943d9e0806100302j159f5b7fq6d970316b902b39b@mail.gmail.com>
	 <20080610104244.GC30119@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:44:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K661M-0000JC-6a
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 17:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbYFJPne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 11:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYFJPne
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 11:43:34 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:16910 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbYFJPnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 11:43:33 -0400
Received: by py-out-1112.google.com with SMTP id p76so1245862pyb.10
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pE4u5sVWg6xyikH80oMNmhkfv5qt+5gLUGHXJshaquY=;
        b=Tou67+Kxi6VeY0GoqBdL3E4ZrJ2mebq/UPagwEOYStjnd9U4Qnm3z5cev8A5Myv5Dj
         26rOqOTBd2j95QYfcBl43mSoGZ0s/xHX3NKvrUUVySM9i9BU3z9YVu4ZXDybTX84WRh+
         cXf8IZ4FE8josV3GOnm1Cg38grI+2igeCsVB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PEHSbWhgpyxDfqg9G1rwUmECEbhL0zQYJaQc0vrQP1+iYsLMrfbHvduY5GNlnkMHQv
         UZ47NN5RUEVwk5plVxsGCvY0KPyzxwwD6VxIiYjUtQ/5hTh8IKVBwJrqVRP8vrBKzrT7
         Hcus3tkVLN2IVGNR9Y7Lvr7NhDoNWYovFYAEo=
Received: by 10.115.50.5 with SMTP id c5mr5115139wak.60.1213112607294;
        Tue, 10 Jun 2008 08:43:27 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Tue, 10 Jun 2008 08:43:27 -0700 (PDT)
In-Reply-To: <20080610104244.GC30119@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84521>

2008/6/10 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-10 11:02:18 +0100, Catalin Marinas wrote:
>
>> However, I found some these policies useful. For example, I just do
>> a "stg pull" from a Subversion repository with the config below:
>>
>> [stgit]
>>         pull-policy =3D fetch-rebase
>>         fetchcmd =3D git svn fetch
>>         rebasecmd =3D git svn rebase
>
> Looks useful.
>
> But what exactly is "rebasecmd" useful for, when you already have
> "fetchcmd" and a built-in rebase?

In case the built-in rebase is not enough. Can you use "git svn fetch"
followed by plain "git rebase"? There are some comments in git-svn.txt
that recommend to use "git svn rebase" to preserve linear history.

>> 2008/6/7 Karl Hasselstr=F6m <kha@treskal.com>:
>> >      2. Depending on the configuration (overridable by the
>> >      --fast-forward, --rebase, and --merge options), one of these
>> >      three things happen:
>>
>> But "pull" always suggests fetching something. Adding "--rebase"
>> would mean that it doesn't fetch. Shouldn't we leave this
>> functionality to "rebase" only?
>
> These two things are orthogonal:
>
>  1. Whether and how to update the branch we're pulling from
>     (fetching).
>
>  2. How to do the actual pulling (rebase, fast-forward, or merge).

I think it's more of an language interpretation issue (I'm not a
native English speaker). I see the "pull" action as pulling (can't
find meaningful synonyms) remote changes into the current branch (i.e.
fetch + merge). I think you see it as pulling the current stack onto a
new base (i.e. rebase).

> I envision (1) being controlled by the branch config (and overridable
> with a --no-fetch option or something), and (2) being controlled by
> another part of the branch config (and overridable with
> --fast-forward, --merge, and --rebase).

OK.

>> >         1. We pop all patches, fast-forward to the new base, and
>> >            push them back. If it's not a fast-forward, we error
>> >            out.
>> >
>> >         2. We pop all patches, reset to the new base, and push
>> >            them back.
>> >
>> >         3. We pop all patches, merge with the other branch, then
>> >            push the patches back.
>>
>> These are OK, with the comment on have rebase functionality in
>> "rebase" only.
>
> Why? I don't see the difference between rebase and the other two that
> would motivate such a separation.

See my interpretation of the word "pull". I can change my mind, no
problem, but it would be interesting to see what a native English
speaker says (though you are probably closer to English than me :-)).

--=20
Catalin
