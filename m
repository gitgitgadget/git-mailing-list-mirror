From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Update setup-git-server-over-http.txt based on my experience.
Date: Thu, 03 Apr 2008 22:56:38 +0200
Message-ID: <vpqtziimzcp.fsf@bauges.imag.fr>
References: <1207241902-4667-1-git-send-email-Matthieu.Moy@imag.fr>
	<alpine.LSU.1.00.0804031905410.4008@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 22:58:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhWVU-0001C3-7J
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 22:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664AbYDCU5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 16:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755720AbYDCU5P
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 16:57:15 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:58749 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664AbYDCU5O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 16:57:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m33KudC4024285;
	Thu, 3 Apr 2008 22:56:39 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JhWUB-0005IO-1x; Thu, 03 Apr 2008 22:56:39 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JhWUA-0001hm-Va; Thu, 03 Apr 2008 22:56:38 +0200
In-Reply-To: <alpine.LSU.1.00.0804031905410.4008@racer.site> (Johannes Schindelin's message of "Thu\, 3 Apr 2008 19\:12\:46 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 03 Apr 2008 22:56:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78776>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> I don't like the commit subject.  At all.

Well, I can't think of a better one. The patch introduces several
minor changes, and I don't think it deserves a real patch serie for
each unrelated change.

Suggestions welcome.

> On Thu, 3 Apr 2008, Matthieu Moy wrote:
>
>> -- have git installed at the server _and_ client
>> +- have git installed on the client, and preferably on the server
>
> How do you want to initialise the repository on the server, then?  (IOW 
> you should mention here that you need a WebDAV client on the client if you 
> do not have Git on the server, and that it is way more fiddly.)

What part of

 Another
 option is to generate an empty repository at the client and copy it to
 the server with a WebDAV client (which is the only option if Git is
 not installed on the server).

is unclear ?

>> -In effect, this probably means you're going to be root.
>> +In effect, this probably means you're going to be root, or that you're
>> +using a preconfigured WebDAV server.
>
> Either you strike "probably" or you skip what you added.

Why?

>> @@ -169,7 +170,8 @@ On Debian:
>>  
>>     Most tests should pass.
>>  
>> -A command line tool to test WebDAV is cadaver.
>> +A command line tool to test WebDAV is cadaver. If you prefer GUIs,
>> +konqueror can open WebDAV URLs as "webdav://..." or "webdavs://...".
>
> What do you do if you have MacOSX, or Windows?

You read messages instead of truncating them if you're on windows.

I have no idea about MacOSX, but that's not the point of my patch.

>> -Make sure that you have HTTP support, i.e. your git was built with curl.
>> -The easiest way to check is to look for the executable 'git-http-push'.
>> +Make sure that you have HTTP support, i.e. your git was built with
>> +curl (and a recent enough version).
>
> Say what version.  Otherwise this comment will soon be very, very stale.
>
>> +The easiest way to check is to +look for the executable 
>> 'git-http-push'. The command "git http-push" +with no argument should 
>> display a usage message.
>
> My search revealed that http-push was in Git since tags/v0.99.9e^2~9^2~4.  
> Which is not recent at all.

Before my patch, the explanation says that you just need to check
whether you have git-http-push, which is insufficient. With my patch,
it gives an accurate check. I believe this is an improvement.

>> +Also note that the URL should point to the git repository itself, that
>> +is, to the '.git/' directory and not the working tree in case the
>> +repository is non-bare.
>
> It makes no sense to describe the case of a non-bare repository.

Actually, it makes no real sense to have a non-bare repository. But
I've been bitten by this (I just typed "git init" without --bare, and
uploaded it). Since git-http-push gives _very_ bad error messages,
it's good to point the user to potential mistakes to help
troubleshooting.

>> +Using a proxy:
>> +--------------
>> +
>> +If you have to access the WebDAV server from behind an HTTP(S) proxy,
>> +set the variable 'all_proxy' to 'http://proxy-host.com:port', or
>> +'http://login-on-proxy:passwd-on-proxy@proxy-host.com:port'. See 'man
>> +curl' for details.
>
> You only need http_proxy.

What makes you think that?

(hint: I've been bitten by this too).

-- 
Matthieu
