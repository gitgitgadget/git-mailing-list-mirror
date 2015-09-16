From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/67] add reentrant variants of sha1_to_hex and find_unique_abbrev
Date: Tue, 15 Sep 2015 18:32:02 -0700
Message-ID: <xmqqh9mvtai5.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152629.GH29753@sigill.intra.peff.net>
	<55F84D9B.90004@ramsayjones.plus.com>
	<20150915175027.GA31091@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 03:32:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc1Zx-0007SE-Ij
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 03:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbbIPBcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 21:32:05 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36772 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbbIPBcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 21:32:03 -0400
Received: by padhk3 with SMTP id hk3so192239934pad.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 18:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Wfm3UU7Y3na+KY8eZeXF+aiPY/2aCnrsIqsYH/v9/jQ=;
        b=0pJSmLQ6dguF2zbXpF6iExA9WsjgMmVjMsrnVVAAin+Z8nI4NLHBtNC2iBAZ6i+Zjc
         DR0PypfpQu6t9QsjeKNUmVohx/ZXrGah9p7YDF/TCu8IT0zdtY29G/Es0c6ywjZo1hah
         0khgeVeXRenoOLkZAwiyIbp3ukJm80jqbhfixCdl5Z1GX69+r3MubsEpri6lO9lBUbGN
         6PVKDECgZiXJJWutmZKdriahB0AYFNS6AMqzjX1+mj3MsaOYTTqCAKfs+z5RfzfyT+Ug
         eQJr2FmN/SMCI1bRVSdyJDuo35ttxSC2zIlIfZDzrHegLqBRehCGE5KmqIkjnuWPa0fh
         4UTg==
X-Received: by 10.66.243.70 with SMTP id ww6mr54356697pac.88.1442367123348;
        Tue, 15 Sep 2015 18:32:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id pm6sm24300095pbc.95.2015.09.15.18.32.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 18:32:02 -0700 (PDT)
In-Reply-To: <20150915175027.GA31091@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 13:50:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277993>

Jeff King <peff@peff.net> writes:

>> Hmm, I haven't read any other patches yet (including those which use these
>> new '_to' functions), but I can't help feeling they should be named something
>> like 'sha1_to_hex_str()' and 'find_unique_abbrev_str()' instead.  i.e. I don't get
>> the '_to' thing - not that I'm any good at naming things ...
>
> I meant it as a contrast with their original. sha1_to_hex() formats into
> an internal buffer and returns it. But sha1_to_hex_to() formats "to" a
> buffer of your choice.

I think that naming makes perfect sense.
