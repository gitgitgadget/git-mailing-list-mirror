From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] Allow combined diff to ignore white-spaces
Date: Mon, 4 Mar 2013 19:50:33 +0100
Message-ID: <CALWbr2xPJQ1tvyT6Q84ccn=k6fg8A1aUbJG7FQjjJGZGC5voGg@mail.gmail.com>
References: <1362236658-17200-1-git-send-email-apelisse@gmail.com>
	<7v38wdc4ei.fsf@alter.siamese.dyndns.org>
	<CALWbr2z0eok-VOQX7DDZafevQUi7asCv_tD8=y6XA2PVYf52AQ@mail.gmail.com>
	<7vy5e3vwos.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 19:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCaTU-0005Od-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 19:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706Ab3CDSuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 13:50:35 -0500
Received: from mail-qa0-f51.google.com ([209.85.216.51]:58841 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758582Ab3CDSue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 13:50:34 -0500
Received: by mail-qa0-f51.google.com with SMTP id cr7so1373631qab.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 10:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=q+G/z8EvWo1rFD83KRNaVHYTxd5b1rye7Hw6m+4xLZ8=;
        b=0/OuXs9O4i6Lt5Bzw8BmZLTjTYf1hsMhM2YBnsyaquwFUL4dQA3P1nybocLKvKRu9k
         OPpAsrfpDx7/DC+6ewIII0JUXbWol4MOSoDD4qdbAI7/Os9yjMxcN0AefzexbnxhhVRX
         fnBeONLdUDKOqFbQlWQeybJt+xi5V5ZXg58LQcMyjiDRr/K+69I0Qy2ohQcQGJcAVH7l
         UM4BhSfv2G7gwEbnxSn26JtECfCaRTX5VPpbX9F2pgkCT8RWue77eiHeAalh4AWa2u+B
         bUJSKN6MEogw0LPgjE3bpBWZVsKl2ViPzIo8vi/a+Y2sogtxg/d4iiDY46RNQtkLNIcE
         i+2Q==
X-Received: by 10.49.127.116 with SMTP id nf20mr15054737qeb.2.1362423033828;
 Mon, 04 Mar 2013 10:50:33 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Mon, 4 Mar 2013 10:50:33 -0800 (PST)
In-Reply-To: <7vy5e3vwos.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217407>

On Mon, Mar 4, 2013 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> It feels incorrect to me to coalsesce "- 5" and "-  5" as it might
>> look incorrect to the user. But still the idea is appealing.
>
> The users already need to see that when reading a regular patch with
> one or more context lines and -b/-w/etc., anyway.  The context lines
> are made into context only because whitespace differences were
> ignored, and in the regular unified patch format we can show only
> one version, either from preimage or from postimage, and have to
> pick one.  Coalescing "- 5" and "-  5" into "--5" or "--  5" by
> picking one or the other is the same thing, no?

That's all I needed to be convinced. I obviously don't care which one we pick.

>> Using the exact example you gave, and running the latest next, I have
>> this output, where 11 is not coalesced.
>> Is that a bug ?
>
> It could be tickling a corner case because the removal is at the end
> of the file.  Perhaps adding 12 that is all common across three
> versions and see what happens?

Doesn't make a difference. Still have "- 11" and " -11".
I will try to have a look at it.
