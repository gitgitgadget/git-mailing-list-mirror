From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: Finding all branches(remote and local) include given commit?
Date: Sat, 12 May 2012 21:25:44 +0900
Message-ID: <CAFT+Tg-cYCatcaP3fR7X7+GnpazUb3ys96A5AP6HTjvD_=+UyQ@mail.gmail.com>
References: <CAFT+Tg9nJZ7E3FB3nA6+_TR=KUqu80128rL8b2DuRGtBavsj-Q@mail.gmail.com>
	<1336824434.3002.17.camel@centaur.lab.cmartin.tk>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat May 12 14:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STBOS-0000es-0r
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 14:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab2ELMZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 08:25:46 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39706 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab2ELMZp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 08:25:45 -0400
Received: by obbtb18 with SMTP id tb18so4611126obb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 05:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=mueo0BYkBWtWbQg1y8BFsmei4ugKlzTJWdugxnXSnFg=;
        b=F2M2GyJlKkDi1FSVfGe1SoO5jxZu/yUJr5Lvtm5rm8SCnyikapUicwWqoICks8Flu3
         JfgEMLMw/qqFVnI8PM1KTyjF9fCzkISw2vfaFL0Q3ENz2SF4Erlb95TLzdinRJ1ofxoA
         D1knVQNXPGI4tX1mVE+pqYUuU8z42tOxUhyP1pOMVwmybwhD6KYxo783LyF5XOK3yH2p
         k225mUrTl7Sl6O3yIc1/5tybTGzVXfMIjWOEy5XBz3ZV5kItepl2N20fqH7wgbFaHoT3
         Rp7L8nGfJcnRXrQ/AxxDsLwRFNFXq0DFfzbdAFq5Top6k4X4zuk0ErwD3jWFe4hmbE4l
         lGlw==
Received: by 10.182.154.73 with SMTP id vm9mr2395383obb.72.1336825544910; Sat,
 12 May 2012 05:25:44 -0700 (PDT)
Received: by 10.182.53.39 with HTTP; Sat, 12 May 2012 05:25:44 -0700 (PDT)
In-Reply-To: <1336824434.3002.17.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197730>

Wow, I should do like this:

$ git branch -a --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e73d6f
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/next
  remotes/origin/pu

git-branch has '-a' but not '-all', and git-remote has '--all' but not =
'-a'.

This is a bit confusing for me. Why don't the two commands have the
option under the same name?


2012/5/12 Carlos Mart=EDn Nieto <cmn@elego.de>:
> On Sat, 2012-05-12 at 20:42 +0900, Yi, EungJun wrote:
>> Is there any way to find remote and local branches include given com=
mit?
>>
>> e.g.
>>
>> $ git branch --all --contains 499e7b31509cfbb59dcb2a046f8e2fd1a3e73d=
6f
>> * master
>> =A0 remotes/origin/next
>>
>> As you know, it does not work and "git branch --contains" finds only
>> local branches.
>
> Works For Me. What version are you trying it with? Are you sure that
> remote-tracking branches do contain that commit?
>
> From a quick look through the log and release notes, it was never
> mentioned as a fix. The log contains 3f7701a4 from 2007 which fixes '=
git
> describe --all --contains' which, though unlikely, might be related.
> This commit was however part of release 1.5.4, which makes it unlikel=
y
> you'd be using something older.
>
> =A0 cmn
>
