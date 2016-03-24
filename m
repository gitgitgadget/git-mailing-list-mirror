From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Thu, 24 Mar 2016 18:56:15 +0700
Message-ID: <1458820579-31621-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	mehul.jain2029@gmail.com, sandals@crustytoothpaste.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 12:57:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj3tA-0000zI-KY
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 12:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbcCXL5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 07:57:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32997 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcCXL5O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 07:57:14 -0400
Received: by mail-pa0-f46.google.com with SMTP id fl4so19929339pad.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDG/ANNv0toLrHsCMfyL/tjVI0Ph3Iy6OJdrt6E6X1Q=;
        b=QU6s3xh/3UZRRtmF2JyFcX0wzxKS2YKRNe9srkRq9mhPLglaPD6TzXlSGX9vTOmzHY
         rla14vZUaHxDzEBA8+AAukvHVySKaclq2Ih2lCCzC3bfJchms/gg05EwvDd8TAsKdC1b
         eHQH32Fxw+7tMQOc9kxLz4JPd2wlcYD56qdxb7fpOehdGEMgJ45SRnROikzXsTXRSuxc
         f3zBWUBmTPCzFFIkYXO5FrmCv+egEMOz30Jl5p74SleWM3WT2xsf0O6kBmK2sLzy0ROq
         nX1vu+YdS1WGj5FDOYpdO9gNSOdGDJAl4ovbnoWmcOfzSlwWDgRIKSyhvaOSIHz0evB3
         iSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDG/ANNv0toLrHsCMfyL/tjVI0Ph3Iy6OJdrt6E6X1Q=;
        b=iUZ4Dyy64ogpnCOBcvYm2+NSv+so4kjvKTQmdIo1pElX7DEfpQSWicDM4tsc4y6Web
         aJqof4ECHVyz3UqpkcjEJg/t1vTf/DhNE0SkPKiznS2vZrHTWaa9XBmGbSaWqxSY33pW
         x8aaDhEltpC2+mYGr8r3XXjosx+5rOBwlMO9TQNl8rsg+G2VY1BUo8zMbEAL75WVCOkS
         OWbzJSwm+/arBpvXEmk5OmTkqyPFyiVKSgMGirsiVfQvB4ExtwHYFOR6eVDvPVxaUSfA
         V+OnooYJtMzPmwky0dN16fZnpl4yxUGYRyjgrYbdHhQzDnymGMBY2wA10BT34opQKEbc
         ld7A==
X-Gm-Message-State: AD7BkJLT6Ifw9EKRj5BFpXthdN0KrYgKe39aF9iZDc0yoofACGfSeJo+WjoxI3YtQk6jMA==
X-Received: by 10.67.24.104 with SMTP id ih8mr12125606pad.124.1458820634148;
        Thu, 24 Mar 2016 04:57:14 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id q2sm9960880pfq.88.2016.03.24.04.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2016 04:57:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 24 Mar 2016 18:57:27 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289737>

+Brian who also had issues with git-apply.

On Thu, Mar 24, 2016 at 5:49 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 23, 2016 at 11:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> See
>>>
>>>   http://thread.gmane.org/gmane.comp.version-control.git/288316/focus=288321
>>>
>>> I agree it is bad that it silently ignores the path outside the
>>> directory.  When run with --verbose, we should say "Skipped X that
>>> is outside the directory." or something like that, just like we
>>> issue notices when we applied with offset, etc.

Implemented in [04/04] apply: report patch skipping in verbose mode.

>> Another thing we may want to do is to loosen (or redo) the logic
>> in builtin/apply.c::use_patch()
>>
>>         static int use_patch(struct patch *p)
>>         {
>>                 const char *pathname = p->new_name ? p->new_name : p->old_name;
>>                 int i;
>>
>>                 /* Paths outside are not touched regardless of "--include" */
>>                 if (0 < prefix_length) {
>>                         int pathlen = strlen(pathname);
>>                         if (pathlen <= prefix_length ||
>>                             memcmp(prefix, pathname, prefix_length))
>>                                 return 0;
>>                 }
>>
>> The include/exclude mechanism does use wildmatch() but does not use
>> the pathspec mechanism (it predates the pathspec machinery that was
>> made reusable in places like this).  We should be able to
>>
>>     $ cd d/e/e/p/d/i/r
>>     $ git apply --include=:/ ../../../../../../../patch
>>
>> to lift this limitation.  IOW, we can think of the use_patch() to
>> include only the paths in the subdirectory we are in by default, but
>> we can make it allow --include/--exclude command line option to
>> override that default.

I went with a new option instead of changing --include. Making it
pathspec can still bite people. And pathspec is not exactly compatible
with wildmatch either. This is in

  [03/04] apply: add --whole to apply git patch without prefix filtering

> git-apply.txt should
> probably mention about this because (at least to me) it sounds more
> naturally that if I give a patch, git-apply should apply the whole
> patch.

  [02/04] git-apply.txt: mention the behavior inside a subdir

> We probably should show a warning if everything file is filtered out
> too because silence usually means "good" from a typical unix command.
> It could be guarded with advice config key, and should only show if it
> looks like there are matching paths on worktree, but filtered out.

I'm holding this back. Too much heuristics.
--
Duy
