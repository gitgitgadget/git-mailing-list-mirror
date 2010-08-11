From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: With feature branches, what is ever committed directly to master
Date: Wed, 11 Aug 2010 19:21:05 +1000
Message-ID: <AANLkTi=b3UBYiLEZDPsjp-J6h-=hJXw7mLjQBx614Q0N@mail.gmail.com>
References: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
	<20100811065751.GA8808@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bradley Wagner <bradley.wagner@hannonhill.com>, git@vger.kernel.org
To: =?UTF-8?B?TWFnbnVzIELDpGNr?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 11:21:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj7Un-0003K9-NC
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 11:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab0HKJVI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 05:21:08 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43779 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab0HKJVG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 05:21:06 -0400
Received: by qyk36 with SMTP id 36so485147qyk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0EoiI2WhGyaWqRVcV584FHDvgpqkSKNsN45EUO+zvlc=;
        b=TDqtOHGTHZso3Es07Nu0ohhKZCyTVJAraH3TH/PREQ1p6Xw4esZUV/6HtS5DJEtlQ+
         BpsPAqbC/NZ3hjhpUfvK6wPDjyMUnII4gcXgI6VuQjXzupBE4MZiqnBoSn39hpAflgCD
         yEmDEJzUmKEIY1r4PJeBAj1SRMAaq/RKjuGsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hT4XiJP6hz2U1QocHmY0magGTOEbSWbfIN8M9ahVnGandK2dXxp6v3lNSn3l8uMj8Q
         e30hCzu3yd4JT+Lj2ypS1qGxOXWAin5e0UEXbmAzh73VpGGToieLXA1HRtEsuuka82ty
         jY1yhX4Dj1Gke9awCpiZHw5i2ZfpVH9DzdqDE=
Received: by 10.229.222.6 with SMTP id ie6mr9395844qcb.28.1281518465612; Wed, 
	11 Aug 2010 02:21:05 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Wed, 11 Aug 2010 02:21:05 -0700 (PDT)
In-Reply-To: <20100811065751.GA8808@jpl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153217>

On Wed, Aug 11, 2010 at 4:57 PM, Magnus B=C3=A4ck
<magnus.back@sonyericsson.com> wrote:

> Finally, bugfixes and similar smaller changes that don't make up a
> whole string of commits should probably not be developed on branches.

I think there is a case for _developing_ fixes on branches as opposed
to _sharing_ fix branches. In particular, it is good to minimize the
stuff that a fix drags along, so delivering a a fix to an integration
stream which is depends on the minimum amount of other cruft is good
practice. It also means the fix can easily be shared with other
developers even if it hasn't yet mean integrated into the main
integration stream.

This is where the idea of maintaining a private working branch
(described in an earlier e-mail) really pays off. You get to keep all
your unintegrated fixes in your working tree, but
you can freely share the stable ones with other developers and the
integration stream without reduced fear of creating a merge nightmare,
since you have taken care (in selecting the base for the fix) to keep
each fix isolated.

As to whether the team should maintain _shared_ feature branches this
does, as you say, depend on your circumstances. By _shared_ feature
branch, I mean a branch that has its own build cycle, test cycle etc.
Such things are expensive, and they get more expensive the more
complicated your delivery environment is. If your team and product is
small and nimble, it doesn't cost much to maintain the several loosely
coupled development processes. If it isn't, then you save a lot by
having a single integration stream that everyone bases their work on
since you can share that build and QA overhead across the entire team.

jon.

>
>> Is "master" really even unstable at that point?
>
> I guess that depends on your organization, your developers, and the
> maturity, architecture and inherent quality of the software. And, of
> course, how you define unstable. How bad can it be before it hurts?
> How would *you* weigh the risk of branching against the risk of
> developer slowdowns caused by frequent regressions?
>
> --
> Magnus B=C3=A4ck =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Opinions are my own and do not necessarily
> SW Configuration Manager =C2=A0 =C2=A0 =C2=A0 =C2=A0 represent the on=
es of my employer, etc.
> Sony Ericsson
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
