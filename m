From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 4/4] Add Travis CI support
Date: Fri, 6 Nov 2015 14:18:59 +0100
Message-ID: <AF36AA68-F603-4151-8314-C9BA69EB27D0@gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com> <1446800323-2914-5-git-send-email-larsxschneider@gmail.com> <CAPig+cSc+BBgd3-UeVE79D9GWXfaQqbLCQdKo6FbhnPMsK_eFA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 14:19:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zugv6-0006se-7E
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976AbbKFNTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:19:03 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37563 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbbKFNTC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 08:19:02 -0500
Received: by wmll128 with SMTP id l128so40595316wml.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 05:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=llkwVTvlFUSykQ9keRJhZwjG5dTC46YPaw/r5l08zSM=;
        b=sb30qtn0M1PJK92MWk1ZfoIi93HrcBoYIe3yI4doDNJbFCe9trHwLF5vZMxKLuANO4
         C1xs7c7QnRVrK7wAOwqKyNVKFn7R1YB37UdtFoYQIoT6QYvBaIf/V7tGeu5kXQnf6Izk
         d2GGzn1p7PA3qr/yYg2IxyX4MYuXVZTqSsCtXgEUoauGe+Ci4YdojD0H5fgXy2xmfz5V
         otdHfF4+G1180yM0IKsdxBEqcwydCRaHH/z8bW8eil8xH0jc5I8GDF9NKWIH5UcdybPs
         85ygnQy+UGjZFsPts/z/X82UmjvSOfxvFMABv6Z5xLgnEGsF80ye74JhicGzT48Cgzmr
         KjLQ==
X-Received: by 10.28.138.140 with SMTP id m134mr10044537wmd.74.1446815940553;
        Fri, 06 Nov 2015 05:19:00 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r9sm99133wjz.35.2015.11.06.05.18.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 05:18:59 -0800 (PST)
In-Reply-To: <CAPig+cSc+BBgd3-UeVE79D9GWXfaQqbLCQdKo6FbhnPMsK_eFA@mail.gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280975>


> On 06 Nov 2015, at 10:56, Eric Sunshine <sunshine@sunshineco.com> wrote:
> 
> On Fri, Nov 6, 2015 at 3:58 AM,  <larsxschneider@gmail.com> wrote:
>> The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
>> 64 bit" and on "OS X Mavericks" using gcc and clang.
>> 
>> Perforce and Git-LFS are installed and therefore available for the
>> respective tests.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/.travis.yml b/.travis.yml
>> @@ -0,0 +1,131 @@
>> +  matrix:
>> +    -
>> +      # NO_ICONV=YesPlease
>> +    - >
>> +      NO_CURL=YesPlease
>> +      NO_D_INO_IN_DIRENT=YesPlease
>> +      NO_DEFLATE_BOUND=YesPlease
>> +      NO_EXPAT=YesPlease
>> +      NO_GECOS_IN_PWENT=YesPlease
>> +      NO_GETTEXT=YesPlease
>> +      NO_HMAC_CTX_CLEANUP=YesPlease
>> +      NO_HSTRERROR=YesPlease
>> +      NO_INET_NTOP=YesPlease
>> +      NO_INET_PTON=YesPlease
>> +      NO_INITGROUPS=YesPlease
>> +      NO_INTTYPES_H=YesPlease
>> +      NO_IPV6=YesPlease
>> +      NO_IPV6=YesPlease
>> +      NO_LIBGEN_H=YesPlease
>> +      NO_MEMMEM=YesPlease
>> +      NO_MKDTEMP=YesPlease
>> +      NO_MKSTEMPS=YesPlease
>> +      NO_MMAP=YesPlease
>> +      NO_NSEC=YesPlease
>> +      NO_OPENSSL=YesPlease
>> +      NO_PERL=YesPlease
>> +      NO_PTHREADS=YesPlease
>> +      NO_REGEX=YesPlease
>> +      NO_SETENV=YesPlease
>> +      NO_SETITIMER=YesPlease
>> +      NO_SOCKADDR_STORAGE=YesPlease
>> +      NO_STRCASESTR=YesPlease
>> +      NO_STRLCPY=YesPlease
>> +      NO_STRTOUMAX=YesPlease
>> +      NO_STRUCT_ITIMERVAL=YesPlease
>> +      NO_SYMLINK_HEAD=YesPlease
>> +      NO_SYS_POLL_H=YesPlease
>> +      NO_SYS_SELECT_H=YesPlease
>> +      NO_UINTMAX_T=YesPlease
>> +      NO_UNSETENV=YesPlease
> 
> Hmm, aren't you losing test coverage by disabling some of these? Is
> that desirable for continuous integration testing? Am I missing
> something?
Per platform/compiler (Linux&Mac/clang&gcc) we run two configurations. One normal configuration (see the lonely "-" right under "matrix:") and one configuration with all sorts of things are disabled ("NO...").

You can see all 8 configurations ([linux, mac] * [clang, gcc] * [normal, NO_...]) here:
https://travis-ci.org/larsxschneider/git/builds/89598194

Cheers,
Lars 
