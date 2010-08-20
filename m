From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] compat/regex: get rid of old-style definition
Date: Fri, 20 Aug 2010 07:47:16 +0000
Message-ID: <AANLkTi=zwfyS-36ysLtcEahp-jKR3a2D=BOu3Rn8MeB8@mail.gmail.com>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain>
	<1282242601-2630-1-git-send-email-avarab@gmail.com>
	<7vtymq74mp.fsf@alter.siamese.dyndns.org>
	<AANLkTikod-o3GHqyFSu7yKJZMc1pgZUQm+pEb-ErAYDB@mail.gmail.com>
	<7vlj8271mm.fsf@alter.siamese.dyndns.org>
	<7v39uadxx3.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Aharon Robbins <arnold@skeeve.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 09:47:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmMJy-00049E-O4
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 09:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab0HTHrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 03:47:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65146 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab0HTHrT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 03:47:19 -0400
Received: by fxm13 with SMTP id 13so1636685fxm.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8sW6XisrHqbIELJHO/j3UQjBFXnIhN5jp1TzOknsRgg=;
        b=h+B9SUeRL+xtelZtNwGinDQ37AjD8lQntYt+o0TbBYNiN92Any4YTGnEAl3P7aWm8n
         B6m9l/kl+rGH3jKstYYFIxZzw6Me6adTCy3S4aUb1w+datHaqNuIHB8Fb42DzXIb+G1t
         BrOXFf67avn8An3TU1QnieIjJfkaVzJKeUjws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wHfiX+wJ45lJF75+FzKHCXOxxZa6dxfh608ykHzkTg/ELnU5Re4SZLrKzd4LID/EsY
         VGSx9RGxaDhpt5mH5PCUZfcQbcQ8TW/j5daSJBConWwAGvvmUnlL6KMInZhB6Qo1DzU1
         RY/r6nJ4zln41/w4GUU/Xp8FqD7cPIG6NoYdI=
Received: by 10.223.121.133 with SMTP id h5mr733990far.74.1282290436189; Fri,
 20 Aug 2010 00:47:16 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Fri, 20 Aug 2010 00:47:16 -0700 (PDT)
In-Reply-To: <7v39uadxx3.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153981>

On Thu, Aug 19, 2010 at 22:45, Junio C Hamano <gitster@pobox.com> wrote=
:
> These files mostly used ANSI style function definitions, but with sma=
ll
> number of old-style ones. =C2=A0Convert them to consistently use ANSI=
 style.

CC-ing Aharon Robbins, perhaps this is something upstream gawk/glibc
is willing to change.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> =C2=A0* With this I can finish my semi-autobuild with the Meta/Make w=
rapper.
> =C2=A0 For people who don't know, a checkout of the 'todo' branch liv=
es in
> =C2=A0 "Meta/" subdirectory in my local environments (not that I need=
 the
> =C2=A0 compatibility replacement in any of them, though...)

It fails for your Make script because you define
-Wold-style-definition and -Werror?


