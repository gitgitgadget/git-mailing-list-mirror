Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD59C433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B313A61454
	for <git@archiver.kernel.org>; Sat,  1 May 2021 19:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhEATW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 15:22:29 -0400
Received: from mout.web.de ([212.227.17.11]:34107 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232249AbhEATW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 15:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619896882;
        bh=JOPFOTB1C+BKKpPwwmFPnW/hoqT4lpQWwvD1Uts5n3k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aTkHM/MkLuVNYwf8znKEPG4rXsh7nT+YPPs/54KI7zbJgOtCEhRNr0z+wEi3YOS01
         pRN43KgEFSIhbYnB3CT7G4UBZU+FyCEVAmg7GZWNTUdbJ/tiU0NiGJe/Q77YXG55WQ
         VEQADdsO7ifp68na4YTT2uzUyuNEHbtxiZ6+fNOk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M5wrF-1lNBm43rwH-00xohG; Sat, 01 May 2021 21:21:21 +0200
Subject: Re: [PATCH] [GSOC] ref-filter: add %(notes) format atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.944.git.1619691880696.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <38083c1b-f92b-7624-67b7-3a5dcf213d79@web.de>
Date:   Sat, 1 May 2021 21:21:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <pull.944.git.1619691880696.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nJERpRCoojoWNwrx/rgQw2g9poOo3P8rYoAwZ1MQ/Kf+WJr7WUH
 ZKFt0Y/SB3GJxw+CUcX3V9Wnk4RNRRyi/ykAYb67Zsevygdt5vdBijEG8hMsw3ZwW2UJ7Ns
 /Whm+GfYvk4GHjATclAY35d14dklgs67ubL4tiMvujEOC6BfveHG//FKNzvsOz7takYk3y2
 je5OOaOSXvMl4JxSm1zlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWmZCBuTzMc=:6Q9RNT0wKSOJh0D+nrZEu/
 VOS/FC0VeRs0WkWSdCcKqefQjbDq3cj5BmPULzzyha6xJ18cvz1Dw5xeGx8Nb3AW/6nJK6Yxv
 SlefGWilA2dDTBTsWLhsGqMWQOyS5EPOcgonXq71E8i1EyxbIr21GiN5/jXHk0U2GwOuDcJlc
 xHmX8rfmQw0d/0B3yNahix6Tcf5GI2pbRGgxGKUlYjLuMQjuwlzO46pZvjZbyB5PckGxa+kci
 HSRqcGFdqTVtk0qOs6INhVCLX/oJV9Mryh6ZYwpMKmuOYGrVPh8tcU7tz4pf0qAPOKAUOPODn
 5AgzENUdnwt+TB0fiImVVtvb41Zk79oyAFKMwvTSVMBWDem9G5+VznYjPPLE3E/gVHWKA3GCT
 cfI5t5VcSG24ZD+LRagZiNB/JZVuRN4cryoMa31sIkrV8AJmHXfKcf7ORK34N4QDfaSDVFzdn
 mHT+2E4BpnQDpvnHklp2nQ2gb6KkfwKih68GNOu9A5g12Vgo5qXz95rL6bmACR/gwoh4F3fnC
 z2x5sJifOkibbmtMsHAuBmdzoVIjIJ3Lou1UJvJV8rX/b9weqze8Iem487I716jD7SJrQjH7Z
 VsTiTmPh5SFMqDMYr1mn+zxFmxzg9Jsnoo5YLopvcaSTjZMKG0ZQV8a62EHvYRTsZs5IWdTi4
 1kAbZEwPk2FKTFMxF/DfnVq1t5yYq25SRx3aCHr+0NtnlaLVkKVbRjgP6p9lN9dsGDGm6JfMS
 ksuUrk9+6QdXCWzp1reNz1CVHUyuBvIPjaE1SRvyATOPeT8gSIdsTLr71boqWzdK7vjiEd/6E
 4o7ycT1wfzlXlM0X+yvK/w/Gdv+q10mCQU0mTtJnVTszx2+TrIPXmMFfk1EHLupH37lcu0hzb
 FXzG/IHOYeAmgDJ+jmS0A+Il5RkTqK24kCI8MQYvYh5lljN9pz58hS0bzfw7xsbSY52Aorg7G
 +UiHdnl8iZqsYfkFDKps7Hg07BC7iyZjHynGfTpB7A1eea29IPM8zWI57QV9oZe1EJOBOftmj
 C8Y4wGahi6ZcilEe+E5xKkdPURbv+hC476uFnR115qmQXBiDueUcDNmcIN5qqWDepMY4LhhpS
 powbX2NYUkd0R2Hglg1t/+q1BzJgjv+X5FCbubj1I+9Qj+gnESoWALIfhcK+Shvp7O4WqI3hM
 z3285DBX8GR1/0DidYmfrOot0W69o93NiZcpUwqPl56V/xXAfSuBesyJKmEjx5dGQ16uk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.04.21 um 12:24 schrieb ZheNing Hu via GitGitGadget:
> From: ZheNing Hu <adlternative@gmail.com>
>
> Note that `--pretty=3D"%N"` can view notes related
> to the commit. So add `%(notes)` to ref-filter
> seem is a good choice. This atom `%(notes)` view
> the notes associated with the ref, and support
> dereference.

I can't judge the usefulness of this feature because I don't use notes.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] ref-filter: add %(notes) format atom
>
>     An important step in the GSOC project Use ref-filter formats in git
>     cat-file is to integrate different format atoms into the ref-filter.
>     Olga and Hariom have also made a lot of efforts in this area.

