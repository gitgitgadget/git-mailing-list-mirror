From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: inconsistent detached worktree handling: several bugs
Date: Wed, 7 May 2008 10:15:09 +0200
Message-ID: <8aa486160805070115k676b03a6s59d3a74d48d44254@mail.gmail.com>
References: <20080505160643.GA28318@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git discussion list" <git@vger.kernel.org>
To: "martin f krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed May 07 10:16:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jteon-0005aY-Gf
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 10:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbYEGIPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 04:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755378AbYEGIPN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 04:15:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:37827 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbYEGIPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 04:15:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so99440ywe.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iRUs5AJl8R1cIULe1bwD0/fyq4IQgieAwSQnsfO2Zuw=;
        b=YepMmpgcErASCe+IUg2SLW/tBjMppXBmGLZe+LAUABpnHy7Onli57ElFlxMhycgs4pcrYW/ZjLniB67ngWBU201bqPT1f8s9Uv8IyninZF2F/YomYRX0cHS6S90fvniWEI8SXYwXNPB+tKuCEHilew59+XFdlCPF2zT0XuEqOY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zrk92OOpaRouoR/FBZkOcIf1uY9zKLoH0udZPXCqyKDE0MuqSDXKBErpaPYjonK/wGyuyls51l7ua6SewKenELtJBcD+2dDVlg/wKzGUdK0wj+QCSjHmbozFcd+04aaSPBn/SbVHM7WiSarpBj+sR5C930MzwX/kZj0Ws0oSbiI=
Received: by 10.150.52.2 with SMTP id z2mr1712996ybz.44.1210148109605;
        Wed, 07 May 2008 01:15:09 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Wed, 7 May 2008 01:15:09 -0700 (PDT)
In-Reply-To: <20080505160643.GA28318@lapse.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81414>

On Mon, May 5, 2008 at 6:06 PM, martin f krafft <madduck@madduck.net> wrote:
> I am playing around with detached worktrees and have identified
>  a number of bugs in the path handling. Specifically, it seems that
>  while git-status and git-add/git-rm are consistent with respect to
>  each other, they expose different behaviour in different scenarios.
>  git-diff, on the other hand, seems broken with respect to worktree
>  handling.
>
>  Let me run you through what I did, bugs are
>  identified with ###BUG. Output is prefixed with #, which should make
>  it easier to cut-n-paste to reproduce
>

I don't know if it resolves all the issues, but:

- If run outside of the working copy => equivalent to run it from the
top of the wc.
  (for the normal case it just fails)

- It is not recommended (supported?) to have the repository inside the
working directory
  (unless it is .git, of course)

Santi
