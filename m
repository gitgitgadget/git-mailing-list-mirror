From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Building GIT on HP-UX: "make test" fails
Date: Mon, 3 Aug 2009 16:54:00 +0200
Message-ID: <81b0412b0908030754l553ddac2y4c2e7f9fe606e67a@mail.gmail.com>
References: <4A76DDEE.6699.119A5FD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Mon Aug 03 16:54:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXyvd-0006uV-2y
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 16:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbZHCOyE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbZHCOyE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 10:54:04 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64285 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175AbZHCOyC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 10:54:02 -0400
Received: by fxm17 with SMTP id 17so2679112fxm.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xvIBG/2HMmGKPvuzIQYT1QWkm0B8OzNXBmQcCa/646w=;
        b=FxDFBtLVVAJzym9B6w3E66PD+GVCFItNFzDRxDO7Zd98DrtkhiCcn2suxK0NyK/XKe
         0GffEwJfrXcmA0Cc2U7ghuiFu0feJxG/z/G0CkfjkpDQdNqNQVP6lr8EgGFcG+JQCKhV
         1QO6xq6o2ionIYSUNXS5DO8xLFUDo3v7wzhlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gjIkVXTxr2kaVcMFs4E+0pxa6tyWf1YR9iNvKq7Pmuq5ubvKkv2eo3dFan/I78t6QJ
         tSMzMKpQOTjKIQLf9Me0Xr7oqwWeDROh1DMz0My//bEvEpweho2FVOVbjZ2WBQh0pi3R
         C4huE679mSLB98w2QOJTsRptPJLKa2KgxSsZc=
Received: by 10.204.100.10 with SMTP id w10mr263139bkn.211.1249311240809; Mon, 
	03 Aug 2009 07:54:00 -0700 (PDT)
In-Reply-To: <4A76DDEE.6699.119A5FD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124696>

On Mon, Aug 3, 2009 at 12:54, Ulrich
Windl<ulrich.windl@rz.uni-regensburg.de> wrote:
> Here is the end of "make test":
> [...]
> *** t0100-previous.sh ***
> * =C2=A0 ok 1: branch -d @{-1}
> * =C2=A0 ok 2: branch -d @{-12} when there is not enough switches yet
> * FAIL 3: merge @{-1}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout A=
 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit B =
&&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout A=
 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit C =
&&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git branch -f =
master B &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git branch -f =
other &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout o=
ther &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout m=
aster &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git merge @{-1=
} &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git cat-file c=
ommit HEAD | grep "Merge branch 'other'"
>
> * FAIL 4: merge @{-1} when there is not enough switches yet
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git reflog exp=
ire --expire=3Dnow &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -=
f master &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --ha=
rd B &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git branch -f =
other C &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout o=
ther &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout m=
aster &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail=
 git merge @{-12}
>
> * failed 2 among 4 test(s)
> make[2]: *** [t0100-previous.sh] Error 1
> [...]
>
> I can try some simple things fixing the problem, but I don't have an =
Internet
> connection at that machine.

Try:

  $ cd t && ./t0100-previous.sh -d -v -i

Look at the output and if you can't make anything out of it,
just post it here.
