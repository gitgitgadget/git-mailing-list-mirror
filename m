From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 10:07:40 -0800
Message-ID: <CA+P7+xpTAsmFTAA6LkBeQ=x8EjfmiC=++CGEAZBHXeCpvejqfw@mail.gmail.com>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
 <20160225014149.GA31616@sigill.intra.peff.net> <CA+P7+xpfuPkwcdeXVTiTdqRCX16J4pus-wmxe7Sipu_GXCNSoA@mail.gmail.com>
 <20160225070036.GA5654@sigill.intra.peff.net> <20160225071159.GA22529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:08:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ0Kd-0007ZE-7e
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 19:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933248AbcBYSIC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 13:08:02 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35809 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381AbcBYSIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 13:08:00 -0500
Received: by mail-ig0-f178.google.com with SMTP id hb3so18632289igb.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OlejQRWwugeYRY6A1dDiFQ90hFs7U5xfg0qQRgPRgew=;
        b=IhlrE7/darbL0p2bsjY+xlGnS/TTqS2+BBNxpoTsXlohN4E/py3Jx1KxF/KbiWFaGz
         vJqpE9/BELQWk3EAuP9rvumQlj/+tzR4NPc3IOW2mIYlaAEqvN9F0o4h+5PRCjzcZqNV
         xUMIkTSdzAQUh0+S7bHvImhcPa/p94ZZr0tl8QTmUibJ0ElTa5krLG2ii45NnQe9bFcC
         aqpyvZhLe031YTsM479c4995pO3DQPLT8KQoZT1xrzwwjr+kg3zhcEH7FBjvUvfoBnta
         pDz25BMYkhEFY70ruLHJ/gsYm1UjeODyR4KGl86gBJYroDkNR9yVnz1wa+uglSKjfNQ7
         zlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OlejQRWwugeYRY6A1dDiFQ90hFs7U5xfg0qQRgPRgew=;
        b=cL16gZ3oSoybC4CnVScySLEAIz7gCZvhjuXWrTA3OhmGfShaPEDgMXr6MQWw6ec+Rl
         vpPBPTaB9yASc8qyDd6Zbybzn3X+NMJ8jnxI5CrNHKrPQHriQ8+2fhPR/AFRRAHhFXlZ
         hj1vI6UCre43kFVcy0vjdh/aBoOM2sCZScIf8KYbh/nnFfjnGUhxCdOzCw1yWVaNPlCu
         6m9zicz6MDVpljXPgGG2uZpNfQw7oFPWTamOcHSJgklcsqm5QPROUt2uln/c/gpqCDXh
         pKExDdiynZGQyy5EhkUZFLgQWtxUvlFcbXz46QsFAhaX7LNWt2YkP56k8hbtOVlbkcAF
         hb3Q==
X-Gm-Message-State: AG10YOS7wyVqZmPG8srSEpFZT/oD+55LxAF/ucV+c90ulBeTlOUbOrhJRkHc4zFyQ+cECmnd0dRStVli+yMNIQ==
X-Received: by 10.50.32.2 with SMTP id e2mr4145980igi.73.1456423679772; Thu,
 25 Feb 2016 10:07:59 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 25 Feb 2016 10:07:40 -0800 (PST)
In-Reply-To: <20160225071159.GA22529@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287410>

On Wed, Feb 24, 2016 at 11:11 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 25, 2016 at 02:00:36AM -0500, Jeff King wrote:
>
>> I think something like this would work:
>> [...]
>> but it does not seem to pass with your patch (even after I fixed up the
>> weird "local" thing). I think the problem is that we ask
>> submodule--helper to do the clone, and it uses local_repo_env. So in
>> addition to your patch, you probably need a C version of the same thing
>> which outputs to an argv_array.
>
> Something like this (which passes my test, but I didn't think hard about
> it beyond that):

I am having trouble getting the httpd tests to work.. The error.log
generated contains the following:

[Thu Feb 25 18:01:58.583832 2016] [core:crit] [pid 16376] AH00136:
Server MUST relinquish startup privileges before accepting
connections.  Please ensure mod_unixd or other system security module
is loaded.
AH00016: Configuration Failed

I have httpd 2.4, so I'm not sure exactly what the deal is here for
these tests..

Any suggestions on what causes this?

Thanks,
Jake
