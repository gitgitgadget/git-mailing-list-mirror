From: Steven Michalske <smichalske@gmail.com>
Subject: Re: How to keep different version numbers in different branches?
Date: Tue, 6 Apr 2010 04:29:16 -0700
Message-ID: <6C464226-8D13-4FB1-9017-C410011247D3@gmail.com>
References: <hpcscv$umg$3@dough.gmane.org> <y2i32541b131004051151v8f4b8774q360c04ecdb046778@mail.gmail.com> <vpqd3ydr9g6.fsf@bauges.imag.fr> <n2x32541b131004051236m3a800c57k41536729ae3f192@mail.gmail.com> <hpetj1$6af$1@dough.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 13:29:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz6yK-0002lT-AC
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 13:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab0DFL31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 07:29:27 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:63842 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab0DFL3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 07:29:25 -0400
Received: by gxk9 with SMTP id 9so3593454gxk.8
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=VqIntA4sKcFeW0vYqGC9AlD5SKgOEN2Oso424mtXoDs=;
        b=l63EORDD/xN1X5u3EOzKsv3wi3n848A1ueOoI8T782QwEu7Wy+o4Cnrg5t/Eqqm07+
         Bge4wRWuGhva0CN5k5bEr6woCU0V7dScQClwYoyflnQLxJp9tEJXBFU6LxBc1QydbGvS
         xOrskgVpKzLP88CbJqaD36MzR9dwZuiaR6AGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=lsOXQLUY54xAX4TA567M3wAOZe1+5k8gX6m1O6upHCIcqImU7m8UCv86kyNBXo+hwf
         7yEdESErOLmzW0fJfDqbZjdPluobyYdP7C27td9LxWULodrmbpAxXcDlulxuu3KNi4LN
         8Z8IkKsn+m/fDfjhpkG/O0azMVOK8wsAyWwTE=
Received: by 10.101.178.8 with SMTP id f8mr15762897anp.213.1270553361177;
        Tue, 06 Apr 2010 04:29:21 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id 20sm3640617ywh.3.2010.04.06.04.29.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 04:29:18 -0700 (PDT)
In-Reply-To: <hpetj1$6af$1@dough.gmane.org>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144129>


On Apr 6, 2010, at 3:06 AM, Stephen Kelly wrote:

> Avery Pennarun wrote:
>
>> On Mon, Apr 5, 2010 at 3:22 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> You can even make sure it _never_ happens, by making a one-commit
>>> release branch which changes the version number for each release.  
>>> This
>>> one-commit is never merged in anything:
>>>
>>> 0.1                         0.2
>>> |                           |
>>> v                           v
>>> --o--o--o--o--o--o--o--o---o--o--o <--- master branch
>>> \                      /
>>> o--o--o--o--o--o--o--o--- ...  <--- maintainance branch
>>> \              \
>>> o <- 0.1.1     o <- 0.1.2
>>>
>>> Here, the maintainance branch never changes the version number in
>>> README & friends.
>>
>> This works too.  In fact, I even do it on one of my projects.
>> However, I find it a little annoying, because then I don't know which
>> version to tag: the pre-number-changed version, or the
>> post-number-changed version.
>>
>> The latter sounds like the obvious answer, but if I do that, then  
>> "git
>> describe" never says anything useful on my master branch.  But if I  
>> do
>> the former instead, then the tag doesn't accurately reflect the
>> version I *actually* released.
>>
>> I've never found an adequate solution to this problem, other than not
>> including the version number in the repo at all.
>
> Hi all,
>
> Thanks for the pointers. I considered the above solution too, but
> disregarded it for the same reason.
>
> I also considered the git describe solution, but disregarded it  
> because in
> CMake I need to know each component of the version separately
> (Grantlee_VERSION_MAJOR, Grantlee_VERSION_MINOR and  
> Grantlee_VERSION_PATCH).
> I could split it on '.', but I think the better solution is to just  
> put the
> version into the CMake files and deal with the conflict in that one  
> place as
> it comes up. I can always switch in the future anyway if using  
> describe
> makes more sense.
>

You might want to look into a filter that edits the cmake file.

smudge in the version information, and clean it out.

See  keyword expansion <http://progit.org/book/ch7-2.html>
