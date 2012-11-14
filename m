From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: Fwd: [PATCH] Add tcsh-completion support to contrib by using git-completion.bash
Date: Tue, 13 Nov 2012 23:26:33 -0500
Message-ID: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
	<CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
	<20121113111448.GA3817@goldbirke>
	<CAFj1UpGxx_9GHSnJRpe8hDGB6OTio1mcN71LKcR0pxhSVx2xDw@mail.gmail.com>
	<20121113234636.GS12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 05:26:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYUYs-0004fp-QR
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 05:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab2KNE0f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 23:26:35 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60593 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab2KNE0e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 23:26:34 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so35296iea.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 20:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Fq16Av+ngnACSJKwzP3v5kLqa0wBZ/n2PeM3KwhP4EE=;
        b=YRWobtJHuC29p9BffGmMYBrB/mtmnmKTvYhJBi/qe07TIvBQE2C9KhIMAbJr8VRqFV
         9dWprxsKFoJNNYLS0FW0RvEEkuIso1q0syLKVoNvJz/JrRED/ZxGFqlkJW8imthj5CSF
         iODlWrQ8P4O5qrYem+cP3L64lGAQORyGKqID+9TjTcnXDLzbfr5iPv2+pNiIFFwcxTkG
         oadxXQHGEc2qbYWObIrAwbS7alYqfeI+0X6JzMW4QYp1oivQkaX+V8YAUD2pPI/F/hoY
         XAjdm0tKThgNhl3K7YB/2s4oAYiNYK4pes3ACFG/PnzWd2s5PTWBzvmCCNRsjziyA0gn
         qY9A==
Received: by 10.50.33.232 with SMTP id u8mr685618igi.39.1352867194058; Tue, 13
 Nov 2012 20:26:34 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Tue, 13 Nov 2012 20:26:33 -0800 (PST)
In-Reply-To: <20121113234636.GS12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209695>

On Tue, Nov 13, 2012 at 6:46 PM, SZEDER G=E1bor <szeder@ira.uka.de> wro=
te:
> Hi,
>
> On Tue, Nov 13, 2012 at 03:12:44PM -0500, Marc Khouzam wrote:
>> >> +if [ -n "$1" ] ; then
>> >> +  # If there is an argument, we know the script is being execute=
d
>> >> +  # so go ahead and run the _git_complete_with_output function
>> >> +  _git_complete_with_output "$1" "$2"
>> >
>> > Where does the second argument come from?  Below you run this scri=
pt
>> > as '${__git_tcsh_completion_script} "${COMMAND_LINE}"', i.e. $2 is
>> > never set.  Am I missing something?
>>
>> This second argument is optional and, if present, will be put in
>> $COMP_CWORD.  If not present, $COMP_CWORD must be computed
>> from $1.  Also see comment above _git_complete_with_output ().
>> tcsh does not provide me with this information, so I cannot make use=
 of it.
>> However, I thought it would be more future-proof to allow it for oth=
er shells
>> which may have that information.
>>
>> It is not necessary for tcsh, so I can remove if you prefer?
>
> I see.  I read those comments and understood what it is about.  I was
> just surprised that the code is there to make use of it, yet it's not
> specified when invoking that function.
>
> Since it's a trivial piece of code, I would say let's keep it.  Could
> you please add a sentence about it (that it's for possible future
> users and it's not used at the moment) to the commit message for
> future reference?

Will do.

>> >> +complete git  'p/*/`${__git_tcsh_completion_script} "${COMMAND_L=
INE}"
>> >> | sort | uniq`/'
>> >> +complete gitk 'p/*/`${__git_tcsh_completion_script} "${COMMAND_L=
INE}"
>> >> | sort | uniq`/'
>> >
>> > Is the 'sort | uniq' really necessary?  After the completion funct=
ion
>> > returns Bash automatically sorts the elements in COMPREPLY and rem=
oves
>> > any duplicates.  Doesn't tcsh do the same?  I have no idea about t=
csh
>> > completion.
>>
>> On my machine, tcsh does not remove duplicates.  It does sort the re=
sults
>> but that is done after I've run 'uniq', which is too late.  I'm not
>> happy about this
>> either, but the other option is to improve git-completion.bash to
>> avoid duplicates,
>> which seemed less justified.
>
> Ok.  Then keep it for the time being, and we'll see what we can do to
> avoid those duplicates.

Thanks.

>> > Does the git completion script returns any duplicates at all?
>>
>> It does.  'help' is returned twice for example.
>
> Right.  Now that you mentioned it, I remember I noticed it a while
> ago, too.  I even wrote a patch to fix it, but not sure what became o=
f
> it.  Will try to dig it up.

Thanks for already posting the patch.

>> Also, when completing 'git checkout ' in the git repo, I can see mul=
tiple
>> 'todo' branches, as well as 'master', 'pu', 'next', etc.
>>
>> You can actually try it without tcsh by running my proposed version =
of
>> git-completion.bash like this:
>>
>> cd git/contrib/completion
>> bash git-completion.bash "git checkout " | sort | uniq --repeated
>
> Interesting, I can't reproduce.  Are the duplicates also there, if yo=
u
> start a bash, source git-completion.bash, and run __git_refs ?

Running __git_refs does not show the duplicates, but running
__git refs '' 1
does show them.
That second parameter causes __git_refs to
"use the guess heuristic employed by checkout for tracking branches"

I don't quite understand this, but what I can see is that my remote
branches GitHub/master and origin/master each cause another
'master' to be listed:

$ __git_refs '' 1|grep master
master
GitHub/master
origin/master
master
master

All fixes are done and I'll post a second version of the patch
as soon as I can figure out the formatting properly.

Thanks again

Marc
