From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sat, 9 Jun 2012 17:08:20 -0400
Message-ID: <CAA3EhHJ9WnisF21iFfsjQKYFSY0t0jFvNV3aBjx0eGFPm8aoGg@mail.gmail.com>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com> <20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sat Jun 09 23:08:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdStq-0002vD-Fp
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 23:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371Ab2FIVIm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 17:08:42 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62774 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab2FIVIl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 17:08:41 -0400
Received: by vcbf11 with SMTP id f11so1551437vcb.19
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lMyU8tL63jNVWaRLFMvz9ELs2q3MzpttlFPuW8laB7w=;
        b=zybpPo3o57pWLVgrJg54ylcMPmOaEFeth+5SrtWP6NmTO3G0jVg+qN1oM8VKdEL2S7
         7uAaOgruxEEhhD6OgCs7lVlbL4cEl5SEmv0aS+ToS/4EFDluI5BwOM1GS0ahlgbaEe7L
         LLx4iMQIdapsSizKvWn0dHLIKWwUtLRAHKlRp7xPsZZFUFJ9OSywVyivKy2CxmaEbbqc
         b+22rvtXnGfGcGT+sWW2kiTZ/mZ/H5KWWZpV0BSXgz/C3GvGLGs6NpWpi/MOBihHHpmn
         Vrs4l5/v/MhAFYplDahEG3C55Fi8SWbLNK8WW8hzqMeTOy7Xa+vIiFjBMuLxDSMNON71
         Gk6w==
Received: by 10.220.230.135 with SMTP id jm7mr9582286vcb.23.1339276120783;
 Sat, 09 Jun 2012 14:08:40 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Sat, 9 Jun 2012 14:08:20 -0700 (PDT)
In-Reply-To: <20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199557>

On Sat, Jun 9, 2012 at 4:13 PM,  <konglu@minatec.inpg.fr> wrote:
>
> Leila Muhtasib <muhtasib@gmail.com> a =E9crit=A0:
>
>
>> =A0wt-status.c | =A0 24 +++++++++++++++++++-----
>> =A01 files changed, 19 insertions(+), 5 deletions(-)
>
>
> Do not forget to also update the test that need 'git
> status'. For example, most of the tests in t7508 are
> broken with your patch (the change is not huge, just
> adding "and directories" at the end of "untracked files:"
> here and there and maybe some other minor details).
> Otherwise, the idea seems good to me :).
>

Thanks! I didn't update the tests. I will do so now.

>
>> =A0 =A0 =A0 =A0for (i =3D 0; i < dir.nr; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct dir_entry *ent =3D dir.entries=
[i];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cache_name_is_other(ent->name, en=
t->len) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_pathspec(s->pathspec, en=
t->name, ent->len, 0,
>> NULL))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 string_list_insert(&s-=
>untracked, ent->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_pathspec(s->pathspec, en=
t->name, ent->len, 0,
>> NULL)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_empty_dir(ent->=
name)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 strbuf buf_name =3D STRBUF_INIT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf=
_addstr(&buf_name, ent->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf=
_addstr(&buf_name, " (empty
>> directories cannot be added)");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 string=
_list_insert(&s->untracked,
>> buf_name.buf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf=
_release(&buf_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 string=
_list_insert(&s->untracked,
>> ent->name);
>
>
> The structure is
> =A0 =A0 =A0if (...) {
> =A0 =A0 =A0 =A0 =A0 =A0 /*code*/
> =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 /*code*/
> =A0 =A0 =A0}
>
> Do not forget braces in the "else" part as the firt block needs it.

I was under the impression that one liners didn't require parenthesis
according to the style guidelines. I didn't realize that if the 'if'
required it, then the else required it. I will make that change and
remember it for the future. Thanks!

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
