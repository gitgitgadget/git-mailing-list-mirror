From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH] MSVC: Enable OpenSSL, and translate -lcrypto
Date: Sat, 03 Oct 2009 22:08:56 +0200
Message-ID: <4AC7AF58.1090603@gmail.com>
References: <18cd41840910031300i32c74b15t74eb9eee23ff8469@mail.gmail.com> <40aa078e0910031305u38cfaf4aua72d4c7af2a470b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 03 22:09:17 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f159.google.com ([209.85.212.159])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuAup-0000GI-Pk
	for gcvm-msysgit@m.gmane.org; Sat, 03 Oct 2009 22:09:16 +0200
Received: by vws31 with SMTP id 31so3647380vws.21
        for <gcvm-msysgit@m.gmane.org>; Sat, 03 Oct 2009 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:received:received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=WO6Tkjx8lEOHXx20XosAoutRYXQN13AsyHwP7Uv6WeE=;
        b=rM5zOWXL763IijoMR1B3FL5xO6seOEL6i4kaNTW6MJKMKMgWCIYD/N/DNwZ9eWJdkE
         0OT8CDbsaPaighM2TqohXUbEUz12s04cwcAiTvGPjJmjF8DvwuHdg3OiZC8ykCOpN5Yc
         vK1q3iDU762dUrfGVtsTK2p9P0+gsAAo1OtLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=j/GYRoT58DGKuen35Pt2CYPvXEKlvbAsWI/sxhUKqwCG4+SI2qbyMbKn8oLd8lGLs3
         QeCH4xW8yTAe0bHdc28+wmmg2UOCdCRxf6/15bD/owIDUXnL3ANXMtC/A7z+dAtMuvU+
         WldN+K1TLcuozNLimTL7UK7gSWwwFAaJjC+D0=
Received: by 10.220.110.148 with SMTP id n20mr867225vcp.1.1254600548536;
        Sat, 03 Oct 2009 13:09:08 -0700 (PDT)
Received: by 10.176.58.28 with SMTP id g28gr7246yqa.0;
	Sat, 03 Oct 2009 13:08:59 -0700 (PDT)
X-Sender: marius@storm-olsen.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.253.11 with SMTP id a11mr606559ebi.23.1254600538423; Sat, 03 Oct 2009 13:08:58 -0700 (PDT)
Received: by 10.210.253.11 with SMTP id a11mr606558ebi.23.1254600538400; Sat, 03 Oct 2009 13:08:58 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147]) by gmr-mx.google.com with ESMTP id 15si573201ewy.4.2009.10.03.13.08.58; Sat, 03 Oct 2009 13:08:58 -0700 (PDT)
Received-SPF: neutral (google.com: 74.125.78.147 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) client-ip=74.125.78.147;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 74.125.78.147 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) smtp.mail=marius@storm-olsen.com
Received: by ey-out-1920.google.com with SMTP id 13so333824eye.52 for <msysgit@googlegroups.com>; Sat, 03 Oct 2009 13:08:58 -0700 (PDT)
Received: by 10.211.132.20 with SMTP id j20mr4933975ebn.32.1254600537742; Sat, 03 Oct 2009 13:08:57 -0700 (PDT)
Received: from ?192.168.0.198? (cm-84.215.55.206.getinternet.no [84.215.55.206]) by mx.google.com with ESMTPS id 10sm1132682eyz.18.2009.10.03.13.08.54 (version=SSLv3 cipher=RC4-MD5); Sat, 03 Oct 2009 13:08:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <40aa078e0910031305u38cfaf4aua72d4c7af2a470b2@mail.gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129498>


Erik Faye-Lund said the following on 03.10.2009 22:05:
> On Sat, Oct 3, 2009 at 1:00 PM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>>  This patch was actually sent using the MSVC
>>  git-imap-send.exe to my GMail account.
>>   D:\msvc\git>cat
>> 0001-MSVC-Enable-OpenSSL-and-translate-lcrypto.patch |
>> git-imap-send.exe
>>   Resolving imap.gmail.com... ok
>>   Connecting to 74.125.79.109:993... ok
>>   Logging in...
>>   sending 1 message
>>   100% (1/1) done
>>  :)
> 
> Awesome :)

Yup, only sad to see that GMail dropped the In-reply-to when sending :-/

>> diff --git a/Makefile b/Makefile
>> index 8818f0f..c4b91d8 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -881,7 +881,6 @@ ifdef MSVC
>>        GIT_VERSION := $(GIT_VERSION).MSVC
>>        pathsep = ;
>>        NO_PREAD = YesPlease
>> -       NO_OPENSSL = YesPlease
>>        NO_LIBGEN_H = YesPlease
>>        NO_SYMLINK_HEAD = YesPlease
>>        NO_IPV6 = YesPlease
> 
> Didn't my 7/7 already do this hunk?

Not for MSVC. It has it's own section above the MinGW part. Besides, the
-lcrypto 'translation' is critical for it to link.

--
.marius
