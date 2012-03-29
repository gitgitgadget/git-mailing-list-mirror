From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-svn: cloning an SVN repo with sub-branches and sub-tags
Date: Thu, 29 Mar 2012 21:02:05 +0530
Message-ID: <CALkWK0mn=vWexhYMNPV5iKf-hX5gTHYjOS4o+E1mFjUtL49hmg@mail.gmail.com>
References: <4F7467E1.3090004@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Pocock <daniel@pocock.com.au>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:32:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDHL0-0000XU-AG
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 17:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933426Ab2C2Pca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 11:32:30 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:41074 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608Ab2C2Pc2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 11:32:28 -0400
Received: by wejx9 with SMTP id x9so1085426wej.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FXYxeT5R36Yy5LjGW68l7kT9OnSObPIobqk5ep1fb64=;
        b=PWew2JleeRIpwV0waHisL1UG66bXC500uB0c30dBL/fLk4cTePkClWP1KOxIgIiF9k
         ug354Dy4jBDj6vKAx5QawL4uRZ4tn082dsXU5gM9vvC9fEk/v/dp2OyWEIOhMpyzCsvi
         ff+3NgNcWlhy8ARnk554haMxYSrFTQU2/OcnhyUBd+Zaaeu2r7X1he1tCcC18qV6daP5
         3xc8UXK7Cg9NjEvHxbD7ikTi/jvi0ug9uIFhFvcLOAVfZBGUp1tn5bc5rRTDYjez8leY
         Eb2onrtMr72d1cqzPlWTtEZWISsj+0mOUgjKQTqXs9mhU8EcWhXjeXTM35OAxkOY0rNv
         NDlQ==
Received: by 10.180.102.101 with SMTP id fn5mr6677175wib.6.1333035146085; Thu,
 29 Mar 2012 08:32:26 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Thu, 29 Mar 2012 08:32:05 -0700 (PDT)
In-Reply-To: <4F7467E1.3090004@pocock.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194262>

Hi Daniel,

Daniel Pocock wrote:
> git svn clone \
> =C2=A0-T trunk \
> =C2=A0-t tags \
> =C2=A0-b branches \
> =C2=A0https://flactag.svn.sourceforge.net/svnroot/flactag \
> =C2=A0flactag-git1
>
> I don't get any of the branches or tags, and I get numerous warnings =
like
> this:
>
> W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.cc
> W: -empty_dir: branches/d_pocock/autotools/HTTPFetch.h
> W: Cannot find common ancestor between
> f475b655c10b55b36df8376a396c0d9534418617 and
> 7e277bfd626a1caa84681e93a7af73e0160eb2eb. Ignoring merge info.
> W: Cannot find common ancestor between
> f475b655c10b55b36df8376a396c0d9534418617 and
> a82cd9bd2197a89303558af9aad43fa0c23d1ddb. Ignoring merge info.

These look like genuine warnings; git-svn probably doesn't like your
repository (nested branches/ tags, missing mergeinfo etc)

> I have the impression that git-svn does not like the repository layou=
t, and
> it is not clear from the manual page how to make it work. =C2=A0Can a=
nyone share
> any advice about this?

Off the top of my head, you could try doing two things:
1. Try exporting the branches and tags by hand one-by-one.
2. You could try using reposurgeon [1] to fix the repository.

[1]: http://esr.ibiblio.org/?p=3D4071

    Ram
