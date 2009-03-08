From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] Google Summer of Code 2009 - new ideas
Date: Mon, 9 Mar 2009 00:59:36 +0100
Message-ID: <200903090059.36699.jnareb@gmail.com>
References: <200903070144.17457.jnareb@gmail.com> <be6fef0d0903061856s21fdb4c4q9d52957dade96e94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 01:01:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgSvc-0002X2-Ey
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 01:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbZCHX7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 19:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbZCHX7k
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 19:59:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:22731 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbZCHX7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 19:59:39 -0400
Received: by fg-out-1718.google.com with SMTP id 16so768626fgg.17
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=h48Z/TpC8kL/cJhH5DijbCAbgjeFwPbBByQDz+3UHto=;
        b=pJR2xqrOe/pQGjFsKQ6LD8yZe5M1mV7k5aTJsLBRdvxanRNm+IRsYNtPpKsn+IlYRh
         fhaIR0O0ExuMKaQjAyJ5UvovUg8rqI9l4X+vhT3190fKMT2m2W75j0gswp89XrFzxykC
         2taBHJih0lzkYv2Ryx35RXF+2gjr0WaazJBV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=d11Cv49Yg+55YG0FZSSg9VcckDC/9Y8ViS4esPhC9IbZD/JJfUwlaINjA0ZgWtvqZf
         As1Gx5NBMoE986BMploy0wEYtOMYsUkxkcu93/zzGUcuVvyxHNI3EB9O9B3KKd09KnGf
         aj1ImLZpKCeClyzRpCVlqZzAiD5CYjlxmOQ4M=
Received: by 10.86.94.11 with SMTP id r11mr3562047fgb.11.1236556776391;
        Sun, 08 Mar 2009 16:59:36 -0700 (PDT)
Received: from ?192.168.1.13? (abvd146.neoplus.adsl.tpnet.pl [83.8.201.146])
        by mx.google.com with ESMTPS id e11sm2792271fga.20.2009.03.08.16.59.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Mar 2009 16:59:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <be6fef0d0903061856s21fdb4c4q9d52957dade96e94@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112654>

On Sat, 7 Mar 2009, Tay Ray Chuan wrote:
> On 3/7/09, Jakub Narebski <jnareb@gmail.com> wrote:

> > == Single credentials ==
> >
> > Currently if you don't save your username and password in plain-text
> > `.netrc` file (for HTTP transport), or avoid need for interactive
> > credentials using public key / private key pair (for SSH), you need to
> > repeat credentials many times during single git-fetch or git-clone
> > command.  The goal is to reuse existing connections if possible, so the
> > whole transaction occurs using single connection and single
> > credentials; if that is not possible cache credentials (in secure way)
> > so user need to provide username and password at most once.
> >
> > '''Goal:''' git-fetch and git-clone over HTTPS and git://
> >             requiring providing username and password at most once
> > '''Language:''' C (perhaps also shell script)
> 
> Perhaps you might want to look at this:
> 
> http://marc.info/?l=git&m=123599968929476&w=4

Thank you for the link.

> At that time, I was thinking more of removing git's reliance on curl's
> multi interface so that it could use older versions of libcurl. But,
> on this point, Daniel convinced me otherwise. In fact, it doesn't make
> sense if you could have a up-to-date git, but not an up-to-date curl.
> 
> I didn't really get a reply on my point of "minimized credential
> prompting", though, and I think this GSoC proposal kinda gives support
> to it.
> 
> From a learning standpoint, I don't think this project would be too
> challenging, nor can it sustain for a whole summer -- the basic
> strategy to allow non-curl multi usage (ie. single connections) would
> be to "fork" the current http slot methods and make them
> non-curl_multi, then finding and replacing instances of them
> throughout the code base.

I was thinking more about caching credentials by git rather than forcing
to use single connection.  Additionally you are solving the problem for
the HTTP(S) transport; admittedly for SSH there is much better solution
of using public/private keys, instead of asking for password.

I guess you are right and "minimized credential prompting" (aka "single
credentials") is too small a project for Google Summer of Code...
I won't add it to SoC2009Ideas page.
 
> I already have a patch series that does that, plus a --persistent
> option for push. I'm fairly sure that it takes place on a single
> connection (I'm relying on my firewall log though I'm doubting it's
> reliability on this issue).

-- 
Jakub Narebski
Poland
