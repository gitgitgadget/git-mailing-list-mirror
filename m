From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6] Add a remote helper to interact with mediawiki (fetch & push)
Date: Thu, 01 Sep 2011 07:26:05 +0200
Message-ID: <vpq39ggomtu.fsf@bauges.imag.fr>
References: <1314381329-8989-1-git-send-email-Matthieu.Moy@imag.fr>
	<1314809708-8177-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAGdFq_gu=SyjUnUS1bcjPrcPPtKVt+UjDBvBmZqosk+OuDFDHw@mail.gmail.com>
	<vpq7h5tbia6.fsf@bauges.imag.fr>
	<7vobz5xg7u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 07:26:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyznA-0007fr-Ly
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 07:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab1IAF0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 01:26:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41585 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab1IAF0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 01:26:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p815PMXU021863
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Sep 2011 07:25:22 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qyzmv-0004Am-PZ; Thu, 01 Sep 2011 07:26:05 +0200
In-Reply-To: <7vobz5xg7u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 31 Aug 2011 17:24:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Sep 2011 07:25:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p815PMXU021863
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315459525.22486@Dw4bgZ+ErU2+5P+EVV1sNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180522>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Here:
>>
>> +	for my $refspec (@refsspecs) {
>> +		unless ($refspec =~ m/^(\+?)([^:]*):([^:]*)$/) {
>> +			die("Invalid refspec for push. Expected <src>:<dst> or +<src>:<dst>");
>> +		}
>> +		my ($force, $local, $remote) = ($1 eq "+", $2, $3);
>>
>> At this point, $force is a boolean saying whether there were a +, and
>> $local and $remote are as you can guess.
>
> It may be slightly more Perl-ish to hoist the "0-or-1" outside the group
> and rely on $1 becoming undef, like this:
>
>         my ($force, $local, $remote) = $refspec =~ /^(\+)?([^:]*):([^:]*)$/
> 		or die(...);

Thanks, I didn't know I could do this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
