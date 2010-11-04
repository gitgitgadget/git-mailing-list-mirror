From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 4 Nov 2010 01:53:57 +0100
Message-ID: <AANLkTimcYdQD-En+SfkH5dkaxaWXveuA5Oz-Hn0Cf1v+@mail.gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
 <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
 <AANLkTin6120QbxyxHt=UM9Dpk_3C-vaD2z8RaRuut76r@mail.gmail.com> <8739rind8u.fsf@fox.patthoyts.tk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 01:54:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDo5x-0006WO-9K
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 01:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab0KDAyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 20:54:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43858 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab0KDAyT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 20:54:19 -0400
Received: by fxm16 with SMTP id 16so1036183fxm.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 17:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=VZ/5aKwc/jbzQcLPaMU6UPHdQNtFYemJ5+ncTpMkoxo=;
        b=cMx8ZcoQT60kbxnAhn9KCyDSxxu65mHxlkFMDzSJC7KtMuOitLdcd5VUlDDv2diSq4
         oH2b4N9n8GkgwnvB9+aCaP3pkJhhdi20jMoIwJ8HUE0/yjfvGhw8JbLiCNX80fnWYxnC
         ezB6C7dl5KhF/BfCh6mtdltCUeOrKlmQTx+50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Jyz6AgEUvah5cQOjmoNMm0e+t9UM03QTV/dU8ilWm23VXJ8X+CAq7Mbb3PZIHyKhtp
         gkBkf1AOuavxxbuIYM43y1X++Foh0lH2KMgrRXhgkT0gyBNqsNz0fWEBJpV1Dg7wuBNF
         0O3K2CH3pd7v1FryGAcgegBaGFspSZJVi5uo4=
Received: by 10.223.83.133 with SMTP id f5mr18567fal.29.1288832057384; Wed, 03
 Nov 2010 17:54:17 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Wed, 3 Nov 2010 17:53:57 -0700 (PDT)
In-Reply-To: <8739rind8u.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160657>

On Thu, Nov 4, 2010 at 1:28 AM, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>> index b780200..47e7d26 100644
>>> --- a/compat/mingw.c
>>> +++ b/compat/mingw.c
>>> @@ -1519,8 +1519,10 @@ pid_t waitpid(pid_t pid, int *status, unsign=
ed options)
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0if (pid > 0 && options & WNOHANG) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleO=
bject((HANDLE)pid, 0))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleO=
bject((HANDLE)pid, 0)) {
>>
>>AAAND the last one is right here as well:
>>- =A0 =A0 =A0 =A0 =A0 =A0 =A0if (WAIT_OBJECT_0 !=3D WaitForSingleObje=
ct((HANDLE)pid, 0))
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (WAIT_OBJECT_0 !=3D WaitForSingleObje=
ct(h, 0)) {
>>
>
> Applying both of these doesn't fix the handle leak when I test
> this. Looking further I believe it is due to the use of a reallocated
> array. When you remove a pinfo structure you realloc to the one you
> found, potentially freeing items you still require.
>

If this is the reason, then that's a bug. The code TRIES to do the
right thing by memmove'ing the the entro to be deleted to the end.
Looking over the code, I still don't see anyhing obviously wrong.
But...

> Attached is a patch that switches to a linked list for this
> instead. Using this I no longer accumulate leaked handles.
>
> ----
> From e0c05f8f9ed8729648eea92cf654f357fa884e40 Mon Sep 17 00:00:00 200=
1
> From: Pat Thoyts <patthoyts@users.sourceforge.net>
> Date: Thu, 4 Nov 2010 00:23:08 +0000
> Subject: [PATCH] win32-daemon: fix handle leaks
>
> The use of an array of pinfo structures and the realloc used when cle=
aning
> up a closed child can free structures that are still in use. Use a li=
nked
> list instead.
> This stops the leaking of handles in the win32-daemon.
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
> =A0compat/mingw.c | =A0 43 ++++++++++++++++++++++++------------------=
-
> =A01 files changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index b780200..29f4036 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -637,11 +637,12 @@ static int env_compare(const void *a, const voi=
d *b)
> =A0 =A0 =A0 =A0return strcasecmp(*ea, *eb);
> =A0}
>
> -struct {
> +struct pinfo_t {
> + =A0 =A0 =A0 struct pinfo_t *next;
> =A0 =A0 =A0 =A0pid_t pid;
> =A0 =A0 =A0 =A0HANDLE proc;
> -} *pinfo;
> -static int num_pinfo;
> +} pinfo_t;
> +struct pinfo_t *pinfo =3D NULL;
> =A0CRITICAL_SECTION pinfo_cs;
>
> =A0static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, =
char **env,
> @@ -746,10 +747,13 @@ static pid_t mingw_spawnve_fd(const char *cmd, =
const char **argv, char **env,
> =A0 =A0 =A0 =A0 * Keep the handle in a list for waitpid.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0EnterCriticalSection(&pinfo_cs);
> - =A0 =A0 =A0 num_pinfo++;
> - =A0 =A0 =A0 pinfo =3D xrealloc(pinfo, sizeof(*pinfo) * num_pinfo);
> - =A0 =A0 =A0 pinfo[num_pinfo - 1].pid =3D pi.dwProcessId;
> - =A0 =A0 =A0 pinfo[num_pinfo - 1].proc =3D pi.hProcess;
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pinfo_t *info =3D xmalloc(sizeof=
(struct pinfo_t));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->pid =3D pi.dwProcessId;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->proc =3D pi.hProcess;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->next =3D pinfo;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinfo =3D info;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0LeaveCriticalSection(&pinfo_cs);
>
> =A0 =A0 =A0 =A0return (pid_t)pi.dwProcessId;
> @@ -1519,13 +1523,15 @@ pid_t waitpid(pid_t pid, int *status, unsigne=
d options)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (pid > 0 && options & WNOHANG) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleObj=
ect((HANDLE)pid, 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleObj=
ect(h, 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CloseHandle(h);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0options &=3D ~WNOHANG;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (options =3D=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pinfo_t **ppinfo;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (WaitForSingleObject(h, INFINITE) !=
=3D WAIT_OBJECT_0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CloseHandle(h);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> @@ -1536,17 +1542,16 @@ pid_t waitpid(pid_t pid, int *status, unsigne=
d options)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EnterCriticalSection(&pinfo_cs);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < num_pinfo; ++i)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pinfo[i].pid =3D=3D=
 pid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppinfo =3D &pinfo;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (*ppinfo) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pinfo_t *info =3D=
 *ppinfo;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->pid =3D=3D pi=
d) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CloseHa=
ndle(info->proc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ppinfo=
 =3D info->next;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(in=
fo);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i < num_pinfo) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CloseHandle(pinfo[i].pr=
oc);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memmove(pinfo + i, pinf=
o + i + 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*pinfo) =
* (num_pinfo - i - 1));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_pinfo--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinfo =3D xrealloc(pinf=
o,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*pinfo) =
* num_pinfo);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppinfo =3D &info->next;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LeaveCriticalSection(&pinfo_cs);

=2E..yeah, using a linked list is more elegant. Do you mind if I snatch
your code and leave a comment in the commit message?
