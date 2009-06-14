From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Mon, 15 Jun 2009 00:03:27 +0200
Message-ID: <81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com>
References: <87bpoqoavp.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 00:03:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFxnZ-0003Fu-TP
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 00:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764715AbZFNWD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2009 18:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764716AbZFNWD1
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 18:03:27 -0400
Received: from mail-fx0-f207.google.com ([209.85.220.207]:41439 "EHLO
	mail-fx0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764713AbZFNWD0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2009 18:03:26 -0400
Received: by fxm3 with SMTP id 3so258359fxm.37
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3WaHiAj73/8a9y5ihhVFR+uD9iG6wccXW+BMehJY6jc=;
        b=voo9xlg01gOdO30DSEbOqfxmPTTP8YYE7DARhInf3Q25HwQB7QHFAW3RU9J4mM3oXU
         uAHxe1e6t9RAorm4NYt0WJ+h9VABHHP/8Tp/BkD60oJcqN097PBivrw3UTREAZ/GOH9T
         C21tRBYWxg0QeUYtunzcrxwdBNdvKi/8iLKSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W3+QMTBgufZwRCoLTpq2TXOUGcNAYEStSLt2LHlZq6rNcJRUfH17f9of3ZUkoxYMKy
         WZWnMBTQgE69saoxCNsWomyv+20/FF41VwZsbRpEQ70Ls7H+cJU/XOyYQLGi3P23FoPW
         Bg49vi++KCJMbNspjba+2Mw3xVF6AwA0oCwHQ=
Received: by 10.204.65.65 with SMTP id h1mr6338229bki.26.1245017007390; Sun, 
	14 Jun 2009 15:03:27 -0700 (PDT)
In-Reply-To: <87bpoqoavp.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121565>

2009/6/14 Jim Meyering <jim@meyering.net>:
> @@ -231,7 +231,7 @@ static int read_merge_config(const char *var, con=
st char *value, void *cb)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(var, "merge.default")) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 default_ll_merge =3D strdup(value);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 default_ll_merge =3D xstrdup(value);

read_merge_config has a failure mode (where it returns -1), why not use=
 it?
