From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 21:06:22 +0100
Message-ID: <AANLkTimDi=KYZ7Bs4C+WEGoP8y-yzjynddWpkxohWoix@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
	<AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
	<20100902192910.GJ32601@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrG3K-0004ss-4C
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767Ab0IBUGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:06:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51231 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab0IBUGX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:06:23 -0400
Received: by ywh1 with SMTP id 1so375436ywh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qfUZQ4b7P5HsH5I4Jizypg+l2wQXURu/LirbmhBPa5Q=;
        b=gRQKrhW2D9OJvnB8B76vKU1fVbfNBm4/W2Ecd6wHsP7oiOFuUILcajJXP6q2i/KDig
         JNq7uEJkjNTOgRmRL487ryyaGBYHtpr7YifkEIc3yUDM/j/0soQSBCxn0zUBuTmh4fl/
         gVo/zAStfTZ8m5Q3JnmRyixdLEau5pEh+vuiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Cvo5temAjTVXKYWMymfouJPM5X0c99Nbos5Pf2Kq5f4RtyW622zJJ0ZNf+iPfzqpzO
         J0gKzIS5IBcKCvcCDxWi/8jGioqYexY8IJmRWaUzqTykWXeh6UuvARZJLe/FW840QeRc
         fGr9IKT+JLDMucAZQ3xf/KgesfsLjQtxjGHV8=
Received: by 10.100.250.11 with SMTP id x11mr10742198anh.95.1283457982560;
 Thu, 02 Sep 2010 13:06:22 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 13:06:22 -0700 (PDT)
In-Reply-To: <20100902192910.GJ32601@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155191>

On Thu, Sep 2, 2010 at 8:29 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Luke Kenneth Casson Leighton <luke.leighton@gmail.com> wrote:
>>
>> =C2=A0* based on what you kindly mentioned about "git repack -f", wo=
uld a
>> (well-written!) patch to git pack-objects to add a
>> "--single-thread-only" option be acceptable?
>
> Probably not. =C2=A0I can't think of a good reason to limit the numbe=
r
> of threads that get used.

 i can - so that git pack-objects, after "git repack -f", returns a
canonical pack! :)

>=C2=A0We already have pack.threads as a
> configuration variable to support controlling this for the system,
> but that's about the only thing that really makes sense.

 ookaaay, so that would work, but would force that particular repo to
be _entirely_ single-threaded, which is non-optimal when all that's
needed is "git pack-objects" to be single-threaded.  sure, i could
write a hack with some shell-script which takes the current option /
value for "pack.threads", stores it, changes it to 1, runs "git
pack-objects" and then changes it back again, but... eeuw.  (not to
mention race-conditions....)

 l.
