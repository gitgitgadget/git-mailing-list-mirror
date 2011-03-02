From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Wed, 02 Mar 2011 20:01:56 +1300
Message-ID: <4D6DEB64.1080003@gmail.com>
References: <20110225133056.GA1026@sigill.intra.peff.net> <201102251658.22678.johan@herland.net> <20110301215907.GA23945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 08:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pug3M-0005eQ-U5
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 08:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab1CBHAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 02:00:48 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53047 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914Ab1CBHAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 02:00:47 -0500
Received: by pwi15 with SMTP id 15so1036850pwi.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 23:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Y8Ts438uI2lq0k4yS6cGPPd58t5n02ebpqbGWSVGykQ=;
        b=WCm+FgOb2mHDvgeU2cGv9CiYnOP2EVCKoqeOv+yMHQLnZ0nR0r5wOzRg6t7EQWcgwd
         yNgGViCiwBOVwpCpd7QNwqqPD4j2KOIDxa3cwizD9dKfM6wEnAnTLCPLl9E+xvTc7vlz
         1s3uuPfGwRYDPC2QxPcOpQP/vxc4Ro6IgXjmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=LeMMT76zJSykJ/BOLIfiH5ebpV3iFTYfHDK6rkuCUjZtiIUOB+n+X6Hiiv3iSrValD
         ewbcnTNUbDvClZFMx9GCCD97zgYYOLXwiY96dkURXLs9r0jWmfpESuWNk6QLgC4Aoz/F
         jEvAqH2RBU8tqKQJhZEiSz0YoDtJkFr7klGA4=
Received: by 10.142.187.2 with SMTP id k2mr6240263wff.97.1299049247048;
        Tue, 01 Mar 2011 23:00:47 -0800 (PST)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id w27sm8604137wfd.4.2011.03.01.23.00.43
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Mar 2011 23:00:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <20110301215907.GA23945@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168296>

On 02/03/11 10:59, Jeff King wrote:
> On Fri, Feb 25, 2011 at 04:58:22PM +0100, Johan Herland wrote:
>> Maybe we should use a slightly more verbose separator (i.e. more 
>> unlikely to trigger false positives). As you say, we already have to 
>> watch out for "---" because of "am", but that only applies to projects 
>> that _use_ "am" (i.e. mailing-list-centric projects like git.git and 
>> the Linux kernel). Other projects (e.g. github-centric projects or most 
>> centralized "$dayjob-style" projects) seldom or never use "am" at all, 
>> so I wouldn't expect those developers think of "---" as "special" in 
>> any way.
>>
>> What about using something like "--- Notes ---" instead?
> 
> Yeah, it is true that many git users will never care about the
> patch-through-mail workflow. And I think these days that is OK, because
> rebase will take care to keep their commit message intact even if it
> doesn't format well in a "format-patch | am" pipeline.
> 
> I really wanted to keep it short and natural, though. Because eventually
> I'd like to have this on all the time via a config option, and I don't
> want to see "--- Notes ---" in every commit that doesn't have notes. But
> I _do_ want to be able to quickly say "oh, let me make a note on this"
> and just add a quick separator.

<bikesheding>
What about "#---"? Satisfies the quick to type and is a lot less likely
to appear in commit messages. Not sure about the implications of finding
that string before the commit message is stripped.
</bikesheding>
