From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] send-email: squelch warning from Net::SMTP::SSL
Date: Mon, 29 Jul 2013 18:12:01 +0100
Message-ID: <51F6A261.40500@colin.guthr.ie>
References: <1373019511-13232-1-git-send-email-artagnon@gmail.com> <20130705104557.GL9161@serenity.lan> <CALkWK0nWvmuxfZJF_Mk2MmJNxz4+=46m_pBtzjSZprLxABhNeA@mail.gmail.com> <vpqbo6hw8e9.fsf@anie.imag.fr> <kstfht$p0e$1@ger.gmane.org> <7va9l51hkn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3r4z-00046J-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396Ab3G2RRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 13:17:50 -0400
Received: from brent.tribalogic.net ([78.86.109.144]:59994 "EHLO
	brent.tribalogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3G2RRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 13:17:49 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2013 13:17:49 EDT
Received: from localhost (summit.brent.tribalogic.net [127.0.0.1])
	by brent.tribalogic.net (Postfix) with ESMTP id 8EB7E10A1B5;
	Mon, 29 Jul 2013 18:12:03 +0100 (BST)
X-Virus-Scanned: amavisd-new at brent.tribalogic.net
Received: from brent.tribalogic.net ([127.0.0.1])
	by localhost (summit.brent.tribalogic.net [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 211BEuXXjIQw; Mon, 29 Jul 2013 18:12:02 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <7va9l51hkn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231301>

'Twas brillig, and Junio C Hamano at 29/07/13 17:01 did gyre and gimble:
> Colin Guthrie <gmane@colin.guthr.ie> writes:
> 
>> For what it's worth, after upgrading here, I got this error at the
>> server side:
>>
>> Jul 26 10:15:41 foo.example.com postfix/smtpd[7736]: warning: TLS
>> library problem: 7736:error:14094418:SSL routines:SSL3_READ_BYTES:tlsv1
>> alert unknown ca:s3_pkt.c:1256:SSL alert number 48:
>>
>>
>> This is because my postfix doesn't have a ca bundle configured but all
>> other mail clients have been fine before.
>>
>> With the original patch here I could continue.
>>
>> I'd really love to see an option to set this to none in the .gitconfig,
> 
> Isn't that what the final patch committed under Ram's name
> implements?
> 
>     sendemail.smtpsslcertpath::
>            Path to ca-certificates (either a directory or a single file).
>            Set it to an empty string to disable certificate verification.
> 
> or have we missed your use case?

Yeah that patch works fine if I set the certpath = "" in the config, and
I even added that path to our packages.

I read the mailing list after following the google trail and replied to
that specific message without realising a more recent patch was
available and then didn't post a followup saying the final patch worked
- my bad!

Sorry about that, and thanks to everyone for the final patch :)

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
