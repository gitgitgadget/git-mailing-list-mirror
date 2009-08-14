From: Erik Sandberg <mandolaerik@gmail.com>
Subject: Re: [PATCH] Work around performance bug in subprocess.Popen.communicate()
Date: Fri, 14 Aug 2009 09:26:06 +0200
Message-ID: <e87cdfda0908140026x21b8aad3x82417d4b1c8016f4@mail.gmail.com>
References: <20090731093632.7018.24435.stgit@october.e.vtech>
	 <b0943d9e0907310427r7e59aa5fi5e5ff5e3f3c03819@mail.gmail.com>
	 <20090804085125.GB27452@lux.e.vtech>
	 <b0943d9e0908131518i3ac18331leb4c0c76313b0780@mail.gmail.com>
	 <20090814062149.GA23179@lux.e.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl Wiberg <kha@virtutech.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbrB3-000225-2J
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbZHNH0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 03:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbZHNH0H
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:26:07 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:54004 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbZHNH0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 03:26:06 -0400
Received: by fxm17 with SMTP id 17so1069099fxm.37
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 00:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=co1zYkVTY0v9zwBezKUjJ5L7ecf4+hNTTS2y4CYIdHc=;
        b=LrZiJPVRlOViTn3/5ok+kVDkWrBQZmm+i8nsgKExjO+fB9q+IwfD5ZFuTllQLHBEaD
         /JTF0roH3aJHq0gw0nEjZYIf7VeL4uzdUhc4uq6dSNJKLyQf8vAi73LczXtxqwf6puHS
         YgSEc3b3BmCKZXKph772uqKogSKVb/910Li5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LEIH0RpyQH5v1OTBhPEI2G1XyRGeMmL08dZNmTEQoP+sn80kMr5xATWDWVbKaGQ8Z3
         gmI0D0suczP2hN8HHotwqhMO1nSXTqKDgQD4lGH6Xn/7WcQ4uUcLM/8+gboi/KI3eGnp
         bOnaFJBSH+cqp/XAtC4/lJSpBhooMeIRyLI4s=
Received: by 10.239.143.214 with SMTP id l22mr110608hba.167.1250234766813; 
	Fri, 14 Aug 2009 00:26:06 -0700 (PDT)
In-Reply-To: <20090814062149.GA23179@lux.e.vtech>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125913>

On Fri, Aug 14, 2009 at 8:21 AM, Karl Wiberg<kha@virtutech.com> wrote:
> On 2009-08-13 23:18:59 +0100, Catalin Marinas wrote:
>
>> Since we are only using Git, I'll merge this patch
>> (and maybe add a comment).
>
> Sure.

Wouldn't it be better to only use the write() workaround when
sys.version indicates that the Python bug may be present, and use
communicate() properly otherwise?

Erik
