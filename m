From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [BUG] Bad msysgit/egit interaction over dotfiles
Date: Wed, 09 Dec 2009 21:56:21 +0100
Message-ID: <4B200EF5.2060606@gmail.com>
References: <20091208132857.GB5425@linagora.com> <40aa078e0912080534x32fe9724xcda47ad46dbdb7c0@mail.gmail.com> <4B1E57BF.1000500@pelagic.nl> <40aa078e0912080623q108b2affk80534ccd5fd7ace3@mail.gmail.com> <20091208143700.GC5425@linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, Ferry Huberts <ferry.huberts@pelagic.nl>,
	GIT ml <git@vger.kernel.org>
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 21:56:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NITaK-0004q7-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 21:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757944AbZLIU4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 15:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757938AbZLIU4S
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 15:56:18 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:58520 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757802AbZLIU4R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 15:56:17 -0500
Received: by ewy1 with SMTP id 1so4817899ewy.28
        for <git@vger.kernel.org>; Wed, 09 Dec 2009 12:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pI9l3e64eoREp4atmHRwowfRseo4dZORXdFXrNVy2Jk=;
        b=HtAEyigSXP5DLHvYA3UCRMB4LJIyRtAg84V9SDWNLKIUOaA+aAlg3jf4C7JoG+TB8H
         rZqir6jHbwhIMP0nC2HziBcny7mzstB6xpe5D5IXwK5QBPmbEMuITih2N9iIb0ZAYz81
         andbxuBvqQtZj+rzIH2RTDGS8c8ZiEuTcqgyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZI7CTmCQyfr10NWRjpTJuhFqNyNB25fhnxioCXuH08vd66c3M4NPSBYQYo5fjaoTfs
         NyOa08XVais3uytUpTsGcr3vZpavjr/V3Jo5f4O6QzIo/jT8/8UpRhtVBM0NOpPjj6fs
         WjC+cFSPOKi4C1VGkq1fxY9XxGRnCbAiGH2mg=
Received: by 10.213.97.14 with SMTP id j14mr251021ebn.52.1260392182399;
        Wed, 09 Dec 2009 12:56:22 -0800 (PST)
Received: from ?192.168.0.67? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 15sm138713ewy.4.2009.12.09.12.56.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Dec 2009 12:56:21 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <20091208143700.GC5425@linagora.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134997>

Yann Dirson said the following on 08.12.2009 15:37:
> On Tue, Dec 08, 2009 at 03:23:55PM +0100, Erik Faye-Lund wrote:
>> You can follow the discussion here:
>> http://code.google.com/p/msysgit/issues/detail?id=288
>>
>> I believe the reason is something like "because someone suggested
>> it, and no one disagreed". Do you have a good argument why it
>> shouldn't be the default (other than "it's a change", because
>> changing it back now would also be a change)?
>
> Depending on the opinion of the Eclipse guys on this issue about
> "writing to hidden files only says 'could not write'", which
> arguably could be seen as a bug on their side, we can see changing
> this behaviour back to the default on the msysgit side as either a
> (possibly temporary) workaround for a known eclipse bug, or as
> getting again interoperable with egit.

Dot-files on unix are considered hidden. It's the only way files are 
hidden there. Not so on Windows. Dot-files are just like any normal 
file, and you need to mark a file hidden.

So, the logic of egit, that *actually* hidden files should not be 
written to, but dot-files should, seems to me to be a bug in egit. 
There should be no reason why egit shouldn't be able to write to any 
file, pending permissions. I'd say file a bug report with egit.

--
.marius
