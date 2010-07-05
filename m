From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: git log and cherry-picks
Date: Mon, 5 Jul 2010 11:09:20 +0530
Message-ID: <AANLkTik9FJ4skKOxH3x5QHqM1S5-6H4ae8MEPN1dnwab@mail.gmail.com>
References: <AANLkTil6-rd5y9xcTVz4kJ4O2jL9ZdXYo1JrgYA3sM6N@mail.gmail.com>
	<4C28F300.1060506@drmicha.warpmail.net>
	<AANLkTinSFdB28QpfcqAuVCFzho0P_H_MG6_i2ODKiWuD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 07:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVeP0-0007cG-2O
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 07:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab0GEFjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 01:39:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54064 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0GEFjV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 01:39:21 -0400
Received: by gye5 with SMTP id 5so1131038gye.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W4cJaMg/ZpZ747F3sUVXfIOfF4CX79Uk1Z1rCQjR87w=;
        b=AiCEi65akiffOQ1RAOpOwekK1PGdY56Cw6cpnVD7AENIXWVvKh6XYnginEYX+clTLw
         lPG9siEU4dN2yIKg+5Azns4XUV9QKCwV3eLHOVU1bbzQHFR43tkxb7FEIZTZKR1UbNGo
         LBZFfyq/d4Ji5/Tz6HhawylXNp4ao/9UwXRSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UiAELaXRBQe+HPiKa1NSl4TeUSgLIVViRL5IYnQyOt2tCTy/frLs+IVlI8SSF2Xcbv
         3Bnyu3B2Pcx8OlHDoCsIijS9DCF3JYQx5FthCHPfFnQbyc/liDAKkzKISZuWebe4z2jt
         AtiIyDoDkv+4tNhj1bFatIJRLmHMYim/D92rk=
Received: by 10.101.175.14 with SMTP id c14mr3071234anp.208.1278308360901; 
	Sun, 04 Jul 2010 22:39:20 -0700 (PDT)
Received: by 10.151.47.13 with HTTP; Sun, 4 Jul 2010 22:39:20 -0700 (PDT)
In-Reply-To: <AANLkTinSFdB28QpfcqAuVCFzho0P_H_MG6_i2ODKiWuD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150241>

Well, I typically leave the commit subject (first line) the same even
if I make minor modifications to a cherry-picked commit.

If that's the case with you, you can write a basic shell script that
looks at the commit message and discards duplicates.

Cheers
Antriksh Pany

On Tue, Jun 29, 2010 at 1:55 AM, Erez Zilber <erezzi.list@gmail.com> wr=
ote:
> On Mon, Jun 28, 2010 at 10:07 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Erez Zilber venit, vidit, dixit 28.06.2010 18:02:
>>> Hi,
>>>
>>> I saw that I can run git log with '--cherry-pick'. With this, if I =
run
>>> "git log --cherry-pick branch_a..branch_b", it doesn't show
>>> differences that are caused by cherry picks.
>>>
>>> My question is: sometimes, cherry picking from branch_a to branch_b=
 is
>>> not immediate, and I need to adapt the patch that was committed on
>>> branch_a to apply on branch_b. In other cases, git is able to apply
>>> the patch on branch_b automatically (e.g. if there's only a line
>>> offset). In such cases, will "git log --cherry-pick" ignore these
>>> cherry-picks like it ignores cherry-picks that were applied without
>>> any problem?
>>
>> With --cherry-pick, log omits those commits whose associated patch h=
as
>> the same patch-id (see "git patch-id").
>>
>> Michael
>>
>
> Is there another way to get over this (a commit that was cherry-picke=
d
> from branch_a to branch_b and had to be changed to be applied on
> branch_b)?
>
> Thanks,
> Erez
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
