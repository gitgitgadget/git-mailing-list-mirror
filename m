From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Wed, 22 Jul 2015 11:58:50 -0700
Message-ID: <xmqqfv4grpcl.fsf@gitster.dls.corp.google.com>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
	<1437416790-5792-5-git-send-email-philipoakley@iee.org>
	<xmqqoaj6y50b.fsf@gitster.dls.corp.google.com>
	<996C8C8A69844E44890D09811C57DAC8@PhilipOakley>
	<xmqqa8uqxxpn.fsf@gitster.dls.corp.google.com>
	<xmqq615exwou.fsf@gitster.dls.corp.google.com>
	<11647308F0684851A72DDF51A486D11D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:59:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzEK-0007st-4s
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 20:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbbGVS6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 14:58:55 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36783 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbbGVS6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 14:58:53 -0400
Received: by pachj5 with SMTP id hj5so142867413pac.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pu9HMM0Q2+WJQ3AXD22cfXkUTm2zuTsI7KBMrn+EpyQ=;
        b=xnjpaOBw5yZUe9M7e2PDHC1NTu0kkGwVXEUcbRjSBXUGmIVk9fdPd2BGCpnpQykmB+
         xonm9UJcmZcRbUPc+7pBhQEMJ5vns/njx2Jn8Bfa6ovibRSx+swlkXLSB0x4nExin2pl
         f5iwBDHxfByvrhmpUtX2zVU1d95EYc8JmEfyKeWcKLawhZCcQuZeBPkDDIehv6J/MKj/
         emPwfxw10+EM4qyc1k9fhS9IbMwD6KbqqBR1+QzMCsBVsdx768DbqKLJolI6BLK4xnUv
         LINnkfEzvYdfXQoLAaAlTNWnjpo9Vrayhur6T/uhitFQUAm2vIsYHHjFrM5BBssJ4o8o
         rehQ==
X-Received: by 10.66.155.102 with SMTP id vv6mr8737300pab.150.1437591532497;
        Wed, 22 Jul 2015 11:58:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2d07:10eb:6a1b:8773])
        by smtp.gmail.com with ESMTPSA id lj7sm3960661pab.38.2015.07.22.11.58.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jul 2015 11:58:51 -0700 (PDT)
In-Reply-To: <11647308F0684851A72DDF51A486D11D@PhilipOakley> (Philip Oakley's
	message of "Tue, 21 Jul 2015 23:48:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274454>

"Philip Oakley" <philipoakley@iee.org> writes:

>>   It is an
>> unacceptable hack for us to encourage in the longer term.  It may
>> happen to work with the current implementation, but it does so
>> merely by depending on the implementation too much.
>>
>> If it is so common to want to spray all your patches to exactly the
>> same list of recipients that is unconditionally determined, having
>
> It wasn't 'unconditional spraying' ;-), rather I'd carefully select
> who to send to for each series, ...

I meant unconditional in the sense that all messages in the series
will get exactly the same cc: list (instead of the cc-cmd inspecting
each message and deciding whom to include conditionally).

>> I would think that it would probably be the best way to address "I
>> often want to cc these recipients, but not always" is to keep a list
>> of aliases, each entry of which expands to the recipients, and say
>> "--cc=group" from the command line to have it expanded to the set of
>> recipients.

I think one of the topics that was reviewed and queued during this
cycle will help the above (it may not be in 'master' yet hence not
in 2.5, but there always is the next release), where it made sure
that alias expansion happens more consistently than before.
