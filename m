From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 05/13] send-email: Cleanup the usage text and docs a 
	bit
Date: Tue, 14 Apr 2009 01:00:13 -0500
Message-ID: <b4087cc50904132300m391ac4ffn6a41ecc5cdcb6ed8@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
	 <7vhc0se0pc.fsf@gitster.siamese.dyndns.org>
	 <b4087cc50904131542q7354fa05wb763f70e4baf9abb@mail.gmail.com>
	 <7vfxgbaj5s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtbiS-0002OJ-Fm
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 08:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbZDNGAQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 02:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbZDNGAQ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 02:00:16 -0400
Received: from mail-qy0-f117.google.com ([209.85.221.117]:36132 "EHLO
	mail-qy0-f117.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZDNGAP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 02:00:15 -0400
Received: by qyk15 with SMTP id 15so492046qyk.33
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PkQPpoZf3pzfwF7hY7gO68PNmc97cecrNoo64R+Zb1w=;
        b=I8yp3QowRWGcuqek1zQqiTS5sTJMfybTxWEbsHHH398N1Q2EBF6GAEPN4VczujdLel
         MTMjiuICf8QqK0yt8T7JIk12vq4yYZkrfjgfv3T6ESqYLoRVlhl9Eo1JWnXx/NKpLsuc
         5lDq35mGNbHD0noxepGPYYun28TBEMKYku71U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k0uFYIYRyO5e0FnmbbDT3VMHQVz/LoM1MNfR7rWVh9a/kv0PzKANReZCaC0ebY5pph
         i6QoRsawG4PPnFeAbe7Ev0L1y1UNHTDadNvM82O8qsIR/8NsFCw1hSlTyh3baWMKPGf7
         iUDzHg4lFdoENZXilhIBCb/nY9D/HZVWVruq8=
Received: by 10.224.47.16 with SMTP id l16mr2180797qaf.150.1239688813893; Mon, 
	13 Apr 2009 23:00:13 -0700 (PDT)
In-Reply-To: <7vfxgbaj5s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116516>

On Tue, Apr 14, 2009 at 00:39, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>>>> A port number in --smtp-server is no longer handled,
>>>> so the suggestion has been removed.
>> ...
>> I may have been concerned that the SSL connection code doesn't suppo=
rt
>> a host:port specification, so I thought it would be easier not to
>> advertise it:
>
> These two statements contradict with each other. =A0Please make up yo=
ur mind
> ;-).

I'm confused.

The usage text for --smtp-server currently has <host:port>, which
doesn't work when 'ssl' is used for the connection to the server.
However, the other forms of connection DO work when a <host:port>
address is given.

I set out to add <host:port> support for SSL, but then decided that
people should just use the --smtp-server-port input. It already works
for every connection method and why else have it? However, rather than
remove ALL support for <host:port>, I just changed <host:port> to
<host> in the usage text for --smtp-server.

So, effectively, I've deprecated <host:port> by changing the
documentation, but the code hasn't changed. Would you rather support
<host:port> for everything?
