From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/9] Add infrastructure to write revisions in fast-export 
	format
Date: Thu, 24 Jun 2010 21:29:29 +0200
Message-ID: <AANLkTikyjq7HQY1hUTOGF_oBsGDj_jUI-GwDBRdacCzG@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624110217.GG12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 21:29:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORs7Y-0003Os-FT
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 21:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab0FXT3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 15:29:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40302 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab0FXT3u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 15:29:50 -0400
Received: by gwaa18 with SMTP id a18so969305gwa.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dHbsFw3UHIQYxTr59nDr79e4wuQWte0zxOvColwLmg0=;
        b=xq1bMF1wUZtmea+0Z7YiANBLkuAmy5/xTTNLNMKG//5yLHXgtqH3FuEyUcifu+vMxP
         JNc7PxoIi6sTRtlgfYumXF43WIpjz/Cg41+U9UC/4zwcmBrimmt9HOh1aWXQOpJO9lV2
         Mb1kL0hsN+c7ca3+Ck8WK/acb+2YjdrTr62QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eseNTeHDxofG+KkrSt3fX46TJqp6V8++mrv9psciA2fPPh6u/Gagmg3rHuFewoXkhU
         cYMEi7BsfHqJ3F7DWuNbFuOSJw3hPpzoVE+zFlXLP0hZ47zaxkjZ2DKYa+Rrev4ECamM
         DasHmGooJAjURYTbN2eRNlrteS/4LJrMLLVMM=
Received: by 10.229.234.3 with SMTP id ka3mr5631903qcb.261.1277407789158; Thu, 
	24 Jun 2010 12:29:49 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 12:29:29 -0700 (PDT)
In-Reply-To: <20100624110217.GG12376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149625>

Hi again,

Jonathan Nieder wrote:
> repo_tree maintains the exporter's state and provides a facility to t=
o
> call fast_export, which writes objects to stdout suitable for
> consumption by fast-import.

These files will also change significantly in a few days- see the
ternary_treap branch.

> The exported functions roughly correspond to Subversion FS operations=
=2E

This description is sufficient for the commit message.

> =C2=A0. repo_add adds a file to the current commit.
>
> =C2=A0. repo_modify adds a replacement for an existing file;
> =C2=A0 it is implemented exactly the same way, but a check could be
> =C2=A0 added later to distinguish the two cases.
>
> =C2=A0. repo_copy copies a blob from a previous revision to the curre=
nt
> =C2=A0 commit.
>
> =C2=A0. repo_replace modifies the content of a file from the current
> =C2=A0 commit, if and only if it exists.
>
> =C2=A0. repo_delete removes a file or directory from the current comm=
it.
>
> =C2=A0. repo_commit calls out to fast_export to write the current com=
mit to
> =C2=A0 the fast-import stream in stdout.
>
> =C2=A0. repo_diff is used by the fast_export module to write the chan=
ges
> =C2=A0 for a commit.
>
> =C2=A0. repo_reset erases the exporter's state, so valgrind can be ha=
ppy.

This is like API documentation- should it go into the commit message?
Maybe put this in a a dedicated repo_tree.txt like trp.h?

-- Ram
