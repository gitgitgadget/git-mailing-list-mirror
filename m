From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 1/7] pack-protocol.txt: Add warning about protocol inaccuracies
Date: Wed, 1 Jul 2015 12:56:47 -0700
Message-ID: <CAD0k6qTtvfKgJX1LyaO3i6as1Av9T=cZrwput-1HnTJuek5HoA@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-2-git-send-email-dborowitz@google.com> <20150701193949.GC4865@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:57:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAO89-0004Qt-8E
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbbGAT5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:57:08 -0400
Received: from mail-vn0-f50.google.com ([209.85.216.50]:37339 "EHLO
	mail-vn0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbbGAT5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:57:07 -0400
Received: by vnbf129 with SMTP id f129so8199905vnb.4
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2WteI2R4lOIWwAFgglTMx3N7oT0/H8eukc07Y3lKReE=;
        b=E/vsta9FieDNEKUNc284pUm7wj2w/2cqnXNBZY1PzSh5FNefY23Gtb9vbro4prxpvV
         qQHbfpJM89hRsK8Wbs844o2w5fuAssJAY/M/eUoMQ50uiFw+CTbysoQRfSMj+gdWsJkE
         yYGa+CsOeuTbCJwIq9jnOrI8PVCR32gXxcJ0CnnLjACqWuKokUO+6U6TrKs1/iHbjQVR
         kyU06AnwPBm8k7XWc6Poad1YthV+FYJymYQ5/GCUwu03oTR0z1w7vVGafyU/zjqpZng3
         7ptLwvb7HiDqXLnm4lJvo/bEmC0NwbZK+oURxTpF50ELEBcpOc1pyrheOO0KXYJF0uyz
         FtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2WteI2R4lOIWwAFgglTMx3N7oT0/H8eukc07Y3lKReE=;
        b=hAmxHmWADB4+egnRDUixGzkTDouJcZ6rl4HBLY5WJ2q4hygSbiBEKjIINb4mmIjuWE
         FfYKErhizVvm2DGBBfzxWNfMenAfT8OVKxOo4zvIDOUWSPNGLDAZC8xC8rL9WGFq5dOM
         7U5QfHPSVIZ/DeP5uqGpk7S6zJlUyMza+HbtSmU6/0/smd289fwrDNeyQE8524fCTmEQ
         YRiRhOiCxlzntueuBTr1/vF4iV1GCcXl9KuJSEavXtrn7QveWJztchi2eix/G3EErI5J
         DnsMJeXQnwHTxeDX5UDRxhxKL2MJomsG4rMaFtqUezKzaOlUi90FzV1icZx5M1IxKpZW
         Ykyg==
X-Gm-Message-State: ALoCoQlxQY/jNwQKztrImk9lyP+jBjdM2sk9tnQ06RR+xdhN3OOayiDZIHBeIcw1ZYTgsFTShaaA
X-Received: by 10.52.104.7 with SMTP id ga7mr27396089vdb.16.1435780626571;
 Wed, 01 Jul 2015 12:57:06 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Wed, 1 Jul 2015 12:56:47 -0700 (PDT)
In-Reply-To: <20150701193949.GC4865@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273193>

On Wed, Jul 1, 2015 at 12:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Dave Borowitz wrote:
>
>> --- a/Documentation/technical/pack-protocol.txt
>> +++ b/Documentation/technical/pack-protocol.txt
>> @@ -14,6 +14,17 @@ data.  The protocol functions to have a server tell a client what is
>>  currently on the server, then for the two to negotiate the smallest amount
>>  of data to send in order to fully update one or the other.
>>
>> +Notes to Implementors
>> +---------------------
>> +
>> +WARNING: This document is a work in progress. Some of the protocol
>> +specifications below may be incomplete or inaccurate. When in doubt,
>> +refer to the C code.
>
> If we include this warning, can it also say to contact
> git@vger.kernel.org for inaccuracies?
>
> Otherwise it is easy to misread as "Some of this document may be
> inaccurate, and we're working on fixing that.  Don't bug me --- I
> already know about the problems --- just be patient!"
>
> I would rather that it would say something like
>
>         Caveat
>         ------
>         This document contains some inaccuracies.  Do not forget to also
>         check against the C code, and please contact git@vger.kernel.org
>         if you run into any unclear or inaccurate passages in this spec.

Agreed with your rationale and suggested wording, thanks.

>> +
>> +One particular example is that many of the LFs referenced in the
>> +specifications are optional, but may (yet) not be marked as such. If not
>> +explicitly marked one way or the other, double-check with the C code.
>
> The 'Reference Discovery' section says:
>
>         Server SHOULD terminate each non-flush line using LF ("\n") terminator;
>         client MUST NOT complain if there is no terminator.
>
> Unfortunately that's not explained in a section with broader scope.
>
> Isn't that actually the rule everywhere except for in push certs?

It's certainly the rule in more places. I personally have partially
audited send-pack.c, but there are many places that are not yet
audited. I don't feel comfortable making a broader claim without
having done so, and I do not have the time to do so at the moment.

> The documentation will be easier to use if it says so instead of
> asking implementers to check the source of all implementations
> (since interoperability with only one isn't enough).

Unfortunately, the trust I have in this document at this point is less
than zero. A handful of spot fixes, while useful, does not serve as
any sort of assurance that we've gotten all or even most of the
problems. Until such time as this document is actually reliable,
implementors must check the source of all implementations if they want
to be accurate. That sucks for implementors (believe me, I know), but
it's the truth.

> Thanks,
> Jonathan
