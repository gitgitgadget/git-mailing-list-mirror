From: Ilya Terentyev <bacondropped@gmail.com>
Subject: Re: Git History Rewriting in a public repository - capability to
 remove one or more commits from a public repository
Date: Wed, 24 Feb 2016 01:15:06 +0300
Message-ID: <56CCD9EA.3010404@gmail.com>
References: <D2F20E85.A04DB%sarvi@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:15:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYLEn-0000ug-4e
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 23:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbcBWWPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 17:15:15 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34522 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbcBWWPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 17:15:13 -0500
Received: by mail-lf0-f54.google.com with SMTP id j78so9414lfb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 14:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Z8qAsSFS9UQSL0p4JJV/kkDSsg49fl+4EsXwKCFysfE=;
        b=rrh1hB192249V4N4sC/SPcHtJAU0QrQFG+CGI1M2IY7ddSZ/yF6X4/iGgxUEgCN/Ww
         5Xm3Y61qZwxipdIJFJ/+/ztOQCnLT77wLvIlN+wZn6JGuJKwQ/7FWch4fzbqdBv0CvLl
         LwsN4XfDAlQqkku359OZ6+x/9LQHQPUWS3ba+kJDw8V1zDltM5sKIGFzxmwtfaeThM9v
         kmVtw88Vo6bBzUdrX1RyoJO3YbR3wD7/mFMKXBPfZWQezqccFFKTH1mIksDcUdjm6dmg
         OHd8/W0afhnpFXxiSBaoQ49skV+4aUYkxd6ezZJ4MfX7T8ELY5Iy4LU1fWyNOawTqSJK
         pNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Z8qAsSFS9UQSL0p4JJV/kkDSsg49fl+4EsXwKCFysfE=;
        b=Gnf/G4ICCvPyftBLupnzT1NDPpJYlP/TjcYWYSIh9Ecylzr19U5ICURgdyV25Djvke
         CuhrqRdJf4jFwJ9UVbmRCsONCHGZsO6EuuAff/Il4bfFdB9sB1EPGVVbBhF3b6c0SJtM
         j9lRNGG4oz2+d7gF2jTOvJ7XmlvMMmF5AtIparJytRuhZeHjvEd7k09f2R3RFPVlldAQ
         7MDzQKqT/DKLDKWGjo+7ei6Wy9QFj3DMPMQ5bbg9ObsrT878Fx3EmPzLQzKgFmD4J4fu
         1w96gfOM4/AazXFEjkq1lAx19pKl6KT2UpiwTRpsb3KnQa+EHion4v1KE6H2a6Wc6zRO
         QWDg==
X-Gm-Message-State: AG10YOTKtFwIzq/UJs0cHaLKIBqYSnRA10+DbIoI6Vewu67JaogBrIDHZPgZCOYQRoqgow==
X-Received: by 10.25.28.209 with SMTP id c200mr10884426lfc.29.1456265711799;
        Tue, 23 Feb 2016 14:15:11 -0800 (PST)
Received: from [192.168.0.12] ([83.167.105.63])
        by smtp.gmail.com with ESMTPSA id a14sm4450220lfe.7.2016.02.23.14.15.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Feb 2016 14:15:10 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <D2F20E85.A04DB%sarvi@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287133>

Hi Saravanan,

Changes that rewrite history, including (but not limited to) deleted=20
commits,
can be pushed with the --force or --force-with-lease options, like this=
:

     $ git push --force remote branch

--force pushes your changes unconditionally, which may overwrite change=
s
that someone else pushed between the moment you cloned the repo and pus=
hed
your own. --force-with-lease will check for others' pushes, so you can=20
use it
in a dry run (without actually changing anything in the remote reposito=
ry)
like this:

     $ git push -n --force-with-lease remote branch

If someone else (like another developer with access to "testing-stage")
pushes anything before your attempt to push, you will receive a message=
=20
like:

     $ git push -n --force-with-lease remote branch
     ! [rejected]        branch -> branch (stale info)
     error: failed to push some refs to remote

Generally speaking, your idea is, probably, better implemented with pat=
ches
or pull requests:

  1) Your developers rewrite their local history as they wish
  2) They generate patches from their commits (with git format-patch,
     for instance)
  3) Send those patches to "testing-stage"
  4) Apply them to staging area (without committing)
  5) Run required checks
  6) If checks don't pass, discard those changes
  7) If checks pass, commit those patches
  8) Push committed changes to "mainline"

But in any case, you should better consider using feature branches for =
that.

Best regards,
Ilya T.


On 02/24/2016 12:30 AM, Saravanan Shanmugham (sarvi) wrote:
> Hi Git Leads,
>        I am looking for git capability/way to be able to remove commi=
ts
> from a public repository.
>
> Background:
> We are looking for a multi-stage commit process where commits get pus=
hed
> into a public =B3testing-stage=B2 repository.
> Where we do testing of commits before they are pushed to another publ=
ic
> =B3mainline=B2 repository.
>
> When there are failures seen in the public =B3testing-stage=B2 reposi=
tory.
> We would like to implement some process to go identify the bad patch =
and
> completely eject it from that public =B3testing-stage=B2 repository, =
as if it
> was not connected.
>
> The plan is to use the Git History Rewriting capability described her=
e
> https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
> So I can pull a pull workspace from the public =B3testing-stage=B2 re=
pository
> use the above mechanism to eject one or more commits from it.
>
> Now I would like to be able push it back to public =B3testing-stage=B2
> repository.
> And allow other people to be able to sync their workspaces to this pu=
blic
> =B3testing-stage=B2 repository, correctly.
>
> This as I understand is not supported?/recommended? in GIT.
>
> Mercurial addresses this with the capability to mark commits with a p=
hase
> such as =B3Draft=B2 or =B3Experimental=B2 and having a workflow aroun=
d them.
> Described here
> https://www.mercurial-scm.org/wiki/Phases
>
> http://www.gerg.ca/evolve/user-guide.html#evolve-user-guide
>
>
>
> Question:
> What are the issues?
> What needs to be done in terms of development, to support this
> functionality and make it work properly in GIT?
> Is there additional development that needs to be done to git core to =
allow
> this development process?
>
>
> Thanks,
> Sarvi
> -----
> Occam's Razor Rules
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message tomajordomo@vger.kernel.org
> More majordomo info athttp://vger.kernel.org/majordomo-info.html
