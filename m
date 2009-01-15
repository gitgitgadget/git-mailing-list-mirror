From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: cygwin git diff crash
Date: Thu, 15 Jan 2009 07:42:49 -0700
Message-ID: <b9fd99020901150642i2e61bb78yf2dab2b8713592df@mail.gmail.com>
References: <b9fd99020901141409w1e0c926fkc762f8709bd1c13f@mail.gmail.com>
	 <alpine.DEB.1.00.0901142333200.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTSB-0001p3-S1
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761788AbZAOOmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761195AbZAOOmw
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:42:52 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:3937 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759851AbZAOOmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:42:50 -0500
Received: by rn-out-0910.google.com with SMTP id k40so884948rnd.17
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 06:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AGn1DPoZMqw+g0jY+XLszJLnsUxPcseBqap19Y348qw=;
        b=s8hjeI+NR4Mxsv2tbOJk2OKeICrqwxBVRl98Dpxtv0LqXhrdQVisDtJ/9PtkuUPe3a
         EbL6bxbWv+IvGdxjbg8WzsVGPCe3UogEIz47FTuQUpWzsGuv+0qANLQAUAielNlzuhow
         Q1cbO/VLPfLn6Q9gf1OPKVBTbayXrA5PdFdH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mRtAYbJOwD4rgcufV/pvbfI946K4aIQdIEXYaV498KKdBO/71OHd5AaWMUA34DayJx
         FrZQHoMY4BvwR6NQl1nK4kNKFWZPNjJiDUD3AFD+3nosb3jMpnTcqIdj/BH2AN7ZWtyE
         B2ehvtUEN8FfbKTOE5ppb+o5Tkcbuz22I3+g0=
Received: by 10.100.136.18 with SMTP id j18mr1159327and.48.1232030569631;
        Thu, 15 Jan 2009 06:42:49 -0800 (PST)
Received: by 10.100.140.4 with HTTP; Thu, 15 Jan 2009 06:42:49 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901142333200.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105822>

On Wed, Jan 14, 2009 at 3:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 14 Jan 2009, Jeremy Ramer wrote:
>
>> Ok this is a weird issue and it's probably cygwin's fault, but I
>> haven't found any way to fix it so I' thought I would throw it out
>> here for comment.
>>
>> I am using git 1.6.0.4 on cygwin. I have a repo where if any file has
>> changes and git detects as mode 100644 I get this error:
>> $git diff
>>       3 [main] git 2744 C:\cygwin\bin\git.exe: *** fatal error - could
>> not load user32, Win32 error
>>
>> If I change the mode to 100755 git diff will work fine.
>> $chmod a+x test.cpp
>> $git diff
>> diff --git a/test.cpp b/test.cpp
>> old mode 100644
>> new mode 100755
>> index 7c0dfcd..20987a7
>> --- a/test.cpp
>> +++ b/test.cpp
>> @@ -6,9 +6,11 @@ int main()
>>
>>  void func()
>>  {
>> +       int a;^M
>>  }
>>
>>  void func2()
>>  {
>> +       int b;^M
>>  }
>>
>> Anybody have a clue as to why this might occur?  I have seen this in
>> many of the repo's I use, but it is not repeatable.  I tried making a
>> test repo but could not reproduce.
>
> Wow, that _is_ weird.  Does your test suite pass?
>
> Ciao,
> Dscho
>

Forgive my ignorance, but I am not sure how to run the test suite.  I
did a quick google search but didn't find anything.  I am using
cygwin's packaged version of git and am not building it from source,
so maybe the suite is not available.  If I get a chance I will try
building from source.

Jeremy