This is done to replace the custom format parser in git cat-file with
ref-filter in order to reduce code duplication, right?

>     Currently, I noticed that there may be some format atoms in "pretty.=
c"
>     that have not been migrated to ref-filter, such as --pretty=3D"%N",
>     --pretty=3D"%(describe)".

git cat-file doesn't support pretty format atoms, so I'm not sure I see
the connection here.

>     So in this patch, I tried to migrate --pretty=3D%N to --format=3D%(n=
otes).
>
>     Hope this will be hopeful !!!
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-944%2F=
adlternative%2Fformat-notes-atom-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-944/adlte=
rnative/format-notes-atom-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/944
>
>  Documentation/git-for-each-ref.txt |  4 ++++
>  ref-filter.c                       | 31 ++++++++++++++++++++++++++++--
>  t/t6300-for-each-ref.sh            | 10 ++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-=
each-ref.txt
> index 2ae2478de706..07f037a16e13 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -139,6 +139,9 @@ deltabase::
>  	given object, if it is stored as a delta.  Otherwise it
>  	expands to the null object name (all zeroes).
>
> +notes::
> +	The notes associated with the ref.
> +
>  upstream::
>  	The name of a local ref which can be considered ``upstream''
>  	from the displayed ref. Respects `:short`, `:lstrip` and
> @@ -302,6 +305,7 @@ git for-each-ref --count=3D3 --sort=3D'-*authordate'=
 \
>  Subject: %(*subject)
>  Date: %(*authordate)
>  Ref: %(*refname)
> +Notes: %(*notes)
>
>  %(*body)
>  ' 'refs/tags'
> diff --git a/ref-filter.c b/ref-filter.c
> index a0adb4551d87..42a5608a3056 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -23,6 +23,7 @@
>  #include "worktree.h"
>  #include "hashmap.h"
>  #include "strvec.h"
> +#include "run-command.h"
>
>  static struct ref_msg {
>  	const char *gone;
> @@ -506,6 +507,7 @@ static struct {
>  	{ "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
>  	{ "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
>  	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
> +	{ "notes", SOURCE_OTHER, FIELD_STR },
>  	{ "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
>  	{ "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
>  	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
> @@ -953,6 +955,24 @@ static int grab_oid(const char *name, const char *f=
ield, const struct object_id
>  	return 0;
>  }
>
> +static int grab_notes(const struct object_id *oid, struct atom_value *v=
)
> +{
> +	struct child_process cmd =3D CHILD_PROCESS_INIT;
> +	struct strbuf out =3D STRBUF_INIT;
> +	struct strbuf err =3D STRBUF_INIT;
> +	const char *args[] =3D { "notes", "show", NULL };
> +	int ret;
> +
> +	cmd.git_cmd =3D 1;
> +	strvec_pushv(&cmd.args, args);
> +	strvec_push(&cmd.args, oid_to_hex(oid));
> +	ret =3D pipe_command(&cmd, NULL, 0, &out, 0, &err, 0);

Nice prototype.  Is it possible to avoid the overhead of calling git
notes as an external process by calling load_display_notes() once at
parse time and format_display_notes() for each item?  Would it cause
conflicts for code that uses ref-filter and handles notes already?

> +	strbuf_trim_trailing_newline(&out);
> +	v->s =3D strbuf_detach(&out, NULL);
> +	strbuf_release(&err);
> +	return ret;
> +}
> +
>  /* See grab_values */
>  static void grab_common_values(struct atom_value *val, int deref, struc=
t expand_data *oi)
>  {
> @@ -975,8 +995,12 @@ static void grab_common_values(struct atom_value *v=
al, int deref, struct expand_
>  			v->s =3D xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
>  		} else if (!strcmp(name, "deltabase"))
>  			v->s =3D xstrdup(oid_to_hex(&oi->delta_base_oid));
> -		else if (deref)
> -			grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
> +		else if (deref) {
> +			if (!strcmp(name, "notes"))
> +				grab_notes(&oi->oid, v);
> +			else
> +				grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
> +		}
>  	}
>  }
>
> @@ -1767,6 +1791,9 @@ static int populate_value(struct ref_array_item *r=
ef, struct strbuf *err)
>  			continue;
>  		} else if (!deref && grab_oid(name, "objectname", &ref->objectname, v=
, atom)) {
>  			continue;
> +		} else if (!deref && !strcmp(name, "notes")) {
> +			grab_notes(&ref->objectname, v);
> +			continue;
>  		} else if (!strcmp(name, "HEAD")) {
>  			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
>  				v->s =3D xstrdup("*");
