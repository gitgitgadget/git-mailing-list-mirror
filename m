From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 21:31:42 +0200
Message-ID: <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md7vq-0004UN-TE
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbZHQTbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 15:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbZHQTbn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:31:43 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:49647 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZHQTbm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 15:31:42 -0400
Received: by bwz22 with SMTP id 22so2511360bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 12:31:42 -0700 (PDT)
Received: by 10.223.144.149 with SMTP id z21mr935118fau.8.1250537502549; Mon, 
	17 Aug 2009 12:31:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126258>

>> diff --git a/compat/msvc.h b/compat/msvc.h
>> new file mode 100644
>> index 0000000..6071565
>> --- /dev/null
>> +++ b/compat/msvc.h
>> @@ -0,0 +1,95 @@
>> +#ifndef __MSVC__HEAD
>> +#define __MSVC__HEAD
>> +
>> +#define WINVER 0x0500
>> +#define _WIN32_WINNT 0x0500
>> +#define _WIN32_WINDOWS 0x0410
>> +#define _WIN32_IE 0x0700
>> +#define NTDDI_VERSION NTDDI_WIN2KSP1
>> +#include <winsock2.h>
>> +
>> +/*Configuration*/
>> +
>> +#define NO_PREAD
>> +#define NO_OPENSSL
>> +#define NO_LIBGEN_H
>> +#define NO_SYMLINK_HEAD
>> +#define NO_IPV6
>> +#define NO_SETENV
>> +#define NO_UNSETENV
>> +#define NO_STRCASESTR
>> +#define NO_STRLCPY
>> +#define NO_MEMMEM
>> +#define NO_C99_FORMAT
>> +#define NO_STRTOUMAX
>> +#define NO_MKDTEMP
>> +#define NO_MKSTEMPS
>> +
>> +#define RUNTIME_PREFIX
>> +#define NO_ST_BLOCKS_IN_STRUCT_STAT
>> +#define NO_NSEC
>> +#define USE_WIN32_MMAP
>> +#define USE_NED_ALLOCATOR
>> +
>> +#define NO_REGEX
>> +
>> +#define NO_SYS_SELECT_H
>> +#define NO_PTHEADS
>> +#define HAVE_STRING_H 1
>> +#define STDC_HEADERS
>> +#define NO_ICONV
>
> These would normally be defined in the Makefile. =A0You might want to=
 state
> that in a comment.
>
> Or maybe move the definitions (along with vsnprintf) to the .vcproj f=
ile,
> which is the logical pendant of the Makefile?

What about having a CMake build system, which would work on every
platform (including cross-compiling), and would produce an appropriate
config.h and makefiles/vcproj/Eclipse projects/XCode projects/whatever
is fit for each platform? If it's OK to include such a build system
upstream, I'm volunteering to implement it.

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
