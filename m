From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: b5227d8 changes meaning of "ls-files -x 'pattern'"
Date: Thu, 17 Dec 2009 18:24:55 +0530
Message-ID: <2e24e5b90912170454x699ed26fm973e2fb7133b3bbf@mail.gmail.com>
References: <2e24e5b90912140751y5d769f15pa6782914bdb04dbd@mail.gmail.com>
	 <20091214182420.GA31594@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 17 13:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLFsq-0000ig-H1
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 13:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761501AbZLQMy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 07:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbZLQMy6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 07:54:58 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:49161 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757700AbZLQMy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 07:54:57 -0500
Received: by pxi4 with SMTP id 4so1475047pxi.33
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 04:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=qpButjsgBT75FxdjkLpYmW0BzghUa084CXv02OAR6Z4=;
        b=rSYDPaZgHRlfGv+HuCx4EpcSCf76GVKdJ3qIzfqkjgYQ/A0J4TJBw0KhbIA3s+dS+7
         e/5s4Img+bq8Qq2hUPrGk4IiZlYZSPcUursVLT6kQVy27ElfSUAtfoEtlouqt7pLV+JO
         UHcdSDgqaDLdrxRPCdCVtpJaWBY7iN1PA1Erk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EpnNyIYyA3Ep3VvDHLf4bxYB/hdraFDdYKjCMdJADjCFyZojNIm9hChDTP6Q3FbwZL
         QuM3ZpxX9QHi5TR57bpbGyoPUs8aADhLWO/P9MR3AzSITeGrnUjRQqXECGDB5EW2zQjY
         GjOF2nY8xf4y8Y0JsETb3+n+RD9Alz+E2BV3s=
Received: by 10.114.6.25 with SMTP id 25mr1692995waf.25.1261054495737; Thu, 17 
	Dec 2009 04:54:55 -0800 (PST)
In-Reply-To: <20091214182420.GA31594@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135369>

On Mon, Dec 14, 2009 at 11:55 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 14, 2009 at 09:21:06PM +0530, Sitaram Chamarty wrote:

>> Before b5227d8, the following two commands would produce different
>> outputs (say on git.git):
>>
>>       git ls-files
>>       git ls-files -x '*.c'
>>
>> From b5227d8 onward, they produce the same output.   The second command
>> no longer excludes *.c files.
>>
>> I was unable to understand the commit message completely but it sounds
>> like this was intentionally changed to do this.

> Yes, it was intentional. Excludes are about untracked files, not about
> restricting parts of the index. The point of the change was to bring
> "ls-files" in harmony with other parts of git. For example, prior to

OK; makes sense -- thanks for the explanation.

> However, for your use case, I can see the utility of an option to limit
> the output of ls-files for a particular invocation. It's just that "-x"
> is tied into the excludes mechanism, which doesn't do that.
>
> I would not be opposed to a patch to add an option that means "exclude
> these index entries from the output list." And for the sake of backwards

I rather doubt if my C skills extend that far these days; I'll figure out
other ways of doing this if I need it :-)

Thanks again,

Sitaram
