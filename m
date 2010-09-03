From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 12:48:21 +1000
Message-ID: <AANLkTik1hfe3jVWy236611d7hdP=yt+d3vCBiGvDa26H@mail.gmail.com>
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
	<m3y6bjnadu.fsf@localhost.localdomain>
	<AANLkTikSHXivniUk-1KU30Ws23ebnbDhOmjKmpmVH-Y9@mail.gmail.com>
	<alpine.LFD.2.00.1009021931340.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 04:48:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrMKL-0003ZL-43
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 04:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab0ICCsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 22:48:23 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41791 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003Ab0ICCsW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 22:48:22 -0400
Received: by wwj40 with SMTP id 40so1780507wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 19:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X0S4xdSomrb/jfvnCymoYFH86Eg98dVyxkBjkXjKb1s=;
        b=TQXyS89oTEVUmmZwtlaJGD4E6iXvVET5g8l8fT59rnIlhWItMshH6dKZY43uCBEmoq
         109QA1yywJjk8zwmzaXFAMadfO22RaOmFyCB3yM0QaJmPt+86Hd7TXX8LsjZKyH3trrc
         YlYhyTwZHGygB/Ifp80EAZxkSdoNyX20qKpeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NEVMfILKCpKBzq1OfDIKdccUFGxm9XrC/ryUpH2ytI8rD6suot5QIDbERvG28m/whT
         97yFlrtx2ChcApix327hf9KFYOwzxa83usDl827zTg7ZGLRC41XeMYayv+yi8ty1gKjn
         IjouJcldDmYaG53P6CwB2rhG6Q15sz7WNd7dU=
Received: by 10.227.146.143 with SMTP id h15mr61354wbv.149.1283482101372; Thu,
 02 Sep 2010 19:48:21 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Thu, 2 Sep 2010 19:48:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009021931340.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155233>

On Fri, Sep 3, 2010 at 10:29 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> But usually the very first commit in a pack is huge as it typically
> isn't delta compressed (a delta chain has to start somewhere). =C2=A0=
And this
> first commit will roughly represent the same size as a tarball for th=
at
> commit. =C2=A0And if you don't get at least that first commit then yo=
u are
> screwed. =C2=A0Or if you don't get a complete second commit when deep=
ening a
> clone you are still screwed.

Elijah's recent work on "rev-list --objects -- pathspec" [1] may help
split a commit into many parts that can be sent separately.

[1] http://mid.gmane.org/1282803711-10253-1-git-send-email-newren@gmail=
=2Ecom

> Another issue is what to do with objects that are themselves huge.

=46or big blobs, it's probably best sending them separately so they can
be resumed.
--=20
Duy
