From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Wed, 26 Jan 2011 15:29:53 +0100
Message-ID: <AANLkTik7BbYTCgBymMiGfS9gxHXN_jY7Ftz8K4+aZRQx@mail.gmail.com>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com>
 <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com>
 <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com>
 <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com> <alpine.DEB.2.00.1101261422550.20831@tvnag.unkk.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mika Fischer <mika.a.fischer@googlemail.com>, msysGit <msysgit@googlegroups.com>, 
	Git Mailing List <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: msysgit+bncCOPdven-DxD37oDqBBoEAl5wPg@googlegroups.com Wed Jan 26 16:02:45 2011
Return-path: <msysgit+bncCOPdven-DxD37oDqBBoEAl5wPg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxD37oDqBBoEAl5wPg@googlegroups.com>)
	id 1Pi6tN-0007ii-5H
	for gcvm-msysgit@m.gmane.org; Wed, 26 Jan 2011 16:02:41 +0100
Received: by fxm13 with SMTP id 13sf499426fxm.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 26 Jan 2011 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:x-beenthere:received-spf:mime-version:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=kKt7DY4IBD88goUYg+Hp5nEGjo11QzgFmwgoTSOSy+8=;
        b=PpYvyJEUsMZfI88C/kdaGkoH07rFMMWHmoJTkfc/TVoRgGekorSzpV8+H+5MJuddL6
         +oYI6oVuVHtmVE3cSQNhhpy8GxGWyl3bewqZYyoQkuGSQ4nPcLMErLYgNN/DeWyWahrt
         KSKDZIYFaWAGnldxB4vxCn1YMOe2R0TV9ElE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        b=ywEVIzx4n2tCkzvlsTnykl1cCsXHPJC14drAO6ULF6gBdUEUG1pv99tm/NkjWvsT0f
         +O+LgeuSrz7giPZNWaLLcS1te5i3HB1dv3Hxxqjbbg5jtwkO6rLuAWrefbXv0J/UxXc+
         srDmuN8SCIMfT7mn8vMERH78Fn9QMrbccrfUc=
Received: by 10.223.71.197 with SMTP id i5mr208450faj.33.1296054135101;
        Wed, 26 Jan 2011 07:02:15 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.7.80 with SMTP id c16ls189016fac.3.p; Wed, 26 Jan 2011
 07:02:14 -0800 (PST)
Received: by 10.223.74.144 with SMTP id u16mr729850faj.8.1296054133857;
        Wed, 26 Jan 2011 07:02:13 -0800 (PST)
Received: by 10.223.74.144 with SMTP id u16mr729849faj.8.1296054133829;
        Wed, 26 Jan 2011 07:02:13 -0800 (PST)
Received: from mail-bw0-f48.google.com (mail-bw0-f48.google.com [209.85.214.48])
        by gmr-mx.google.com with ESMTPS id r13si1760060fah.7.2011.01.26.07.02.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 07:02:12 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.214.48 as permitted sender) client-ip=209.85.214.48;
Received: by bwz8 with SMTP id 8so1535039bwz.35
        for <msysgit@googlegroups.com>; Wed, 26 Jan 2011 07:02:12 -0800 (PST)
Received: by 10.204.57.13 with SMTP id a13mr474213bkh.75.1296052972550; Wed,
 26 Jan 2011 06:42:52 -0800 (PST)
Received: by 10.204.120.197 with HTTP; Wed, 26 Jan 2011 06:29:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101261422550.20831@tvnag.unkk.fr>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.214.48 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165520>

On Wed, Jan 26, 2011 at 2:29 PM, Daniel Stenberg <daniel@haxx.se> wrote:
> On Wed, 26 Jan 2011, Mika Fischer wrote:
>
>> But I noticed that the same problem occurs on OpenSuSE 11.2. So I compiled
>> the latest version of curl on OpenSuSE 11.2 and the problem is still
>> present...
>
> Sorry, but I can't repeat this problem. I tried this:
>
> 1. I got OpenSSL 1.0.0c, built it and installed it.
>
> 2. I started OpenSSL's little HTTPS server with this version:
>
> $ openssl s_server -HTTP -cert [PEM]
>
> (I verified, and this binary uses the lib statically so there's no funny lib
> path issues here.)
>
> 3. I tried getting a file through this using curl 7.21.2 and my current dev
> version of 7.21.4-DEV (see below for full details). Both managed to get it
> fine.
>
> From this, I conclude that there's some additional factors necessary to make
> this problem trigger. Can you figure out what?
>
> The full curl -V outputs from my two test versions:
>
> curl 7.21.2 (i486-pc-linux-gnu) libcurl/7.21.2 OpenSSL/0.9.8o zlib/1.2.3.4
> libidn/1.18 libssh2/1.2.6
> Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3
> pop3s rtsp scp sftp smtp smtps telnet tftp
> Features: GSS-Negotiate IDN IPv6 Largefile NTLM SSL libz
>
> curl 7.21.4-DEV (i686-pc-linux-gnu) libcurl/7.21.4-DEV OpenSSL/1.0.0c
> zlib/1.2.3.4 c-ares/1.7.5-DEV libidn/1.18 libssh2/1.2.8_DEV librtmp/2.2e
> Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3
> pop3s rtmp rtsp scp sftp smtp smtps telnet tftp
> Features: AsynchDNS Debug TrackMemory GSS-Negotiate IDN IPv6 Largefile NTLM
> SSL libz
>

Here's the output from Git for Windows' curl -V:

$ curl -V
curl 7.21.1 (i686-pc-mingw32) libcurl/7.21.1 OpenSSL/0.9.8k zlib/1.2.3
Protocols: dict file ftp ftps http https imap imaps ldap ldaps pop3
pop3s rtsp smtp smtps telnet tftp
Features: Largefile NTLM SSL SSPI libz
