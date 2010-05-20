From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Three-tiered VM development setup with support for branch 
	switching
Date: Thu, 20 May 2010 08:37:45 +0000
Message-ID: <AANLkTilIhuE06gVSO8cM_iLtixxBUX7DxrSlUbaCvmUs@mail.gmail.com>
References: <AANLkTinQJLsS6N_d2hsfwbibEuKiUHi9FAnrb5K4Frih@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Burke Cates <burke.cates@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 10:38:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF1GX-0005uU-GP
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 10:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab0ETIhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 04:37:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51605 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab0ETIhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 04:37:46 -0400
Received: by iwn6 with SMTP id 6so4046335iwn.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=vbvCXqmlqBJE87+RXN8uNLx76d99a4VxHy70E80jvi0=;
        b=szFvABna2E8MOHaGy3/rq/+1KrXpUVxVe+861OZblEN2y/oCPwfrXsu+aJ3YjVuK8S
         4yHx/Ahzc+jH7WNPOvq3UXidHGRRtrW7M+tto2VznslwmHoHlH8s0PPRyGGeUo9ynLuX
         PQRwkhqs1owzm5OBI9NwWd+cyjf9M8cIBi5sA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NYwQJ90ByOgFOGb6DBm9i1kyKu6zajpgA1Zn5S/xNrAEmeaaVlNqIXv7HfHYu9Qghk
         Dn80Xvv9nNDtcOiVrJ2rJYRHlN0PLRdUhPsoaY4yc3DN2aT9ke8Lj58pxsteT7rAGF9K
         nqV/gdd4F94GGqkFRHpFJsJxYg+kA0O3Emz98=
Received: by 10.231.157.200 with SMTP id c8mr725214ibx.53.1274344665362; Thu, 
	20 May 2010 01:37:45 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 20 May 2010 01:37:45 -0700 (PDT)
In-Reply-To: <AANLkTinQJLsS6N_d2hsfwbibEuKiUHi9FAnrb5K4Frih@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147363>

On Thu, May 20, 2010 at 00:59, Burke Cates <burke.cates@gmail.com> wrote:
> The only solution I can think of involves ripping the branch out of
> the refspec that is passed to the hook and using that to call checkout
> and pull (or possibly a checkout -b --track newbranch if I dont have
> the branch locally on prime). I feel like this is a pretty nasty hack,
> but I might be missing something completely that would make this sort
> of setup much easier to pull off.
> What I'm trying to pull off here is this: devs can code at their
> workstations with whatever tools they want, and push changes to the
> VM's with git. Hooks will be used to initiate makes for testing and
> for pushing changes to other nodes in the test-cluster (who will have
> the same make hook). The only obstacle at this point is the branch
> switching.

If I'm not mistaken the plumbing commands like git-commit-tree allow
you to make commits without switching branches. I.e. they just record
raw data in the repository and don't care about your checkout.
