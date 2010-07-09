From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: Handling tags/branches after git-svn fetch during SVN to Git 
	conversion
Date: Thu, 8 Jul 2010 23:18:02 -0400
Message-ID: <AANLkTilJ9tAO6Zf9whowApqhcpXU8Qvm31Z9RrQ3QaS6@mail.gmail.com>
References: <AANLkTim56UOYQJfX3M5Jpt0vXD8iTnkLuG68IjQG39Xn@mail.gmail.com>
	<AANLkTinAhxIKD6U3u4OpPnt5kDMPGTyhDhhCRaFtU-gA@mail.gmail.com>
	<AANLkTilnoIyrKg4PLSL71RDU-vyvIeNEtJ8STkOd9Lcq@mail.gmail.com>
	<AANLkTilNLjTn1FyRqqz5xmOi4rOnSIwMUy6dOb0c0sRt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 05:18:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX46N-0003Fh-Qn
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 05:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab0GIDSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 23:18:05 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63262 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425Ab0GIDSD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 23:18:03 -0400
Received: by gwj18 with SMTP id 18so476137gwj.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 20:18:02 -0700 (PDT)
Received: by 10.229.188.7 with SMTP id cy7mr5615449qcb.57.1278645482492; Thu, 
	08 Jul 2010 20:18:02 -0700 (PDT)
Received: by 10.229.38.133 with HTTP; Thu, 8 Jul 2010 20:18:02 -0700 (PDT)
In-Reply-To: <AANLkTilNLjTn1FyRqqz5xmOi4rOnSIwMUy6dOb0c0sRt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150636>

Thanks. Yea I was just looking at the man page trying to find the
notation with the colon separated ref names.

Is ":refs/heads/branch-foo" equivalent to just saying ":branch-foo" in
the remote Git repo? Do I need the refs/heads piece?

I'm trying to understand what a usual "git push origin branch-foo"
equates to using your syntax.

On Thu, Jul 8, 2010 at 11:09 PM, Jacob Helwig <jacob.helwig@gmail.com> =
wrote:
> remote2 would be the name of your remote repo, yes.
>
> origin/branch-foo would be equivalent to svn/branch-foo in your local
> repo, if you did "git branch -a". =A0It should be the name of one of =
the
> git-svn created branches.
>
> refs/heads/branch-foo is telling git where to store the reference for
> the branch within remote2. =A0It does not need to exist already, and
> should not in your case.
>
> The git-push man page has more in-depth explanations, if you're inter=
ested.
>
> On Thu, Jul 8, 2010 at 20:01, Bradley Wagner
> <bradley.wagner@hannonhill.com> wrote:
>> In your example, does "remote2" represent the name of my remote Git
>> repo? What is "origin/branch-foo" and does the path
>> "refs/heads/branch-foo" need to actually exist in my .git directory?
>>
>> On Thu, Jul 8, 2010 at 10:54 PM, Jacob Helwig <jacob.helwig@gmail.co=
m> wrote:
>>> On Wed, Jul 7, 2010 at 06:36, Bradley Wagner
>>> <bradley.wagner@hannonhill.com> wrote:
>>>> Do I need to convert these remote tags/branches into local Git
>>>> tags/branches before pushing them to my remote Git repo or is ther=
e a
>>>> way to push remote branches directly to my remote Git repo?
>>>>
>>>
>>> You don't need to "convert" the branches to local ones. =A0git-push=
 will
>>> accept any ref your local repo knows about when you do a push. =A0F=
or
>>> example "git push remote2 origin/branch-foo:refs/heads/branch-foo"
>>> works just fine, even if you don't have a "local" branch called
>>> "branch-foo", and it will push the branch-foo branch out to the
>>> remote2 remote repository.
>>>
>>> The tags, you'll need to convert to _actual_ tags, instead of just
>>> branches under a tags/ namespace. =A0Unless you're fine with them
>>> staying as pseudo-tags, then you can just push them out as you woul=
d
>>> any other branch.
>>>
>>> -Jacob
