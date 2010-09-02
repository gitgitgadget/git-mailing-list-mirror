From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 20:41:57 +0100
Message-ID: <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgQ-0006jt-M4
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab0IBTmE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:04 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:32786 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629Ab0IBTl7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 15:41:59 -0400
Received: by ewy23 with SMTP id 23so593291ewy.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=VF6vuu5UdSOldAQkmC0x5j0/t1Uou0A+uf/7fj+LyFM=;
        b=HZuTTR/cX80256VWkO6BE8QcTdaP25eWltTextc9EfQTxG93ZHAscyOI1Wyst0+FNF
         1lY4tIXp0JUCvuQ/Xj8V80oav4wR10yrLsEIS9XQ9uRmhkkUR4gwtGjhq+BnAibvFDI8
         jekSjbVVK+VmjdinLuTcGgmR8Hp5B5NUTdDv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=kWFxGlrQQeI27uiiQ4EO8J7OJ6SvZdPH6GOBJlQUrMTkLWRZW15plzUmhTJLjdKsgT
         +/RpXrGeGxZv6noiRf7zIUzoBSmKRem6HcL3SrSJ1YrhtKSTp/gJ25X782xfkWzr8pr+
         0Y7l2nuKg6LCZQbw2HOrLmZVQwLXgl7xEIVTE=
Received: by 10.213.28.8 with SMTP id k8mr593179ebc.55.1283456518138; Thu, 02
 Sep 2010 12:41:58 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 12:41:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155177>

nicolas, thanks for responding: you'll see this some time in the
future when you catch up, it's not a high priority, nothing new, just
thinking out loud, for benefit of archives.

On Thu, Sep 2, 2010 at 6:21 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> =C2=A0* what _can_ be guaranteed?
>
> You can guarantee that if the SHA1 name of different packs is the sam=
e
> then they contain the same set of objects. =C2=A0Obviously their pack=
ed
> encoding will be different, and even the pack sizes might be quite
> different too.

 ack.  ok, so the idea of creating lots and lots of 2nd level
=2Etorrents by name {ref}-{commitref}-{SHA-1}.torrent is about the only
way to get around that.

@begin lots of no, no and hell no...
> [...]
@end

 dang.  diffs, versions, threads and zlibs as well, all conspiring agai=
nst me :)

>> * is it possible to _make_ the repository guaranteed to produce
>> identical pack objects?
>
> Sure, but performance will suck.

 that's fiiine :)  as i've learned on the pyjamas project, it's rare
that you have speed and interoperability at the same time...

> The only way to get a bit-for-bit reproducible pack one one specific
> system is to use 'git repack' with the -f switch, and limit it to onl=
y
> one thread.

 whew - a way out, at last.  you had me going, for a minute :)

>> * is it a versioning issue? =C2=A0is it because there are different
>> versions (2 and 3)? =C2=A0if so, that's ok, you just force people to=
 use
>> the same pack-object versions.
>
> Not at all. =C2=A0FYI [....]

 appreciated.


> I'm sorry as this isn't going to help you much unfortunately.

 neeh, i'm flexible.  it looks like i'm going to need to deviate from
bittorrent, after all, start adding new commands over which the git
rev-list gets transferred, rather than as a VFS layer.  the reason is
that bittorrent depends on the files and the data in the files being
all the same, so that a hash can be taken of the whole lot and the
end-result verified.

 if the pack-objects are going to vary, then the VFS layer idea is
blown completely out the water, except for the absolute basic
meta-info such as "refs/heads/*".  so i might as well just use
"actual" bittorrent to transfer packs via
{ref}-{commitref}-{SHA-1}.torrent.

ho hum, drawing board we come...


l.
