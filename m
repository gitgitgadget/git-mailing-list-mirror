From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: Re: merge result
Date: Sat, 10 Sep 2011 09:11:42 +0800
Message-ID: <CAPgpnMTMPQQPkS-gKLvUJNKLfMWuAT-oA3NCiSRFxu7PknYsnA@mail.gmail.com>
References: <CAPgpnMRrSmVrXD__jxv3uNrek8up+scHp+_Kj8+=HX8tfweWzQ@mail.gmail.com>
	<vpqmxed6fby.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Sep 10 03:11:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2C6p-00040l-C9
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 03:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab1IJBLp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 21:11:45 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:44246 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410Ab1IJBLo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 21:11:44 -0400
Received: by vws10 with SMTP id 10so2196415vws.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 18:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nlBmTf0MuGpbfgWjG5sqaUffOCNZzdwZvdf2+72vSqM=;
        b=lIAdKwtQKrpZq5X9XUseIGIbnFOmetmAfzon7ufRyluoL1qDXsM8Ttd+M1EMcVAybJ
         /yHAIN6GsYk6zjMETiugdBGAO4xRycN84SucZ2WUjyY7PgDd2xXprahvuAjumFkt1Weg
         rzvzWTLyc+xKxzU39xZWbX86uZPKPTgkjff5s=
Received: by 10.52.70.106 with SMTP id l10mr366737vdu.483.1315617102280; Fri,
 09 Sep 2011 18:11:42 -0700 (PDT)
Received: by 10.52.166.6 with HTTP; Fri, 9 Sep 2011 18:11:42 -0700 (PDT)
In-Reply-To: <vpqmxed6fby.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181133>

On Fri, Sep 9, 2011 at 9:00 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Lynn Lin <lynn.xin.lin@gmail.com> writes:
>
>> Hi All,
>> =A0 =A0When I merge branch A back to master branch,if there are same
>> commit(developer do double commit) both in master and A branch, ther=
e
>> will be two same commit in master branch.
>
> They cannot be the "same" commit. They are different commits (i.e.
> different sha1 identifier, and probably different trees), even though
> they may have the same commit message and represent the same diff.
>
>> =A0 =A01->2->3-4>5 =A0 =A0 =A0 =A0Master
>> =A0 =A0 =A0 =A0|
>> =A0 =A0 =A0 =A04->6->7 =A0 =A0 =A0 =A0 =A0A
>
> A more accurate drawing would be
>
> =A0 =A01->2->3-4>5 =A0 =A0 =A0 =A0Master
> =A0 =A0 =A0 =A0|
> =A0 =A0 =A0 =A04'->6->7 =A0 =A0 =A0 =A0 =A0A
>
> and after merging, you'd get
>
> =A0 =A01->2->3-4>5-->8 =A0A, master
> =A0 =A0 =A0 =A0| =A0 =A0 =A0 /
> =A0 =A0 =A0 =A04'->6->7
>
> with 8 having both 4 and 4' as ancestors. There's nothing wrong with =
it.
> Git cannot remove either 4 or 4' without rewritting history, and "git
> merge" does not rewrite history.
so confused here.If 4' is just next 4 commit,how can the diff work? for=
 example

1->2->4->4'->6->...

 diff 4 and 4' is a little confused,correct?


Thanks for your time to explain here and teach me

> If you really really want to avoid this duplication in the history, t=
hen
> learn about rebase (which is both powerfull and dangerous, you've bee=
n
> warned).
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
