From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch 
	when appropriate to do so
Date: Tue, 6 Oct 2009 12:43:28 -0400
Message-ID: <76c5b8580910060943k6172e3a5waee2f92c403e5cc3@mail.gmail.com>
References: <237967ef0910060241q671baafav93fe6402a4c510c5@mail.gmail.com>
	 <0016e68fd0123a175304754694b4@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Euguess@gmail.com, git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 18:52:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvDGa-0003of-Un
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 18:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbZJFQoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2009 12:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbZJFQoI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 12:44:08 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:51523 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbZJFQoG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2009 12:44:06 -0400
Received: by ywh3 with SMTP id 3so4134738ywh.22
        for <git@vger.kernel.org>; Tue, 06 Oct 2009 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xKlY+WXoCKn/lkIL7d/BmSrsgeF+JBQu5jDoCi7B0qk=;
        b=gsf3g/l+wmz0o6IUDvvgpHjBv7WZ5hxoCGl/hKCqyWl7o/j4lDz4kQQI69jTSiLW7l
         6WkeBE6qJr4IBcOk7+hCUgQDCYozPuZfL3vEwkMuJHInRBjCVGr9NIGQ1CwEDycMd6x5
         Eo4o3AMF7FuieplWfc9WqnUCFcOuyM4Cah/FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J8T9gFTCxrF/fR1+lW9n9YXD5fLhVQdYg+YajObonTF5xJrsDYWDiqXRmGHF8/2wVz
         xVchEgmXRuvRgoJsZYih2OxNd7DP0pxkk3CNTkfzmFbwhpCuRyM32HnVXN7aAhW3gELH
         JLMRerrHvjaK+zpPgOprxvg7RQdgPXsBtHRWs=
Received: by 10.91.191.17 with SMTP id t17mr830127agp.51.1254847409014; Tue, 
	06 Oct 2009 09:43:29 -0700 (PDT)
In-Reply-To: <0016e68fd0123a175304754694b4@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129631>

It seams that my first email was eaten by the server for some
reason... Sorry, if it will be a dupe.

On Tue, Oct 6, 2009 at 12:18 PM, =C2=A0<Euguess@gmail.com> wrote:
 Hi,

 If i may have a word:

> On Oct 6, 2009 5:41am, Mikael Magnusson <mikachu@gmail.com> wrote:
>> I can imagine this happening:
>>
>> % git clone git://git.git git
>>
>> % git checkout next
>>
>> do you want to checkout origin/next? y
>>
>> # a few days later
>>
>> % git fetch
>>
>> % git checkout next
>>
>> [freenode] /join #git
>>
>> [#git] i did git checkout next but my files are still the same?
>>


 I'm a new user of git and I don't think i will ever have a commit in
 git.git, because I'm not a programmer (I'm QA). I was reading this top=
ic as
 carefully as i could and I think that this makes a lot of sense to add=
ress
 this issue. As i understand when somebody fetches from remote repo in =
order
 to be able to start working on the code from this remote repo you shou=
ld
 create tracking branch for one of the branches from remote and only th=
en you
 should do your changes or perform merges.
 in case if you didn't do that and you try to checkout you will end up =
having
 detached HEAD which is quite scary;) for non-experienced user and as i=
 see
 might lead to some unnecessary questions in this list or on IRC channe=
l...
 As for the solution i would choose the "simplest thing that will work"=
 - so
 i think that we just have to notify user about his suicide attempt to
 checkout nonlocal branch and offer him a correct syntax to go with.
 Something like below should work:

 % git clone git://git.git git
 % git checkout next
 You're attempting to checkout to non-local branch. This will lead to y=
our
 HEAD being detached (our team is on its way!).
 Do you want to check out local branch 'next' tracking 'origin/next' in=
stead?
 y/n

 if yes, then:
 Created branch "next" tracking "origin/next"
 You can update it with 'git pull'.

 If no - abort or continue with checkout to nonlocal branch? ('m not su=
re if
 detaching HEAD can provide some benefits if done on purpose)

 I hope I'm not missing anything...

 Thanks,
 Eugene
