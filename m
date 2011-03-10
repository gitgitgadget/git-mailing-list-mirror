From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Thu, 10 Mar 2011 10:44:31 +0100
Message-ID: <AANLkTikD2M=33B9E2mpBEmT5rLsZHPFc-T5Yqp3EMRJx@mail.gmail.com>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
	<AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
	<7v7hckje4n.fsf@alter.siamese.dyndns.org>
	<20110301205424.GA18793@sigill.intra.peff.net>
	<7vwrkiccy6.fsf@alter.siamese.dyndns.org>
	<AANLkTi=+iBR3OBZ=4fi_g=JMQKi=47F47hRsWxK=RbMv@mail.gmail.com>
	<m3k4gh7r0m.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 10:44:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxcQE-0001ik-NL
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 10:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab1CJJog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 04:44:36 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34632 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab1CJJod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 04:44:33 -0500
Received: by bwz15 with SMTP id 15so1561953bwz.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 01:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lFLGv08qH1HfZBtQ8cn9Kv6MTYMjWqaifrZWBk4rrzw=;
        b=NjY4RM+uLO3LyDScGA/fSre0t67AKtgk+NDFuCAhzbQRjv3teUDa5dlu2nUgy8YqVe
         89xnL3svvD9cdNY4DvgFFRKA6CiPx/cZWFn3JQ1NyjDDCee7CuqGpK0oRK02PC727/mn
         JciUq6YqXC97OGOq9t2o8tzcYrgU/QNP66BRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sogkCPJ66Rs6+Qfmpye1tO1CBwBtOArOQV+T4H1KNbHmNaTUcgS4DFmURUfPkJFfSj
         7e6VbxDVVxVU+IXt4a7zm/fd6iRlN3E595zYNbxnZQypy+czAqdwQL207fDw3DN8xQHJ
         lchCiBFP+tsMBWpt+jX7AaXrcJqTmopiXCacA=
Received: by 10.223.151.8 with SMTP id a8mr2385604faw.65.1299750272234; Thu,
 10 Mar 2011 01:44:32 -0800 (PST)
Received: by 10.223.108.130 with HTTP; Thu, 10 Mar 2011 01:44:31 -0800 (PST)
In-Reply-To: <m3k4gh7r0m.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168803>

On Wed, Mar 2, 2011 at 11:32, Jakub Narebski <jnareb@gmail.com> wrote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>> Don't know how it's handled in shell scripts or perl or whatever other
>> language (which does not use gettext?)
>
> Both shell scripts and Perl scripts would use gettext: gettext.sh for
> shell, Locale::Messages for Perl (we need lower level than Text::Domain,
> and Locale::Maketext is first no longer recommended, and second does
> not use gettext at least by default).

The i18n series uses Locale::Maketext:
https://github.com/avar/git/blob/ab%2Fi18n/perl/Git/I18N.pm

What do you mean it's not recommended? There are some articles about
Perl i18n saying you shouldn't use it, effectively because:

 * Building GNU gettext is hard, let's go shopping.

 * There were some bugs in it, which do not apply to us.

So using it is fine. I might still write some Gettext::XS::Tiny module
that works with both GNU gettext and Solaris, stick it on the CPAN and
make us depend on it. It would more closely align with what we
need. But that's something for the far future.
