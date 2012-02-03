From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Re: Breakage in master?
Date: Fri, 03 Feb 2012 08:55:37 -0500
Message-ID: <4F2BE759.4000902@gmail.com>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com> <20120202174601.GB30857@sigill.intra.peff.net> <CABPQNSZfKCTsuusPpHa2djEOeGVN9z5s_Fr+S3EaHiv7Q4Re9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 03 14:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJcB-00034l-EH
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab2BCNzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 08:55:43 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53095 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578Ab2BCNzm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:55:42 -0500
Received: by qcqw6 with SMTP id w6so2081939qcq.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 05:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=G6Mtm043hTnPiDe8XEVSSdkI4f+ho4HdHP6RgEFV3e0=;
        b=T4gyY2ANvbf7EEh3Xxt9TcbINwFkmK2YnQk+FsNjIPBC4aa4fjVPoGaOT53KU/wKcv
         JeFX4VdnMX8qUGs1Ape9TUGjWiLkHBz5kuk4UF35K9Br6bjHkR9zq9es8rNn7XPp6Olw
         ABmRqThrHsZYqDdhOAQwySB12OaS3iYBdIVoM=
Received: by 10.229.105.88 with SMTP id s24mr2789945qco.53.1328277341629;
        Fri, 03 Feb 2012 05:55:41 -0800 (PST)
Received: from [192.168.1.47] (pool-173-77-102-10.nycmny.east.verizon.net. [173.77.102.10])
        by mx.google.com with ESMTPS id de9sm12974901qab.9.2012.02.03.05.55.38
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 05:55:39 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111229 Thunderbird/9.0
In-Reply-To: <CABPQNSZfKCTsuusPpHa2djEOeGVN9z5s_Fr+S3EaHiv7Q4Re9w@mail.gmail.com>
X-Enigmail-Version: 1.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189774>

On 02/03/2012 07:28 AM, Erik Faye-Lund wrote:
> On Thu, Feb 2, 2012 at 6:46 PM, Jeff King <peff@peff.net> wrote:
>> vsnprintf should generally never be returning -1 (it should return the
>> number of characters that would have been written). Since you're on
>> Windows, I assume you're using the replacement version in
>> compat/snprintf.c.
> 
> No. SNPRINTF_RETURNS_BOGUS is only set for the MSVC target, not for
> the MinGW target. I'm assuming that means MinGW-runtime has a sane
> vsnprintf implementation.

That doesn't sound right; MinGW defaults to linking to a fairly old
version of the Windows C library (MSVCRT.dll from Visual Studio 6,
IIRC).  According to <http://mingw.org/wiki/C99> there exists libmingwex
with some functions (especially those from <stdio.h>) replaced for
Standard compatibility, but it's "far from complete".  (Is msysGit using
it anyway?)

--Joel
