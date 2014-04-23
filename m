From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 04:07:37 -0500
Message-ID: <535782d95bbed_24448772ec7a@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
 <53558f6269f91_640076f2f08f@nysa.notmuch>
 <857g6h5ssh.fsf@stephe-leake.org>
 <5356996d12ede_3e5aed7308e5@nysa.notmuch>
 <85mwfc4hab.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Stephen Leake <stephen_leake@stephe-leake.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 11:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WctJl-0007lP-HM
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 11:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbaDWJSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 05:18:05 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55909 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaDWJSD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 05:18:03 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so718532obb.19
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=zs8YpuEm/GRz9fmG4CAs9Nczs0YaJ5ozSER3S3AB20U=;
        b=itPCAiRru1id2Ih8D30PPaAae6OzS/zf7pwdr/kJYniLR+fmapmSaXxT0SE7uSYJEF
         Dn3DqNJKSG4hbI9kfin0rjJ/iLcAAMHx/Nx+twEIL0Z0BF0OG/trovZhTm04ako7zD+K
         s80f4/Ne6hXILOqNyNPElBQBC2HOY1PNPyIwnnap62hAkyQPGJZSAq70XRbSSS9JYQUi
         VPVUt9vHQsv9P4cdD/79eGJ3ZB2luO3dWP0x/PR34QRigao1B4SUWSnK3plissuHDmmt
         AD2y9T87IyFwzS5Xx5wl+Tv6nGvT5627cstCmvivfsRdccticPGhCb0z1i6mGeoA1vMt
         2R7w==
X-Received: by 10.182.29.33 with SMTP id g1mr6681578obh.53.1398244682038;
        Wed, 23 Apr 2014 02:18:02 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dg2sm675834obb.17.2014.04.23.02.18.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 02:18:00 -0700 (PDT)
In-Reply-To: <85mwfc4hab.fsf@stephe-leake.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246817>

Stephen Leake wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Stephen Leake wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > Ilya Bobyr wrote:
> >> >> On 4/21/2014 2:17 PM, Felipe Contreras wrote:
> >> >> > Ilya Bobyr wrote:
> >> >> >
> >> >> >> Also, most have names that start with either "pre-" or "post-".
> >> >> >> It seems reasonable for both "pre-update-branch" and
> >> >> >> "post-update-branch" to exist.
> >> >> > I don't see what would be the point in that.
> >> >> 
> >> >> Do you see the point in the other hooks doing that?
> >> >
> >> > Yes, there a reason for the existance of those hooks. Now tell me why would
> >> > anybody use post-update-branch instead of pre-update-branch?
> >> 
> >> I have a branch which should always be recompiled on update;
> >> post-update-branch would be a good place for that.
> >
> > And why would pre-update-branch not serve that purpose?
> 
> Because the code that needs to be compiled is not yet in the workspace

And it won't be in 'post-update-branch' either.

 % git checkout master
 % git branch feature-a stable
 <- update-branch hook will be called here

The hook will get 'feature-a' as the first argument, but the code in the
workspace would correspond to 'master'; the checked out branch (pre or post).

-- 
Felipe Contreras
