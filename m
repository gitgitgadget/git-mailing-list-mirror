From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH v2 0/6] Extensions of core.ignorecase=true support
Date: Wed, 6 Oct 2010 18:04:41 -0400
Message-ID: <AANLkTi=tHaCki5yWQW_iQ21Y8ee5G2rNBzX8Pf-nZYAp@mail.gmail.com>
References: <20101003043221.1960.73178.stgit@SlamDunk>
	<AANLkTinZzM=HeT_J-tF5F9DBdvts3i+nboPkPy-uc8V5@mail.gmail.com>
	<201010032012.01678.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:05:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c6k-00031h-07
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271Ab0JFWEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:04:44 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36725 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932921Ab0JFWEm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:04:42 -0400
Received: by ewy23 with SMTP id 23so25214ewy.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=xHF703Pkfmdc3f9dDfpcVogsP1mr40y1AEpjHUYto2o=;
        b=xu/ueeefKJvNGHfNvAn8tt3Ug1S0rosBgs0awYF8+hwak8KW5Vb8cEeq/NYs2zvlxK
         ZWFWIEtsOpbZx/pmZY5XZOU1Ocg3cg5PDh8+ha2tI4HN4EzLEQ6y5h/q75kC7egyad2h
         eg92rrpg4ZDOxoN6bZdppiCE2ojLvFeSXdqmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OU5yGb2kx6ckA4Do/xSJsjTO/oL2FjM9D+Co0+LTJvy+4rOLT5zfYEEVXz2iFBrEyU
         Zle9QA9MxKVqGVSZZUBjVuVGQArrlm/UqjP/NDne/U+EYGeXdWXHKmiywV9VccTpnIjA
         zaJ/iLXHXAkkfEAWAwOiIhRHKDecpOa5uUjnw=
Received: by 10.213.113.147 with SMTP id a19mr1077283ebq.24.1286402681229;
 Wed, 06 Oct 2010 15:04:41 -0700 (PDT)
Received: by 10.14.47.74 with HTTP; Wed, 6 Oct 2010 15:04:41 -0700 (PDT)
In-Reply-To: <201010032012.01678.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158332>

Hello Johannes,

Here is the use case I was thinking of.

Let's say I want to have .gitignore be case insensitive with respect
to matches so I can simplify the file by not having [D][d]ebug sorts
of messes. But let's say I also want to support files whose names only
differ by case (just like Unix supports). Can your current patch
series support this? Does the current patch series break this?

Could you share how this would or would not work, and if not, how you
might accomplish this?

Thanks,

Bob

On Sun, Oct 3, 2010 at 2:12 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Sonntag, 3. Oktober 2010, Robert Buck wrote:
>> So I could we please separate the behaviors that change intent
>> (folding) from the behaviors that merely alter how things are
>> displayed (listing) by splitting this into two separate properties?
>> For example,
>>
>> core.casepreserving=true|false
>> core.caseinsensitive=true|false
>>
>> The former property would control folding, the latter property would
>> apply to listing and pattern matching. Then people could opt out of
>> the folding behaviors (add, import), while continuing to adopt listing
>> and pattern matching (status, ls, ignore).
>
> core.ignorecase has a very well-defined meaning: It describes whether the
> worktree lives on a filesystem that is case-insensitive. Perhaps you could
> help me understand your case if you gave examples and a use-case? I have a
> slight suspicion that your wish is orthogonal to core.ignorecase.
>
> -- Hannes
>
