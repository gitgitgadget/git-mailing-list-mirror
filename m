From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [patch 02/16] const-expr.patch
Date: Tue, 27 Apr 2010 16:08:24 +0200
Message-ID: <l2t40aa078e1004270708w905ae1e1lbead0f21acc70dee@mail.gmail.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
	 <20100427135812.656626000@mlists.thewrittenword.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 16:08:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lSl-0001dW-L0
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab0D0OI1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 10:08:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57772 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab0D0OI0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 10:08:26 -0400
Received: by wyb42 with SMTP id 42so771532wyb.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 07:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=BZ54gTty/mzGDluGvHfDd/aufY8WqO7ITB9KQBWKMgs=;
        b=GmhqJ5B8yZaAOU4aVlPEOB3zXPxPfhS3RFxK9zV4BiHh97Y/GMLBNrfOEeipkVmzPo
         RmV/2adqgtF2BTd3fW1Aau0SwVL5QilyZIyqqJQLPjtfQzjq683DPgV3Y07RjktIjS1z
         P8i98NHTOoAdLXoyKRYZyxd33TMh9F9qpCm/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=CX1x0qNFZcHwqYFp/ZGyObYOI2EOUS9VWRoZhkC1fnRUMedUCdHsAzgxEmXdGkO+2C
         kx+bBxY/tbghvoObITY3RKtFHG274+q+XisyMH+nLS7ELXhyA1BbllJp1xDIMMRnQ9PL
         9exMhSo2ja8auAcAjwMhIWedp9bQPfP7qZ7bA=
Received: by 10.216.88.134 with SMTP id a6mr2190651wef.66.1272377304139; Tue, 
	27 Apr 2010 07:08:24 -0700 (PDT)
Received: by 10.216.51.79 with HTTP; Tue, 27 Apr 2010 07:08:24 -0700 (PDT)
In-Reply-To: <20100427135812.656626000@mlists.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145919>

On Tue, Apr 27, 2010 at 3:57 PM, Gary V. Vaughan
<git@mlists.thewrittenword.com> wrote:
> Index: b/unpack-trees.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -287,9 +287,11 @@ static void add_same_unmerged(struct cac
> =A0static int unpack_index_entry(struct cache_entry *ce,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct unp=
ack_trees_options *o)
> =A0{
> - =A0 =A0 =A0 struct cache_entry *src[5] =3D { ce, NULL, };
> + =A0 =A0 =A0 struct cache_entry *src[5] =3D { NULL, NULL };

You don't need NULL twice when the array-size is specified, it's just
confusing as the array has 5 elements.

> Index: b/builtin/commit.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -717,7 +717,8 @@ static int prepare_to_commit(const char
>
> =A0 =A0 =A0 =A0if (use_editor) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char index[PATH_MAX];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *env[2] =3D { index, NULL };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *env[] =3D { NULL, NULL };

Why not "const char *env[2] =3D { NULL };", as it's shorter?

> Index: b/builtin/cat-file.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -118,7 +118,9 @@ static int cat_one_file(int opt, const c
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* custom pretty-print here */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (type =3D=3D OBJ_TREE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *ls_args[3] =
=3D {"ls-tree", obj_name, NULL};
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *ls_args[3] =
=3D { NULL, NULL, NULL };

Again, you don't need to repeat NULL.

--=20
Erik "kusma" Faye-Lund
