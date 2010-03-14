From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 17:03:16 +0200
Organization: Private
Message-ID: <87634zc5e3.fsf@jondo.cante.net>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
	<87eijng4hy.fsf@jondo.cante.net>
	<7vtysjs9hi.fsf@alter.siamese.dyndns.org>
	<878w9vdx01.fsf@jondo.cante.net>
	<7vljdvp16n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 14 16:06:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqpOV-00088L-T9
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 16:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758742Ab0CNPGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 11:06:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:57670 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758463Ab0CNPGO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 11:06:14 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NqpNH-0007kB-Kp
	for git@vger.kernel.org; Sun, 14 Mar 2010 16:05:03 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 16:05:03 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 16:05:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:W8CDyaTsvzBBhH139DRloeeBSq4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142142>

Junio C Hamano <gitster@pobox.com> writes:
>     if (eval "require Net::Domain") {

Refactored.

>> +{
>> +    my $mail_domain_system;		# Static variable
>
> This, and ...

Refactored.
>
>> @@ -917,6 +988,8 @@ X-Mailer: git-send-email $gitversion
>>  		}
>>  	}
>>  
>> +	my $maildomain;
>> +

Refactored.

>
>> @@ -962,9 +1040,10 @@ X-Mailer: git-send-email $gitversion
>>  		}
>>  
>>  		if (!$smtp) {
>> -			die "Unable to initialize SMTP properly. Check config. ",
>> +			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
>>  			    "VALUES: server=$smtp_server ",
>>  			    "encryption=$smtp_encryption ",
>> +			    "maildomain=$maildomain",
>
> You said you needed a separate local variable for reporting but that
> doesn't explain why you need three redundant variables.  Why can't the
> code look like this?

Refactored.

>
>  - once set, ||= ensures that it will we used without needing to

Refactored.

Jari
