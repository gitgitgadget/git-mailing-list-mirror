From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH v2] Make sure objects/pack exists before creating a new 
	pack
Date: Thu, 26 Feb 2009 15:54:03 +0000
Message-ID: <e2b179460902260754t38618c3fsf22a699ec35070cf@mail.gmail.com>
References: <49A428B7.4000003@spiralti.com>
	 <7v7i3fivx2.fsf@gitster.siamese.dyndns.org>
	 <7vocwrc7oe.fsf_-_@gitster.siamese.dyndns.org>
	 <49A65EBF.10307@viscovery.net>
	 <e2b179460902260319je8ce6c6qc028d260b9d35b7c@mail.gmail.com>
	 <49A6B5E8.8040306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
	Rafael Darder Calvo <rdarder@spiralti.com>, mike@abacus.co.uk
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 17:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcigR-0001MQ-8N
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 17:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbZBZQAb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 11:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754246AbZBZQAb
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 11:00:31 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:31099 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbZBZQAa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 11:00:30 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1070679qwi.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 08:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UX55R/FK1hqU6GG3y+JI5qyompIYFmVmZndFLrHFFe8=;
        b=pbMEaS0wfTanFenmAtwPACrV+P6o3/yevjbKhIR3GVuGQk+Dzu5Az7xKjwgtrlqlhx
         FnMGUw5riPtk2n8CyxexthcW4iC+7Go7xraJfRDrrP9uPalYmawQPIjuAv+fixfnKHIc
         OTjcl8EkHdHuGveGZnFb/GZQbj7xYVXFY4Pxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZFhG0ba2W7acpZXiEjUc6oeudJXHRCETzxTJVJ3S8b2YS72UuaCh//BSfDH9NX2aud
         l6vXYSGCxrLDPzVqeTzSWIr1Rw29455/kmHJxEwEGVG3nJBDhXmVxXYDfZNLZlSEem78
         UA75fJs0qJukLQC8T/iM20Ag0DXOZf4l5E2lQ=
Received: by 10.224.53.203 with SMTP id n11mr2371290qag.192.1235663643773; 
	Thu, 26 Feb 2009 07:54:03 -0800 (PST)
In-Reply-To: <49A6B5E8.8040306@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111577>

2009/2/26 Johannes Sixt <j.sixt@viscovery.net>:
> Mike Ralphson schrieb:
>> Even with j6t's patch, I'm seeing failures in t5300--pack-object.sh =
on AIX 5.3
>>
>> * FAIL 15: survive missing objects/pack directory
>> fatal: Unable to create temporary file (): No such file or directory
>
> I can confirm this. Your patch is good. I wrapped it up:
>
> -- snip --
> From: Mike Ralphson <mike.ralphson@gmail.com>
> Subject: [PATCH] Fix odb_mkstemp() on AIX
>
> The AIX mkstemp() modifies its template parameter to an empty string =
if
> the call fails. =C2=A0The existing code had already recomputed the te=
mplate,
> but too late to be good.
>
> See also 6ff6af62, which fixed this problem in a different spot.

Ah, I should have remembered that one.

If my $DAYJOB email address could be used in the From, as per this s-o-=
b:

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>

Thanks.