> =C2=A0compat/regex/regcomp.c | =C2=A0 23 ++++-------
> =C2=A0compat/regex/regexec.c | =C2=A0101 ++++++++++++++++++++++------=
--------------------
> =C2=A02 files changed, 55 insertions(+), 69 deletions(-)
>
> diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
> index 4a80056..8c96ed9 100644
> --- a/compat/regex/regcomp.c
> +++ b/compat/regex/regcomp.c
> @@ -230,10 +230,9 @@ btowc (int c)
> =C2=A0 =C2=A0are set in BUFP on entry. =C2=A0*/
>
> =C2=A0const char *
> -re_compile_pattern (pattern, length, bufp)
> - =C2=A0 =C2=A0const char *pattern;
> - =C2=A0 =C2=A0size_t length;
> - =C2=A0 =C2=A0struct re_pattern_buffer *bufp;
> +re_compile_pattern (const char *pattern,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
_t length,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct re_pattern_buffer *bufp)
> =C2=A0{
> =C2=A0 reg_errcode_t ret;
>
> @@ -271,8 +270,7 @@ reg_syntax_t re_syntax_options;
> =C2=A0 =C2=A0defined in regex.h. =C2=A0We return the old syntax. =C2=A0=
*/
>
> =C2=A0reg_syntax_t
> -re_set_syntax (syntax)
> - =C2=A0 =C2=A0reg_syntax_t syntax;
> +re_set_syntax (reg_syntax_t syntax)
> =C2=A0{
> =C2=A0 reg_syntax_t ret =3D re_syntax_options;
>
> @@ -284,8 +282,7 @@ weak_alias (__re_set_syntax, re_set_syntax)
> =C2=A0#endif
>
> =C2=A0int
> -re_compile_fastmap (bufp)
> - =C2=A0 =C2=A0struct re_pattern_buffer *bufp;
> +re_compile_fastmap (struct re_pattern_buffer *bufp)
> =C2=A0{
> =C2=A0 re_dfa_t *dfa =3D (re_dfa_t *) bufp->buffer;
> =C2=A0 char *fastmap =3D bufp->fastmap;
> @@ -484,10 +481,9 @@ re_compile_fastmap_iter (regex_t *bufp, const re=
_dfastate_t *init_state,
> =C2=A0 =C2=A0the return codes and their meanings.) =C2=A0*/
>
> =C2=A0int
> -regcomp (preg, pattern, cflags)
> - =C2=A0 =C2=A0regex_t *__restrict preg;
> - =C2=A0 =C2=A0const char *__restrict pattern;
> - =C2=A0 =C2=A0int cflags;
> +regcomp (regex_t *__restrict preg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *__restrict pattern,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int cflags)
> =C2=A0{
> =C2=A0 reg_errcode_t ret;
> =C2=A0 reg_syntax_t syntax =3D ((cflags & REG_EXTENDED) ? RE_SYNTAX_P=
OSIX_EXTENDED
> @@ -650,8 +646,7 @@ free_dfa_content (re_dfa_t *dfa)
> =C2=A0/* Free dynamically allocated space used by PREG. =C2=A0*/
>
> =C2=A0void
> -regfree (preg)
> - =C2=A0 =C2=A0regex_t *preg;
> +regfree (regex_t *preg)
> =C2=A0{
> =C2=A0 re_dfa_t *dfa =3D (re_dfa_t *) preg->buffer;
> =C2=A0 if (BE (dfa !=3D NULL, 1))
> diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
> index 0c2b054..b49585a 100644
> --- a/compat/regex/regexec.c
> +++ b/compat/regex/regexec.c
> @@ -218,12 +218,12 @@ static reg_errcode_t extend_buffers (re_match_c=
ontext_t *mctx)
> =C2=A0 =C2=A0We return 0 if we find a match and REG_NOMATCH if not. =C2=
=A0*/
>
> =C2=A0int
> -regexec (preg, string, nmatch, pmatch, eflags)
> - =C2=A0 =C2=A0const regex_t *__restrict preg;
> - =C2=A0 =C2=A0const char *__restrict string;
> - =C2=A0 =C2=A0size_t nmatch;
> - =C2=A0 =C2=A0regmatch_t pmatch[];
> - =C2=A0 =C2=A0int eflags;
> +regexec (
> + =C2=A0 =C2=A0 =C2=A0 const regex_t *__restrict preg,
> + =C2=A0 =C2=A0 =C2=A0 const char *__restrict string,
> + =C2=A0 =C2=A0 =C2=A0 size_t nmatch,
> + =C2=A0 =C2=A0 =C2=A0 regmatch_t pmatch[],
> + =C2=A0 =C2=A0 =C2=A0 int eflags)
> =C2=A0{
> =C2=A0 reg_errcode_t err;
> =C2=A0 int start, length;
> @@ -303,11 +303,11 @@ compat_symbol (libc, __compat_regexec, regexec,=
 GLIBC_2_0);
> =C2=A0 =C2=A0match was found and -2 indicates an internal error. =C2=A0=
*/
>
> =C2=A0int
> -re_match (bufp, string, length, start, regs)
> - =C2=A0 =C2=A0struct re_pattern_buffer *bufp;
> - =C2=A0 =C2=A0const char *string;
> - =C2=A0 =C2=A0int length, start;
> - =C2=A0 =C2=A0struct re_registers *regs;
> +re_match (struct re_pattern_buffer *bufp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *string,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 int length,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 int start,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct re_registers *regs)
> =C2=A0{
> =C2=A0 return re_search_stub (bufp, string, length, start, 0, length,=
 regs, 1);
> =C2=A0}
> @@ -316,11 +316,10 @@ weak_alias (__re_match, re_match)
> =C2=A0#endif
>
> =C2=A0int
> -re_search (bufp, string, length, start, range, regs)
> - =C2=A0 =C2=A0struct re_pattern_buffer *bufp;
> - =C2=A0 =C2=A0const char *string;
> - =C2=A0 =C2=A0int length, start, range;
> - =C2=A0 =C2=A0struct re_registers *regs;
> +re_search (struct re_pattern_buffer *bufp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *string,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int length, int start, int range,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct re_registers *regs)
> =C2=A0{
> =C2=A0 return re_search_stub (bufp, string, length, start, range, len=
gth, regs, 0);
> =C2=A0}
> @@ -329,11 +328,10 @@ weak_alias (__re_search, re_search)
> =C2=A0#endif
>
> =C2=A0int
> -re_match_2 (bufp, string1, length1, string2, length2, start, regs, s=
top)
> - =C2=A0 =C2=A0struct re_pattern_buffer *bufp;
> - =C2=A0 =C2=A0const char *string1, *string2;
> - =C2=A0 =C2=A0int length1, length2, start, stop;
> - =C2=A0 =C2=A0struct re_registers *regs;
> +re_match_2 (struct re_pattern_buffer *bufp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *string1, int length1=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *string2, int length2=
, int start,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct re_registers *regs, int s=
top)
> =C2=A0{
> =C2=A0 return re_search_2_stub (bufp, string1, length1, string2, leng=
th2,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 start, 0, regs, stop, 1);
> @@ -343,11 +341,10 @@ weak_alias (__re_match_2, re_match_2)
> =C2=A0#endif
>
> =C2=A0int
> -re_search_2 (bufp, string1, length1, string2, length2, start, range,=
 regs, stop)
> - =C2=A0 =C2=A0struct re_pattern_buffer *bufp;
> - =C2=A0 =C2=A0const char *string1, *string2;
> - =C2=A0 =C2=A0int length1, length2, start, range, stop;
> - =C2=A0 =C2=A0struct re_registers *regs;
> +re_search_2 (struct re_pattern_buffer *bufp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *string1, int l=
ength1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *string2, int l=
ength2, int start,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int range, struct re_regis=
ters *regs, =C2=A0int stop)
> =C2=A0{
> =C2=A0 return re_search_2_stub (bufp, string1, length1, string2, leng=
th2,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 start, range, regs, stop, 0);
> @@ -357,12 +354,11 @@ weak_alias (__re_search_2, re_search_2)
> =C2=A0#endif
>
> =C2=A0static int
> -re_search_2_stub (bufp, string1, length1, string2, length2, start, r=
ange, regs,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stop, ret_l=
en)
> - =C2=A0 =C2=A0struct re_pattern_buffer *bufp;
> - =C2=A0 =C2=A0const char *string1, *string2;
> - =C2=A0 =C2=A0int length1, length2, start, range, stop, ret_len;
> - =C2=A0 =C2=A0struct re_registers *regs;
> +re_search_2_stub (struct re_pattern_buffer *bufp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
*string1, int length1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
*string2, int length2, int start,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int range, =
struct re_registers *regs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int stop, i=
nt ret_len)
> =C2=A0{
> =C2=A0 const char *str;
> =C2=A0 int rval;
> @@ -402,11 +398,10 @@ re_search_2_stub (bufp, string1, length1, strin=
g2, length2, start, range, regs,
> =C2=A0 =C2=A0otherwise the position of the match is returned. =C2=A0*=
/
>
> =C2=A0static int
> -re_search_stub (bufp, string, length, start, range, stop, regs, ret_=
len)
> - =C2=A0 =C2=A0struct re_pattern_buffer *bufp;
> - =C2=A0 =C2=A0const char *string;
> - =C2=A0 =C2=A0int length, start, range, stop, ret_len;
> - =C2=A0 =C2=A0struct re_registers *regs;
> +re_search_stub (struct re_pattern_buffer *bufp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *string=
, int length, int start,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int range, int sto=
p,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct re_register=
s *regs, int ret_len)
> =C2=A0{
> =C2=A0 reg_errcode_t result;
> =C2=A0 regmatch_t *pmatch;
> @@ -490,10 +485,9 @@ re_search_stub (bufp, string, length, start, ran=
ge, stop, regs, ret_len)
> =C2=A0}
>
> =C2=A0static unsigned
> -re_copy_regs (regs, pmatch, nregs, regs_allocated)
> - =C2=A0 =C2=A0struct re_registers *regs;
> - =C2=A0 =C2=A0regmatch_t *pmatch;
> - =C2=A0 =C2=A0int nregs, regs_allocated;
> +re_copy_regs (struct re_registers *regs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regmatch_t *pmatch,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int nregs, int regs_alloc=
ated)
> =C2=A0{
> =C2=A0 int rval =3D REGS_REALLOCATE;
> =C2=A0 int i;
> @@ -570,11 +564,11 @@ re_copy_regs (regs, pmatch, nregs, regs_allocat=
ed)
> =C2=A0 =C2=A0freeing the old data. =C2=A0*/
>
> =C2=A0void
> -re_set_registers (bufp, regs, num_regs, starts, ends)
> - =C2=A0 =C2=A0struct re_pattern_buffer *bufp;
> - =C2=A0 =C2=A0struct re_registers *regs;
> - =C2=A0 =C2=A0unsigned num_regs;
> - =C2=A0 =C2=A0regoff_t *starts, *ends;
> +re_set_registers (struct re_pattern_buffer *bufp,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct re_r=
egisters *regs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned nu=
m_regs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regoff_t *s=
tarts,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regoff_t *e=
nds)
> =C2=A0{
> =C2=A0 if (num_regs)
> =C2=A0 =C2=A0 {
> @@ -621,13 +615,11 @@ re_exec (s)
> =C2=A0 =C2=A0(START + RANGE >=3D 0 && START + RANGE <=3D LENGTH) =C2=A0=
*/
>
> =C2=A0static reg_errcode_t
> -re_search_internal (preg, string, length, start, range, stop, nmatch=
, pmatch,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 efla=
gs)
> - =C2=A0 =C2=A0const regex_t *preg;
> - =C2=A0 =C2=A0const char *string;
> - =C2=A0 =C2=A0int length, start, range, stop, eflags;
> - =C2=A0 =C2=A0size_t nmatch;
> - =C2=A0 =C2=A0regmatch_t pmatch[];
> +re_search_internal (const regex_t *preg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cons=
t char *string,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int =
length, int start, int range, int stop,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
_t nmatch, regmatch_t pmatch[],
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int =
eflags)
> =C2=A0{
> =C2=A0 reg_errcode_t err;
> =C2=A0 const re_dfa_t *dfa =3D (const re_dfa_t *) preg->buffer;
> @@ -947,8 +939,7 @@ re_search_internal (preg, string, length, start, =
range, stop, nmatch, pmatch,
> =C2=A0}
>
> =C2=A0static reg_errcode_t
> -prune_impossible_nodes (mctx)
> - =C2=A0 =C2=A0 re_match_context_t *mctx;
> +prune_impossible_nodes (re_match_context_t *mctx)
> =C2=A0{
> =C2=A0 const re_dfa_t *const dfa =3D mctx->dfa;
> =C2=A0 int halt_node, match_last;
> --
> 1.7.2.1.364.gf88bdb
>
