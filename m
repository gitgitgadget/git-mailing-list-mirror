From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Document 'stash clear' recovery via unreachable commits
Date: Sun, 9 Aug 2009 14:56:52 +0530
Message-ID: <2e24e5b90908090226r1941c383j40853fd811ae3a73@mail.gmail.com>
References: <9e8ddf7c6c4d4df4150bff0467b461bfff92a401.1249778711.git.trast@student.ethz.ch>
	 <7veirlbwws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 11:27:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma4g9-0002jF-TV
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 11:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZHIJ0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Aug 2009 05:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZHIJ0x
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 05:26:53 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:60425 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbZHIJ0w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 05:26:52 -0400
Received: by yxe5 with SMTP id 5so3122696yxe.33
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9Yd45aCthwGvPFPezsh7mQzB/ww68N2ZZHASWC4cnoQ=;
        b=aWDizMWwm6ywIn2uCBqA2h4LfvOJ8Ct4LVeEIlVkq6eKPZAFG5bhPAvi9nCyv7rBUy
         8YN53mQYQtigByL2CFnB4P8zNBavLnW0u7lVp0tHNT6d+90po3VRQ79Gbv0GjoASSQnJ
         0Iic9Vv8BCNtBvJF/Duk4u29Rxp32eLJSndSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RWTEXZAZcH7DkjX9+elcicNcosboBEXABK1FKz+vhIhX5BhhzpRTaVp3/y9aYfaJVU
         q6FZ2k9rlAtXFdOUfQl15nq4dahuPxZjcrBzGm9s01inKaMDRDNVBGIakKAnki+WSSOR
         LdEaHqO8NxYpW2F8/XwfeG0zeAZCc20UPpJGg=
Received: by 10.231.32.134 with SMTP id c6mr1232593ibd.34.1249810012618; Sun, 
	09 Aug 2009 02:26:52 -0700 (PDT)
In-Reply-To: <7veirlbwws.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125336>

2009/8/9 Junio C Hamano <gitster@pobox.com>
>
> Thomas Rast <trast@student.ethz.ch> writes:


>
> > Unless you have merges of branch names containing WIP, or edit your
> > merge messages to say WIP, there will be no false positives.
>
> That may be true, but I suspect that people's stash entries that are =
worth
> saving are given their own messages with "git stash save 'message'" a=
nd do
> not necessarily say WIP. =A0I wish if there were a better way to iden=
tify
> them, but I do not think of any offhand.

gitk $(git fsck | grep commit | cut -f3 -d' ') --since=3D'1 week ago'

The --since clause limits the display to stashes lost recently; adjust =
to taste.

A "stash" has a very recognisable, triangular, shape in the commit DAG
-- with gitk you can visually find stashes really fast even if your
time limit is too broad or you have too many other kinds of
unreachable commits perhaps due to too many rebase etc.
