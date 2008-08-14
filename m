From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 12:42:00 -0400
Message-ID: <48A46058.6090407@griep.us>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814151451.GA10544@machine.or.cz> <48A45CC9.5040708@griep.us> <20080814163446.GD10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 14 18:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTfv5-0003GC-Pd
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 18:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116AbYHNQmI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbYHNQmH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 12:42:07 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:47360 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYHNQmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 12:42:04 -0400
Received: by qw-out-2122.google.com with SMTP id 3so44801qwe.37
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=xQkjZKgTJvflu0H4hYdmRBPMWQgeNcNkIbjEozwq4S8=;
        b=kaYXfO5s8haYgL1D/pRcVvDbBAcsgvCCHa7iHJKEt7JDtpYZNi36B47Pfem+EvUCIR
         B6C9xOqqPhZxbri77aUAhyBCVm0ufyZswBGP8dApfql4k00v429tS5X+Gpepi9sEp2L0
         6XmKgRZrhHG7oP4AC6dt8+IR1l9KMi9+xKAdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=iGxFqOP/V0RI4dw7fObZ2qEYmBbZlzqAMOiMLKc3PfrmcEAELuds9UsU84HGJwITOp
         7k/BBzwQ0zEvpr+YwVLKEV1TZ6DDnMpVvk/Ydgdd5gz5uLSM4SY8RfmvT8XMTWCLF21A
         GwKLXmwg8vvgsgSqblitbgfCVn6ARw52nN1Sw=
Received: by 10.214.43.9 with SMTP id q9mr1417194qaq.86.1218732123013;
        Thu, 14 Aug 2008 09:42:03 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id q30sm3710377wrq.36.2008.08.14.09.42.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 09:42:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080814163446.GD10360@machine.or.cz>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92370>

Petr Baudis wrote:
> I'm confused - you didn't seem to really address my suggestion. Is th=
ere
> a good reason _not_ to go with the /.iB/ prefixes, and just forget ab=
out
> SI? Who is ever going to need SI?

It's more of a not limiting support, but in the spirit of YAGNI, I can
forget about SI until we find some reason to actually want it, and then
add it at that point.

As for the /.iB/ prefixes, other than the actual magnitude prefix, 'iB'=
,
'B', 'bps', etc. would be supplied as a suffix by the consumer so as no=
t
to assume that we will be formatting bytes or widgets, since conceivabl=
y
you may want to know that there are 203k objects (which would be an SI
use) or are transferring at a rate of 1.6k blobs/s.

In which case, it might be preferable to leave the SI in, since it woul=
d
allow more than just bytes to be formatted in shorter, human-readable
form.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
