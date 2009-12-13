From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: strange error while pushing
Date: Mon, 14 Dec 2009 00:08:11 +0100
Message-ID: <40aa078e0912131508y79815bej6290c0848aa9f9cf@mail.gmail.com>
References: <40aa078e0912131441i370d9c23r65c42fe1f46bd194@mail.gmail.com>
	 <20091213230214.GA27365@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 00:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJxY2-0005Pi-Ig
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 00:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbZLMXIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Dec 2009 18:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659AbZLMXIO
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 18:08:14 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:65499 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633AbZLMXIN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Dec 2009 18:08:13 -0500
Received: by ewy19 with SMTP id 19so2855649ewy.21
        for <git@vger.kernel.org>; Sun, 13 Dec 2009 15:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PVCgmn+Kjiisj1utGDkxxR6vQRXNqDzB95DgYO884UU=;
        b=o26nVbiIO6RdVFtUxCjpWKPenY64Z6uKGa5iutTyfZ835z9HY1gVJYeE9UgXJTyGVL
         5ZoqtrZvbn4We9myqsiPb6qJNWMbIYrc+JOA/1t0flBbdnsSB1Cpk6KPd3A3nIujVHux
         YY22IbCCD0mcTc5CcOP3w72b76NuTVskLW4Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=VjneKDtviDRhIzDG51bLvZVg0vxeuQBxwaIxQViviv1R7Ny14iULio5HV5fRKrz9WI
         arloVfx85eDx/67KGFXT5vSBetz0geDgmly4V/JPV1zHXgjD63YsTcb4H/klVhqchiQ6
         Xe70GRoRJ1D7U2u3IbQp9WqBYWJRtVFeXPd9w=
Received: by 10.216.89.194 with SMTP id c44mr1690481wef.199.1260745691818; 
	Sun, 13 Dec 2009 15:08:11 -0800 (PST)
In-Reply-To: <20091213230214.GA27365@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135159>

On Mon, Dec 14, 2009 at 12:02 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Dec 13, 2009 at 11:41:49PM +0100, Erik Faye-Lund wrote:
>> usage: git pack-objects [{ -q | --progress | --all-progress }]
>> =A0 =A0 =A0 =A0 [--max-pack-size=3DN] [--local] [--incremental]
>> =A0 =A0 =A0 =A0 [--window=3DN] [--window-memory=3DN] [--depth=3DN]
>> =A0 =A0 =A0 =A0 [--no-reuse-delta] [--no-reuse-object] [--delta-base=
-offset]
>> =A0 =A0 =A0 =A0 [--threads=3DN] [--non-empty] [--revs [--unpacked | =
--all]*] [--reflog]
>> =A0 =A0 =A0 =A0 [--stdout | base-name] [--include-tag]
>> =A0 =A0 =A0 =A0 [--keep-unreachable | --unpack-unreachable]
>> =A0 =A0 =A0 =A0 [<ref-list | <object-list]
>
> Is it possible you have a new git accidentally calling an old version=
 of
> pack-objects?
>

Ah, yes it is! I just now tracked down the issue myself, and landed at
the same conclution. The reason? Simple, I was pushing git from a
directory with a recent git-binary, when my *installed* git was v1.6.4
;)

Running "make install" before pushing fixed the issue.

Thanks for wasting time on my PEBCAK :)

--=20
Erik "kusma" Faye-Lund
