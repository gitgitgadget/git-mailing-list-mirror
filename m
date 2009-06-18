From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for 
	the given branches
Date: Thu, 18 Jun 2009 15:55:53 +0200
Message-ID: <adf1fd3d0906180655q5c142889r3375169b6cf1f8b0@mail.gmail.com>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	 <1245311834-5290-2-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0906181433330.4297@intel-tinevez-2-302>
	 <adf1fd3d0906180622n25169f51n6aa249e9167cbc38@mail.gmail.com>
	 <m3iqithd24.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 15:56:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHI61-0005WC-EW
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 15:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758528AbZFRNzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 09:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757328AbZFRNzw
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 09:55:52 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:54237 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609AbZFRNzw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 09:55:52 -0400
Received: by fxm8 with SMTP id 8so1064204fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 06:55:53 -0700 (PDT)
Received: by 10.204.52.2 with SMTP id f2mr1369787bkg.90.1245333353640; Thu, 18 
	Jun 2009 06:55:53 -0700 (PDT)
In-Reply-To: <m3iqithd24.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121842>

2009/6/18 Jakub Narebski <jnareb@gmail.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>> 2009/6/18 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>> On Thu, 18 Jun 2009, Santi B=E9jar wrote:
>>>
>>>> diff --git a/Documentation/git-remote.txt b/Documentation/git-remo=
te.txt
>>>> index 9e2b4ea..e444899 100644
>>>> --- a/Documentation/git-remote.txt
>>>> +++ b/Documentation/git-remote.txt
>>>> @@ -17,6 +17,7 @@ SYNOPSIS
>>>>  'git remote show' [-n] <name>
>>>>  'git remote prune' [-n | --dry-run] <name>
>>>>  'git remote update' [-p | --prune] [group | remote]...
>>>> +'git remote tracking' <name> <branch>...
>>>>
>>>>  DESCRIPTION
>>>>  -----------
>>>> @@ -128,6 +129,12 @@ be updated.  (See linkgit:git-config[1]).
>>>>  +
>>>>  With `--prune` option, prune all the remotes that are updated.
>>>>
>>>> +'tracking'::
>>>> +
>>>> +Returns the tracking branch for the given remote (<name>) and bra=
nch
>>>> +(<branch>). Note that <branch> must exactly match the left hand s=
ide of
>>>> +the refspec of the given remote.
>>>> +
>>>
>>> From that description, it is not clear to me if the branch is the _=
remote_
>>> branch, the branch _on_ the remote, or the local branch.
>>
>> OK. s/and branch/and remote branch/
>>
>>> If it is the remote branch (or the branch on the remote), I wonder =
how you
>>> deal with ambiguities, as I can easily create hundreds of branches
>>> tracking the same remote branch.
>>
>> AFAICS from remote_find_tracking (and some tests), it picks the firs=
t match.
>>
>> So, additional text could be: In case of multiple matches, it picks
>> the first one.
>
> Why not have both:

It makes sense.

>
>  git remote tracking <remote> <remote branch>
>
> would show all local branches that track <remote branch>, and have
> <remote> as default remote,

Maybe my description is unclear, but it's not about local branches
which track <branch> on <remote>, it is about the local branch
representation of the remote branch, i.e. not 'master' but
origin/master (git remote tracking origin master in a default clone).

> while
>
>  git remote tracking <local branch>
>
> would show <remote> and <remote branch> if <local branch> is followin=
g
> remote-tracking branch.

Good idea.

Santi

> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
