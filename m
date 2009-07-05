From: Matt Pearson <404emailnotfound@gmail.com>
Subject: Re: git diff infinite loop at attempt to diff two specific commits
Date: Sun, 5 Jul 2009 14:22:00 -0400
Message-ID: <706b4240907051122s784e97abkde5628189956ceb0@mail.gmail.com>
References: <b33ba6660907051037ve9e4176s2a1edbda8af4068f@mail.gmail.com>
	 <20090705181208.GA8629@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Toresson <alexander.toresson@gmail.com>,
	git@vger.kernel.org
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 05 20:22:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNWLo-0004g6-EM
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 20:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbZGESV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jul 2009 14:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbZGESV6
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 14:21:58 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:47686 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbZGESV5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 14:21:57 -0400
Received: by fxm18 with SMTP id 18so3398094fxm.37
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d+ic2URBeaY7qakCBjvlkZvWIs+FtIs2aY2W7b1KJ3I=;
        b=NNFi08lcOHJiJ0TYcYfQSMKDdtW2gCt3Tf+X+TesEF5iBjHC7o3084a0YHP12Fh/MA
         R3dpUq19nfEP5CPJmoAk78UISHaAvMsg0ECIbSrMSKcE4DfKI1eUODGKE2v/0zS8b0Jt
         8IhsoT1a9qzEtdJVDcGJi8vOi6RPudKaypu+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pJhaee6fhH3auGsoPobKxAFZ9F67fC1J2fQKJ7VBeagozgPzCeb7Dzt5jZSofkVwlr
         /Qonb7zbfrDoa7hFNzgqBHdlWbrynNl92TyUmUU5UEA0j6V1kv94gFs2sIJFpg3ZHGdH
         T3GLxJJlk7JzquhSzNEcame6Sk2lyFnXphEH8=
Received: by 10.223.115.146 with SMTP id i18mr1630140faq.6.1246818120366; Sun, 
	05 Jul 2009 11:22:00 -0700 (PDT)
In-Reply-To: <20090705181208.GA8629@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122744>

2009/7/5 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.07.05 19:37:44 +0200, Alexander Toresson wrote:
>> Hello,
>>
>> I've got problems with git diff, it hangs in an infinite loop when
>> attempting to generate a diff between two specific commits. Commands
>> to reproduce:
>>
>> git clone git://eulex.zapto.org/nightfall.git
>> cd nightfall
>> git diff --stat 597711..61a139
>>
>> (Note that the clone needs to fetch 16mb)
>>
>> I'm running git 1.6.3.3.
>
> FWIW, it "hangs" on the save.xml file. The old version is 1.2M, the n=
ew
> one is 9M. Using the patience diff algorithm to compare them takes ab=
out
> 5 seconds here, while the default algorithm took 6m15s.

I can confirm this for the 1.6.0.4 shipped with Ubuntu Jaunty (so this
would seem to not be a recent change). Actually, it may be worse: mine
is still running after 8 minutes, and this machine is almost
brand-new. Normal diff -u on the two versions of the file finishes in
under a second.

On an unrelated note, it's usually a bad idea to have files like
configure and *.suo in the repo (and possibly this save.xml as well).
