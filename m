From: =?UTF-8?B?RsO8emVzaSBab2x0w6Fu?= <zfuzesi@eaglet.hu>
Subject: Re: [PATCH/RFC] gitweb: parse_commit_text encoding fix
Date: Sat, 1 Aug 2009 18:55:34 +0200
Message-ID: <9ab80d150908010955l3710c54bp9e2716570fd1d5ed@mail.gmail.com>
References: <1249115323-17974-1-git-send-email-zfuzesi@eaglet.hu>
	 <m3r5vvris1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 18:55:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXHrz-0006BZ-95
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 18:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbZHAQzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 12:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbZHAQzf
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 12:55:35 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39006 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbZHAQzf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 12:55:35 -0400
Received: by bwz19 with SMTP id 19so1716392bwz.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 09:55:34 -0700 (PDT)
Received: by 10.204.57.19 with SMTP id a19mr4063742bkh.194.1249145734809; Sat, 
	01 Aug 2009 09:55:34 -0700 (PDT)
In-Reply-To: <m3r5vvris1.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124638>

2009/8/1 Jakub Narebski <jnareb@gmail.com>:
>
> Thanks.
>
>
> Still, I do wonder if it would be possible to simply do the following=
:
>
> =C2=A0-binmode STDOUT, ':utf8';
> =C2=A0+use open qw(:std :utf8);
>
> ...but it unfortunately doesn't work. =C2=A0It was tried in
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/87129/fo=
cus=3D87135
>
> to_utf8() has at least (possible) fallback if it encounters character=
s
> outside of UTF-8 coding.
>

The following 2 changes in my patch are unnecessary, but please
confirm (I'm not familiar with perl (yet)):

-                               $co{'author_name'}  =3D $1;
+                               $co{'author_name'}  =3D to_utf8($1);

-                               $co{'committer_name'}  =3D $1;
+                               $co{'committer_name'}  =3D to_utf8($1);

BR,
Z=C3=A9
