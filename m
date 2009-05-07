From: Chris Packham <judge.packham@gmail.com>
Subject: Re: How to sync changes in GIT to ClearCase or How to get the list of 
	files changed in GIT for a specific branch
Date: Fri, 8 May 2009 09:34:42 +1200
Message-ID: <a038bef50905071434v59354824i8112f32e8359c726@mail.gmail.com>
References: <23197522.post@talk.nabble.com>
	 <a038bef50904232018w29419030k100ed5a5089f9e8e@mail.gmail.com>
	 <41a31a5a0905071204s597cb76ek524748b8b919b25e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Senthil Kumar <ask4thunder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 23:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2BFL-0004Lv-5v
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 23:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbZEGVeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 17:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbZEGVeo
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 17:34:44 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:59097 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbZEGVeo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 17:34:44 -0400
Received: by ewy24 with SMTP id 24so1431331ewy.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=totu4Nf+g4x+fePrUluoINUCDsqZoYwoVJ3yl5H3it0=;
        b=O1fejfYwtL2WbVwtgk4PFxITbrQwuXbwnHVJS03hH5sRphoXmPghS5x/t95xae4avP
         YQ97HY/w1a9JHPDmGMqzAYVVpQ81RYqJ91zVhadqV5N/TdY04VmBP0AbBTV7j+1NWubF
         ADTAtqlpyDOzaIPOo+vOCqa8xv8gJq60irSwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AZek2Lbr9i8kyHCuRg+ff7M5tyWOD7W6/dFI4nzOCAuiWSIeCAH6hXq/jfDEhcfyp1
         SKXza9r+edV2pA7tS5TzyFKLQy0qp2A3Q8+3OT+yArRe832L2bf4YJaEoFqbKkUvV4dW
         lFwpUQblMXqryxhmP2VMgrgWaMcyUv5xWxe7k=
Received: by 10.210.71.11 with SMTP id t11mr3520174eba.57.1241732083322; Thu, 
	07 May 2009 14:34:43 -0700 (PDT)
In-Reply-To: <41a31a5a0905071204s597cb76ek524748b8b919b25e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118526>

On Fri, May 8, 2009 at 7:04 AM, Senthil Kumar <ask4thunder@gmail.com> w=
rote:
> Hey Chris,
>
> First thanks for giving me the knowledge transfer and i really apprec=
iate
> it. Am working on the sync stuff now, but i have an issue in a perl s=
cript
> in post-update hook.
>
> =A0Have a doubt here, am writing a post-update hook in perl, so that =
whenever
> a user pushes code from their local repo to the bare public repo, the
> post-update hook triggers so as to pull changes from the abre public =
repo to
> the actual parent data repo.
>
> My data repo: /snaps4/searumugam/spec-repo/mydodo.repo
> My bare repo: /snaps4/searumugam/spec-repo/mydodo.bare
> My local repo: /snaps4/searumugam/githome/searumugam_mydodo
>
> here is what i have in the script (left),=A0 and the output i get is =
in blue
> (right)
>
> The concept: First when a user pushes to bare repo -
> /snaps4/searumugam/spec-repo/mydodo.bare, the post-update trigger sta=
rts, it
> shd cd into the data repo path=A0 (/snaps4/searumugam/spec-repo/mydod=
o.repo)
> and initiate a 'git pull'
>
> The $data path has the correct path - my data repo path, where the pu=
ll will
> be initiated,
>
> print "\nData Path: $data_path\n";=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =A0=A0 Data Path:
> /snaps4/searumugam/spec-repo/mydodo.repo/
> chdir ($data_path);
> system("pwd");
> /snaps4/searumugam/spec-repo/mydodo.repo
> system("git pull");=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fatal: N=
ot a git
> repository: '.'
> system("pwd");
> /snaps4/searumugam/spec-repo/mydodo.repo
>
> i even tried with system("/usr/libexec/git-core/git-pull"); but its s=
aying
> the same error. But when i do it manually in the same direcotory it w=
orks
>
> Manual pull, when am in the same directory.
> rndhyper1:/snaps4/searumugam/spec-repo/mydodo.repo 30> pwd
> /snaps4/searumugam/spec-repo/mydodo.repo
> rndhyper1:/snaps4/searumugam/spec-repo/mydodo.repo 31> git pull
> remote: Counting objects: 5, done.
> remote: Compressing objects: 100% (4/4), done.
> remote: Total 4 (delta 2), reused 0 (delta 0)
> Unpacking objects: 100% (4/4), done.
> From /snaps4/searumugam/spec-repo/mydodo.bare
> =A0=A0 cb9f659..2c5bca8=A0 master=A0=A0=A0=A0 -> origin/master
> Updating cb9f659..2c5bca8
> Fast forward
> =A00 files changed, 0 insertions(+), 0 deletions(-)
> =A0create mode 100644 final111223
> =A0create mode 100644 final1112233
>
> Am i doing something wrong, or should i execute 'git pull' in a diffe=
rent
> manner?
> hope you could help mein this.
>
> Thanks & Regards
> Senthil A Kumar
>

Like I say not exactly an expert. But it looks like when run in this
manner 'git pull' is unable to figure out the location of the .git
directory. Try something like.

system("GIT_DIR=3D$data_path.git; git pull");

There were some other replies to your original post that promising for
the cc-to-git-and-back aspect. Looking into them may save you a lot of
time.

Good luck.
