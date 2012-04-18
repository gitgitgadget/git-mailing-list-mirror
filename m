From: Kent Fredric <kentfredric@gmail.com>
Subject: Re: IRC discussion re: submodules & missing refs/heads/master
Date: Thu, 19 Apr 2012 09:22:12 +1200
Message-ID: <CAATnKFCoE6XXTB48Mvq-ay-j-1gyxxPBUvLM+REFWHLCsrTsVQ@mail.gmail.com>
References: <CAATnKFCAAwJYTx42iX5ZQ5-HrygFwUCWnKDNj0GDydwPYs-Nvg@mail.gmail.com>
	<CAATnKFDM5a9diHPg5QtS-jqEC1oYWL3a1dYnpwFLZK1UktgJAA@mail.gmail.com>
	<20120418211426.GA6920@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKcKQ-0006k2-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 23:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab2DRVWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 17:22:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60294 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab2DRVWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 17:22:13 -0400
Received: by iagz16 with SMTP id z16so10942095iag.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=a3ettLeUgoExYD/1PlA8JTjVn7Vrwy8ITq1Qh5OLOpI=;
        b=bH1ik82HBYiAg2mAUDzq3q+jdPNFHRiny4B1bXUVRk0iH7XZL9TI2koCh/y3dMI95X
         8EWbGaORZiOGp3+2mNPqozpNiK3G4qkixiou8Gbn+Arap+M8RROSFmeFFnqvBzeYVsOA
         1PAlomC6yrn6IpKgxGxfcNXkvHqRSvrqvRwcA0ILS4qSlk5pNu+7EJVEDYYKY+NW7TOQ
         Qx0PQWIttlW/SbIbWQpRcz57fFo1Zxe7H+eqx9eD5nsXOjtpyFeIZWQhuQc+fErZCoLp
         FHUh69HmIIElECbsf9f3Vy0cUGPeqcBKcNcYr9DyhDQxCTY4MJSZnlphlIJdsPR7uKo1
         NiyA==
Received: by 10.50.51.134 with SMTP id k6mr3439275igo.47.1334784132715; Wed,
 18 Apr 2012 14:22:12 -0700 (PDT)
Received: by 10.42.138.74 with HTTP; Wed, 18 Apr 2012 14:22:12 -0700 (PDT)
In-Reply-To: <20120418211426.GA6920@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195911>

On 19 April 2012 09:14, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> From the subject I deduce that you have a some problem involving
> submodules. Could you please clearly summarise what you found and
> possibly provide a recipe (script snippet) how to reproduce the issue=
?
>

The transcript was provided for context, after the transcript are
details of the problem and solution.

Summarised is as follows:

on 1.7.8.5 ,  running "git gc" while inside a submodule path removes
refs/heads/master  for that submodule in ~/.git/modules  , and for
some reason, sub-modules still require those files to work properly at
1.7.8.5 , ( which results in 'git status' bailing with 'oops' from the
main repo )

Migrating to a newer git makes the problem vanish, as the newer git
uses info/refs for both the main repo and the submodule, and the
presence/absense of refs/heads/master is unimportant.

Solving it is reasonably straight forward on 1.7.8.5, manually extract
the SHA1 from the modules info/refs file, and inject it back into the
relevant file refs/heads/master  , and things return to normal.


--=20
Kent

perl -e=C2=A0 "print substr( \"edrgmaM=C2=A0 SPA NOcomil.ic\\@tfrken\",=
 \$_ * 3,
3 ) for ( 9,8,0,7,1,6,5,4,3,2 );"

http://kent-fredric.fox.geek.nz
