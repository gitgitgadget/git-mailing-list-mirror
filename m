From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 05/13] send-email: Cleanup the usage text and docs a 
	bit
Date: Tue, 14 Apr 2009 02:15:51 -0500
Message-ID: <b4087cc50904140015t459f0656te30dcb0dfc6a063@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
	 <7vhc0se0pc.fsf@gitster.siamese.dyndns.org>
	 <b4087cc50904131542q7354fa05wb763f70e4baf9abb@mail.gmail.com>
	 <7vfxgbaj5s.fsf@gitster.siamese.dyndns.org>
	 <b4087cc50904132300m391ac4ffn6a41ecc5cdcb6ed8@mail.gmail.com>
	 <7vfxgb91hc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 09:17:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltcta-0002jp-8c
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 09:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbZDNHPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 03:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbZDNHPx
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 03:15:53 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:20502 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbZDNHPw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 03:15:52 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2792195qwh.37
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 00:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rGL+00z42lsV7SokN/42AMPLkDgvqubRpzm6nOsy/wc=;
        b=pzVTAq8iUgCRdWBeYuxmngr652CDDbbIeaSF/VixDoav9tL0vw8XwGlp/KqK/g09Gu
         1IWA2AsOxJ9LpU83Au+6RGEJmrGthvxZ2bsmWd7Yq2h1rXxU4sNfTSQ59nqpyx06at9c
         hh4fTDvknR/xw4LAHf+Teu7nxJu5UUWVrjLuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rSy7FKTjA1Gc+rutlncKB03PUNid42OqtSYsiIyTYrWEoGtABYaW2JOe1EC3zWy2CA
         rK08ZDHES4cn7qRwQMmIoN2sp07S2ZHEJ3fJDq61TxPlEq8Ql9TvUR49esclE9J/h4P9
         LpHiRxYrNe4Dy+16NMP2GpqPRuuPEhOkm7mEs=
Received: by 10.224.67.75 with SMTP id q11mr7004989qai.272.1239693351182; Tue, 
	14 Apr 2009 00:15:51 -0700 (PDT)
In-Reply-To: <7vfxgb91hc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116525>

On Tue, Apr 14, 2009 at 01:46, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> The usage text for --smtp-server currently has <host:port>, which
>> doesn't work when 'ssl' is used for the connection to the server.
>
> Ah, I see. =A0But it does work when ssl is not used, right?

Right.

> A possible solution would be one of:
>
> =A0- support host:port in SSL codepath (shouldn't it be trivial?);

Extremely trivial.

> =A0- split the description in the documentation to clarify it does no=
t work
> =A0 for SSL; or
>
> =A0- remove host:port support to make both consistent.
>
> To me, the last one makes the least sense. =A0Is that the approach yo=
u are
> taking?

That is SORT OF the approach I took. I got lazy and didn't care to
make <host:port> work for SSL, because there is already
--smtp-server-port and by just replacing <host:port> with <host> in
the USAGE text, the whole <host:port> notation was effectively
deprecated but still usable as before. Genius, right? Grade *A*
laziness.
