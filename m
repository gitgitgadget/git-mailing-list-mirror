From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 22:24:37 +0100
Message-ID: <AANLkTi=-+XMPOqaeiE_z4s_tCKHhK-rpyCgZgNmOjmZ1@mail.gmail.com>
References: <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<m3tym5mfce.fsf@localhost.localdomain>
	<AANLkTimhCi2vWWnHGwT5ToRtFbjkxTgVYVvYLR3UCb2S@mail.gmail.com>
	<201009042316.38655.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ted Ts'o" <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 23:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0EX-0003zW-Br
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 23:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab0IDVYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 17:24:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56681 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab0IDVYi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 17:24:38 -0400
Received: by vws3 with SMTP id 3so2311132vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h7uH0B+UrCv9eLJk69tjyn5KLERJCGZ1k5MQim7LnBI=;
        b=fgK8n6+6ExkyLFYrjsHwOquVGxJglCUysGgWnVfIZLG/EjDWjwWNBYie0kM3Cr3rqL
         9gnvpmRWb8XhMpYnXtvfqPDOHG4X7AtxdgaF8Z6N7bo3CkVXdUfOpCxjJASgiMo5e1u7
         WNre6patI9qbjm3SWVedBcWwkTu8teukIbVZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rBHNzTpWzzi5CS5coj1FKui9AUnAbevuX2rYSAV8P7jyf6GfWVoa+GyITHEr/CClWm
         VyH3D3Y0GOO0ORZHJ0/Ai7zAkAyJkjTUkwQnE606d6Pgw9yKGH1FzvFX9YB2CSXM1/DH
         WN0iDMkPzuadUloZXnYanGkxfB8ijYYecPbYU=
Received: by 10.220.158.9 with SMTP id d9mr205467vcx.245.1283635477558; Sat,
 04 Sep 2010 14:24:37 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 14:24:37 -0700 (PDT)
In-Reply-To: <201009042316.38655.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155360>

On Sat, Sep 4, 2010 at 10:16 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Sat, Sep 4, 2010, Luke Kenneth Casson Leighton wrote:
>> On Sat, Sep 4, 2010 at 9:20 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>>
>> > Luke, you don't have to be peer-to-peer to be decentralized and
>> > distributed. =C2=A0People from what I understand bitch most about
>> > centralized (and closed) services.
>>
>> i've covered this in the FAQ i wrote:
>>
>> FAQ:
>>
>> Q: is git a "distributed source control system"?
>> A: yeees, but the "distribution" part has to be done the hard way,
>> =C2=A0 =C2=A0by setting up servers, forcing developers and users to =
configure
>> =C2=A0 =C2=A0git to use those [single-point-of-failure] servers. =C2=
=A0so it's
>> =C2=A0 =C2=A0"more correct" to say that git is a "distributable" sou=
rce control
>> =C2=A0 =C2=A0system.
>
> "Distributed" is not equivalent to "peer to peer".

 correct.  exactly.

> Setting up server (git, smart HTTP, ssh) is not that hard.

 for you and me, and for the majority of people developing git, this is=
 correct.

>> proper peer-to-peer networking infrastructure takes care of things
>> like firewall-busting, by using UPnP automatically, as part of the
>> infrastructure.
>
> With "smart" HTTP transport support there is no need for any
> firewall-busting.

 the assumption is that the users are capable of deploying a server
(at all), and are happy to reconfigure to use that server.

 ok.

 this is getting off-topic and is distracting, both for me and for
people wishing to read about git.  with respect, jakob, i'm going to
do something which i don't normally do, and that's begin to be
selective about what i reply to.  apologies, but i'm on very short
timescales to get this code working, for financial reasons.

l.
