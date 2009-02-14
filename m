From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 12:41:37 +0200
Message-ID: <94a0d4530902140241j6547a1d2kd51f784916770943@mail.gmail.com>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
	 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
	 <7v1vu1webk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 11:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYHzi-0003Qo-P9
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 11:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbZBNKll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 05:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbZBNKlk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 05:41:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:9453 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbZBNKlk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 05:41:40 -0500
Received: by fg-out-1718.google.com with SMTP id 16so38183fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 02:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z9ilrIuCu0bn6tx+ivA6FmSpeMgJAsp6VeV1h1CErfE=;
        b=hCHXQLnw0jS6xma2hDD1K9uRZlV1LTJki3wFk55fJHwhal2b5hWTOvfMwSZp2aH04m
         vB9yHps8QCFHQE/gAMCGjheC61OWIUMyA2z88LatySN7oK4cF2x0O3He0rjHB08Z6I+I
         QEKSqqrybf20t/Cy+EL4Pl8/++/PScu8gYg40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nZY7pYiQrTYZKL8d0q4KCldQZ0kLBxKymXE1gV5tF/ByjoSUmnrQDI3JG3DvzBnumU
         bZ66zJwEeuxvkzE6XKnGkVLAokKNUCYTSXEa2QODJQI2fJnyc9AjbOwtr0FnWWEcp2gs
         oGw76CU3Pj6/8T/BmZyOYiyAgLLvIxoInSMyk=
Received: by 10.86.99.9 with SMTP id w9mr242708fgb.68.1234608098044; Sat, 14 
	Feb 2009 02:41:38 -0800 (PST)
In-Reply-To: <7v1vu1webk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109858>

On Sat, Feb 14, 2009 at 11:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +    OPT_STRING(0, "get-color", &get_color_name, "name", "find the color configured: [default]"),
>>
>> get-color is used to get the defined color for a given slot.  Please do not
>> rename it to "name" (see the original).
>>
>>> +    OPT_STRING(0, "get-colorbool", &get_colorbool_name, "name", "find the color setting: [stdout-is-tty]"),
>>
>> get-colorbool is used to get the boolean setting for a given configuration
>> variable.  Please do not rename it to "name" (see the original).
>>
>
> By the way, I think it might be more appropriate if you categorize the
> above two (especially the "colorbool" one) in the "Types" section, as that
> really is what is happening.  Instead of doing the usual "print the value
> as a string", it does something magical.

All right.

I haven't used most of the config options, so I had to learn and try
them; color/colorbool are the ones I still don't get.

>> Overall, with the same number of lines, we lost a lot of error checking in
>> exchange for an ability to say "git config --remove-sec" instead of "git
>> config --remove-section", and "git config --help" may give an easier to
>> read message.
>
> And I forgot to mention the "option categorization" merit.
>
>> Given that "git config" is primarily meant for script use, this particular
>> round does not look like a good tradeoff to me.
>
> Don't take this too negatively.  The tradeoff will improve if there aren't
> these obvious bugs you can spot without even running the code.

No problem, I probably should have explained that this was RFC, I knew
there were issues in the code.

-- 
Felipe Contreras
