From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: Fwd: [PATCH] Add tcsh-completion support to contrib by using git-completion.bash
Date: Tue, 13 Nov 2012 15:12:44 -0500
Message-ID: <CAFj1UpGxx_9GHSnJRpe8hDGB6OTio1mcN71LKcR0pxhSVx2xDw@mail.gmail.com>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
	<CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
	<20121113111448.GA3817@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:13:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYMqz-0003z8-0F
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 21:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617Ab2KMUMr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 15:12:47 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65155 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab2KMUMq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 15:12:46 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so11354151iea.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5+522PjY/1e9obuoywWqrqd45tfbJowcI47abULp6xc=;
        b=oQinXo085Lr07EjjrmsSKcds6NwFcfbnJWj+rNCAPY/hoIDWjUi+XN06NvfEzIujos
         B77n8yHZKEml5WwQl0YY/PXEyR7rja9ZFu4UmKjFuHUyAGMJAJ9OudcMRvbaPjzP/lrZ
         5vu6jVTQu6S1WJkMcdqeixia3iIXaeamctGQIVuqzzVj5KnZCnC+c38K3Y0dr2YUMm/a
         o6oJvO4WDouhvecT8vBUdtsdI5z4qrR2RB2GFSiJ8dD8g+Y0u2eQqdhJE9cmz9SMC6+y
         8bTaYP8AacuIKU1ganDI3qBysx6rKmfY6Ox4ZTy3yD6jqhaZ/P4A2pcEMS8/375CSyfx
         cHYQ==
Received: by 10.50.182.230 with SMTP id eh6mr1970684igc.39.1352837565945; Tue,
 13 Nov 2012 12:12:45 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Tue, 13 Nov 2012 12:12:44 -0800 (PST)
In-Reply-To: <20121113111448.GA3817@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209666>

Thanks for the review.

On Tue, Nov 13, 2012 at 6:14 AM, SZEDER G=E1bor <szeder@ira.uka.de> wro=
te:
> Hi,
>
> On Mon, Nov 12, 2012 at 03:07:46PM -0500, Marc Khouzam wrote:
>> Hi,
>
> [...]
>
>> Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
>
> [...]
>
>> Thanks
>>
>> Marc
>>
>> ---
>>  contrib/completion/git-completion.bash |   53 +++++++++++++++++++++=
++++++++++-
>>  contrib/completion/git-completion.tcsh |   34 ++++++++++++++++++++
>>  2 files changed, 86 insertions(+), 1 deletions(-)
>>  create mode 100755 contrib/completion/git-completion.tcsh
>
> Please have a look at Documentation/SubmittingPatches to see how to
> properly format the commit message, i.e. no greeting and sign-off in
> the commit message part, and the S-o-b line should be the last before
> the '---'.

Sorry about that, since I should have noticed it in the doc.
I will do my best to address all submission issues mentioned
when I post the next version of the patch.

> Your patch seems to be severely line-wrapped.  That document also
> contains a few MUA-specific tips to help avoid that.
>
> Other than that, it's a good description of the changes and
> considerations.  I agree that this approach seems to be the best from
> the three.
>
>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index be800e0..6d4b57a 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1,4 +1,6 @@
>> -#!bash
>> +#!/bin/bash
>> +# The above line is important as this script can be executed when u=
sed
>> +# with another shell such as tcsh
>
> See comment near the end.

Great suggestion below.  I removed the above change.

>> +       # Set COMP_WORDS to the command-line as bash would.
>> +       COMP_WORDS=3D($1)
>
> That comment is only true for older Bash versions.  Since v4 Bash
> splits the command line at characters that the readline library treat=
s
> as word separators when performing word completion.  But the
> completion script has functions to deal with both, so this shouldn't
> be a problem.

I've updated the comment to be more general and left the code
the same since it is supported by the script.

>
>> +       # Print the result that is stored in the bash variable ${COM=
PREPLY}
>
> Really? ;)

Removed :)

>> +       for i in ${COMPREPLY[@]}; do
>> +               echo "$i"
>> +       done
>
> There is no need for the loop here to print the array one element per
> line:
>
>         local IFS=3D$'\n'
>         echo "${COMPREPLY[*]}"

Better.  Thanks.

>> +if [ -n "$1" ] ; then
>> +  # If there is an argument, we know the script is being executed
>> +  # so go ahead and run the _git_complete_with_output function
>> +  _git_complete_with_output "$1" "$2"
>
> Where does the second argument come from?  Below you run this script
> as '${__git_tcsh_completion_script} "${COMMAND_LINE}"', i.e. $2 is
> never set.  Am I missing something?

This second argument is optional and, if present, will be put in
$COMP_CWORD.  If not present, $COMP_CWORD must be computed
from $1.  Also see comment above _git_complete_with_output ().
tcsh does not provide me with this information, so I cannot make use of=
 it.
However, I thought it would be more future-proof to allow it for other =
shells
which may have that information.

It is not necessary for tcsh, so I can remove if you prefer?

>> +# Make the script executable if it is not
>> +if ( ! -x ${__git_tcsh_completion_script} ) then
>> +       chmod u+x ${__git_tcsh_completion_script}
>> +endif
>
> Not sure about this.  If I source a script to provide completion for =
a
> command, then I definitely don't expect it to change file permissions=
=2E
>
> However, even if the git completion script is not executable, you can
> still run it with 'bash ${__git_tcsh_completion_script}'.  This way
> neither the user would need to set permissions, not the script would
> need to set it behind the users back.  Furthermore, this would also
> make changing the shebang line unnecessary.

Very nice!  Done.

>> +complete git  'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE=
}"
>> | sort | uniq`/'
>> +complete gitk 'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE=
}"
>> | sort | uniq`/'
>
> Is the 'sort | uniq' really necessary?  After the completion function
> returns Bash automatically sorts the elements in COMPREPLY and remove=
s
> any duplicates.  Doesn't tcsh do the same?  I have no idea about tcsh
> completion.

On my machine, tcsh does not remove duplicates.  It does sort the resul=
ts
but that is done after I've run 'uniq', which is too late.  I'm not
happy about this
either, but the other option is to improve git-completion.bash to
avoid duplicates,
which seemed less justified.

> Does the git completion script returns any duplicates at all?

It does.  'help' is returned twice for example.
Also, when completing 'git checkout ' in the git repo, I can see multip=
le
'todo' branches, as well as 'master', 'pu', 'next', etc.

You can actually try it without tcsh by running my proposed version of
git-completion.bash like this:

cd git/contrib/completion
bash git-completion.bash "git checkout " | sort | uniq --repeated

> Ambigious refs come to mind, but I just checked that refs completion,
> or rather 'git for-each-ref' (the command driving refs completion), i=
s
> kind enough to make any ambigious ref names unique (i.e. a branch and
> a tag with the same name is listed as 'heads/name' and 'tags/name').

I will post a new version of the patch after looking at Felipe's patch =
for zsh,
which I was not aware of.

Thanks!

Marc
