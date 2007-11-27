From: gapon <gapon007@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 12:31:51 +0100
Message-ID: <200711271231.51270.gapon007@gmail.com>
References: <200711271127.41161.gapon007@gmail.com> <81b0412b0711270321q6f70554at177ade878448b9fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:32:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwyfx-0000dE-OL
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440AbXK0Lb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 06:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755355AbXK0Lb6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:31:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:50120 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbXK0Lb5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 06:31:57 -0500
Received: by nf-out-0910.google.com with SMTP id g13so910359nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 03:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=OIc2nPlM1snFZQepfrgoA+Fu8//DHVVP2ECo2XIVsQA=;
        b=JN6aP6jAIEDxkBPsaxyp95HNSwcb6FgbXdhzwbxpNaP+6uqBe2OrrYDyrpr9oJYhtErJ3Zi6R/s3hlTM8ZiDWM9M2miOnm+uRMK1o7iEKgtCXb2gA0gwcKWr6/2SSArXOfcd7UE8XH298UZkoFSuW3xzrZnylIk6YCNMCHeF3kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CWVpMB3KWHvml9aYFYDTIzzsz/HNxzC5Gm+VTmhgnv7GsEUGVX6kAIDkG6XlZrvDVfCWH+K0RqGfUK6SApx0TzY2Kr4ld4FJYh5W1TUHco3OOnDEOGQFmeO540zGqVYku2ygNlx7hbmNG28bBF94LwxyCEmSpKXPL15RjicrCxo=
Received: by 10.86.4.2 with SMTP id 2mr3775064fgd.1196163116289;
        Tue, 27 Nov 2007 03:31:56 -0800 (PST)
Received: from dhcp-eprg06-20-185.czech.sun.com ( [192.9.112.196])
        by mx.google.com with ESMTPS id 28sm4324397fkx.2007.11.27.03.31.54
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 03:31:55 -0800 (PST)
User-Agent: KMail/1.9.7
In-Reply-To: <81b0412b0711270321q6f70554at177ade878448b9fc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66192>

as i wrote in my first email - i know that this is not "correct" scenar=
io (i=20
don't and won't use it anywhere) - but the git's behaviour is in such c=
ase=20
confusing, at least for me
just for clarification - my email wasn't about how to push or create sh=
ared=20
repository - it was just about what i have discovered while playing wit=
h=20
different scms

gapon


Dne =C3=BAter=C3=BD 27 listopadu 2007 Alex Riesen napsal(a):
> On 27/11/2007, gapon <gapon007@gmail.com> wrote:
> > hi all,
> > first of all i don't know if there's a bugzilla or something simila=
r for
> > git - i have found just this email (on http://git.or.cz/ webpage).
> >
> > i have discovered "weird" behaviour of git in this scenario*:
> > - user A is working in repo A
> > - user B clones repo A
> > - user B makes some changes, commits, pushes
> > - user A makes some changes, git status (no info about new commit i=
n his
> > repo from user B but it's probably ok i'd say - but some of my file=
s are
> > marked as changed and already added to index  but i haven't changed=
 them
> > - that's confusing, isn't it?)
> > - user A can commit his changes =3D> shouldn't be there any
> > info/message/warning displayed? it would be helpful to have here so=
me
> > info about "foreign commit" in the repo or something like this
>
> If you share a repository with someone else, you better use different
> branches. What's happened is that user B changed the branch the
> user A was working on (strictly speaking, the B-user changed the
> reference A-user used as HEAD at the moment).
>
> Just have the B-user push his/hers changes on something else,
> not the master of the parent repository. For instance, B-user can
> add a "push"-line to his origin remote which redirects its pushes
> somewhere else:
>
>   git config remote.origin.push 'refs/heads/*:refs/heads/B-user/*'
>
> Or just use a dedicated shared repo where no one works in.
> See also Documentation/config.txt, and the man page of git-push.
