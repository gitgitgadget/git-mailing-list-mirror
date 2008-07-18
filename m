From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [StGit PATCH] Test that we can add a new file to a non-topmost patch with refresh -p
Date: Fri, 18 Jul 2008 13:45:41 -0400
Message-ID: <9e4733910807181045mb19ab1dxaaa76696db294ddf@mail.gmail.com>
References: <20080718084127.GA7042@diana.vm.bytemark.co.uk>
	 <20080718170225.10086.17504.stgit@yoghurt>
	 <20080718180109.GA14825@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:46:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJu2X-0007oU-3x
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 19:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbYGRRpn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 13:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYGRRpn
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 13:45:43 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:6903 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbYGRRpm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2008 13:45:42 -0400
Received: by qw-out-2122.google.com with SMTP id 3so185977qwe.37
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=o+B+kqX8ctrsnPboLm6B0JGY1Vmam8VVR8f1TDxBjPU=;
        b=wFBuehwKreNZHTdhbziWJgNI+FsiIN4oWsPIr5m9TOEXJ3qk/7i6uyAZIU2ZXf7edw
         ra35sRl4y2bBh1ZFqwMnb9uRNHmravaxED9Itikjuzw5kTnlzNX3/+NErdO1A6t5r9BT
         ++xYyOcg20k3l+gj+hezC0jwUC52u0Aas0+d0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fw8nQcXH8Ypte0n6DQY4HBwDW7PZwFhdq0eEalKGBQZ08s5FsnfMUjCgBSeqvDQ3cC
         rc+HpZeeTbj4npxMMsZlpuH1BFK0Lr+ZLXjw+I8eh4h2fKt1AmkcxFBd0FD86yIKgLDA
         nnqQshst7PM7esO7nFB9B7e7A5HziHT3jBjbE=
Received: by 10.150.12.3 with SMTP id 3mr496239ybl.16.1216403141543;
        Fri, 18 Jul 2008 10:45:41 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Fri, 18 Jul 2008 10:45:41 -0700 (PDT)
In-Reply-To: <20080718180109.GA14825@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89063>

On 7/18/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-07-18 19:03:06 +0200, Karl Hasselstr=F6m wrote:
>
>  > We currently can't -- this is bug 12038, found by Jon Smirl. See
>  >
>  >   https://gna.org/bugs/index.php?12038
>
>  OK, the problem is that to pop the patches on top of the one we are =
to
>  refresh, we call pop_patch(keep =3D True). This in turn calls
>  git.switch(keep =3D True), which resets the index (but is careful to=
 not
>  touch the worktree).
>
>  I'm not quite sure how to fix this in a simple way -- the code simpl=
y
>  assumes that the index contains nothing of interest. And since I
>  already have a rewrite of refresh that handles this and a handful of
>  other cases that the old code does not, I'm kind of disinclined to
>  undertake a larger restructuring of the code.

It's no big deal to me, it is easy to work around. But it did take me
a while to notice that the add was missing.

When is the refresh rewrite going to be ready for prime time?

>
>  Catalin, what do you think?
>
>
>  --
>  Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
