From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 2/9] gitweb: uniform author info for commit and 
	commitdiff
Date: Sun, 28 Jun 2009 00:33:53 +0200
Message-ID: <cb7bb73a0906271533g308fd42w82d11cd2658b1e99@mail.gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906271810.23119.jnareb@gmail.com>
	 <7vskhlikt7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 00:35:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKgUx-0007xO-Em
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 00:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbZF0Wdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2009 18:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbZF0Wdw
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 18:33:52 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:55751 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbZF0Wdv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jun 2009 18:33:51 -0400
Received: by bwz9 with SMTP id 9so2623160bwz.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aNBM/M2KfFUZAMEJzSAJvDNrbeNwLrSessrwbgt/uXU=;
        b=EyFhJKRk1T993V4S6uFlcHCY1Wz83cVFWuG7AwRQ2vMAjFOiDgYVBm5px7pASUqaXF
         R/WMKb8BMDK7gobn9KPrUiOiwa5x7sfgQk7vOLhOpWuI4O7yogapDr7VZX17JxHbgqA+
         vVf4JXvPvQoU3JnqK4I0JMDI8agQd28fhpCPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ufNW4wTtMlNnfPj1F6TjypNg9dsMiThhGMvBfn6UVSLsMJDmE6zm8/svSPXbQUX8u5
         LNFB5MDBGuf4QjFky/hvgOTteoQ933pmMUpxGbaBvE6uEaNrtBIt4mvJUgflkUov7LMX
         le53AT+Ny4cbcsi/cbCwKg1jJhfVgDPJNgevE=
Received: by 10.204.64.196 with SMTP id f4mr5234783bki.151.1246142033685; Sat, 
	27 Jun 2009 15:33:53 -0700 (PDT)
In-Reply-To: <7vskhlikt7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122389>

On Sat, Jun 27, 2009 at 8:38 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> I would use:
>>
>> =A0 Switch from form similar to the one used by 'log' view
>>
>> =A0 =A0 =A0 A U Thor <email@example.com> [date time]
>>
>> =A0 to the form used in 'commit' view
>>
>> =A0 =A0 =A0 author =A0 =A0 =A0 A U Thor <email@example.com>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0date time
>> =A0 =A0 =A0 committer =A0 =A0C O Mitter <other.email@example.com>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0date time
>>
>> (i.e. use spaces and not tabs to align). =A0But this is minor
>> issue, not worth worrying about IMVHO.
>
> These extra blank lines make things much easier to read, and explicit
> mention of switching from WHAT to WHAT ELSE is very much appreciated.

I updated the patch accordingly.

>> On the other hand side IIRC 'commitdiff' uses short (one-line)
>> authorship info because the main point is the diff, and multi-line
>> author and commit info like the one used in 'commit' view takes
>> a bit of vertical space.
>
> In general, we might want to make the committer information less prom=
inent
> than it currently is.

I've been thinking about this. A possible approach I considered could
be to only show the commit _date_ by default (which could be
interesting to see), and use some DHTML to show the committer on
request. But as you mention, this is not the patchset to do this kind
of work on 8-)

--=20
Giuseppe "Oblomov" Bilotta
