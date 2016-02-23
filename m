From: Stefan Beller <sbeller@google.com>
Subject: Re: Git History Rewriting in a public repository - capability to
 remove one or more commits from a public repository
Date: Tue, 23 Feb 2016 13:59:34 -0800
Message-ID: <CAGZ79kaPPvbfXDPYBsivTtOC8jdNvWC9=xLuHgRGqmZWXy1b4Q@mail.gmail.com>
References: <D2F20E85.A04DB%sarvi@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:59:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKzb-0004ol-Rf
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbcBWV7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 16:59:36 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:34205 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589AbcBWV7e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 16:59:34 -0500
Received: by mail-io0-f182.google.com with SMTP id 9so3561371iom.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=iPggm/6EC4bHOVatr1Jcv+lTI6Shk8czHrglFTCzwww=;
        b=OAnh+kvOE4Lqn8Q+G0ZyKlvnzU7BwY6xRzLacqHAV+99uHG/qmxCVquwSWbRSN4m5K
         GlyqR1srj/SPfYEoDhjbil8yYqdXyGaiYlTK9zQX+N2AFYG9mlJa7/vPo/dam0e+Cyuf
         m0KWJIjVblgVgTuXb6rXqBYMG4FU1hgIxOfMoKhKYje0Buze0CKuC5t/pVIZPMN3tycO
         635SkkBApw37gJrws54fheXjd2H3YNUcataGMEEWHhh6ZcA9epvqiiJSL4TuBAtM70u+
         dVa6CcQN2keuobA5WikN7xHWuLGkFXNZww9rG1t9kpy1BvQBgAz443m6K8NrNibEVO9h
         bMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=iPggm/6EC4bHOVatr1Jcv+lTI6Shk8czHrglFTCzwww=;
        b=FFFSDY+5D4jtOQoA2HnoBN7i9P5+PQnDO542DykWazTyi3INZD6y2QOkx2zn840Uxh
         1zyCHzM5mVM34h+9uSIkv3l/f+qTev7OczMpbp841S7nw81bM/RZcjOv8eQh0X+RyYh5
         P53PpDSaU93jeUUo80w+efwrzpXrect3jhmq65NdmfBYw3jbn3jp2hgqs7QSz4NNKuMe
         cRL3fwG2Dl3Bhl8b0cnu5o1rfsKLeVTZUe4jQ6arJTIEesFnkh6COnOmE6rtoJqv0/tg
         ixoIjbKEyak6lz4zAirUnvlVd5SzEBXrBy0ICxe7a5lv4XASdss58f7Tk/WjtNrE2lP9
         3Jow==
X-Gm-Message-State: AG10YOQ7yS236j9Ol65EMCa9+9IAzY1FA9m77hau0WfLWCIX0ltJCg/f+M7/Pe4KhVbiQKNHLVBE3ta1G4me23+Z
X-Received: by 10.50.28.105 with SMTP id a9mr20432938igh.94.1456264774149;
 Tue, 23 Feb 2016 13:59:34 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 23 Feb 2016 13:59:34 -0800 (PST)
In-Reply-To: <D2F20E85.A04DB%sarvi@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287131>

On Tue, Feb 23, 2016 at 1:30 PM, Saravanan Shanmugham (sarvi)
<sarvi@cisco.com> wrote:
>
>
> Hi Git Leads,
>       I am looking for git capability/way to be able to remove commit=
s
> from a public repository.
>
> Background:
> We are looking for a multi-stage commit process where commits get pus=
hed
> into a public =C2=B3testing-stage=C2=B2 repository.
> Where we do testing of commits before they are pushed to another publ=
ic
> =C2=B3mainline=C2=B2 repository.

instead of different repositories you could have different branches,
but as you like...

>
> When there are failures seen in the public =C2=B3testing-stage=C2=B2 =
repository.
> We would like to implement some process to go identify the bad patch =
and
> completely eject it from that public =C2=B3testing-stage=C2=B2 reposi=
tory, as if it
> was not connected.

So git revert is not an option, but you really want to purge the commit
as if it never existed?

That is not possible without rewriting history (which is considered bad
behavior for public repositories)

You can use a cherry-picking workflow where you cherry-pick the good
commits, once you are sure they are good indeed.

>
> The plan is to use the Git History Rewriting capability described her=
e
> https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
> So I can pull a pull workspace from the public =C2=B3testing-stage=C2=
=B2 repository
> use the above mechanism to eject one or more commits from it.
>
> Now I would like to be able push it back to public =C2=B3testing-stag=
e=C2=B2
> repository.

when using the cherry-pick workflow above (cherry picking from testing
to public),
you can still merge back public to testing

> And allow other people to be able to sync their workspaces to this pu=
blic
> =C2=B3testing-stage=C2=B2 repository, correctly.

    git fetch testing && git reset --hard testing-stage test-branch

would do that client side.

>
> This as I understand is not supported?/recommended? in GIT.

It is supported as Git is a toolkit and you can align your workflow usi=
ng
different tools from the box.

But it's not what anyone with prior knowledge of "How to work with Git"
expects things to be.

>
> Mercurial addresses this with the capability to mark commits with a p=
hase
> such as =C2=B3Draft=C2=B2 or =C2=B3Experimental=C2=B2 and having a wo=
rkflow around them.
> Described here
> https://www.mercurial-scm.org/wiki/Phases
>
> http://www.gerg.ca/evolve/user-guide.html#evolve-user-guide
>
>
>
> Question:
> What are the issues?

Rewriting history is considered bad practice, and that is probably the =
reason
why there are no good tools AFAIK to verify rewritten history easily.

When you consider published history permanent, you can use gpg or local=
 tags
to know what "is already good" and only inspect new incoming deltas
for correctness.

> What needs to be done in terms of development, to support this
> functionality and make it work properly in GIT?
> Is there additional development that needs to be done to git core to =
allow
> this development process?

I think the workflow you described can be done using current tools.
You would just need to
polish things or create aliases for things as this seems to be an
unusual workflow?

Thanks,
Stefan

>
>
> Thanks,
> Sarvi
> -----
> Occam's Razor Rules
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
