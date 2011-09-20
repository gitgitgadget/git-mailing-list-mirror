From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCHv2] git-web--browse: avoid the use of eval
Date: Tue, 20 Sep 2011 21:04:46 +1200
Message-ID: <4E78572E.6030105@gmail.com>
References: <20110918183846.GA31176@sigill.intra.peff.net> <1316424415-11156-1-git-send-email-judge.packham@gmail.com> <20110919183408.GB26115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 20 11:04:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5wFu-0000pN-OA
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 11:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089Ab1ITJEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 05:04:37 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36914 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab1ITJEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 05:04:35 -0400
Received: by gyg10 with SMTP id 10so176377gyg.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YPIVvFpiR88na9d3pXqw87TLhRGvBMy77VBAy9pFAAM=;
        b=RyyVgCx7mOP3nl0kjpUT9bDHJvYNP/MPkhRRjfQj1KW5esykxcCZuFd/6HP92oWmCm
         wC35KL+f71o3IjOqq1wYSDVNspn5RXTU/YjDTUEYlTTIWOzCAqEWBGncB4evMb4BZd6o
         jDcvZW157mzs26qs5MD8Zatv4KTlOk6J0jEgY=
Received: by 10.101.125.9 with SMTP id c9mr426977ann.109.1316509475377;
        Tue, 20 Sep 2011 02:04:35 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id g17sm9651763ana.15.2011.09.20.02.04.30
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 02:04:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.20) Gecko/20110804 SUSE/3.1.12 Thunderbird/3.1.12
In-Reply-To: <20110919183408.GB26115@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181745>

On 20/09/11 06:34, Jeff King wrote:
> On Mon, Sep 19, 2011 at 09:26:55PM +1200, Chris Packham wrote:
> 
>> Using eval causes problems when the URL contains an appropriately
>> escaped ampersand (\&). Dropping eval from the built-in browser
>> invocation avoids the problem.
>>
>> Cc: peff@peff.net
>> Cc: chriscool@tuxfamily.org
>> Cc: jepler@unpythonic.net
> 
> Although other projects do use "cc" in the commit message, I think we
> don't usually bother adding this noise in the git project. The cc
> headers in your email are enough.

That's more for git send-email's benefit than anything else. I'm working
on a laptop with a touchpad (and a cat) so the less switching between
editor and MUA the better. Any better suggestions for tracking Cc's for
git send-email?

>> I've replaced my tests With the test suggested by Peff (should I be
>> giving him credit in the copyright line or something?).
> 
> For a minor bit of help, usually mentioning the person in the commit
> message (with a "Helped-by", or indicating which parts they contributed
> to) is plenty. Personally, I don't even care much about that. My
> contributions to git are thoroughly documented in the commit history and
> the mailing list at this point. :)
> 
> I also find the "Copyright ..." lines in the files to be overkill, too.
> They end up becoming out-of-date as other people work on the file. The
> commit history is the best way to get the right answer, and a comment in
> the file is at best redundant with what's there. But that is just my
> opinion; I don't know that we have a particular policy for such
> things[1].
> 
> -Peff
> 
> [1] Once upon a time, I think I saw the advice that every file should
> have a copyright notice and mention the license at the top of the file,
> but I don't know that it has ever been tested in court. I suppose the
> distributed tarballs of a particular version would lack the copyright
> attribution, but in that case, my solution would be to generate it from
> the commit history at packaging time.

The example in t/README has has a copyright notice which is why I put
one in but I don't consider the test (or the fix itself) to actually be
copyrightable. If I wasn't creating a new file I wouldn't have bothered
putting anything in (other than the testcase).
