From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Mon, 11 Oct 2010 07:59:09 +0000
Message-ID: <AANLkTikGSj-x4hk7NFysWETuR80=REZ81Qy8Zu3Pks-L@mail.gmail.com>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 11 09:59:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5DI4-0008KH-2r
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 09:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab0JKH7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 03:59:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56294 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab0JKH7K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 03:59:10 -0400
Received: by iwn6 with SMTP id 6so3021556iwn.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zzEnyEjwVvu1edhjcFi/J7tQABCMIsUWXwu/9lwze5k=;
        b=mP6Z1/JhLnV0A0thF2AdJF3TabsxPTIku1Gil6vsbXFVp83YID9aimmKNnj6c5MHPR
         3ux+5R2ISqzKwdYZxiJgzZoTAkeqGTJW3/+tOCg4z1c1L8j0/tZJJNzwOoAdkISWrduh
         CCTCJu20HTygVR5OaCMFJgj/IAdnXt0zLZDWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TAd8wfRrJYjNE1VA8heoIN1DN6p1LthCkTtxmgnWIfQXpFJHDGuPZzELpa+QoQZ4y0
         sz6O7pr23jACPQ62wCuiVFSIX3oEr4JGfvVaJw3+GI1xlhx/iDoOrsMUIbbQsu98unxx
         Ehb6gQOBa1uFEW2kKbUQJIcWOBrY+gUr0HKMs=
Received: by 10.42.167.4 with SMTP id q4mr1793091icy.14.1286783949369; Mon, 11
 Oct 2010 00:59:09 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 11 Oct 2010 00:59:09 -0700 (PDT)
In-Reply-To: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158753>

On Mon, Oct 11, 2010 at 07:47, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

(CC-ing Jakub Narebski, who maintains configure.ac)

I don't like it. For one this would break build scripts that use `make
configure && ./configure && ...`. It's also annoying to have to set
some variable to *really* invoke a target that I just indicated I
*really* wanted by invoking it in the first place.

Perhaps a @echo from the configure script itself indicating that it's
complimentary would be better.

> For most software packages, untar-autoconf/make configure-configure-m=
ake
> is the preferred way to build the package; not so for Git. But the
> presence of the make target makes people believe so.

Unlike in most packages autoconf is strictly complimentary for Git,
but it usually gives you much better results. Instead of the Makefile
guessing based on `uname -s` we actually check for features and set
the config.mak.autogen variables accordingly.

So it's less likely to break on odd systems, and given that (as you
point out) mostly everyone has autoconf already recommending it as the
default would make more sense than the other way around.

> =C2=A0 =C2=A0On an annecdotical note: When I decided to switch to a d=
vcs, I failed building
> =C2=A0 =C2=A0Git (with configure) and tried out hg instead. Imagine!

What sort of failure? Has it been fixed since then?
