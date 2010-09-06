From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 10:49:36 +0200
Message-ID: <201009061049.38546.jnareb@gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi> <AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com> <AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason" 
	<avarab@gmail.com>, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 10:49:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsXO9-0008HG-Hq
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 10:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010Ab0IFItN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 04:49:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37531 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab0IFItL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 04:49:11 -0400
Received: by fxm13 with SMTP id 13so2346390fxm.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=C60w7aPXpjf2zjLGHM3LZ35Kwdey0OcPecY5WpISp4Q=;
        b=QlJGLzIY1Lk6+hfFaztr8dcOjXykEuT/8M2nRNRpFRc/s8Bj0AjpAHxQBDV90EG4VD
         +uFxyKJHdeVyV6MxBj+/hhxwXQjHqrpgOG8oS980VqxQxcTWhLf4i0h8aRM4xNO8QSWf
         ZZunC3TiU/4d71jpdP6KhwVOzG9Aelni4DLgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=w9MWHzFcqaipQNMM+H+7zIamnIkHFzbz1BG9F0a6E6SZFN3NIp10x705m48am7RJ26
         z7r6vHme3cRvTTy6tR3ezobCGCijofV1jXD/VZIPvSybr4DIVe6gvEzwz6KX+r5YXyvc
         VbDS9V8eVNJwgygZ3omtrIjFYgf003mI9QS8k=
Received: by 10.223.103.148 with SMTP id k20mr2668648fao.37.1283762949759;
        Mon, 06 Sep 2010 01:49:09 -0700 (PDT)
Received: from [192.168.1.13] (abwo37.neoplus.adsl.tpnet.pl [83.8.238.37])
        by mx.google.com with ESMTPS id 19sm2249891fas.1.2010.09.06.01.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 01:49:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155544>

On Mon, Sep 6, 2010, Sitaram Chamarty wrote:
> On Mon, Sep 6, 2010 at 6:34 AM, Sitaram Chamarty <sitaramc@gmail.com>=
 wrote:
>> On Mon, Sep 6, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> On Sun, Sep 5, 2010 at 18:49, Ilari Liusvaara
>>>> <ilari.liusvaara@elisanet.fi> wrote:
>>>>
>>>>> AFAIK, HTTP errors don't have descriptions printed.
>>>>
>>>> I don't know if this applies here but HTTP error codes can come wi=
th
>>>> any free-form \n-delimited string:
>>>>
>>>> =C2=A0 =C2=A0 HTTP/1.1 402 You Must Build Additional Pylons
>>>
>>> And you can also send more detailed description in the *body* (and =
not
>>> only HTTP headers) of HTTP response, though I don't know if git doe=
s
>>> that.
>=20
> turns out all this was moot.  It was *because* I was using something
> other than "200 OK" that the user was not seeing the message.  Ilari'=
s
> patch just makes the message *look* better/cleaner, but I still have
> to send it out with a "200 OK" status.
>=20
> That was... a surprise :-)

=46rom what I remember from smart HTTP discussion (during fleshing-out
the protocol/exchange details), the fact that errors from git are send
with "200 OK" HTTP status are very much conscious decision.  But I don'=
t
remember *why* it was chosen this way.  If I remember correctly it was
something about transparent proxies and caches...  Is it documented
anywhere?  Can anyone explain it?

Nevertheless I think it would be a good idea to make *client* more
accepting, which means:
1. Printing full HTTP status, and not only HTTP return / error code;
   perhaps only if it is non-standard, and perhaps only in --verbose
   mode.
2. If message body contains ERR line, print error message even if the
   HTTP status was other than "200 OK".  To be "generous in what you
   receive" (well, kind of).
3. In verbose mode, if body of HTTP error message (not "HTTP OK")
   exists and does not contain ERR line (e.g. an error from web server)=
,
   print it in full (perhaps indented).

I think that neither of the above would lead to leaking sensitive=20
information.

What do you think?
--=20
Jakub Narebski
Poland
