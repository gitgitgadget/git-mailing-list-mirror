From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Making git history strictly time safe
Date: Fri, 18 May 2012 17:58:10 +0530
Message-ID: <CAMK1S_g91K71hSo_N8Xz+s3Y1snfGH0e2Z4hpVsviwGZ9P_S0g@mail.gmail.com>
References: <2EDEF5ABBE208442B7547C8D36B9D8840C4A03@nawespscez09v.nadsuswe.nads.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600" 
	<brian.p.jones4.ctr@navy.mil>
X-From: git-owner@vger.kernel.org Fri May 18 14:28:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVMIT-0004s8-Fv
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 14:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182Ab2ERM2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 08:28:22 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41615 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762045Ab2ERM2L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 08:28:11 -0400
Received: by obbtb18 with SMTP id tb18so3897978obb.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4HDNnSD8xYY5E+I1L2DBVBkZ13TjfGULfvp4cINqkrU=;
        b=kuoaHn3fb279aL0qSAq0r5IvA2qasjUuZLKodMWC8VSVU1BSPCTVCVTjCXAFFqCo+B
         cS0cq/VcTCO9kKHAm0g/qXzXmDl+dQGQMQkeqUzSxemabw+zWXmMH5+0bKR6xOykkVvl
         kp82+FW8/C7RXBqzhe3crdnYBAlii5OGs5yc5cXJLupxMW2hpXkrtjv7IibRu6cQyoxM
         51MLmL6mfz/mkaXz6UlwUGOuPqt1Q7SVrrFMP2UYxRwOQ4LrRanGoI6mOCldNbJhW5op
         4tsCtH0Y3oGgQxrz3tN+VoaI2nlDJyrLi8dBn2gYTlIzOU531KMkZ9+kHnJG9uhZgAAk
         4WwQ==
Received: by 10.60.9.102 with SMTP id y6mr10212957oea.46.1337344090312; Fri,
 18 May 2012 05:28:10 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Fri, 18 May 2012 05:28:10 -0700 (PDT)
In-Reply-To: <2EDEF5ABBE208442B7547C8D36B9D8840C4A03@nawespscez09v.nadsuswe.nads.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197951>

On Thu, May 17, 2012 at 4:17 AM, Jones, Brian P CTR
SPAWARSYSCEN-PACIFIC, 63600 <brian.p.jones4.ctr@navy.mil> wrote:
> I am working towards git adoption on a project. One of the concerns i=
s the fear that git history is not guaranteed to be time safe. How can =
I configure a git repository so users cannot push or pull changes into =
it that change it's history? This includes keeping users who work direc=
tly in the repository from doing a rebase.
>
> I've found...
> http://stackoverflow.com/questions/2085871/strategy-for-preventing-or=
-catching-git-history-rewrite
>
> Which recommends setting...
>
> =C2=A0git config --system receive.denyNonFastforwards true
> =C2=A0git config --system receive.denyDeletes true
>
> ...Is this enough to guarantee time safe history?

Yes.

If you want something more fine-grained, you should consider using
gitolite.  For example you could say that only the master branch, and
tags whose names start with "v" followed by a digit (followed by
anything else) should be so protected, and that the other stuff can be
rewound if someone wants to.

http://sitaramc.github.com/gitolite/why.html shows you a couple of
simple use cases for gitolite, although it does not explicitly address
your situation.
