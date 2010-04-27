From: Chris Packham <judge.packham@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Tue, 27 Apr 2010 10:00:39 -0700
Message-ID: <v2ra038bef51004271000u218edd9fp639a53e7d8669345@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com> <4B7E3856.3080609@gmail.com>
	 <20100219135549.GA31796@Knoppix> <4B820B4E.7050405@gmail.com>
	 <20100222105133.GA10577@Knoppix> <4B834989.50502@gmail.com>
	 <20100223124553.GA19153@Knoppix>
	 <p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
	 <4BD651C6.5050501@gmail.com>
	 <q2j86ecb3c71004270147le799967dw579964600be84066@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 19:01:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6o9r-00031F-Pp
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 19:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab0D0RAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 13:00:43 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:50434 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab0D0RAm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 13:00:42 -0400
Received: by qyk9 with SMTP id 9so19636900qyk.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yesVMXswsajcTcTMKFKYo2dm4uCHjJt7xrZl1m9Ee/A=;
        b=Z6Ia9ZUW+NM3DTH1t4Ewzegl2HWXQ5vSZlZZbph0bIo+G55xMmsRk/o8CoiIJDMCHM
         UDWCIZlEEbeSM/LfeFkslpztsvXpTWuhtKtfOuxo2+lpwmvwxufQ/F57KeqZ/lggZ3Pt
         SEpAj0TXIgkKwa2RR73XGCRvitrhe/hrBAOYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=x2VkT9zi0uSKMT0tw2PrjwVKuIE3xTaI0EFLMfxZqxxRmApnSfKh71SKQdlsUZFKU0
         NCRMIwNhS2zhIRrBrHcQLy/ZIrI50giHgANXGsknvO4iEZlwZ3xHL/7keh2s76JE1UUZ
         EkzLmgq4O4RwpeEg6O70zIb7LSKCl2Het7kvc=
Received: by 10.229.239.148 with SMTP id kw20mr7551168qcb.10.1272387639910; 
	Tue, 27 Apr 2010 10:00:39 -0700 (PDT)
Received: by 10.229.11.77 with HTTP; Tue, 27 Apr 2010 10:00:39 -0700 (PDT)
In-Reply-To: <q2j86ecb3c71004270147le799967dw579964600be84066@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145930>

On Tue, Apr 27, 2010 at 1:47 AM, Dmitrijs Ledkovs
<dmitrij.ledkov@ubuntu.com> wrote:
>
> Well I did this:
>
> $ mkdir -p ~/.bazaar/plugins
> $ bzr branch lp:bzr-fast-import ~/.bazaar/fast-import
> $ bzr branch lp:xiphos
> $ git init git-xiphos
> $ cd git-xiphos
> $ bzr fast-export ../xiphos | git fast-import

Bringing this full circle this is my version of what I needed to do.
Again its likely that the old version of bzr that openSUSE uses is the
reason the above didn't "just work(tm)" but just in case anyone else
is hitting the same problem heres my working recipbzr branch
lp:bzr-fast-import ~/.bazaar/fast-importe.

# plugin install
mkdir -p ~/.bazaar/plugins
bzr branch lp:bzr-fast-import ~/.bazaar/plugins/fastimport # note it
needs to be fastimport not fast-import or fast_import
bzr plugins --verbose  # just to check that the plugin is successfully installed

# actual import into git
bzr branch lp:upstart
git init upstart-git
cd upstart-git/
bzr fast-export ../upstart | git fast-import

> And the resulting git repository has master branch with tags.
>

Which is almost true for me except some tags weren't added due to
"missing revisions", and dang it if it doesn't happen to be the one
I'm after. This is probably because the 0.5 series for upstart is off
on its own, whatever fixes were in 0.5 probably have been merged I
just can't tell.

I think for my purposes I can manually find something close enough to
the actual revision that I need, either that or mess around trying to
import the obsolete 0.5 branch as well but thats something for me to
work through on my own now that I've got the fast-export recipe
working.
