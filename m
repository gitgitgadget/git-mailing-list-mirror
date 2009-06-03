From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 03 Jun 2009 03:47:21 -0700 (PDT)
Message-ID: <m3r5y1a91m.fsf@localhost.localdomain>
References: <200905122329.15379.jnareb@gmail.com>
	<200906022339.08639.jnareb@gmail.com>
	<20090602232724.GN30527@spearce.org>
	<200906030250.01413.jnareb@gmail.com>
	<20090603021840.GE3042@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 12:47:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBo0K-0003Ke-KP
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 12:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbZFCKrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 06:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbZFCKrX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 06:47:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:54264 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbZFCKrV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 06:47:21 -0400
Received: by fg-out-1718.google.com with SMTP id 16so3344711fgg.17
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZpyWxs8Ynn0nUeRG/geREVtHoZ+6ZoHpbQTGf5FdKkY=;
        b=YZPFYhva+hHFkD+ylGHa+ycDB2K40bjMee9xc5KIXeF0wW5PSDcd33j49FJhQhBrx6
         uhA9VGdRjUQI07izYjPwmVh8ej25JOIe4rAVtryzaATmizN5LHPR0/v3DYy9Mo/ebZKI
         e0MKGdbXkfVY6HYkllZRktSGCA00Tx5A7m+Gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mSer9/gPsoQ2MlQVUqE7tR3QZgX196pv+mq93l+NzeZh/NYQu5oFP2ROGPWS1uW/Hf
         eDExxmSjW/x+GZrK5uvTrxsinm/yRbSwZACftOLbBCaF74BkrNVhmPjKztyqZMTQW8mO
         HZNKc+meYxUYpyKivn3AUmZ1Ix5zT7P8U0nnU=
Received: by 10.86.92.9 with SMTP id p9mr990580fgb.15.1244026042001;
        Wed, 03 Jun 2009 03:47:22 -0700 (PDT)
Received: from localhost.localdomain (abws210.neoplus.adsl.tpnet.pl [83.8.242.210])
        by mx.google.com with ESMTPS id e20sm14052704fga.10.2009.06.03.03.47.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 03:47:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n53AlJ3f019145;
	Wed, 3 Jun 2009 12:47:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n53AlHXe019134;
	Wed, 3 Jun 2009 12:47:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090603021840.GE3042@orbis-terrarum.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120599>

Please try to not cull the CC list (if possible), and provide
attribution for quoting.

"Robin H. Johnson" <robbat2@gentoo.org> writes:

>>>>> 	"0008NAK\n"
>>>>>
>>>> What does this server response mean? That served doesn't need more
>>>> info?
>>>>
>>> It means the server is answering a prior flush from the client,
>>> and is saying "I still can't serve you, keep tell me more have".
>>>
>> Hmmm... the communication between server and client is not entirely
>> clean. Do I understand correctly that this NAK is response to clients
>> flush after all those "want" lines? And that "0009done" from client
>> tells server that it should send everything it has?

> Relatedly with the "done" message, I'm in the process of writing a hook
> that allows the server to deny the client at this point, instead of
> building and sending a pack.
> 
> Suggestions on other modifications that might be needed to integrate. 
> The hook:
> - takes all want/have lines as input (maybe capabilities too?)
> - returns 0/1
> - on error, should also send a message to stderr, to be passed over the
>   wire.

I am not sure if it would be possible to fit a hook there, but perhaps
it would be possible to add such `pre-upload` hook... Note that it
would have to somehow work for both git:// and ssh:// protocols, and
perhaps also for "dumb" protocols such as http:// (and other
curl-based) and deprecated rsync://

> 
> My intended use is to block initial clones while still allowing updates
> (as long as you've got a tree at least commit X recent, I'll talk to
> you). Initial and too-old clients get a message to go and download a
> bundle instead.

Wouldn't it be better to make use of mirror-sync (which sadly is in
planning stages only; see SoC2009Ideas page on git wiki) to redirect
to some other repository to be used for cloning requests?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
