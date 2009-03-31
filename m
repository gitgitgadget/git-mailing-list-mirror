From: P Baker <me@retrodict.com>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers on 
	active trees]
Date: Tue, 31 Mar 2009 19:49:25 -0400
Message-ID: <526944450903311649q358d43edkf07e2e5058a9e527@mail.gmail.com>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>
	 <20090330153245.GD23521@spearce.org>
	 <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>
	 <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302>
	 <526944450903311532u24eb74fby1f558c1bef5c653a@mail.gmail.com>
	 <alpine.DEB.1.00.0904010058490.6616@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:51:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LonjY-0006em-7Z
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 01:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763116AbZCaXta convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 19:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762840AbZCaXt3
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 19:49:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:41945 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762322AbZCaXt2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 19:49:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3425371qwh.37
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=2sGzghMNiMCUjBwN0Ku2u9OgvLanoUGeg1PZ5j7Hv/o=;
        b=lR+A0XHAg4kkfY0g3KkKAAbmr/O39fFhnC8Goe2O41nwepMVkoYY82xVI3p8gYdb1N
         IbtHxbIeHnDMlqaOPSppOfKqJaa57nhrRWnzZ9NTExVYkPJr07AW1O6stC4jtqgJL2In
         HQdPGtJG2UBJv1gd+qn+K7daG34R5P/5iTLwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=uSfgwuPsHeubffG5hoEI4Z+E2kK91UmVTabhc/QSn7bC6VfLCR+d3Ni1yviEAPyLJm
         iLbRwrufWS8GEcMkrTTlOROEc8/jNkeQ7n9tQh3qr5HB4EtrwjsiHhdAB8EMVBQ1oMkz
         t02vp/Zws75lQx6AUHCvz6WBUsrFJ+uU7NxT0=
Received: by 10.220.83.149 with SMTP id f21mr2884043vcl.34.1238543365169; Tue, 
	31 Mar 2009 16:49:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904010058490.6616@intel-tinevez-2-302>
X-Google-Sender-Auth: a11f5850968088c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115330>

I'll paraphrase to see if I understand your points:

*Moving objects from submodule .git directories into the base .git/
directory would protect the submodules and is a good idea.
*Moving to a .git/ file from .gitmodules should be taken off of the
goal list (I went back and read this thread:
http://thread.gmane.org/gmane.comp.version-control.git/78605; seemed
to clear things up).
*git submodule recurse would be a good option (not as a default), if
the remaining issues are resolved.
*It would be a good idea for git submodule to work with foreign VCS,
through Daniel's patches.

I appreciate the guidance, it's helping me to see that some of this
work has already been done, it needs to be finished and pushed into a
public release. As an intense user of submodules, what does it do
poorly/not do for your needs?

Thanks,

Phillip Baker

On Tue, Mar 31, 2009 at 7:05 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 31 Mar 2009, P Baker wrote:
>
>> On Tue, Mar 31, 2009 at 11:57 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> >> *move objects of submodules into base .git/ directory
>> >> **This would, as I understand it: protect submodules from being
>> >> overwritten and changes lost when switching between branches of t=
he
>> >> superproject that might or might not contain the submodules and
>> >> centralize their management into one location. =C2=A0The added be=
nefits of
>> >> fully using git's ability to branch and merge submodules makes it
>> >> worth adding some complexity within the .git directory.
>> >
>> > The main problem with renaming/deleting is not the repository of t=
he
>> > submodule, but the working directoy.
>> >
>>
>> My understanding is that since the submodule objects (history) is
>> stored in a .git directory in the subdirectory where the submodule i=
s
>> located, removing that subdirectory during checkout of a branch that
>> does not include that submodule eliminates the .git directory as wel=
l.
>> Moving the objects from the submodule's .git directory to the base
>> .git directory would seem to alleviate this problem.
>
> My point was more about "you cannot just remove the subdirectory, or =
you
> _will_ lose data".
>
>> >> *use .git instead of .gitmodules
>> >> **I actually don't know why this was included with the project
>> >> description, I searched for an explanation of the desired name ch=
ange
>> >> on the mailing list and in commit messages, but came up with noth=
ing.
>> >
>> > AFAICT somebody thought that the information about the locations o=
f the
>> > submodules should be in .git/ rather than in the working directory=
=2E =C2=A0But
>> > of course, that is wrong: you want it to be tracked.
>>
>> So, in looking back through the archives of the mailing list there
>> seems to be some disagreement between using .gitmodules and
>> .git/config to track submodules.
>
> No. =C2=A0.gitmodules has the default information, and "git submodule=
 init"
> brings that into .git/config, to be overridden by the user if she so
> likes.
>
>> >> *git submodule update --init should initialize nested levels of s=
ubmodules
>> >> **As an ease of use command, either an additional flag to recurse=
 can
>> >> be added, or it can act by default. As a requested feature on the
>> >> mailing list, this is worth implementing.
>> >
>> > I thought there was a patch to support "git submodule recurse"? =C2=
=A0That
>> > would be rather less limited than yet another option to submodule =
update.
>>
>> There is a git submodule foreach command, but it doesn't look like t=
he
>> patch for git submodule recurse
>> (http://marc.info/?l=3Dgit&m=3D120997867213008&w=3D2) has been incor=
porated
>> into a public release.
>>
>> That is one route, on the other hand, the default action is also ope=
n
>> to question. When I update a submodule, I would probably expect that
>> anything it depends on is also updated. The default action probably
>> should be recursive.
>
> No. =C2=A0Not at all. =C2=A0At least in my usage, submodules are most=
ly optional.
> IOW I have ways in my projects to cope with the absence of a checkout=
=2E
>
>> >> *ability to update submodule pulled from svn repo
>> >> **One workaround is to clone it as local copy using git-svn and t=
hen
>> >> import that local clone as a submodule; clearly a clunky solution=
=2E
>> >> There are many requests for this feature (see
>> >> http://panthersoftware.com/articles/view/4/git-svn-dcommit-workar=
ound-for-git-submodules
>> >> for a typical example), and it makes sense integrating git-submod=
ule
>> >> with git-svn would expand submodule's usefulness.
>> >
>> > I do not think that this would be good. =C2=A0Both "git svn" and "=
git
>> > submodule" are rather complex by now, and mixing them would only
>> > complicate code.
>>
>> Hm, point well taken, but it would seem to have enormous benefit for=
 a
>> lot of people. I can move it down the priority list, but I'd like to
>> include it in the proposal - complexity alone isn't a good reason to
>> avoid something.
>
> Complexity is often a good sign of bad design.
>
> In this case, I want to point out that there has been a better design
> already:
>
> http://thread.gmane.org/gmane.comp.version-control.git/114545
>
> (Unfortunately, Daniel decided to post the follow-up patches in diffe=
rent
> threads; that will make it hard for you to find them.)
>
> Ciao,
> Dscho
>
>
