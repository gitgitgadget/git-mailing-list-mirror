From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #01; Fri, 4)
Date: Tue, 8 Apr 2014 07:39:00 +0700
Message-ID: <CACsJy8A0oNRZ45xLvGTDPmDu0ZEAyHbdQBt2gdyo1yUtUeeB_g@mail.gmail.com>
References: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com> <533FCA92.8060006@kdbg.org>
 <5342EFD4.6020007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Zager <szager@chromium.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 02:39:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXK4s-0001Nx-K3
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 02:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbaDHAjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 20:39:32 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:50420 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbaDHAjb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 20:39:31 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so197065qaq.8
        for <git@vger.kernel.org>; Mon, 07 Apr 2014 17:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XnEF78PuxIAGo9Tj6DJ2SXTSRkz7/nJYwgOhW0WdzMc=;
        b=GLTaxaGthVaaSoAHLbuT0MWfDqeu2fxL4umvkS4e7E3yOVihcubT5dP+ltTOX4ZIO6
         tgQn4+nFA5gKFBQfJGOk9gCdmYKo4VpHo3G6uqHeN9FXkCdPabA7Nj3tyNmIprEH1K+k
         czmHwHMfKUeTwhRqkwnXAjv2HSWq002vV41TqDlsQhDKNZmRKEiQf17eOJAZh3qszhl/
         eWqC2LtQkcWaar+jvU0i4CFPVusNgi84bfTkq4jknXY8YBfGATsVdo+KXwj0NU88MoPH
         +jgvWzDnwmA9bj7Ybrn2ukToSUwsY9KjUtTUMYnNkXOPbXhKo4Oe/jm2N0aVOsiT7ZfF
         29fw==
X-Received: by 10.140.18.175 with SMTP id 44mr455221qgf.105.1396917570806;
 Mon, 07 Apr 2014 17:39:30 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Mon, 7 Apr 2014 17:39:00 -0700 (PDT)
In-Reply-To: <5342EFD4.6020007@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245915>

On Tue, Apr 8, 2014 at 1:35 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 05.04.2014 11:19, schrieb Johannes Sixt:
>> Am 04.04.2014 22:58, schrieb Junio C Hamano:
>>> * sz/mingw-index-pack-threaded (2014-03-19) 1 commit
>>>  - Enable index-pack threading in msysgit.
>>>
>>>  What is the status of this topic?  A failure report exists
>>>  ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
>>>  where the discussion stalled.  Is everybody waiting for everybody
>>>  else to get the discussion unstuck?
>>
>> I still have to cross-check Duy's patch. I'll hopefully get to it in the
>> next days and report back.
>
> The test suite passes with Duy's patch ($gmane/245034), but t5302 fails
> with this patch with a MinGW build.

Is "this patch" the one on 'pu', or mine?

> The patches touch the Cygwin configuration, but I cannot test a Cygwin build.

If no one can test the Cygwin changes, I'm happy to revert it back for safety.

> I have, however, lost track of what the objective of these patches is.
> Is the threaded version significantly faster, and these patches are
> worth it?

It depends on the repo, how much deltas it has, how deep. According to
b8a2486 (index-pack: support multithreaded delta resolving -
2012-05-06), going to two cores saves ~20% time. But some actual
numbers on Windows would be nice.
-- 
Duy
