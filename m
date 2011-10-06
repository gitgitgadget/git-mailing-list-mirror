From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Merge seems to overwrite unstaged local changes
Date: Thu, 06 Oct 2011 08:35:59 -0700 (PDT)
Message-ID: <m3zkhe16bu.fsf@localhost.localdomain>
References: <j5v9r7$fi1$1@dough.gmane.org>
	<7vaa9o1yf7.fsf@alter.siamese.dyndns.org>
	<CAHGBnuNrhtyq1tfok3p9YHAVbfo9T7BO3ZOUy+8YvNE9Mmhjhg@mail.gmail.com>
	<4E8DACCC.2050302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 17:36:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBpzX-0003uI-JH
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 17:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758400Ab1JFPgF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 11:36:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59183 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756594Ab1JFPgD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 11:36:03 -0400
Received: by gyg10 with SMTP id 10so2696015gyg.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=ShtXIaR3zbkSyYDSktIIiQ/jCmBp8QaMFA3266zFTBI=;
        b=h+BJ/haHMR66/pEfPSXc6SZOXjNwJUZ9Ao1NOX/AKBrRfSZnCIQp9GVUPZxgSll4Ea
         IBnLNRYMBswaNObTPDIKTawFNenCuOZERm87CMwMCtkBDmrtp2AdIRiDVjlKQF/omo0q
         61xJnl4rJcj7bUbgqiMEVKxt7QYsJSw3Aga1Y=
Received: by 10.223.17.11 with SMTP id q11mr4267892faa.13.1317915362490;
        Thu, 06 Oct 2011 08:36:02 -0700 (PDT)
Received: from localhost.localdomain (abvr174.neoplus.adsl.tpnet.pl. [83.8.215.174])
        by mx.google.com with ESMTPS id h16sm7555947fab.19.2011.10.06.08.35.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 08:35:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p96FZYZW010200;
	Thu, 6 Oct 2011 17:35:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p96FZHGh010187;
	Thu, 6 Oct 2011 17:35:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E8DACCC.2050302@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182959>

Sebastian Schuberth <sschuberth@gmail.com> writes:
> On 29.09.2011 15:07, Sebastian Schuberth wrote:
>=20
>>> There recently have been quite a change in merge-recursive implemen=
tation
>>> and it would be really nice if you can try this again with the tip =
of
>>> 'master' before 1.7.7 final ships.
>>
>> The unstaged changes do not seem to get lost during the merge anymor=
e
>> when using git version 1.7.7.rc3.4.g8d714 on Linux. I guess that
>> somewhat confirms that there's a bug in git<  1.7.7. I'll write a wo=
rd
>> of warning to our in-house git users that they should always commit
>> before merging ...
>=20
> It seems I'm not the only one who lost code due to this bug. For a
> more detailed analysis see this blog post:
>=20
> http://benno.id.au/blog/2011/10/01/git-recursive-merge-broken
>=20
> As it turns out, my use case also involves a rename of the file in
> which changes were lost. And just like for the blog's author it
> somewhat concerns me and shakes my confidence in Git for how long thi=
s
> severe bug slipped through undetected.

Khmmm... perhaps Mercurial was right in its transaction-based
atomicity (that allows to safely merge even if there are local
changes; not theough that I have doubts if it is sane behavior)
;-)

I wonder if it would be possible to get some Comp. Sci. student, or
graduate, or postdoc, to analyse formally the recursive merge
algorithm.  And to *prove* that it is correct (or not).

--=20
Jakub Nar=EAbski
