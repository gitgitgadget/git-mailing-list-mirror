From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Sat, 09 Mar 2013 13:50:16 -0500
Message-ID: <513B8468.7070006@gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de> <513B8037.7060107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Sat Mar 09 19:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEOvc-0000dG-36
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 19:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab3CISzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 13:55:00 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:57393 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab3CISzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 13:55:00 -0500
Received: by mail-ia0-f174.google.com with SMTP id k38so779853iah.5
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 10:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=G/acVatE6EgQQTcq/MXgWfK+4/LCkzbjTvQSCKtuO5g=;
        b=IjaTK03t2UZMHQxZpZ20rAs+JVDpxnfs9LPD6HLhjHvjHyHNIoJOSBI+yIFVIZ9sC4
         5PgV3vwSVjBVsX7pruAl9ITLbeOKMenwynn3mijj28lniQT1s+GoDhbx+T15lcFKHFLO
         9QNTScC7Dv61RPD1C3/rmRXmvBD7dQOK7EANjXG8OuFTP/aeQ08b51ArX7k59q10G9Zo
         R5zxKotEOCv2UjX0gneyKLOM6x8itu4tRNcPvcL/n3DwI1B9okiS34iKfFn4cZ7FS2lL
         7jvyBMYCk6Ku4sXBQoxeU5M6e7li+gV0kzhzjxeYAPdKWiwXyHCaDZmxc8a47goFSnLm
         sn0Q==
X-Received: by 10.50.184.132 with SMTP id eu4mr3150716igc.19.1362855299757;
        Sat, 09 Mar 2013 10:54:59 -0800 (PST)
Received: from [192.168.1.4] ([69.165.234.69])
        by mx.google.com with ESMTPS id g6sm4843903ign.4.2013.03.09.10.54.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 10:54:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.11) Gecko/20121202 Thunderbird/10.0.11
In-Reply-To: <513B8037.7060107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217735>

On 03/09/13 13:32, Andrew Wong wrote:
> Yea, that's really suspicious. This could mean there's an issue with
> when git is checking the index. Try running these a couple times in a
> clean work tree:
>     $ git update-index --refresh
>     $ git diff-files
>
> In a clean work tree, these commands should print nothing. But in your
> case, these might print random files that git thinks have been modified...
Before you run those commands each time, you probably have to "touch"
couple files to trigger the issue:
    $ touch file1 file2

Maybe use touch on the files that git rebase has been reporting error?
