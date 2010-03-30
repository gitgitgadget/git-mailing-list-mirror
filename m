From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git check-attr in bare repositories
Date: Tue, 30 Mar 2010 14:39:25 -0700 (PDT)
Message-ID: <m3iq8dij6r.fsf@localhost.localdomain>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
	<20100328014208.GA23015@progeny.tock>
	<19376.50971.397375.810974@winooski.ccs.neu.edu>
	<19376.53419.640007.930897@winooski.ccs.neu.edu>
	<20100329231501.GA28194@progeny.tock>
	<19377.33747.838003.360864@winooski.ccs.neu.edu>
	<20100330212222.GA11192@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 23:39:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwj9q-00048y-Vz
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 23:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab0C3Vja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 17:39:30 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:36384 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab0C3Vj3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 17:39:29 -0400
Received: by bwz1 with SMTP id 1so4753327bwz.21
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=uuHJ0YWVCq5/fCfVXs1fH4kRkpOLekddyxdAfFoEu5Q=;
        b=gsEGVvilo2wnTjEv6u3vUq71j5HF/rXvX/fSID3XLT+rEkOgYKWlUsopACsndgvrU8
         rhWNx0GLuXOWiSoozrzPv7EHEW+E6CUAXSOt7I1/888fNrH8kOyWVAWxQ8hGxZ2gYOu1
         vlMT2MuC3DDW3HCRnegiMfiZHpTKKcVj4xsGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=tD2VO8KgpPOrz4PBVaAziX+GGumRNGZlnMMzUm5fSXJJ9ajugFudDmJn68kzZ1213L
         eUbq8Jhp/b3sjLhvXG1UKbaL+84OYPBpuQusZqVqi6fZJ2WHthP9x4zUUuLNWxgKodz9
         9DnVepVq2NSZBu1nygTJpv6HEx4M/qlP+y/4I=
Received: by 10.204.30.195 with SMTP id v3mr3503499bkc.3.1269985167534;
        Tue, 30 Mar 2010 14:39:27 -0700 (PDT)
Received: from localhost.localdomain (abvx12.neoplus.adsl.tpnet.pl [83.8.221.12])
        by mx.google.com with ESMTPS id d5sm51337724bkd.19.2010.03.30.14.39.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 14:39:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2ULcsDp019041;
	Tue, 30 Mar 2010 23:39:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2ULcb9N019031;
	Tue, 30 Mar 2010 23:38:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100330212222.GA11192@progeny.tock>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143606>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Eli Barzilay wrote:
>=20
> > Well, using the index this way seems like a kind of a hack anyway, =
so
> > I'm not sure that there is any reason to do this.
>=20
> Most git commands do write out the tree they are working with to an
> (in-memory or on-disk) index, so using the index this way would make =
a
> warped kind of sense.  But I agree that it is ugly.
>=20
> > If anything, I'd
> > like it if `check-attr' could just use the repository directly inst=
ead
> > of the index (or a work tree) in a bare repository.
>=20
> I think the right thing to do is to put this functionality in a new
> =A1git ls=A2 command.  Maybe something like this:
>=20
>  $ git ls --format=3D'%p %a(crlf)' master -- '*.txt'
>  some/path/foo.txt crlf:input
>  some/path/bar.txt crlf
>  some/path/other.txt !crlf
>  yet/another/path.txt=20
>  $

Well, that or make `git check-attr` support reading .gitattributes
from repository (from a corresponding tree object).

Unfortunately `git check-attr` doesn't have place to put revision...
well unless as a parameter:

  git check-attr [--cached|--tree <tree-ish>] <attr>... [--] <pathname>=
=2E..

--=20
Jakub Narebski
Poland
ShadeHawk on #git
