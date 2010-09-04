From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 13:33:10 +0100
Message-ID: <AANLkTik8S708qOBaZDPdPheqinYKhBP71w=u=9BFhyjA@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
	<alpine.LFD.2.00.1009040040030.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 14:33:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orrw1-00054r-9d
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 14:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab0IDMdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 08:33:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39224 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab0IDMdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 08:33:11 -0400
Received: by vws3 with SMTP id 3so2076620vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=1Q2WLwrj785K7ewyzTwwUgVGLDnIOls8DOUF4evxJIE=;
        b=bbwdC7A/HLxw8tWJc0dgoXQuiDMzpa38Trg7VVejpWG1KTbzdBfdfdoMAdRer4WlR3
         VxYhyUVH0Dm1wSHMyWYK9sLpiuLxk6sPlG+W8MZgdJ8VBs4zOMxcSssc/K3HdqItgbSS
         sPiodH/OL1rcnkMkA+m+uxNhKQtAihOlr9BFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sB19eDKW7Bz/Ra/FQ07f0p8+epZiZIaKqzJmNuCTRyvVxME1jmDsHTkC1FngvuidSj
         8XHmzR+5gTYNNeCuooa8mUPQaF6WmNh/Zq7ZxFT5bbHFWDZ70SOzf3LlbCVkjfdY/Pdm
         CkYg5tn/P0kb4YOGB9+SdYUXFxWsm7eHtD0J4=
Received: by 10.220.63.78 with SMTP id a14mr649158vci.246.1283603590091; Sat,
 04 Sep 2010 05:33:10 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 05:33:10 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009040040030.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155322>

On Sat, Sep 4, 2010 at 6:40 AM, Nicolas Pitre <nico@fluxnic.net> wrote:

> But again, I don't think it is worth freezing the pack format into a
> canonical encoding for this purpose.

 ... and, even if different seeds produce different pack index files,
or even if the same seed produces a different pack index file, it
doesn't matter because the objects will still be there, can still be
shared, can still be used to reconstruct the commit.

 so even if you end up asking for and sharing different objects
because you're using a different index file, it really really doesn't
matter: all roads lead to rome.

you might end up not _having_ some particular objects (due to git gc)
but that's ok: just re-request the index file again (and go through
the process of evaluating / comparing the index fan-objects again
*sigh* you can't have everything).

l.
