From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Check for local changes with "goto"
Date: Thu, 15 Jan 2009 22:24:53 +0000
Message-ID: <b0943d9e0901151424m49f6869cq1255cf841703dc9d@mail.gmail.com>
References: <20090114225945.11098.88671.stgit@localhost.localdomain>
	 <20090115083700.GB24890@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNafY-0003yU-LO
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 23:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935502AbZAOWY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 17:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935712AbZAOWY6
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 17:24:58 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34627 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935709AbZAOWY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 17:24:56 -0500
Received: by bwz14 with SMTP id 14so4164012bwz.13
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yxw/MNzNdZQ4h3O+Ck9zMqyzE1GOofPiYa9fd9UV7ks=;
        b=htqEwZ32L7a7TEWT3lPdKwCZiG4gio0+ai0ClvsVCYujB9SxHTmv0VacoVEn073b3y
         hg9nt3tYOxWLSFeJRzZ7I3sO0URr8rqC01Vy49VeT8SwDIasOSY/6ccfWb44sX51/4OB
         31Du/iQAqy61+iY5YkwBGtM6bjeXbgh8k6avU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UfZYFMiHa3roJk9213CdZ0OcPpA050UlETYgnAx5gynyYqwNC3+koQ6c0qk38M3Mg3
         PqOUmY4s4kKU5nrJLXdIs8CcMSnuY1lsvYKWPeVX0wi2ZzDXY1oJam1qMZ/UfLMdrSa/
         2XoY076Ab0lA0QjzWxCqb6zrHWe89ubWeGtFc=
Received: by 10.223.115.193 with SMTP id j1mr2211985faq.98.1232058294000; Thu, 
	15 Jan 2009 14:24:54 -0800 (PST)
In-Reply-To: <20090115083700.GB24890@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105887>

2009/1/15 Karl Hasselstr=F6m <kha@treskal.com>:
> I'm not opposed to the change as such (even if I personally think it'=
s
> very convenient to allow operations like goto if the local changes
> don't touch the same files), but ...

That would work if "refresh" only commits files previously added to
the patch (the same way as quilt). I found myself many times moving to
another patch and refreshing more than I wanted to add to that patch
because I forgot to run "status" before "goto".

Maybe we can make this configurable to accommodate both variants
(would be even easier if I move the check to transaction.py).

> On 2009-01-14 22:59:45 +0000, Catalin Marinas wrote:
>
>>  stgit/commands/common.py  |    7 +++++++
>>  stgit/commands/goto.py    |    8 +++++++-
>
> ... are you sure it wouldn't be better to build the check into
> transaction.py, so that all new-infrastructure command would share it=
?

OK, I'll do this and repost.

--=20
Catalin
