From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Q. regarding subtree merge
Date: Fri, 18 Apr 2008 14:59:57 +0200
Message-ID: <8aa486160804180559y70c72449g8f0beff63c229c7b@mail.gmail.com>
References: <loom.20080418T091729-407@post.gmane.org>
	 <8aa486160804180302m43a7c942la93954401741b264@mail.gmail.com>
	 <8aa486160804180309o26ab9c69j2b3b665a280bf7c4@mail.gmail.com>
	 <60b759020804180518k2fc1957bk60a5d7cdac8c3991@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Stefan_N=E4we?=" <stefan.naewe@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 15:07:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmqDi-0002cW-Rs
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 15:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbYDRNAx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2008 09:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366AbYDRNAx
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 09:00:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:1473 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbYDRNAv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2008 09:00:51 -0400
Received: by yw-out-2324.google.com with SMTP id 5so368467ywb.1
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sysFpUlOctAeNrI9ChT9mYFgA7owNFK+tEje8LWICTE=;
        b=cXc7or4v1hdEY2xLtdJlFVa3pUxvuEQrbcYjFkjm+PfMB6qYcZs0HMrakWZyWiHxBr+hk5LoZGvGXya5a1Cytwls1znqgxOtqmQLt92tjfi8Sy7dwk6rjUl70Tv6VNwBUOqIwz6eZKDPokONwvXTqqveETriKsndUQUzh31RqX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RUqrFageEnH9gDGsTwgpslRNUgzUh2KXzbt5him/C7OIKaT7xlk+20Mx/gv2cRy6U+WyKwXK1qpW8cm/7Q0Bz7LopkLofrlm2WRmOd4P+nIup3axz0e14Qa3Y2wiZRgLuKaz3WMVfxKqoB/kG63ESp1+yeUTOdiS7LgKyTeoPzc=
Received: by 10.151.15.9 with SMTP id s9mr3541803ybi.215.1208523597101;
        Fri, 18 Apr 2008 05:59:57 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Fri, 18 Apr 2008 05:59:57 -0700 (PDT)
In-Reply-To: <60b759020804180518k2fc1957bk60a5d7cdac8c3991@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79887>

On Fri, Apr 18, 2008 at 2:18 PM, Stefan N=E4we
<stefan.naewe@googlemail.com> wrote:
> 2008/4/18, Santi B=E9jar <sbejar@gmail.com>:
>
[...]

>  >
>  >  $ git reset --soft libfoo/current-work
>  >
>
>  OK. Thanks. It worked without the merge.
>  I did another test where the 'super-prj' was not empty, this time wi=
th
>  'git merge -s...' and
>  that worked as well. So:
>  If you have an empty super-prj    -> drop the merge

+ git reset --soft commit

If not the next "git merge -s subtree" will fail.

>  If you have a non-empty super-prj -> do the merge
>
>  But I really don't understand (yet...) why it is as it is...

Because you cannot merge an empty branch with another branch.
Maybe "git merge -s ours" should fail in this case, because it does not
make sense to merge an empty branch with the "ours" strategy.

Santi
