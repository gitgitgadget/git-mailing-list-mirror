From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH/RFC] mingw: rename WIN32 cpp macro to NATIVE_WINDOWS
Date: Sat, 26 Jan 2013 09:11:36 -0500
Message-ID: <5103E418.7090104@gmail.com>
References: <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin> <50FEDB08.6030901@ramsay1.demon.co.uk> <51031C43.5030307@gmail.com> <7v38xo3irh.fsf@alter.siamese.dyndns.org> <51032481.4030707@redhat.com> <20130126010359.GH3341@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <eblake@redhat.com>, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 15:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz6UJ-0000t1-As
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 15:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab3AZOLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 09:11:42 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:58836 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab3AZOLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 09:11:40 -0500
Received: by mail-qa0-f49.google.com with SMTP id o13so12334qaj.8
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=umJ6B4pjzKM7mP5Kt4gwNBRY0i9RcHkgesno/HKZ4aQ=;
        b=TCz4C8R6ak6DNZD5f7m8DHgNKRQvdikqqYbcLFHcXP0Q335xya1NsFo/04cAJBL2gF
         tBJq+vv5VTH0osfJvGuhBBrsPHxKnHNOyPzuPSuzUwpvaWWWrtU/pV1Td0TW4zgPsAU5
         nsXcVi8EgVej44i35f0vd43vVBX0CGvfmQ1QrUEhgDcWQSia5qVRcmiYVZmCmhDJjbGV
         Iy2MtCNNNG4F7o1bNuUhazIoZ13lWXS/en1/f8wt4gx5p8rd89XLV4/VP5KPuwcNzNez
         uZancYAmHwIvHstg+rBnGRzYuVN5RZP2X3NcHTpxK4lc+Ftb8LE+P1zFaBK45SRZoavi
         dqow==
X-Received: by 10.224.53.7 with SMTP id k7mr9355345qag.96.1359209499698;
        Sat, 26 Jan 2013 06:11:39 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-109-151.washdc.fios.verizon.net. [173.79.109.151])
        by mx.google.com with ESMTPS id r4sm222845qaa.2.2013.01.26.06.11.37
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 26 Jan 2013 06:11:38 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130126010359.GH3341@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214625>

On 01/25/2013 08:03 PM, Jonathan Nieder wrote:
> diff --git a/abspath.c b/abspath.c
> index 40cdc462..c7d5458e 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -216,7 +216,7 @@ const char *absolute_path(const char *path)
>   const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
>   {
>   	static char path[PATH_MAX];
> -#ifndef WIN32
> +#ifndef WINDOWS_NATIVE
>   	if (!pfx_len || is_absolute_path(arg))
>   		return arg;
>   	memcpy(path, pfx, pfx_len);
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 9b5e3d1b..136e4a74 100644

Maybe WINDOWS_NATIVE should be defined in config.mak.uname?

Otherwise, I tested the patch and it does build / run on Cygwin, but I 
cannot run a test suite until next week. I am concerned about subtle 
changes due to the  various WIN32 tests that were not guarded by 
__CYGWIN__ before, haven't stared at the code enough to see if there 
could be an issue.

Mark
