From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 10:16:16 +0100
Message-ID: <AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
References: <4D871972.7080008@elegosoft.com> <7vhbawno11.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1103212302000.1561@bonsai2> <7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
 <20110322085027.GF14520@neumann>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 10:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1xhj-0007ZB-4N
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 10:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab1CVJQi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 05:16:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52934 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab1CVJQh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 05:16:37 -0400
Received: by fxm17 with SMTP id 17so6224952fxm.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QBFabr8xgn4pF9x+02RgIsPBK7B0PrhFHIicKabrLo0=;
        b=Wvl1TxxpeI9qFG8Uq68ksSvSbaAM5OWwpU4p57UTiYq0ldhF2KqTgukHCkRpA5jR1Q
         fP1xOtlKTuLNsMzpFBlCzv56M7yoi+U5Hcw73Jouqyuny3kb6OoN2+45oaNadXKDcFK1
         b4z0YmQNIsM+IxOTUF5qkCFfTG3t9l3k3QXko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=jHucPkbC4uxCcyG9TV5fcSC/c/KHSZfA10CYa0OnoVCXGgY235S2RGbCawJCK8FIit
         cjFeE2oLmBBp2cgNJNTrGK+6WVt/on3azZUQo9/JipAF+R/rZ0+HuQZkI1x/gA2708QY
         SzGIia+y+j3/Chb8Eze9ufdOUPAnbgG94aSZs=
Received: by 10.223.20.144 with SMTP id f16mr6216899fab.68.1300785396064; Tue,
 22 Mar 2011 02:16:36 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Tue, 22 Mar 2011 02:16:16 -0700 (PDT)
In-Reply-To: <20110322085027.GF14520@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169713>

2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
> On Tue, Mar 22, 2011 at 12:53:43AM -0700, Junio C Hamano wrote:
>> This is a constructive tangent but if we are going to run $(__git_al=
iases)
>> every time we run _git_help, perhaps it would want a hack similar to=
 the
>> way the value for $__git_all_commands is generated just once?
>
> I think this is not necessary. =A0We already run __git_aliases() ever=
y
> time after 'git <TAB>', and it was not an issue so far. =A0And indeed=
, I
> just created 50 aliases, and the time required for __git_aliases()
> seems to be negligible:
>
> =A0$ time __git_aliases
> =A0<bunch of aliases>
>
> =A0real =A0 =A00m0.028s
> =A0user =A0 =A00m0.016s
> =A0sys =A0 =A0 0m0.004s
>

Unfortunately, the situation is not quite so good on Windows:
$ time __git_aliases
<bunch of aliases>

real    0m0.112s
user    0m0.030s
sys     0m0.015s

This is with 50 aliases, with 0 aliases I get this:
$ time __git_aliases
test

real    0m0.063s
user    0m0.015s
sys     0m0.015s
