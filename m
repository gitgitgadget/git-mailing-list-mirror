From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch
 submodules too
Date: Sat, 9 Oct 2010 15:02:32 -0500
Message-ID: <20101009200232.GB19064@burratino>
References: <4C935D77.3080008@web.de>
 <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org>
 <4C953DE5.6020900@web.de>
 <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org>
 <4C963D00.9050207@web.de>
 <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org>
 <4CAB8DDF.8080004@web.de>
 <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org>
 <20101006232243.GA30302@burratino>
 <4CB0C279.8050407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:05:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4ffw-0007AC-5t
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760518Ab0JIUFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:05:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59997 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760512Ab0JIUFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:05:42 -0400
Received: by iwn6 with SMTP id 6so1709956iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3nDZVvy1vKn2P4vhuIUgzatA4To13oapZK68t3dN6Cc=;
        b=K2r8o6vqvegsNdhBqwTCnx/c5i8XZhYnu0YLzEIVhn8P5iwvEwRrDt0SfuRXEUffcy
         1jKlB4O0Xp984aDPgpVbYiqLUGqfN+VLpk1xEAIQUBvirFb9APXoM1rDTSSoujVkpOAc
         z9KuzCdiuMkU4GHlr6qNtC1ii8MxsXIVywIfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SL0gFGMPTBVxc9zRX/4NvQJS9bA9pTPnLBFQS44dJ11T+ftsLoQ4Nhi7ItIXb9AXhS
         tebwLOocrGv0BdoGM/hYHKeN22OcTCfSG+zYRQE5g7EojrpPxlibhH9FHVdn2/IdXRoF
         /Y4+8QLc4MVlGYGudTfD6Sb81OieXl0wonhWk=
Received: by 10.42.8.202 with SMTP id j10mr970827icj.11.1286654741804;
        Sat, 09 Oct 2010 13:05:41 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 34sm2516120ibi.8.2010.10.09.13.05.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:05:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CB0C279.8050407@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158602>

Jens Lehmann wrote:
> Am 07.10.2010 01:22, schrieb Jonathan Nieder:

>>     I also
>> don't want to pay the penalty of fetching, say, git-gui when I don't
>> need it.
>
> I'm not sure I understand your setup, do you want to configure that for
> each remote or for each submodule?

Without thinking too hard about it, I imagine listing submodules in
the [remote "foo"] stanza, just like I list branches there now.

> Because you can already do the latter
> with my patches. And configuring that via .gitmodules has the advantage
> that every clone inherits that setting

I certainly do _not_ want that property.  Upstream can tell what
submodules to check out by default, but aside from that, the choice of
what to fetch has nothing to do with them.
