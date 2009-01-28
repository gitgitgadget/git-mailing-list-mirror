From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] git-am: emit usage when called w/o arguments and w/o 
	patch on stdin
Date: Tue, 27 Jan 2009 22:08:26 -0500
Message-ID: <76718490901271908m4f64232ka9cfb9c554589cf2@mail.gmail.com>
References: <1233110338-16806-1-git-send-email-jaysoffian@gmail.com>
	 <7v7i4gyvzr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sverre@rabbelier.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 04:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS0of-0004wZ-SK
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZA1DIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 22:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbZA1DI3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:08:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:15612 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbZA1DI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:08:28 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6732563rvb.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 19:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z60Y8kmVreGbxIkvaLBxYnDl5P3wJ7JZHzTP+J70qZQ=;
        b=AuUVqE3OhRA+UhfH5nLCnGJx86vMjQHB6fGEm7TJa469b6BAOWM54lg//iMGcz3eWe
         5v+sL8B6WPwbIWplL4Mh55h1GJm5iylEg3+OeYsY0r36msCjXMXB1C+N9yywb3WB6/Q3
         27UsVEVSiFmFasNqTtSakNvqbd7+7R4hukFys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oaxw5a5ZdJNFeKOX0enh9JL5BsdfODVwc9SV4mNm0DiKE/tydhbB5UPIFIvzmMI6he
         Dnn36iPUMkjfh3mxA6q9KwKA/tHyN/hRoPQ5L8MJndEOBgv4wX6k+UbV1NQmDLP8uxAc
         khJ0yoz3ePmecJ8TBjReBYg4hNnByrq67HZsI=
Received: by 10.140.201.6 with SMTP id y6mr137409rvf.298.1233112106553; Tue, 
	27 Jan 2009 19:08:26 -0800 (PST)
In-Reply-To: <7v7i4gyvzr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107457>

On Tue, Jan 27, 2009 at 10:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> Also ensure that $dotest is cleaned up if user manages to interupt mailsplit
>> while it is processing input.
>
> I do not think this "Also ensure" part is necessary nor desirable.  If
> something goes wrong, we'd like to have a way to resurrect some partial
> results from the split out result.

Hmm, git-am was already nuking $dotest if mailsplit exited non-zero,
so I kept that behavior, but also clean-up if user kills git-am while
mailsplit is running.

I still think it should nuke $dotest if user hits ctrl-c, but I agree
if mailsplit exits non-zero it should not (which would be a change
from what it does now).

> The rest looked fine.  Perhaps a re-roll?

Sure.

j.
