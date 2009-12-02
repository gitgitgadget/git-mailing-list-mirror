From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 01/11] mingw: add network-wrappers for daemon
Date: Wed, 2 Dec 2009 16:11:23 +0100
Message-ID: <40aa078e0912020711v6dcebba1g511e6cacbbed16be@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
	 <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st>
	 <40aa078e0911260246j47fa36d5t421de7c1d07d5cca@mail.gmail.com>
	 <alpine.DEB.2.00.0911261250180.14228@cone.home.martin.st>
	 <40aa078e0912020501v9378c37l106e1e23b5e7b43d@mail.gmail.com>
	 <alpine.DEB.2.00.0912021511310.5582@cone.home.martin.st>
	 <40aa078e0912020549s792eb3ffi93b2cfdc6b7219dd@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	dotzenlabs@gmail.com, Johannes Sixt <j6t@kdbg.org>
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Wed Dec 02 16:11:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFqrb-00077k-RS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 16:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbZLBPLT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 10:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbZLBPLT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 10:11:19 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:37449 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbZLBPLS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 10:11:18 -0500
Received: by fg-out-1718.google.com with SMTP id e21so303930fga.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 07:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sDb4wvLq12w2D8M3zee6B8pbUNfniJ45qeL8gFQ7hA0=;
        b=oNvfDRtvgKCBQPi0qtdfs7a4buk+5FnfBCI1iIFST2f1W5OdrYOFQ3Hwicc7MW6IBV
         QUe88qJfe8O//lr7P1GMKjAR/YZtLKo6oLHji+Pzy/Jw3WrV37Dw6/V7crRY9RZU8+pi
         gXE/ru6J+bfIrPVL0/Ok83g0yiIeVsHMrzzZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=GgYUKe3rGtAVFGy7d2ItrQV4ogz8HE419G2kwpxskmGtOrEUsFIg+GI8hOBpDHXUJ4
         F+GbvfhfAsK7um+M8jaaUBplrN7BvYZoPVDI5w+htWcHQxkLQk1v/5dFHQ8ZnVqDhmHs
         oUWTuXAgtfdti/y4s79+fz1ca2Apx51OHbjKs=
Received: by 10.216.85.136 with SMTP id u8mr76958wee.79.1259766683987; Wed, 02 
	Dec 2009 07:11:23 -0800 (PST)
In-Reply-To: <40aa078e0912020549s792eb3ffi93b2cfdc6b7219dd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134337>

On Wed, Dec 2, 2009 at 2:49 PM, Erik Faye-Lund <kusmabite@googlemail.co=
m> wrote:
> On Wed, Dec 2, 2009 at 2:21 PM, Martin Storsj=F6 <martin@martin.st> w=
rote:
>> On Wed, 2 Dec 2009, Erik Faye-Lund wrote:
>>> @@ -854,6 +850,7 @@ static int service_loop(int socknum, int *sockl=
ist)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 han=
dle(incoming, (struct sockaddr *)&ss, sslen);
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break=
;
>>
>> What's this good for?
>>
>
> When I clone git://localhost/some-repo, select() returns a fd-set wit=
h
> both the IPv4 and IPv6 fds. After accept()'ing the first one, the
> second call to accept() hangs. I solved this by accepting only the
> first connection I got; the second one should be accepted in the next
> round of the service loop (if still available).
>

Actually, it's no good - my code is broken. FD_SET() and FD_ISSET()
needs wrapping to call _get_osfhandle() on the socket. Since this is
not needed on Linux, the code ran just fine there. But on Windows,
select() failed, but due to the following bug, it wasn't picked up:
+               if (select(0, &fds, NULL, NULL, &timeout) > 0) {

changing the comparison around, revealed that select hadn't done
anything so fds wasn't modified at all! Thus, I wrongly interpreted it
as if both sockets had an awaiting connection, making IPv6 connections
work (since they are on the first socket), but IPv4 not.

I've corrected this locally, and I'll include the fixed patch in the ne=
xt round.

Thanks for pointing out the issue, causing me to second guess my "cure"=
 :)

--=20
Erik "kusma" Faye-Lund
