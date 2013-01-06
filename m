From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 17:16:34 -0500
Message-ID: <50E9F7C2.1000603@gmail.com>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6ge?= =?ISO-8859-1?Q?rshausen?= 
	<tboegi@web.de>, Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 23:16:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TryWW-00089K-O6
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 23:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab3AFWQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 17:16:38 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:39755 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab3AFWQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 17:16:36 -0500
Received: by mail-qc0-f173.google.com with SMTP id b12so11200485qca.4
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 14:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8nPhTMa/SRBKw7IprWbcuAdfG3qz9I9gMwU3ssaPs0Y=;
        b=a4YdL5Gj32+vBHnfDMp1qi+btvI5HyiSUgZ3sOQ+dgBa43G5F2kFPyXA1tQEYffFH/
         Of9903eRAJP6k0zbvs/nlj0kBle3Dh5yNrICw/Nk3VJflywa9P6fnvpXRBZGrSFR7TxN
         Sar4i8y17hz/CpgoivzVf1/QdmnYOkmmygMmlfq35pWy6eVCzhplB69UskHQXPS6f5OC
         /KI7adjyFOrGXQE+1AcShuGNGXdEEVaHWhi6ps1WtoYcQZc8Y41gPRoYZhRYTdprQlxy
         g9Zz1mHHfGGeCR+lXX58UM1yams4rb0QM7cepP9W4JRDs4afwL0GfaDbdd7Qa38TQ2EU
         BnOg==
X-Received: by 10.49.95.166 with SMTP id dl6mr48123266qeb.33.1357510596152;
        Sun, 06 Jan 2013 14:16:36 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-102-236.washdc.fios.verizon.net. [173.79.102.236])
        by mx.google.com with ESMTPS id hn9sm18406741qab.8.2013.01.06.14.16.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 14:16:35 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212851>

On 01/06/2013 02:54 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Mark Levedahl wrote:
>>
>>>                                                           However, the newer
>>> win32api is provided only for the current cygwin release series, which can
>>> be reliably identified by having dll version 1.7.x, while the older frozen
>>> releases (dll versions 1.6.x from redhat, 1.5.x open source) still have the
>>> older api as no updates are being made for the legacy version(s).
>> Ah.  That makes sense, thanks.
>>
>> (For the future, if we wanted to diagnose an out-of-date win32api and
>> print a helpful message, I guess cygcheck would be the command to use.)
> Hmph, so we might see somebody who cares about Cygwin to come up
> with a solution based on cygcheck (not on uname) to update this
> part, perhaps on top of Peff's "split default settings based on
> uname into separate file" patch?
>
> If I understood what Mark and Torsten wrote correctly, you will have
> the new win32api if you install 1.7.17 (or newer) from scratch, but
> if you are on older 1.7.x then you can update the win32api part as a
> package update (as opposed to the whole-system upgrade).  A test
> based on "uname -r" cannot notice that an older 1.7.x (say 1.7.14)
> installation has a newer win32api because the user updated it from
> the package (hence the user should not define CYGWIN_V15_WIN32API).
>
> Am I on the same page as you guys, or am I still behind?
>
> In the meantime, perhaps we would need something like this?

It's perhaps worth noting how we got into this mess. The problems have 
their root in

     adbc0b6b6e57c11ca49779d01f549260a920a97d

Cygwin's entire goal is a completely POSIX compliant environment running 
under Windows. The above commit circumvents some of Cygwin's API 
regarding stat/fstat to make things perhaps a bit faster, and definitely 
not POSIX compliant (The commit message is wrong, the commit definitely 
breaks POSIX compliance). That code is also what will not compile on 
different w32api versions. It is curious: the Cygwin  mailing list has 
been absolutely silent since the w32api change was introduced last 
summer, this is the only piece of code I am aware of that was broken by 
the new headers, and of course the purpose of this code is to circumvent 
the Cygwin API (and by extension, Cygwin project goals).

So, perhaps a better path forward is to disable / remove the above code 
by default. (Those wanting a native Win32 git should just use the native 
Win32 git).

Mark
