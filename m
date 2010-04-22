From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Thu, 22 Apr 2010 17:48:34 -0400
Message-ID: <x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	 <20100422155806.GC4801@progeny.tock>
	 <87wrvzs590.fsf@frosties.localdomain>
	 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	 <87sk6n4426.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 22 23:48:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O54GJ-00053y-1I
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 23:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab0DVVsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 17:48:37 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:43149 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0DVVsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 17:48:35 -0400
Received: by bwz25 with SMTP id 25so10237071bwz.28
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e4BM8w3xccq6JChrG6W0yQq/AxafaR8TpDJodf2vMeM=;
        b=xgbVQs6J50jC43uGTO7sTfJRAsSwtCs0/4jmX5juw549F0dP1miKDiCbP+b4VIGsd+
         eRAPT2vaJXswIf6iAtZyiHju4dbrgtstCKrUSIS1qRXc3ENPuLpoU99yCun3XgH7K+w5
         ofvHCy8Zxt2K4V//eEweh34TqA4o5j2kY9zOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QTyeMT02XiybsNBH+pOh1nAC9XiAtUwTGR+wqwD/XcjjXEzcFFKiaqPdD1qjkihFri
         44it87KvUlgQbJwNrBdzGKylTBtRvuOkK+1KPuOXAyrtlvjfIFd4fOr/I+o9nqjqLRdz
         JRNkMZl39XJRlZUHUnvnG+3U020YyoTM5/COg=
Received: by 10.204.71.20 with HTTP; Thu, 22 Apr 2010 14:48:34 -0700 (PDT)
In-Reply-To: <87sk6n4426.fsf@frosties.localdomain>
Received: by 10.204.134.70 with SMTP id i6mr1467311bkt.74.1271972914091; Thu, 
	22 Apr 2010 14:48:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145568>

>> What _you_ can do though, is this:
>>
>> =A0 =A0 =A0 git config --global alias.ci "commit -a"
>
> But then when I accidentally use 'git ci' while having an index the
> index gets ignored and all changed files get commited in one big mess=
=2E
> Given how seldom I need an index (so far never) the risk of using 'gi=
t
> ci' accidentally is way to high. Same with typing -a. I do it so ofte=
n
> that when I actualy don't want it I will probably type it anyway out =
of
> habbit.
>
> My way would be safe in that it will never ignore an index if there i=
s
> one. And if it is a new option then it would not alter the existing
> semantic, just add to it. Call the option --smart-a or --a-if-empty.
>

Consider

$ echo -e '#!/bin/bash\nif git diff-tree --quiet HEAD; then git commit
-a; else git commit; fi' > `git --exec-path`/git-ci
$ chmod 555 `git --exec-path`/git-ci

Adam
