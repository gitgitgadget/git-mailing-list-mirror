From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Change type of signed int flags to unsigned
Date: Sun, 28 Feb 2016 02:59:20 -0500
Message-ID: <CAPig+cTeo=7GJNkNu8WwGYE2pDH51U_qeOaa65jx2k_ri45pQA@mail.gmail.com>
References: <1456406672-5661-1-git-send-email-sauravsachidanand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Saurav Sachidanand <sauravsachidanand@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 08:59:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZwGD-0006mX-VG
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 08:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbcB1H7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2016 02:59:22 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36139 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbcB1H7V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2016 02:59:21 -0500
Received: by mail-vk0-f53.google.com with SMTP id c3so109530717vkb.3
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 23:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=ZKQ9SQ9cMIWmaPUP06bu02UvcmNpHcWWDlwhiHN14NI=;
        b=iMpcp6Uxnf9HBEp2qZc9I3Ti1wf6TtedH1bpI2NeKo/3IWy6rrAieJEKAsNLc6b8Bi
         WXILpQR7TVRhmkCG5yV7ZNc7gud0I6/4aWJUaOQBLGQCIinjBn35MTO/5PgW9BaY2Si4
         7j6SrWVaJiTM5dErEU784LF91Yg//8JJTpeervpiXqCE8gjoIHU2W4TawIxaPO7tUx8c
         pSwxJm1sMeew9ik00a8CEi5+ZwU0lmoiGeYhF4at2whcpLiRaEcoyGWiwfeotkQBuHNA
         yiHoTj2kJImIoAQNcMyaDGE/aWlrfdQRFBamMKfY+2bdSvUC1lZz3EPTN2xbpm7oJeku
         m3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=ZKQ9SQ9cMIWmaPUP06bu02UvcmNpHcWWDlwhiHN14NI=;
        b=OUUYFuxC+219Izz8nzulzgepDYhuNXpX9Q9qbD26wP719n7wiWy9d8MUd9ELAEve17
         oqUjuSkTM7IutVmUR3cqAc7/pWdn1q1BbZc+aJiDhdD05kojaWSHXpZtEMIe0LFoptLJ
         E/nMXin2SpTArWTlbmGUWYvwIaEG88z9WT3VQWd7RmhGZhnVa5WI7GFFIA4CkD3txGOW
         oSqDzYHDJmgxVrgX5fqmUayiM1P3BMn9WVVnQ4/h6MBm+UF2Uth6z+XdwPpPyeUqZhoD
         tbiqYtSBIeG1kS8Pd8Y0uKRoLjMP5ZeX+zJj5B0U4bVIPRY9twavrfXYQu07mlMNl2ch
         BkTw==
X-Gm-Message-State: AD7BkJK1HL7gU3Edb1B6B+8vLi4BMDKziChwdVsqRkQk91d8UdFAWCNL7+hLeYzCvdRqmUurIeTpA7adov3ESQ==
X-Received: by 10.31.168.76 with SMTP id r73mr7261257vke.117.1456646360440;
 Sat, 27 Feb 2016 23:59:20 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 27 Feb 2016 23:59:20 -0800 (PST)
In-Reply-To: <1456406672-5661-1-git-send-email-sauravsachidanand@gmail.com>
X-Google-Sender-Auth: dHovLnCkim_BEQ24GuHDNSkzWP0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287759>

On Thu, Feb 25, 2016 at 8:24 AM, Saurav Sachidanand
<sauravsachidanand@gmail.com> wrote:
> =E2=80=9Cpattern=E2=80=9D and =E2=80=9Cexclude=E2=80=9D are two struc=
ts defined in attr.c and dir.h
> respectively. Each contains a field named =E2=80=9Cflags=E2=80=9D of =
type int, that
> takes on values from the set of positive integers {1, 4, 8, 16}
> enumerated through the macro EXC_FLAG_*.
>
> That the most significant bit (used to store the sign) of these two
> fields is not used in any special way, is observed from the fact
> that, the flags fields (accessed within attr.c, dir.c, and
> builtin/check-ignore.c) is either checked for it's value using the &
> operator (e.g.: flags & EXC_FLAG_NODIR), or assigned a value of 0
> first and then assigned any one of {1, 4, 8, 16} using the | operator
> (e.g.: flags |=3D EXC_FLAG_NODIR). Hence, change the type of flags
> to unsigned in both structs.
>
> Furthermore, flags is passed by reference to the function
> parse_exclude_pattern defined in dir.c, which accepts an =E2=80=9Cint=
 *=E2=80=9D type
