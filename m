From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [patch 02/15] const-expr.patch
Date: Tue, 16 Mar 2010 19:43:54 -0400
Message-ID: <32541b131003161643g1a1cbf6ck3089ae5fb016a985@mail.gmail.com>
References: <20100316054220.075676000@mlists.thewrittenword.com> 
	<20100316054306.167331000@mlists.thewrittenword.com> <4B9F33DC.3030309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 17 00:50:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrgXH-0003X3-S8
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 00:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab0CPXut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 19:50:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52431 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab0CPXus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 19:50:48 -0400
Received: by gyg8 with SMTP id 8so202235gyg.19
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=o5ESS8NHbcD8MsZBSvzzVyiZzpqKyOyRbzYVJGPwuew=;
        b=chsFn5USpwp5Iuz4yWThPlBQHO1tFs9FESoGpb0n1Y36g6XFgXm81lB16p0MRKgex8
         z22DWXQ7MiFB9Zrtk3DPZMh382b0HatyzMU2Fxk+LJccdzTKAjBBfiM5uSKvfqb1438z
         tHDBjPToODIeg8KtsGCeJwQIGj5fBcWDag2bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VFAHhCyreNVGXBWWbw8Xm5edbuhKFF4/xN6UuRRNJIwa5/xA7q0+zuYyFe2sV0gcfD
         9nuKUeH3vG9FXzh4Ta+MEFHYCOGNDfafik205ZjlZA+4I5xb1VzJt9ASfp82VWf4LWvV
         N0KjpWkb4uTp0rAcjq3WTeEoXdxo6kLDUEQV0=
Received: by 10.150.59.20 with SMTP id h20mr660827yba.257.1268783447806; Tue, 
	16 Mar 2010 16:50:47 -0700 (PDT)
In-Reply-To: <4B9F33DC.3030309@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142360>

On Tue, Mar 16, 2010 at 3:31 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Gary V. Vaughan schrieb:
>> Unfortunately, there are still plenty of production systems with
>> vendor compilers that choke unless all compound declarations can be
>> determined statically at compile time, for example hpux10.20 (I can
>> provide a comprehensive list of our supported platforms that exhibit
>> this problem if necessary).
>
> Yes, a comprehensive list would be appreciated. This change is an
> uglification that I personally would prefer to stay out of the code base
> unless many consumers of git are hurt.
>
> The problem with this non-feature is that it is all too easy that new code
> introduces new incompatibilities.

This is probably a stupid question, but why not just build it using
gcc on systems with a broken vendor compiler?  You don't have to
distribute gcc just to distribute binaries built with it, so it seems
like there's no downside... and less suffering for the build
maintainer.

Have fun,

Avery
