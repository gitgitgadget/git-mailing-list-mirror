From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 16:51:46 +0100
Message-ID: <AANLkTi=W3QwWSrNTie-K4QDDrucSVGQa5e3Ldy7m7ihy@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 02 17:52:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrC5D-000575-Aq
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 17:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab0IBPvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 11:51:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33104 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0IBPvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 11:51:48 -0400
Received: by gwj17 with SMTP id 17so203164gwj.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=xzxOUFzOA473uYjnVIoTm96wY+YhFpN0VOHoxi7NEbA=;
        b=RS6wnrr/fscAf3NYCsMwr2k27ohMbG09iTYUC/2p4oy9V3780r7RESr2gxuERBdOx2
         E9u6jfIIwolxvXSMfuZieg/nIT2pCbj/R5kvdrNIH/y7mbygVV9++GHqj8XY/tOFJ8Qy
         p2CpzPgs/6rSOQbcW0f7GCq7Pbb5J0daYPA3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ricQj6LbdDK7En0frurhHH4jOE3Lcm/m7C2ZBulpXnDl64SUewA//fOH4evsrjYYoI
         o6tnNATx7UF5ZjtjsVxFLiUvw4TRDRXV/vX1b4VmOMtZFIbSCv+nXKM27c0swbP+1vYd
         LCufvItM3g0y/r1QClIyvjMon3W0U2PUKWCxg=
Received: by 10.103.95.2 with SMTP id x2mr268246mul.32.1283442706737; Thu, 02
 Sep 2010 08:51:46 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 08:51:46 -0700 (PDT)
In-Reply-To: <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155138>

On Thu, Sep 2, 2010 at 4:42 PM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> On Thu, Sep 2, 2010 at 4:33 PM, A Large Angry SCM <gitzilla@gmail.com> wrote:

> * is it possible to _make_ the repository guaranteed to produce
> identical pack objects?

 i.e. looking at these options, listed from
Documentation/technical/protocol.txt:

    00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack
thin-pack side-band side-band-64k ofs-delta shallow no-progress
include-tag

 is it possible to use shallow, thin-pack, side-band or side-band-64k
to guarantee that the pack object will be identical?

 another important question:

* if after performing a "git unpack" of one pack-object, can it be
guaranteed that performing a "git pack-object" on the *exact* same ref
and the *exact* same object-ref, will produce the *exact* same
pack-object that was used by "git unpack", as long as the exact same
arguments are used?  if not, why not, and if not under _some_
circumstances, under what circumstances _can_ the exact same
pack-object be retrieved that was just used?

if there is absolutely absolutely no way to guarantee that the
pack-objects can be the same, under no circumstances or combinations
of arguments or by forcing only compatible versions to communicate
etc. etc., a rather awful work-around can be applied which is to share
and permanently cache every single pack-object, rather than use what's
gone into the repo.

l.
