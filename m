From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
 create '//etc/.git/index.lock': No such file or directory
Date: Thu, 18 Nov 2010 23:26:38 +0700
Message-ID: <AANLkTin6vir9UT9c4-9ArNvFHNdHiDiXMtXKRUMoExho@mail.gmail.com>
References: <AANLkTi=UPWTeZP9uF+FGtsSs7wH3AmwdeLtsPJQnKvez@mail.gmail.com>
 <20101117112042.GX22067@login.drsnuggles.stderr.nl> <20101118155211.GE22067@login.drsnuggles.stderr.nl>
 <AANLkTi=mf_1HaJ0qZJ4nG1=zti9CJdTZHAfhLayR4FRS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Thu Nov 18 17:27:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ7KJ-00024u-Bh
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 17:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab0KRQ1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 11:27:03 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64595 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab0KRQ1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 11:27:01 -0500
Received: by yxf34 with SMTP id 34so1936972yxf.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 08:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=d5P52rp8J9H6NGf2NwuCf52PKqi7FeSP15R9hoXcJnI=;
        b=Jiko/rQkieEUjGcVgR/YPg+ZalkTcTFY3BgcpzqtkscoLgGuMMGaKQARdIx0tH5TBx
         xr0mmwhTn2I4XkJG7TRdbQqnF2mccygoyoQ+Iwi4kc+CpXS6LFyy3+U/mhpMUIP5wZ1/
         487zKxANctoNTDkZvq2sWfd5+mktSUzhsiPAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=aEKEiY1xFYGlvg9jHV7eKOs1WFALQFSbcHzajP9d6N6zhE609wrQdj6x1kTHv9Ojm+
         /i0qNKVLDgEV3AHsKzFB5M+KaJ7Wezj6m2XdNfHEeDGIYeBJgx4MemGJSDB4sS/bA0IW
         3qKph1wKexD8R30NbnF6g41WhnvI7edvfU1dI=
Received: by 10.216.172.9 with SMTP id s9mr819986wel.56.1290097619068; Thu, 18
 Nov 2010 08:26:59 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 18 Nov 2010 08:26:38 -0800 (PST)
In-Reply-To: <AANLkTi=mf_1HaJ0qZJ4nG1=zti9CJdTZHAfhLayR4FRS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161681>

On Thu, Nov 18, 2010 at 11:07 PM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On Thu, Nov 18, 2010 at 10:52 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
>> Hi all,
>>
>>> I've been using git for exactly this purpose succesfully for a while now
>>> (git 1.5.6.5 from Debian stable and I think also 1.7.2.3 from Debian
>>> testing).
>> Coming back to the testing machine I was using this on, I see this
>> problem as well now. I'm pretty sure it wasn't there before, which would
>> mean it was introduced by a recent upgrade.
>>
>> Checking the logs shows that I was running 1.7.1 before, and now 1.7.2.3
>> is broken. Downgrading to 1.7.1 indeed removes the problem.
>>
>> I've rummaged around in the source a bit, haven't found the cause yet
>> (and I'm out of time now).
>>
>> The issue also still occurs with a fairly recent git master (ca209065f:
>> completion: fix zsh check under bash with 'set -u').
>
> You may be interested in 72ec8ba (Support working directory located at
> root - 2010-02-14). t1509 reports the breakages. Unfortunately this
> kind of tests can't be run automatically

I think 490544b (get_cwd_relative(): do not misinterpret suffix as
subdirectory - 2010-05-22) causes it. Haven't fully understood what's
going on in that function though :P

Will look again tomorrow, if nobody beats me to it.
-- 
Duy
