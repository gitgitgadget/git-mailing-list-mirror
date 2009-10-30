From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool 
	option
Date: Fri, 30 Oct 2009 11:17:09 -0400
Message-ID: <76718490910300817w776bde48j40de31e5532b9fd4@mail.gmail.com>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
	 <200910300202.02016.markus.heidelberg@web.de>
	 <76718490910292000t7b024b83y68d71b6ff810c15@mail.gmail.com>
	 <200910301135.59831.markus.heidelberg@web.de>
	 <3f4fd2640910300425q602471a6v1111a7dceee7746c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <charles@hashpling.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Reece Dunn <msclrhd@googlemail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 16:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3tET-0003bP-QP
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 16:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbZJ3PRH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 11:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbZJ3PRH
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 11:17:07 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:49234 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322AbZJ3PRE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 11:17:04 -0400
Received: by iwn10 with SMTP id 10so2188485iwn.4
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9tBedcMjypEW+QaIIkukrDsl1SxwH8PqiY8wqINxgjM=;
        b=fGKVJv+DgkxyP4AfJoKBFJ+CVx0R1zWRWAzFmElszPxUqxuHlHKgEgy/Lwe58gCdrB
         ppl8VlF04rz59fhNfs6oSAVjViRh6U+UXEsAMA2R7+ypmY5TmG/m51XsT24D3jFfQ3Cw
         JadM5aIxSXxq6F3wztwVp2hTqrcrl0hh7NwSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eM9Fg03IehjkD8M7xtEg16uyCxxrX1cKHCmG8lnPjoei7u1ozj1hSeLRluvtUfWFOb
         8RYamVdq82vkuuSIKfNWUJTh9CMTFPAWusY7UG+TJcZM+u1WvqnzGIdf+Z+zLAaFvnFG
         N40n1nfFOyN9TsTSjmZp3M725ewJQ+5AUO+oA=
Received: by 10.231.148.135 with SMTP id p7mr4892252ibv.27.1256915829595; Fri, 
	30 Oct 2009 08:17:09 -0700 (PDT)
In-Reply-To: <3f4fd2640910300425q602471a6v1111a7dceee7746c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131710>

On Fri, Oct 30, 2009 at 7:25 AM, Reece Dunn <msclrhd@googlemail.com> wr=
ote:
> 2009/10/30 Markus Heidelberg <markus.heidelberg@web.de>:
>> Another possible problem: the user can change the installation
>> destination on Windows. What's the behaviour of Mac OS here? Is the
>> instalation path fixed or changeable?

This has already been answered. Yes the application can move on OS X,
but 9/10 it will be in one of two standard locations. There are ways
to find an application regardless of where it is, but it's maybe not
worth the platform specific complexity for that 1/10 time.

> For Windows, the program should have an InstallDir or similar registr=
y
> value in a fixed place in the registry to point to where it is
> installed (something like
> HKLM/Software/[Vendor]/[Application]/[Version]).

And if someone wants to contribute the code to grub around the
registry on Windows, I'm all for it, as long as it doesn't negatively
impact non-Windows users (and similarly for any other platform
specific code -- don't impact users of other platforms negatively).

> As for Linux, there is no guarantee that things like p4merge are in
> the path either. It could be placed under /opt/perforce or
> /home/perforce.

No, of course not, but again, looking in PATH is likely to work in the
common case. By looking in /Application and $HOME/Applications, that
covers the common case on OS X.

> What would be sensible (for all platforms) is:
> =C2=A01/ =C2=A0if [difftool|mergetool].toolname.path is set, use that=
 (is this
> documented?)
> =C2=A02/ =C2=A0try looking for the tool in the system path
> =C2=A03/ =C2=A0try some intelligent guessing
> =C2=A04/ =C2=A0if none of these work, print out an error message -- i=
deally,
> this should mention the configuration option in (1)

This is basically what is already done, but (3) isn't yet platform
specific in any way, and (4) doesn't mention the config option.

> (3) is what is being discussed. It is good that it will work without
> any user configuration (especially for standard tools installed in
> standard places), but isn't really a big problem as long as the user
> is prompted to configure the tool path. Also, I'm not sure how this
> will work with multiple versions of the tools installed (e.g. vim/gvi=
m
> and p4merge).

There's a fixed order of tools, first tool that's found wins.

Oh, and my favorite color paint is blue. :-)

j.
