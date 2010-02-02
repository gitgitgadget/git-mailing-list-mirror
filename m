From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Completion of error handling
Date: Tue, 2 Feb 2010 14:49:31 -0500
Message-ID: <32541b131002021149g6ffe703erd9e25621e4305a52@mail.gmail.com>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home> 
	<4B6873AC.4030303@web.de> <alpine.LFD.2.00.1002021424550.1681@xanadu.home> 
	<4B688042.8090400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 02 20:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcOl5-0006af-Tz
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 20:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687Ab0BBTtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 14:49:53 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:48445 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495Ab0BBTtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 14:49:51 -0500
Received: by ywh36 with SMTP id 36so485570ywh.15
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 11:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=cETkR4S7R0DE4cQGE857dzYcuH1NKunEVdaM9/yrhMc=;
        b=HqkqxjpveV8v4mvUthkOob0y47X3+sliPZ0yNiLzPYBvCWctc9SGM1JPSlGeiOvz/3
         KeIxn5POKtGLiD2TBlvjSe3AG8Zak489rYT2GmeWSDtozm7EEPBGCUCASyCNyvOYn5gW
         R2x1m0m/n8Mj505sKKfzTXSVlu3h+guYxG6jU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eA/UQ0vTvZ0jQEpi1sobkIQfNcQGMoJcaQQf8O5lFYMJGgfeJiHheCXzncp2d4qM0u
         q6hFA65ij8Gy1d8UNzTUzCQx0zMggQZBjAeQvliDC09OXy/ahPrusK2M9HLhN0KdKRaW
         eFHGk/019nZjh/yZ/W6b9FfiK33wktedzfbx4=
Received: by 10.151.89.33 with SMTP id r33mr9123756ybl.290.1265140191096; Tue, 
	02 Feb 2010 11:49:51 -0800 (PST)
In-Reply-To: <4B688042.8090400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138745>

On Tue, Feb 2, 2010 at 2:42 PM, Markus Elfring <Markus.Elfring@web.de> wrote:
> Nicolas wrote:
>> At least on Linux, most of those functions simply cannot fail.
>
> Would you like to support software environments that work without a
> famous out-of-memory killer?

In many cases on Linux systems, you don't get the OOM notification
anyway until you try to *use* the memory, not at allocation time.  So
even checking the results of malloc() won't always save you (although
*not* checking can make problems even worse).

However, for functions that can't allocate memory at all, it's extra
pointless to worry about.

>> There is just no dynamic memory allocation involved.
>
> I find this opinion strange.

This isn't an opinion; because it's open source, you can actually look
at the source code and find out that many system calls don't do memory
allocation at all.

Avery
