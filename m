From: Elijah Newren <newren@gmail.com>
Subject: Re: Poor status output during conflicted merge
Date: Tue, 6 Jul 2010 23:07:39 -0600
Message-ID: <AANLkTimWugg7IznbXfVFDZe44Ag6VW-PJPAdDl7rWLY-@mail.gmail.com>
References: <loom.20100701T195742-266@post.gmane.org>
	<7v1vbm3g8j.fsf@alter.siamese.dyndns.org>
	<AANLkTimBQULqlIVLOOpFoOO5Lg7hGrgm7N69qouafFyG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 07:07:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWMrL-00081B-9p
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab0GGFHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 01:07:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62225 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab0GGFHl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 01:07:41 -0400
Received: by vws5 with SMTP id 5so8460952vws.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d5Lbv5d2FUDyxv5jVVrtPI7AoOOCMEqzLnNZ9kinzig=;
        b=InojVZNPFx3y51Gob9WIPmLMFFlKvcS+L73ox7dP9d3GThKHo7XlllSyI6TuBlYxoh
         pZcPVw57AnFGdfE6c93geh5Pnw58h7tzDH9jO9gf2LJVgIYtdR7mvgohVJ1hfqeEHZuU
         diJkIdVwf5pNXwiT7c6Hno5JO3qYMLf030ypE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vNvt69zIrCOTisCpnoQ2eNfNpIxMH8Nlmos2Kwtw0PmhjEJmxArDPAkia8we7lyysg
         ymVHZQ6I6XYvyX7WcuUMzpinOQ5dsm+mWdxIBzG4RSx2xUvIp49wUi0QDJVwq7SAzD3Y
         1CAmLKZfcl0MpNSbwzKyKv2wuPA7385J7lsEw=
Received: by 10.220.168.10 with SMTP id s10mr3105514vcy.50.1278479259742; Tue, 
	06 Jul 2010 22:07:39 -0700 (PDT)
Received: by 10.220.83.138 with HTTP; Tue, 6 Jul 2010 22:07:39 -0700 (PDT)
In-Reply-To: <AANLkTimBQULqlIVLOOpFoOO5Lg7hGrgm7N69qouafFyG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150437>

On Tue, Jul 6, 2010 at 6:12 PM, Eric Raible <raible@gmail.com> wrote:
> On Thu, Jul 1, 2010 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> It might be just a simple matter of ...
>>
>> =C2=A0wt-status.c | =C2=A0 =C2=A02 ++
>> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/wt-status.c b/wt-status.c
>> index 2f9e33c..757536f 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -674,6 +674,8 @@ void wt_status_print(struct wt_status *s)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0fprintf(s->fp, "# No changes\n");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (s->n=
owarn)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0; /* nothing */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (s->in_me=
rge)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 printf("merge result will be the same as HEAD commit\n");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (s->w=
orkdir_dirty)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0printf("no changes added to commit%s\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0advice_status_hints
>
> I suppose that's better than nothing, but I can't help but think that
> the output would =C2=A0be more useful if it explicitly mentioned the =
merge.
>
> Most sensible people probably already have that in their bash prompt,
> of course, but we have some users at $dayjob who use the anemic
> windows cmd.exe as their "command shell".
>
> So how about something like this:
>
> $ git status
> # Merging branch 'master' into topic
> # Changes to be committed:
> #
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 file2
>
> The "branch 'master' into topic" part can come
> from .git/MERGE_MSG

At my $dayjob, when we switched from cvs to git, I got _lots_ of
support questions around people being confused with merges and rebases
-- they often didn't realize they were still in the middle of one, or
didn't know how to resolve conflicts, or didn't know how to complete
the operation (i.e. didn't know that they needed to "commit" or
"rebase --continue"), or didn't know how to abort the operation.  This
despite a few hours of dedicated training on basic git usage for
everyone including some nice handouts.  [Granted, most developers were
engineers that were more interested in engineering and physics than
"computer science stuff", didn't have a very strong grasp of version
control, plus they had years of brain damage from CVS usage to cope
with, so this user group may be uncommon -- at least other than the
CVS usage bit.]  Fixing the bash prompt would help in reminding people
that they were in the middle of an operation, but not the other
issues.  And most people were stubbornly sticking with tcsh as their
shell, preventing even using that solution.

Most such users were using EasyGit (lightweight git-like wrapper
designed to assist in avoiding common gotchas for those braindamaged
by CVS or SVN), so I quickly modified "eg status" to also print
annoying "YOU ARE IN THE MIDDLE OF A <OP> OPERATION.  TYPE 'eg help
topic middle-of-<OP> FOR MORE INFO" notices when relevant[1].

After making that change, support questions dropped _dramatically_.

I'm a bit ashamed I never got around to making that into a proper RFC
patch for git (yet?).  I'm not sure whether it'd fit git, but it's
certainly worth discussion and was amazing how much it helped us.

Elijah

[1] See http://people.gnome.org/~newren/eg/documentation/topic-middle-o=
f-merge.html
and http://people.gnome.org/~newren/eg/documentation/topic-middle-of-re=
base.html
for what the help pages suggested; there are similar ones for am and
bisect as well.
