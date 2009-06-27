From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 1/9] gitweb: refactor author name insertion
Date: Sat, 27 Jun 2009 17:26:29 +0200
Message-ID: <cb7bb73a0906270826y45f3f9f1lec720aa4dad2a237@mail.gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906271624.52372.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 17:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKZou-0003aj-RE
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 17:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbZF0P03 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2009 11:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbZF0P02
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 11:26:28 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:38236 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbZF0P01 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jun 2009 11:26:27 -0400
Received: by bwz9 with SMTP id 9so2512973bwz.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yt7im4sV/M07fLic8lYfnmVhslsjQIKhcJoXo4kYftI=;
        b=UdZCoVEJYHG1X8S4ST3TPR9ISnrJSmRWmEAsWeMCUVx0mwpJVu1GINakDk/+w58ean
         eVQcN10pvtSVLyyBaHIsedXyPCLMpAU5jdaAwmUDUYtZl9ONWn+POKdPdo8CJ3HB7GmK
         5rRlUFK2ZCMGwAzpR84bVt7l0QRGuQwL5igCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Yf8fBlXe242zPgw3LW3t6YcKeZIQoPkNw+GQqcM/ZqKDN3EoWlIyvfBjwZmDbQ6XLM
         HYPjsfRzvTUa7HFPJDncb1tNpH1V4jdUV2E7tfP3STEMS3RU2/T9ULyutUORqf++8lwM
         3X2OyUoc7zDhFsHlhbo3b86R5vI8weT8xqQDo=
Received: by 10.204.60.72 with SMTP id o8mr4895679bkh.184.1246116389485; Sat, 
	27 Jun 2009 08:26:29 -0700 (PDT)
In-Reply-To: <200906271624.52372.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122367>

2009/6/27 Jakub Narebski <jnareb@gmail.com>:
> By the way, this "atnight" warning is duplicated in subroutine below
> git_print_authorship_rows(), but IMHO it is not something very import=
ant.
> It can be left for later.

I'll resend this patch, with this thing refactored too, and with the
localtime fix.

>> + =A0 =A0 foreach my $who (@people) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 my %ad =3D parse_date($co->{$who . '_epoch=
'}, $co->{$who . '_tz'});
>
> Wouldn't
>
> =A0$co->{"${who}_epoch"}
>
> be simpler than
>
> =A0$co->{$who . '_epoch'}
>
> Also it is now %wd (%who_date) or just %date rather than
> %ad (%author_date) vs %cd (%committer_date).
>
>
> Both of those issues are very, very minor.

But I can tune them out 8-)

> Nice... although this set of diff chunks made me wonder why we
> use "10" for 'shortlog', "15, 3" for 'history, and "15, 5" for
> 'search' (grep).

I don't know about that. It might be worth considering unifying them.

> Thanks again for your diligent work on this patch series!

Thank you very much for your comments. I could clearly see the code
improving significantly at each iteration. It's a great sastisfaction,
even though it's quite some work.

--=20
Giuseppe "Oblomov" Bilotta
