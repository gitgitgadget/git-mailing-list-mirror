From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: Bug: t5813 failing on Cygwin
Date: Sat, 7 Nov 2015 23:24:49 +0000
Message-ID: <20151107232449.GX14466@dinwoodie.org>
References: <563DEA71.1080808@dinwoodie.org>
 <20151107184527.GA4483@sigill.intra.peff.net>
 <20151107192029.GW14466@dinwoodie.org>
 <1446930165.16957.9.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Sun Nov 08 00:25:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvCr3-0005hO-G4
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 00:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933166AbbKGXYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 18:24:55 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37882 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933124AbbKGXYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2015 18:24:53 -0500
Received: by wiva10 with SMTP id a10so14457357wiv.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2015 15:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gMwmdR1pR6qoUn0uiYjbC5Uy+3PFbv0ZYXep7s27e5c=;
        b=Y+hwpgSWS3n5nrX6Mse1ae7vA4zQUYCnuGdtoR+WsFuKn8Vi4f7iIieIQHfIpaojZt
         1UgDzrOjfoMTUw/Ea1HAeP2sH0pdNfNy9PheCmmBUi2dXFa829bngSLssaiv8NWUhSnX
         u+PHr0DbhNAtiQ3+j+QxzjPgGW8IemQKcErmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gMwmdR1pR6qoUn0uiYjbC5Uy+3PFbv0ZYXep7s27e5c=;
        b=KFLJuYQEyF2Up1/6avopXp5BjJ5jvPAE510F+KoKMHLuZgBkNSMzhMHAp3BDnJ6OHQ
         Xz7dVUV055KLW4u003rhTS4yIR4g/Mt5HlqMunvZSsQrK1OuRUMWxmW1nYyuj9wSdQSG
         NnWBY3eB3E05LNoIgF3+5zVxbaCk9qL7ODdRO1awg+ZZFLZfU8QKm6sAOKfCE2Cu0+a8
         yl9DrW6QuAxFKCBXNmSO4vIHx0YWHepqcWoByV+K3HXe9Y4TBppEFCFdwFEPvAvT8V6g
         uGV6HkmhDonmT78ZJjZjE0JRN08lhIl11czk3txmEzSRpQ62RnPKt/YgnLyjJ81GwGxz
         Heew==
X-Gm-Message-State: ALoCoQlbvk/zYo2nV2h4Km7bLYYKXhFTnown3Hc8Z++whd4DEBFwNhmg0g0MOlDiG6Ni+OxQb3l1
X-Received: by 10.194.11.67 with SMTP id o3mr1394294wjb.3.1446938692080;
        Sat, 07 Nov 2015 15:24:52 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id jh4sm7246187wjb.33.2015.11.07.15.24.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 07 Nov 2015 15:24:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1446930165.16957.9.camel@kaarsemaker.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281026>

On Sat, Nov 07, 2015 at 10:02:45PM +0100, Dennis Kaarsemaker wrote:
> On za, 2015-11-07 at 19:20 +0000, Adam Dinwoodie wrote:
> > On Sat, Nov 07, 2015 at 01:45:27PM -0500, Jeff King wrote:
> > > On Sat, Nov 07, 2015 at 12:11:29PM +0000, Adam Dinwoodie wrote:
> > > 
> > > > Specifically, I'm seeing t5813 subtests 9-13 and 15-19 failing.
> > > > This happens
> > > > with a clean build straight from the Git source tree (git clean 
> > > > -dfx && make
> > > > configure && ./configure && make && cd t && ./t5813-proto-disable
> > > > -ssh.sh) as
> > > > well as builds using the Cygwin packaging paraphernalia.
> > > 
> > > What does the output of "./t5813-proto-disable-ssh.sh -v -i" show?
> > > 
> > > It seems strange that it would fail only on Cygwin; this code
> > > doesn't
> > > really use any platform-dependent features. It's also weird that it
> > > fails _only_ for ssh, and _only_ on the tests that are using
> > > "ssh://"
> > > URLs are not "host:path" syntax.
> > 
> > Ah!  I thought I'd checked that already, but looking at the output
> > now I
> > can see what's going wrong.  Cutting down to the relevant error:
> > 
> >     ssh: remote git-upload-pack '//home/Adam/vcs/Cygwin-Git/git-2.6.2
> > -1.x86_64/build/t/trash directory.t5813-proto-disable
> > -ssh/remote/repo.git' fatal: '//home/Adam/vcs/Cygwin-Git/git-2.6.2
> > -1.x86_64/build/t/trash directory.t5813-proto-disable
> > -ssh/remote/repo.git' does not appear to be a git repository
> > 
> > Note the '//' at the start of the path -- on most *nix systems '//'
> > is
> > effectively identical to '/'.  On Cygwin, however, '//' is used to
> > access Windows UNC paths: what Windows calls "\\server\share", Cygwin
> > calls "//server/share".  If you replace the '//' with '/' you get the
> > locatoin of the repository; but here Cygwin is looking for the
> > repository in a share called "Adam" on a network server called
> > "home"...
> > 
> > I suspect the correct fix here is to fix whatever's causing Git to
> > generate a path with that '//'.  If nobody else gets to it soon
> > (probably on the order of a week before I'll get the chance), I'll go
> > code diving and submit a patch.
> > 
> > > I tried building on Linux with the Cygwin build knobs found in
> > > config.mak.uname, but I couldn't get it to fail. I also wondered if
> > > the
> > > test was doing something with the shell that might not be portable,
> > > but
> > > I don't see anything interesting.
> > 
> > If I recall correctly, the correct interpretation of '//' isn't
> > defined
> > in POSIX, so whatever's causing that path to be generated is the bit
> > that's not fully portable.  It looks as though t5813 throwing this up
> > is
> > just a coincidence rather than it being particularly related to the
> > function those tests are actually testing.
> 
> Looks like lib-proto-disable.sh's fake SSH doesn't strip double leading
> /'es from the path. Try this patch:
> 
> diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable
> -ssh.sh
> index ad877d7..a954ead 100755
> --- a/t/t5813-proto-disable-ssh.sh
> +++ b/t/t5813-proto-disable-ssh.sh
> @@ -14,7 +14,7 @@ test_expect_success 'setup repository to clone' '
>  '
>  
>  test_proto "host:path" ssh "remote:repo.git"
> -test_proto "ssh://" ssh "ssh://remote/$PWD/remote/repo.git"
> -test_proto "git+ssh://" ssh "git+ssh://remote/$PWD/remote/repo.git"
> +test_proto "ssh://" ssh "ssh://remote$PWD/remote/repo.git"
> +test_proto "git+ssh://" ssh "git+ssh://remote$PWD/remote/repo.git"
>  
>  test_done
>  

Confirmed this patch has the test running successfully for me.

Adam
