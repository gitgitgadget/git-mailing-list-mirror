From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: purpose of -r flag for git-svn fetch
Date: Wed, 30 Jun 2010 09:32:14 -0400
Message-ID: <AANLkTikSZgH42-G447IZ5j3s53ERW-H68iK9xRh9cGAG@mail.gmail.com>
References: <AANLkTil_iADth0dvcar-nkqjRcmK4p1Sc3UcBmXJ9nQn@mail.gmail.com>
	<1277887235.2498.31.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 15:32:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTxOr-0005CC-Ba
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 15:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab0F3NcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 09:32:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43027 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0F3NcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 09:32:15 -0400
Received: by gyd12 with SMTP id 12so360252gyd.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 06:32:14 -0700 (PDT)
Received: by 10.229.182.131 with SMTP id cc3mr5012639qcb.53.1277904734388; 
	Wed, 30 Jun 2010 06:32:14 -0700 (PDT)
Received: by 10.229.181.3 with HTTP; Wed, 30 Jun 2010 06:32:14 -0700 (PDT)
In-Reply-To: <1277887235.2498.31.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149958>

Hmm, this makes sense, but why does the initial fetch then update my
local branch and if I call subsequent fetches without the "-r" it will
fetch new revisions and update my local branch.

On Wed, Jun 30, 2010 at 4:40 AM, Will Palmer <wmpalmer@gmail.com> wrote=
:
> On Tue, 2010-06-29 at 22:29 -0400, Bradley Wagner wrote:
>> I've tried doing git-svn fetch in batches because it takes too long =
to
>> do it all at once.
>>
>> =A0 =A0 git svn -r1:5000 fetch
>> =A0 =A0 git svn -r5000:10000 fetch
>> =A0 =A0 git svn -r10000:15000 fetch
>>
>> Strangely, after this is done if I look in the history with "git log=
",
>> I only see commits on master branch up through the 5000th revision o=
f
>> the SVN repository. Someone told me to then call git-svn rebase to f=
ix
>> it. What does "-r" actually do when invoked on consecutive calls to
>> "git-svn fetch" and why does git-svn rebase appear to fix it?
>
> The keyword here is "fetch". "fetch" only retrieves data into the
> remote-tracking branch (often called refs/remotes/git-svn), without
> updating your local branches. "git svn rebase", on the other hand,
> rebases your currently-checked-out branch to be based on the git-svn
> remote ref. (note that "git svn rebase" does a "git svn fetch"
> behind-the-scenes first, and is actually just "git svn fetch" followe=
d
> by a normal "git rebase")
>
> The concepts are the same as if you were using the regular git comman=
ds
> "fetch" and "rebase", so the man pages for those may offer some insig=
ht.
>
>>
>> I posted this question to Stackoverflow before realizing that this
>> list is a better audience for it:
>> http://stackoverflow.com/questions/3144683/master-branch-missing-rev=
isions-after-sequential-git-svn-fetch-calls
>>
>> Thanks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
