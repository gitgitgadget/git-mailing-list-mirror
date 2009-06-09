From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 5/5] builtin-remote: Make "remote -v" display push urls
Date: Tue, 9 Jun 2009 18:25:41 +0200
Message-ID: <36ca99e90906090925q71ed98f4j23336dabbe199bd8@mail.gmail.com>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
	 <1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>
	 <1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>
	 <1244563298-15479-4-git-send-email-git@drmicha.warpmail.net>
	 <1244563298-15479-5-git-send-email-git@drmicha.warpmail.net>
	 <1244563298-15479-6-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 18:25:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME492-0005RX-74
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037AbZFIQZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 12:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbZFIQZm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:25:42 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:44871 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbZFIQZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 12:25:41 -0400
Received: by fxm9 with SMTP id 9so114996fxm.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FzB/jPsnbVHXCHgJU3YM6k3sLWps7gl34OLCkYdT2wY=;
        b=n65sGlKg5DgdrNy1eCy+s8K1QlbfbVcyUhaec5VasegyykpbI0O+j7BrxoWSAnYEip
         9y4mQPJyA9BV0/0RdRr4uGzj4AdRmSXPTa4Pm8idxgLv6xUfE31AyoOvWgPUbdGni8hQ
         6kVqu6XYVdm3R41zqtt+J6+QLQKgRWON4OIvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wrJMhotlsuUA8KjLXzByd5WuIqh0PoefJNquvva1yH0zuTps7Fc6mN0+jq3/KT/pFy
         z8gl99tytWshOD48Cjo+OPcBkpdqXGVf7cuqQ2ERrybD7ZGjCKUWy5ci84SvNlA8amKr
         w8whCl0tJD3AWL5kevNu2vfDom4Ti/GGY3KNo=
Received: by 10.223.104.74 with SMTP id n10mr349800fao.5.1244564741942; Tue, 
	09 Jun 2009 09:25:41 -0700 (PDT)
In-Reply-To: <1244563298-15479-6-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121187>

Hi,

On Tue, Jun 9, 2009 at 18:01, Michael J Gruber<git@drmicha.warpmail.net=
> wrote:
> Currently, "remote -v" simply lists all urls so that one has to remem=
ber
> that only the first one is used for fetches, and all are used for
> pushes.
>
> Change this so that the role of an url is displayed in parentheses, a=
nd
> also display push urls.
>
> Example with "mjg" having 1 url and 1 pushurl, "origin" having 3 urls=
,
> sb having 1 url:
>
> mjg =C2=A0 =C2=A0 git://repo.or.cz/git/mjg.git (fetch)
> mjg =C2=A0 =C2=A0 repoor:/srv/git/git/mjg.git (push)
> origin =C2=A0git://repo.or.cz/git.git (fetch)
> origin =C2=A0git://repo.or.cz/git.git (push)
> origin =C2=A0git://git2.kernel.org/pub/scm/git/git.git (push)
> origin =C2=A0git://repo.or.cz/alt-git.git (push)
> sb =C2=A0 =C2=A0 =C2=A0git://repo.or.cz/git/sbeyer.git (fetch)
> sb =C2=A0 =C2=A0 =C2=A0git://repo.or.cz/git/sbeyer.git (push)

Wouldn't it be more readable if push|fetch comes first?

mjg     (fetch) git://repo.or.cz/git/mjg.git
mjg     (push)  repoor:/srv/git/git/mjg.git
origin  (fetch) git://repo.or.cz/git.git
origin  (push)  git://repo.or.cz/git.git
origin  (push)  git://git2.kernel.org/pub/scm/git/git.git
origin  (push)  git://repo.or.cz/alt-git.git
sb      (fetch) git://repo.or.cz/git/sbeyer.git
sb      (push)  git://repo.or.cz/git/sbeyer.git

And how about to print only one line for (url_nr =3D=3D 1 && pushurl_nr=
 =3D=3D 0):

mjg     (fetch) git://repo.or.cz/git/mjg.git
mjg     (push)  repoor:/srv/git/git/mjg.git
origin  (fetch) git://repo.or.cz/git.git
origin  (push)  git://repo.or.cz/git.git
origin  (push)  git://git2.kernel.org/pub/scm/git/git.git
origin  (push)  git://repo.or.cz/alt-git.git
sb              git://repo.or.cz/git/sbeyer.git

>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> =C2=A0builtin-remote.c | =C2=A0 27 +++++++++++++++++++++++----
> =C2=A01 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/builtin-remote.c b/builtin-remote.c
> index b350b18..80b2536 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -1276,14 +1276,31 @@ static int update(int argc, const char **argv=
)
> =C2=A0static int get_one_entry(struct remote *remote, void *priv)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct string_list *list =3D priv;
> + =C2=A0 =C2=A0 =C2=A0 const char **url;
> + =C2=A0 =C2=A0 =C2=A0 int i, url_nr;
> + =C2=A0 =C2=A0 =C2=A0 void **utilp;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (remote->url_nr > 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < =
remote->url_nr; i++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 string_list_append(remote->name, list)->util =3D (void *)remote=
->url[i];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 utilp =3D &(string=
_list_append(remote->name, list)->util);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *utilp =3D malloc(=
strlen(remote->url[0])+strlen(" (fetch)")+1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcpy((char *) *u=
tilp, remote->url[0]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcat((char *) *u=
tilp, " (fetch)");
How about using struct strbuf?

Bert
