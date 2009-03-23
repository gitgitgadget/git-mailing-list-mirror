From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: Minimum libCurl version for git
Date: Mon, 23 Mar 2009 11:24:57 +0000
Message-ID: <e2b179460903230424v1c98d73ci1f41918807fb2d5c@mail.gmail.com>
References: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com>
	 <7vy6uzg98v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Daniel Stenberg <daniel@haxx.se>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 12:26:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LliIg-0003pF-9q
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 12:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050AbZCWLZA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 07:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbZCWLZA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 07:25:00 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:22447 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbZCWLY7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 07:24:59 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1679300qwh.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Yrd1xkxbbABkNwtK+3qONRhgNWEGXZn9kgxaa8yZ+DU=;
        b=N5l3syBaDSKtjn1Lw7oTWPJEFhBXZtGmRpGvrKUzl4Oab9vcT3OT7/6Flmk5SPoBbi
         xm59OMxj3JJVGKWmnV5gFCd6v5Y5p2545z0pRRVsonxAntHu7DJxO4jbYwUiIG81mWJa
         KJ8rVe+EUgMzzUTz46Pur6j5ZiafjJPxaD7Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oLgPASGJfUhV2i0s7jUUt1AK6t4YwBzUvoRuvZlDfd3PKwSYBeW9/gjzYFFtKFpKFE
         o8yuob2HoakeaVpH5opSlXqmrExZqeMjtn4+kvZPHFh1e7hB5e4KeR43rVoCp9JO9dUa
         O+PrePhHpFmeHr1KZXMcZE2TEDXSn+6OghIQI=
Received: by 10.224.60.74 with SMTP id o10mr8602040qah.229.1237807497376; Mon, 
	23 Mar 2009 04:24:57 -0700 (PDT)
In-Reply-To: <7vy6uzg98v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114292>

2009/3/20 Junio C Hamano <gitster@pobox.com>:
> We can have these two macro definitions on our side
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#if curl older than 7.10.8
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#define CURLINFO_RESPONSE_CODE CURLINFO_HT=
TP_CODE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#endif
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#if curl older than 7.9.7
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#define CURLOPT_READDATA CURLOPT_INFILE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#endif
>
> for backward compatibility, while writing our code to the recent API =
by
> using CURLINFO_RESPONSE_CODE and CURLOPT_READDATA, and people with ol=
der
> curl would not have to suffer a bit.

See? That's why they pay you the big maintainer-bucks... 8-)

> Mike, I'd say we declare 7.9.3 as the floor and go from there.  That'=
s
> your #3, I think.

Short patch series to follow, though maybe not today.

Mike
