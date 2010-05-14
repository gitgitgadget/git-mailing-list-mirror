From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Fri, 14 May 2010 23:16:29 +0200
Message-ID: <7DF58EB2-F6A0-47FB-BC89-72757B29FAE6@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org> <961B7250-F65E-4C67-8C5C-6701F68C2FC0@gmail.com> <alpine.LFD.2.00.1005131438330.3711@i5.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 14 23:16:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD2FO-0003uj-F7
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 23:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759550Ab0ENVQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 17:16:36 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:42922 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758979Ab0ENVQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 17:16:35 -0400
Received: by ewy8 with SMTP id 8so1020601ewy.28
        for <git@vger.kernel.org>; Fri, 14 May 2010 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=v/zoyoeFizL/PKnqJ3oWB3ynS4GYs+9d3SQ41UAFVDc=;
        b=nE/VgySLaFxLwpjk/ofYNbC1Ni523rzrzuIFja7qW/YEwA/ySBMd39nheYPorauTKA
         /P6UlL1nfGNSfUlFoKv/lJnI3uapxSFnx2+lBa0P5F1aDuR7RVbuoWCfeFhs+wFqGTJ8
         +9ovO1ODWS3SY8w6JdQR2lR77TZQGm2/lk7HY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=Q7g5Ie0uL5TPvmYDORcuKWakp72fK0LUgGbuwOP305olo6kGeJi5CO6MlHSMkEGFvx
         gBIsogkJyzl6AHYiy3rex69D0iVPPottwPbhENvWt2rtvEqeDWogQo3NkUq1AblGZnNh
         n+hmOVIFTSSLMunRJmA9g91nVf4ARqt3g5k1c=
Received: by 10.213.49.144 with SMTP id v16mr946239ebf.46.1273871793760;
        Fri, 14 May 2010 14:16:33 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm1480994ewy.1.2010.05.14.14.16.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 14:16:32 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005131438330.3711@i5.linux-foundation.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147116>

On 13. mai 2010, at 23.45, Linus Torvalds wrote:

> On Thu, 13 May 2010, Eyvind Bernhardsen wrote:
>> 
>> Do you agree that "native" eol should only be CRLF if autocrlf is true?  
> 
> Not really. We're trying to get _away_ from .gitattributes depending on 
> autocrlf, aren't we?

I'm not sure we still are.  I certainly was when I started this series, but that was because autocrlf just plain didn't work with many existing repositories.  When "safe autocrlf" fixed that, I decided that the extra complexity of core.eolStyle wasn't worth it.

I could be wrong, and I'd be happy to add it later.  I don't think this series requires it, though.

I'd like to make my terms explicit: when I say "core.autocrlf", I mean a config value that makes git normalize all text files automagically.  "core.eol" would be a different config value that simply tells git what line endings to put in files that are explicitly flagged as "text" (or automatically detected by "text=auto").

>> Otherwise, if .gitattributes looks like this:
>> 
>> 	*.txt text
>> 
>> git will put CRLFs in .txt files but LFs in .c files, and I don't think 
>> that makes much sense.
> 
> Well, but that's what you asked for, isn't it? And I don't see why you say 
> *.c files would have LF's, since that depends on what you put in them: and 
> under Windows, that might well be CRLF.

That's not an interesting problem.  If you're okay with CRLFs in your repository there's no need for you to use text file normalization at all, and you're certainly not going to bother to set any text attributes.  Everything will Just Work.

To make it more relevant, let's consider what would happen if you suddenly wanted to share that repository with a Linux user.  You would clearly have been better off if the text files had been normalized, but I can only see three ways this could happen:

1. You set "* text=auto" when you created the repository
2. text=auto is the default for all files
3. autocrlf=true is set by default on Windows

The first option is unrealistic, and we probably agree that the second one is a bad idea.  That's why, once Finn Arne fixed autocrlf, I realized it's not all that bad.

> And I do think it's perfectly reasonable to override the "native" mode in 
> your .git/config. If we're renaming the attributes, we might as well then 
> introduce a 
> 
> 	[core]
> 		eol=lf
> 
> to set the "native" EOL for that repo, exactly because presumably a number 
> of Windows people would like to see the saner LF-only model rather than 
> the traditional native CRLF.

But they can equally easily set "core.autocrlf=false".  Although the name still grates.

> In fact, maybe it would even make sense to just make LF the default 
> "native" end-of-line sequence even on windows, so that Windows people who 
> actually want CRLF would have to set core.eol=crlf. Whatever. That would 
> be for the Windows git users to fight out, I don't care.

This is the crux of the problem.  It's possible that I'm just being prejudiced, but I think that if someone wants CRLF as a _default_ they probably want it to be the default for all text files, not just normalized ones.

> But if we are going to clean up text attribute handling, then I really 
> think we want to totally break that old "core.autocrlf" dependency.

"core.autocrlf=true" is exactly equivalent to "core.eol=crlf" in a repository with "* text=auto" (setting the "text" attribute disables the index check).

In a repository that doesn't care, "core.autocrlf=true" will normalize your text files and put CRLFs in them, while "core.eol=crlf" won't do a thing.

Unless you're simply arguing for renaming autocrlf to eol?
-- 
Eyvind
