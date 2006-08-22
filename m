From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: stgit: deleting a branch doesn't seem to work
Date: Tue, 22 Aug 2006 19:12:53 +0200
Message-ID: <e7bda7770608221012u269ca577ye83a3a548c4faf08@mail.gmail.com>
References: <e7bda7770608211027m298ca361pdd78e164b9a524a5@mail.gmail.com>
	 <tnxd5attbhq.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 22 19:13:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFZoA-0001dB-HX
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 19:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWHVRMz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 13:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWHVRMz
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 13:12:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:46313 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932258AbWHVRMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 13:12:54 -0400
Received: by nf-out-0910.google.com with SMTP id o25so112157nfa
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 10:12:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rCq8h2M7N6qaclEufHm308G/KepfjX8GRGs/i+3bfa/F2k8vyopNdMbxu0qskeylc/P2lZ+iEzCrpknnBiro9HjMbgObJmY/+FTKUBEoeiPr+Vn9pMznUZUHAi8WAqFA1YpdAIVbmB5HNSA2DAMvNuyvpyG0O8rOH3Tybq5DIIU=
Received: by 10.48.163.19 with SMTP id l19mr685643nfe;
        Tue, 22 Aug 2006 10:12:53 -0700 (PDT)
Received: by 10.49.26.9 with HTTP; Tue, 22 Aug 2006 10:12:52 -0700 (PDT)
To: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
In-Reply-To: <tnxd5attbhq.fsf@arm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25863>

Which option you choose doesn't really matter to me, I easily deleted
the master-branch (with rm). If you choose to stay with the current
situation the message should be changed to something like "stgit
patches succesfully deleted from branch xxx" and "branch xxx is not
controlled by stgit, nothing is done."

It also would be helpful to new users if "stg refresh -e" is mentioned
in the tutorial. Refresh isn't obvious to test if you want to edit
description.

Otherwise I had no problem in my first stgit experience. I first took
a chance that "stgit import" recognized patches saved by
"format-patch", but this was easily solved with "stg refresh -e" once
I found it (thanks #git).

I've never worked with quilt before so i'm new to this style of
development. My experiece so far is that I find stgit to be very
useful.  Thanks!

//Torgil

On 8/22/06, Catalin Marinas <catalin.marinas@arm.com> wrote:
> "Torgil Svensson" <torgil.svensson@gmail.com> wrote:
> > I have three branches and want my "gst10" to be "master" instead
> >
> > $ stg branch --delete master
> > Deleting branch "master"... done
> > $ stg branch -l
> > Available branches:
> >   s     gst10   |
> >         master  |
> >>       origin  |
> > $ stg branch --delete master
> > Deleting branch "master"... done
> > $ stg branch -r gst10 master
> > stg branch: Branch "master" already exists
> >
> > Is there something i'm missing in my logic?
>
> It's not actually documented but it looks like the master branch is
> not completely deleted by StGIT. If you have StGIT-managed patches in
> "master", they are removed but the GIT branch is kept as this is
> usually the default branch.
>
> You could do a "git branch -d master" but maybe I should change StGIT
> to fully delete the "master" branch as well.
>
> --
> Catalin
>
