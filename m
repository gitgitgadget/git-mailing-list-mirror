From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Reconstructing git-svn metadata after a git clone
Date: Mon, 10 May 2010 21:43:11 +0000
Message-ID: <AANLkTin_hVhyrhjwoM_on_sd1RIZrk6YIFVsYXKm5UKg@mail.gmail.com>
References: <AANLkTikR5EpZhwFXmRfmE9jSNtiuFoGwTgGbpcwUBxnq@mail.gmail.com>
	 <t2l86ecb3c71005081120lf87fc99bh1566c82a4d21904e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon May 10 23:43:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBal7-0002mA-3A
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 23:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab0EJVnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 17:43:15 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:62697 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab0EJVnN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 17:43:13 -0400
Received: by gxk9 with SMTP id 9so3166167gxk.8
        for <git@vger.kernel.org>; Mon, 10 May 2010 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bb+fncRJg9hKq1vcpN5dKW7W4rGQ+fETe1l4c682cNE=;
        b=hrOWmApEy/s5Fg7XIcrUWmHe8oxb8992DG3VUMoUq2spnwW3MAKc2MEQ+LUExpLM3H
         HVytTvCbqpsb3H7BA0+gTfNxfQYjQlG7SQGz5tCOpXrfWwULy5doqX+Ag229M8TXc3Wx
         CVIo+Z42zucNCwskG/ejByVdMR8cdB04mp9uU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jNq2/DZFEAhFHZsMMYsYWHKVbCrhX51Gb0JUlT3Lgki83dNLdR0rKEGlUx4NP+0ISn
         XRQ6k8Hy0e/0/MmLiarRT3jA5w6AxGCnwf1US8Pq3ZFe0YIQlP9sGqn0NCYJFbUXgUnn
         Z0x90w59IpTKExGogF0HEWfVLUHjuUaAmuRiQ=
Received: by 10.231.59.18 with SMTP id j18mr2330436ibh.88.1273527791183; Mon, 
	10 May 2010 14:43:11 -0700 (PDT)
Received: by 10.231.160.11 with HTTP; Mon, 10 May 2010 14:43:11 -0700 (PDT)
In-Reply-To: <t2l86ecb3c71005081120lf87fc99bh1566c82a4d21904e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146859>

On Sat, May 8, 2010 at 18:20, Dmitrijs Ledkovs
<dmitrij.ledkov@ubuntu.com> wrote:
> On 8 May 2010 18:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>> So:
>>
>> =C2=A0* Am I doing something wrong? If so I can't see what it is.
>>
>
> No
>
>> =C2=A0* Is there something that works for the general case, i.e. you=
 only
>> =C2=A0 have to know the original `git svn init` options. If there is=
 I'd
>> =C2=A0 like to document that & submit a patch.
>>
>
> In my repo I have a branch with no anestors which has a config file,
> setup.sh & fetch.sh
>
> I instruct to clone repo, checkout "utils" branch, run setup.sh (it
> overrides .git/config with config file committed to utils branch and
> after it copied config it runs git svn init URL), fetch.sh just runs
> git svn fetch =3D)
>
> I have to do this because I have two svn remotes and both are not
> standard layout. The only way for me to represet "same init options"
> is by editing .git/config cause it's impossible for me to supply
> git-init options on the command line =3D)

If I can't resolve this I'll do something similar. Just provide a
tarball of .git/svn for each repo that is.

>> =C2=A0* Depending on the above; can git-svn itself be friendlier her=
e?
>> =C2=A0 Maybe by having a `git svn bootstrap` command. E.g.:
>>
>
> It would be nice to have the git init info propogate with the git
> clone. But this won't work. You are cloning *all* branches and
> providing a git mirror, where as I want to to git init just my svn
> branch or a subset of them. To achieve that I will clone just the
> branches I need modify my .git/config and get the result I want.
>
> So imho git-svn is ok here.

I still don't see why it can't work. Maybe I'm just hopelessly na=C3=AF=
ve
to git-svn internals, but:

   * Every commit message in the Git repo has info on the svn
     branch/svn commit.

   * The Git repo has a list of branches that map to SVN branches.

   * If I supply the same `git svn init` options that made the repo,
     it should be able to bootstrap just using the above.

Why isn't that the case? What info is in .git/svn that can't be
inferred from the above?

>> =C2=A0git clone git://$some_url
>> =C2=A0# Does all the work of setting up metadata/refs
>> =C2=A0git svn bootstrap --stdlayout $remote_svn_url
>
> If you are committing to svn regularly you are better of with bzr-svn
> in my opinion. Because launchpad can run automatic imports for you
> (webkit is already running btw) and the whole bootstrapping thing is
> done the way you are expecting it.
>
> #create repository to store revisions efficiently
> $ bzr init-repo .
>
> #on the first ever run it will rebuild meta-data
> #subsequent runs just fetch missing revisions
> $ bzr branch svn://path.to.any.branch
>
> And you can commit from that =3D) and bzr can operate on your svn
> checkouts. And every single clone done by bzr-svn is identical (unlik=
e
> git where everyone has to follow the same git-svn mirror to get same
> revision-ids).
>
> You have two options when commiting with bzr-svn. Regular bzr ci will
> store bzr merge information in revision properties on svn server or
> you can use bzr dpush which is like git svn dcommit.
>
> IMHO bzr-svn is the best when you need to commit back to svn and
> painlessly commit parts of the feature branch and merge other bits
> later.

That's informative. But from having used Bazaar a bit my experience
with it was that I might as well be using Subversion.
