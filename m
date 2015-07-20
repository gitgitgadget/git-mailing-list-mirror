From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 15:37:08 -0700
Message-ID: <xmqqa8uqxxpn.fsf@gitster.dls.corp.google.com>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
	<1437416790-5792-5-git-send-email-philipoakley@iee.org>
	<xmqqoaj6y50b.fsf@gitster.dls.corp.google.com>
	<996C8C8A69844E44890D09811C57DAC8@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 00:37:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHJgU-0007eC-Ca
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 00:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbbGTWhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 18:37:11 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35067 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbbGTWhK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 18:37:10 -0400
Received: by pdrg1 with SMTP id g1so108081878pdr.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Z16e12THJC90CJaxvKD5cHbFHgwsGiivp84bagT5qKc=;
        b=guwhjbsWRfhWpuyj31JJOqeZjIKJC8dPbfvgHHOpZGWnsm8WFzC4Tzf/BwEqE2drhS
         +EKtaD/8Hp9Z9eDvXCcX/mbVT5dA8n4CQXNrcgaopnmBdlbjQKJ8Spb+imKLWyRaeEfF
         3zvStQoj5cGUET6HGWBWCuE+9QeJHYDCk8/hf7orXAfk+2SR6iW5cALdg5j85fyLLlKf
         PMpdjmc26hhjk67gGz2h+Q0hXHcWsqjRjw2l5OnG/vcag5P7ziHS+Gu+vWRoF9qoBhI6
         yk6zydBQSYxx+Qo/1ag0hgGegeKNr9Pm8BIAM137IP5SGX79jv88+2CKHvBAL7wihtXJ
         xdwQ==
X-Received: by 10.70.130.34 with SMTP id ob2mr64547563pdb.15.1437431829561;
        Mon, 20 Jul 2015 15:37:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id os7sm23652807pdb.51.2015.07.20.15.37.08
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 20 Jul 2015 15:37:08 -0700 (PDT)
In-Reply-To: <996C8C8A69844E44890D09811C57DAC8@PhilipOakley> (Philip Oakley's
	message of "Mon, 20 Jul 2015 22:35:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274356>

"Philip Oakley" <philipoakley@iee.org> writes:

> We seem to be going round in circles.

I do not think so.

> Currently the --cc-cmd isn't well documented.

Yes, I agree.

> I was trying to use, essentially, 'cat list.txt' as the command, which
> should work according to the current doc, which says nothing about
> how/if the patch file is to be passed to the command.

I've already agreed in the message you are responding to that the
current documentation is sketchy and invite mistakes like yours.
And that is why this series exists, isn't it?

> The question are:
> What should the "command" look like. (can it be a command, or does it
> have to be a script??)
> How should the patch/patchfile be passed - what should the
> documentation guarantee?

Yes, I think I already answered that, no?

>>    The program that is specified by `cc-cmd` is invoked by `git
>>    send-email` with the name of the patch file as an argument;
>>    the program can read from it and customize its output based on
>>    what the patch file contains.
>>
>> or something like that, perhaps.

We do not care if that program is scripted, or written in java and
compiled.  It will find the patch in argv[1].  It is up to the
program if it uses that input to customize its output, or it just
outputs a hardcoded list of addresses.

That is the only guarantee we would want to give.