> for the flags argument. To avoid converting between pointers to
> different types, change type of the flags argument to =E2=80=9Cunsign=
ed *=E2=80=9D.

If you follow Duy's suggestion[1] of checking for additional
sign-conversion warnings and fixing the additional instances, then
there will be a bit more fallout than this one function. In that case,
you might consider changing this paragraph to be a bit more generic;
for instance, perhaps something like this:

    These "flags" fields are passed to several functions, so convert
    the functions to accept 'unsigned' rather than 'int', as well.

> While we=E2=80=99re at it, document the flags field of exclude to exp=
licitly
> state the values it=E2=80=99s supposed to take on.

Good.

> Signed-off-by: Saurav Sachidanand <sauravsachidanand@gmail.com>
> ---

Right here below the "---" line is where you'd write commentary about
the patch. In this case, you should mention that this is a GSoC
microproject.

As an aid to reviewers, also provide a link to the previous version
(like this [2]), and explain what changed since that attempt. In this
case, you refined the commit message and used bare "unsigned" in the
patch rather than "unsigned int".

The patch itself looks reasonable (though it would look better if
additional fixes were made as suggested by Duy[1]).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/286821/focu=
s=3D286900
[2]: http://thread.gmane.org/gmane.comp.version-control.git/286821

>  attr.c | 2 +-
>  dir.c  | 4 ++--
>  dir.h  | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 086c08d..679e13c 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -124,7 +124,7 @@ struct pattern {
>         const char *pattern;
>         int patternlen;
>         int nowildcardlen;
> -       int flags;              /* EXC_FLAG_* */
> +       unsigned flags;         /* EXC_FLAG_* */
>  };
>
>  /*
> diff --git a/dir.c b/dir.c
> index 552af23..d36fda7 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -459,7 +459,7 @@ int no_wildcard(const char *string)
>
>  void parse_exclude_pattern(const char **pattern,
>                            int *patternlen,
> -                          int *flags,
> +                          unsigned *flags,
>                            int *nowildcardlen)
>  {
>         const char *p =3D *pattern;
> @@ -500,7 +500,7 @@ void add_exclude(const char *string, const char *=
base,
>  {
>         struct exclude *x;
>         int patternlen;
> -       int flags;
> +       unsigned flags;
>         int nowildcardlen;
>
>         parse_exclude_pattern(&string, &patternlen, &flags, &nowildca=
rdlen);
> diff --git a/dir.h b/dir.h
> index 3ec3fb0..e34df5e 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -28,7 +28,7 @@ struct exclude {
>         int nowildcardlen;
>         const char *base;
>         int baselen;
> -       int flags;
> +       unsigned flags;         /* EXC_FLAG_* */
>
>         /*
>          * Counting starts from 1 for line numbers in ignore files,
> @@ -244,7 +244,7 @@ extern struct exclude_list *add_exclude_list(stru=
ct dir_struct *dir,
>  extern int add_excludes_from_file_to_list(const char *fname, const c=
har *base, int baselen,
>                                           struct exclude_list *el, in=
t check_index);
>  extern void add_excludes_from_file(struct dir_struct *, const char *=
fname);
> -extern void parse_exclude_pattern(const char **string, int *patternl=
en, int *flags, int *nowildcardlen);
> +extern void parse_exclude_pattern(const char **string, int *patternl=
en, unsigned *flags, int *nowildcardlen);
>  extern void add_exclude(const char *string, const char *base,
>                         int baselen, struct exclude_list *el, int src=
pos);
>  extern void clear_exclude_list(struct exclude_list *el);
> --
> 2.7.1.339.g0233b80
