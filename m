From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git add -u nonexistent-file
Date: Mon, 8 Feb 2010 14:12:41 -0500
Message-ID: <a038bef51002081112s2d552835m4b34973f797ab4f8@mail.gmail.com>
References: <20100208182929.GB14355@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:20:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeZA0-0002m6-AC
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 20:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab0BHTUf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 14:20:35 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:62340 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab0BHTUe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 14:20:34 -0500
Received: by pzk2 with SMTP id 2so181146pzk.21
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 11:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=98RY0FR8564HwooHYhBSUebkYs8FuS9uQDjVhUG934U=;
        b=vW4Fa9pbn5MZbvpyvPEzbaCoyAyKID5QytRPMEi8e3bwca03N6OAQ7Pr0D2scw3WQJ
         LRTr1NTu0l+ZEnuHUSaaXuwkS05WR5QNL0tTmKFJtDUQzjIi9tZTyricUN/1q035g8ST
         9u0krIKLCmMmp4VXWHoQVv32ThD/J4EQWgRHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lvaY0R+dm0VfYNWyzqhL1n6i7IvGtJ2wv9FQvkOMZ0baAtORC/4Dyn6duheXkaWOHS
         u633CbEE3tkwmD3CRM/Bv0SlDhbeAz4h4e8a2+kr/5u9hEkxxP1TyLzuB9rEsV5+rK+5
         P+OesSiEghV+su/Vspl5+QasoF7bfvHoDaAcc=
Received: by 10.115.65.6 with SMTP id s6mr3669167wak.53.1265656361657; Mon, 08 
	Feb 2010 11:12:41 -0800 (PST)
In-Reply-To: <20100208182929.GB14355@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139305>

2010/2/8 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> Hi,
>
>
> $ git --version
> git version 1.7.0.rc1.84.g9879
> $ git add -u nonexistent-file
> $ echo $?
> 0
>
> No error message, no error in exit status.
>
> Is it OK this way? =C2=A0Why?
>
>
> Best,
> G=C3=A1bor
>

Hi,

I see the same behaviour with git version 1.6.4.2.

=46rom the man page of git-add

-u, --update
           Update only files that git already knows about, staging
modified content for
           commit and marking deleted files for removal.

So git will only look at files that are already in the repository.

It looks like in the case you've highlighted git is ignoring the extra
non-option parameters on the command line. I'll let other people argue
whether this is by design or omission.

'git add nonexistent-file' works as expected, exiting with an error
message and non-zero exit status.
