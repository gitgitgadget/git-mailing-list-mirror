From: =?ISO-8859-1?Q?Mart_S=F5mermaa?= <mrts.pydev@gmail.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 7 Mar 2011 22:38:03 +0200
Message-ID: <AANLkTinBTWPrAOq9BOkBJc5GOhFkzsr__9wqEWnWdwYR@mail.gmail.com>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
	<7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
	<4D6A6291.8050206@drmicha.warpmail.net>
	<7v7hclulz0.fsf@alter.siamese.dyndns.org>
	<7v39n9uldp.fsf@alter.siamese.dyndns.org>
	<4D6B4F6B.1040209@drmicha.warpmail.net>
	<20110228121726.GA5197@sigill.intra.peff.net>
	<20110228122335.GB5197@sigill.intra.peff.net>
	<7vy650hvwa.fsf@alter.siamese.dyndns.org>
	<20110228222352.GC5854@sigill.intra.peff.net>
	<7vfwr7hh7f.fsf@alter.siamese.dyndns.org>
	<7vy64zg0ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 21:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwhC1-0006Uo-52
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 21:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab1CGUiH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 15:38:07 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40928 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab1CGUiF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 15:38:05 -0500
Received: by qyg14 with SMTP id 14so4099750qyg.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GueXm2+o9Zzm1/l3xngc9Uguw9cQjhPOkwUuELKmvbA=;
        b=hhmj+nBdhlGnZ4xQ4vH19Q/B/aofi7KkZjhYv+RG7dpJrItfBq5BPovLXW/XCAWTvX
         FH+LT9pXZRGrXBxqxPJVSqupiXavRQSemXt27lkwbbVP9pO+XKSDFnjqccrBrsUJtcsw
         GLvQv9XY/nO+r282GkPOIhqlzMHAQvneaGlQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E2zTj+CNP4DvSA3ezZYJTiNFDGgoYEJRlrKY8F5FO7dSQ05CtpI8RcKRPUWQ7qeMvy
         8XzWIHRx1wkwLlxhaupteY/6humZjuGC50btlwWG/88LqU+pVGD+ByUBgBtqXXtMKD7u
         ov6QA74/DvJLwcPbXE4u8MlQ5mIfyVf+0NUeE=
Received: by 10.229.64.160 with SMTP id e32mr3251969qci.217.1299530283918;
 Mon, 07 Mar 2011 12:38:03 -0800 (PST)
Received: by 10.229.98.133 with HTTP; Mon, 7 Mar 2011 12:38:03 -0800 (PST)
In-Reply-To: <7vy64zg0ms.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168609>

On Tue, Mar 1, 2011 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> In any case, a minimum patch to give what Mart wanted to see would
> probably look like this. =A0I'll leave bugfixes, documentation and te=
sts to
> the readers ;-).

The minimum looks to be the optimum -- IMHO this is entirely sufficient=
,
thank you very much!

What would the bugfixes be (i.e. do you have any doubts about the
implementation)?
The change looks quite straightforward, to the point and bug-free to my=
 eyes.

I try to get to writing tests ASAP.

As for the documentation, would the following section be sufficient in
Documentation/diff-options.txt?

-D::
--irreversible-delete::
	Omit file contents when file has been deleted and only
	output the header. This is useful during diff review
	but should not be used in actual patches as these would
	be non-reversible due to the omitted file contents.

Best regards and warm thanks once more,
MS
