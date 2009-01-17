From: David Aguilar <davvid@gmail.com>
Subject: Re: git-difftool
Date: Fri, 16 Jan 2009 20:41:49 -0800
Message-ID: <402731c90901162041w2437587bsae1e6dde9384a4b3@mail.gmail.com>
References: <20081226013021.GA15414@gmail.com> <vpqhc4kz5zh.fsf@bauges.imag.fr>
	 <46dff0320812312338i5a3ee0cem702a6b67ef76e48c@mail.gmail.com>
	 <200901020104.01522.markus.heidelberg@web.de>
	 <46dff0320901011759ke7026d9hafe4fdde099e370b@mail.gmail.com>
	 <1232164040173-2171934.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: enso <a.calhoon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 05:43:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO31j-00023N-1o
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 05:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760578AbZAQEly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 23:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760395AbZAQElw
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 23:41:52 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:54225 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759864AbZAQElu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 23:41:50 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2254091wfd.4
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 20:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9rRafX5WFkvypCxqDMFzB+TURr0Rm2vli/FwWU1h49k=;
        b=Nolj3AM1z/NcuxfOJo4EBZZb5FWF2tYV/R7yjqKuaymEXb+nkHSVSzwmmfUvJlMXb0
         lNUYilVW/dODRHHdMjCyM7Kkf17KgzNKI7lBZBcfptl65MMo1Q/BmHL0XsBKM+lE7FiT
         TQ7vx34E98JNP3bW6ywENYHcGaCKB6xm1bDAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z/p867zoM3FjZ9T2h4MCO0DqnfLRtc6WqgyGrRldkvhiFpUDj6uCJ2Db8944IjVN0k
         pxjBKTmCXWxiTxlI5miUwyz39Bh/UqqyvtsmQfv/kS4NOUu88cWP1BnV2hfNwXnVDtOh
         Ix4+e/R7Rzsjxse3a2S4G8Gd/VJ6BAUfUait8=
Received: by 10.142.230.9 with SMTP id c9mr1330496wfh.254.1232167309852; Fri, 
	16 Jan 2009 20:41:49 -0800 (PST)
In-Reply-To: <1232164040173-2171934.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106024>

On Fri, Jan 16, 2009 at 7:47 PM, enso <a.calhoon@gmail.com> wrote:
> Ping Yin wrote:
>>
>> Thanks. With GIT_PAGER="" it works now.
>>
>
> Personally, I didn't like having to screw around with environment variables
> directly to get vimdiff to work. So I did the following:
>
> 1) Made a simple diff script gitvimdiff.sh:
>
> #!/bin/env sh
> vimdiff "$2" "$5"
>
> 2) git config --global diff.external ~/path/to/gitvimdiff.sh
> 3) git config --global pager.diff ""
>
> Now when I run git-diff it uses vimdiff (hooray) and automatically turns the
> pager off for me! Now only if I could get meld to work under cygwin.
> --

Hello sir
It sounds like you were looking for exactly the patch I sent last night =)

http://article.gmane.org/gmane.comp.version-control.git/105925


With 'git difftool' you just do it once:

git config --global merge.tool vimdiff
git difftool [diff options]

The nice thing is that it supports the same configuration variables as
'git mergetool', so if you've already set things up to work correctly
with mergetool then you're already setup for difftool.

Meld.. I can't say I've used it on windows.
I have successfully used kdiff3 with msysgit, though.  I just
downloaded it and copied it to /bin.

difftool supports meld, though, so if you get a build of meld that
works then you should in theory be able to use it just by setting
merge.tool to meld.

-- 
    David
