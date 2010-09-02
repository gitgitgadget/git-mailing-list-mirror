From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 14:08:46 +0000
Message-ID: <AANLkTim0QgpGd2aNCF1cUfwwFmntNTFzwNzDkV39Hxgr@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 16:08:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrATG-0000tt-Du
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 16:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab0IBOIs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 10:08:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47666 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab0IBOIr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 10:08:47 -0400
Received: by iwn5 with SMTP id 5so576513iwn.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TU0lhaHBpauEpZQ94NOfhMH0bWIGIHvh6Z8cNHziTMI=;
        b=L/ESBLeDNa5NaEUz3e0QuDyBwO5RI8yxagLzA36DyG+SdbaquS8CRR9c6JP18BvbbA
         TiPzFTq3erF6RnTyBgzWrgJDXjMQds+mytvB9k4sMLJlIgHbVSidWrYRcJRCBxzKbdAO
         zrI0tckR/ejdT1AcJYQBI7F2Dq59/3CVckrQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fz3yOWX8y9DVV4ZA/JONwcIcdWXKq9luEgIFRbgiS54IInl/gnpNVZITkXQY+tu3Ok
         w/QF8vY26sWFW8LdkyPeoy1mPUWG/HYNsuCEhPLqb4cTqhdOmGKRGts60aCpYRBUPcuH
         yFE8xqRGarp/0/v1DZEu2mJSsgnCiVCR4U9Yg=
Received: by 10.231.11.65 with SMTP id s1mr10500694ibs.134.1283436526694; Thu,
 02 Sep 2010 07:08:46 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 2 Sep 2010 07:08:46 -0700 (PDT)
In-Reply-To: <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155129>

On Thu, Sep 2, 2010 at 13:37, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:

> =C2=A0cameron dale created apt-p2p which is a recreation of a peer-to=
-peer
> file distribution mechanism, and, not surprisingly, it's slow and
> problematic.

apt is somewhat of a bad fit for bittorrent. You can get a lot of
throughput over torrent, but connecting to the swarm and beginning the
download generally takes much longer than downloading & installing
dozens of packages using the normal apt transport.

Also as a matter of implementation they're using a really resource
hungry Python implementation of BitTorrent instead of something like
libtorrent, which is why I stopped running it.

But presumably most uses for GitTorrent (and what you're doing)
wouldn't suffer so badly from the latency, you could just leave some
daemon on which would download commits in the background.

So e.g. if someone submitted a series against git.git to the list 30
minutes ago and he/I were running some git-p2p thingy I could rely on
those commits having made it to my repository by now.

Just a thought.
