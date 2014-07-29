From: Bryan Turner <bturner@atlassian.com>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Tue, 29 Jul 2014 11:06:25 +1000
Message-ID: <CAGyf7-HK74YuqhrRDJ46qti17UNAd6Bp6if4y+ZwUV_PZs2ujQ@mail.gmail.com>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
	<20140728103504.GB10737@peff.net>
	<xmqqtx614cea.fsf@gitster.dls.corp.google.com>
	<20140728173734.GA10309@peff.net>
	<20140728180157.GA11265@peff.net>
	<xmqqppgp4a7x.fsf@gitster.dls.corp.google.com>
	<xmqqegx53txe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 03:06:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBvs7-0001lt-C3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 03:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbaG2BG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 21:06:27 -0400
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:40480 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752495AbaG2BG1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2014 21:06:27 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]) (using TLSv1) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
	ID DSNKU9bzkhw7IPlfbTR1pykWtz4rmlo0GsCH@postini.com; Mon, 28 Jul 2014 18:06:26 PDT
Received: by mail-oa0-f42.google.com with SMTP id n16so9689533oag.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 18:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dVNmZAulTqivjnepQ1aSwUEgPtoaaS0bJ7j7Sc1ExJc=;
        b=dJ/BTT2PO6LoDqb9rmSecFfztSxGyAAF8cmvRYpUrvL3lcbEApC7jrabPwxRHlcj34
         hw8Xxk/FQHM4JjbEwGTDjSlHoA3d8s7GCcWIB7VwibXak8EOFSaJ2lNUWwqmvcZagBeN
         5hy8xmRZWXLMbhETDuwGItiKf6FR2tRd8CyGaRAHL6G94SjMolnF7l8gq6OzypVdIGqo
         h7fxXcZmUzndlcNk7tn/k7rtnzPWtWATxNolNPLf2y5K3hqNyLb+ZXBJVuj7kJ3qbWcB
         aliIC8kqhFKlW/RPSfeARnF/QQPIne5p8Lyq8jOAxIy68rUoUkSRhZgDMTJ929u0iozY
         U3Cg==
X-Gm-Message-State: ALoCoQk2ormvBvC5sD6qK2G6eNzEnSEQwb3+fZGh89Ozeaj8EX11y32dHpSIJYPNdewWIE28k7+ZkEzB3fweaxNe7D6lRn4T6Ffzsli9P5HihceI1fCp0RbpyK2HGS4GIeQTfi7PNni8
X-Received: by 10.182.199.5 with SMTP id jg5mr54970453obc.75.1406595986143;
        Mon, 28 Jul 2014 18:06:26 -0700 (PDT)
X-Received: by 10.182.199.5 with SMTP id jg5mr54970448obc.75.1406595986032;
 Mon, 28 Jul 2014 18:06:26 -0700 (PDT)
Received: by 10.182.51.130 with HTTP; Mon, 28 Jul 2014 18:06:25 -0700 (PDT)
In-Reply-To: <xmqqegx53txe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254389>

On Tue, Jul 29, 2014 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>> Yeah, I'm fine with a straight revert, too (I think it is fine to keep
>>>> in master, though). I think jk/alloc-commit-id is built right on top of
>>>> the original commit-slab topic, so it should be easy to do either way.
>>>>
>>>> Thanks for dealing with it.
>>>
>>> Whatever we do, perhaps it is worth applying the test below on top?
>>
>> Yeah, thanks.  I think that is a good idea.  I was preparing a patch
>> to tuck your minimum reproduction at the end of 4202, but your version
>> and placement makes good sense.
>
> OK, I pushed out updated 'maint' and 'master'.  The former merges
> a rebased version of jk/alloc-commit-id in to make the "reorganize
> the way we manage the in-core commit data" topic, and the latter
> reverts the "Use SSE to micro-optimize a leaf function to check the
> format of a ref string".
>
> Please give them some quick sanity check.
>
> Thanks.

Thanks both of you; I appreciate your efforts! I've run my suite of
tests against the tips of master and maint and all 681 pass for each.
Looks good to me.

Best regards,
Bryan Turner
