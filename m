From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH/RESEND] gitweb: Fix snapshots requested via PATH_INFO
Date: Wed, 15 Apr 2009 11:33:48 +0200
Message-ID: <cb7bb73a0904150233wfa72b1fn85692f81880f6848@mail.gmail.com>
References: <20090414104648.GA36554444@CIS.FU-Berlin.DE>
	 <7vvdp6xvv3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Holger_Wei=DF?= <holger@zedat.fu-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 11:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu1Wt-0001bm-E2
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 11:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955AbZDOJdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 05:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbZDOJdw
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 05:33:52 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:61250 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbZDOJdv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 05:33:51 -0400
Received: by ewy9 with SMTP id 9so3112177ewy.37
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DQ2QJhsat1lwN3AuSiBExX4tPd6g1Oqd0fJIZwyQPjo=;
        b=nq/BYCQg6AwBecEUqvAXs/IPCQbEJ+QhY9DHC7ev0Iq4HcsTRGvIo/C1tfosMpJUXo
         MwEmqEwlQy391RCxliIAgpkbQZteCTtEZvvjIJOprL6WdS1xwPJ2mX4n0Pxau/HZgg/t
         +1tgNgwNnVvYgw3DjUQKnf9sV/ru7zOZxCgxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G+smmhqqMVb3feia/FRsyThcf/UbdH5YKdNeDFYgDjuD5K2lOUWlD49zPQIDIJjKHH
         32p68Cf18akuut13k2pWi9QGAnLoT6Cgbx2K23fPMQNbKh4fCQ/+SlztcFXoNnw+ec7u
         WRHjD+Xq5KIK630HThG32L2IjW2SBS1sr6G/I=
Received: by 10.210.13.17 with SMTP id 17mr5024ebm.58.1239788028719; Wed, 15 
	Apr 2009 02:33:48 -0700 (PDT)
In-Reply-To: <7vvdp6xvv3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116600>

On Wed, Apr 15, 2009 at 8:40 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Holger Wei=DF <holger@zedat.fu-berlin.de> writes:
>
>> Fix the detection of the requested snapshot format, which failed for
>> PATH_INFO URLs since the references to the hashes which describe the
>> supported snapshot formats weren't dereferenced appropriately.
>>
>> Signed-off-by: Holger Wei=DF <holger@zedat.fu-berlin.de>
>> ---
>> I guess this one got lost. =A0Without this patch, snapshots won't wo=
rk if
>> Gitweb is configured to generate PATH_INFO URLs. =A0(Original Messag=
e-ID:
>> <20090331161636.GV30233737@CIS.FU-Berlin.DE>).
>
> The patch looks obviously correct; "our %known_snapshort_formats" map=
s a
> name to a hashref, but the current code makes a nonsense assignment,
> essentialy doing ($fmt, %opt) =3D ($name, $hashref), but what would I
> know... =A0I am not using gitweb actively.

My gitweb over at http://git.oblomov.eu/ supports snapshots with
PATH_INFO just fine even without the need for this patch. Could this
be a perl version issue? My apache is using mod_perl version 2.0.4,
and I have a perl 5.10 on my system.

--=20
Giuseppe "Oblomov" Bilotta
