From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Tue, 18 Dec 2007 13:32:59 +0100
Message-ID: <200712181333.01051.jnareb@gmail.com>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu> <200712181014.38986.jnareb@gmail.com> <20071218121115.1c893dc4@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 18 13:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4be3-0004yh-3a
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 13:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbXLRMdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 07:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755968AbXLRMdL
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 07:33:11 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:20015 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933AbXLRMdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 07:33:09 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2034021fkz.5
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 04:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=v5zpNJFtCYVSH/jgDXMJQ+OJvMg1nTgtCSW/ogHbHeQ=;
        b=EtkdFrTvavmwUeV7dBg8E8BZ3O1EUOBFvl88ezF06gSLyDB821rpUIH9CEM6SBVB26W0N7APPmQ+mriCCLr/9UhSig/DGKgM1LBzsLPGIc+DVtQiQdLMlLvzfEFO8JxqvwtYUwLAfnJA27267Z5Ey9b4K0zLGEXZSibLf5vlkL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=vX0R64oYu6GSC+ujQXL4of2M4WlfdkqcpYKDA84zDHy0SbA79XsUeBAataav4nNk2yS+xgFLCq8vQSUD213pubiP3VRNudP9HBVQoRerwh7WgiU8px0hrIufisN2X8/tpA+lEAean6+wSzhfzVRrjf0m1quMKoeEYzkSrmrD+JE=
Received: by 10.82.146.14 with SMTP id t14mr2589115bud.9.1197981186610;
        Tue, 18 Dec 2007 04:33:06 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.201])
        by mx.google.com with ESMTPS id b30sm1586320ika.2007.12.18.04.33.04
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 04:33:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071218121115.1c893dc4@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68737>

H.Merijn Brand wrote:
> On Tue, 18 Dec 2007 10:14:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Tue, 18 Dec 2007, H.Merijn Brand wrote:
>>> On Tue, 18 Dec 2007 09:20:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> On Tue, 18 Dec 2007, H.Merijn Brand wrote:
>>>>> On Mon, 17 Dec 2007 17:21:08 -0800 (PST), Jakub Narebski wrote:
>>>>>>
>>>>>> Second, the default autoconf macro AC_PROG_INSTALL *requires* that
>>>>>> there is BSD-compatible `install' program (as 'install-sh' or
>>>>>> 'install.sh') in the sources.  Adding such script is (I think) not a
>>>>>> problem; finding minimal portable[*1*] script is.  
>>>>>> So if you know one... 
>>>> 
>>>> [...]. There is need for BSD-compatibile
>>>> `install` program as 'install-sh', not 'make-install' script. The idea
>>>> is to use system-provided 'install' if it exists and is compatibile,
>>> 
>>> There lies the problem. HP-UX does have an 'install', but it is not
>>> compatible, and chances are (very) small that people have installed
>>> the GNU or any other BSD compliant install.
>>> 
>>>> because it should be faster than script version, and fallback to 
>>>> provided install-sh only if system install is not found.
>>> 
>>> The problem again. It *does* find install, but it turns out to be
>>> unusable.
>> 
>> Could you check if ./configure correctly uses install-sh in your case?
>> Copy install-sh from for example autotools[*1*] (e.g. libtool has one)
>> to the git sources, uncomment line with AC_PROG_INSTALL in configure.ac,
>> generate configure script using "make configure" and check what
>> ./configure chooses.
>> 
>> In my case it is:
>> 
>>   $ cp /usr/share/libtool/install-sh .
>>   $ make configure
>>   GIT_VERSION = 1.5.4.rc0.56.g6fbe-dirty
>>       GEN configure
>>   $ ./configure
>>   configure: CHECKS for programs
>>   [...]
>>   checking for a BSD-compatible install... /usr/bin/install -c
>> 
>> What is ./configure output in your case?

 
> /pro/3gl/LINUX/git-2007-12-17 119> cp /pro/3gl/GNU/gcc/r3/gcc-4.2.2/install-sh install-sh

> -- uncommented the AC_PROG_INSTALL line ...

> OK, rebuild configure ...
> 
> a5:/pro/3gl/LINUX/git-2007-12-17 129> make configure
>     GEN configure
> a5:/pro/3gl/LINUX/git-2007-12-17 130> rm config.{log,status}
> a5:/pro/3gl/LINUX/git-2007-12-17 131> configure --prefix=/pro/local --disable-nls --without-iconv --with-perl=/pro/bin/perl> & config-log
> a5:/pro/3gl/LINUX/git-2007-12-17 132> grep -w install config-log config.log config.status
> config-log:checking for a BSD-compatible install... /opt/imake/bin/install -c
> config.log:configure:2218: checking for a BSD-compatible install
> config.log:configure:2273: result: /opt/imake/bin/install -c
> config.log:ac_cv_path_install='/opt/imake/bin/install -c'
> config.status:INSTALL="/opt/imake/bin/install -c"

Does chosen by ./configure script 'install' binary, namely 
/opt/imake/bin/install works correctly, meaning does it install
git correctly?

-- 
Jakub Narebski
Poland
