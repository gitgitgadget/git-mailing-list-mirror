From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 19:01:54 +0300
Message-ID: <37fcd2781002220801q2bdb553g15c0a99301a27283@mail.gmail.com>
References: <20100213162924.GA14623@Knoppix>
	 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
	 <20100219082813.GB17952@dpotapov.dyndns.org>
	 <7v635tkta7.fsf@alter.siamese.dyndns.org>
	 <7v8waniue8.fsf@alter.siamese.dyndns.org>
	 <20100221072142.GA5829@dpotapov.dyndns.org>
	 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
	 <20100222033553.GA10191@dpotapov.dyndns.org>
	 <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 17:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjajS-00006H-0X
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 17:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab0BVQB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 11:01:56 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:58491 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab0BVQBz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2010 11:01:55 -0500
Received: by bwz1 with SMTP id 1so122917bwz.21
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=45qMbaN0ovsz/yob4mW0+kB9O/QMLS0jW0o7ZL0jyQg=;
        b=hNAgKApnpxJmrDpd8brmk9hf50jc1fd+Y2AFk5cUmoYT8ifrCQHjlT/tDZBK4A2zYL
         P1PutuUOtCJjbZ4pm90NN1NpTfdCpE0nZC2ulm+CWO/0PL7SLqsAgSVkZe+a0/w+d1wU
         E6erdRbcdDIO+zoGn3+WRVifz8zQmw8T1YeHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PBThXL+Ou0ufnfnq1z36KMVTG96QWcHx+xA0D8Kbks42CvM4BasgykMYks0UbCMX8N
         SqnZJAHanug7/3iqHNnFCBt3ivnKmDOONCYn0gAH5tYiUQ4I7FeeS1YnlbugCykk1UAp
         3101M2RXmxjvoHIU0i5HTKoD4ipnv5+ejiY1s=
Received: by 10.239.187.146 with SMTP id l18mr1616220hbh.29.1266854514432; 
	Mon, 22 Feb 2010 08:01:54 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140694>

On Mon, Feb 22, 2010 at 6:40 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
>
> read() is not always a winner. =A0A read() call will always have the =
data
> duplicated in memory. =A0Especially with large files, it is more effi=
cient
> on the system as a whole to mmap() a 50 MB file rather than allocatin=
g

Agreed. I meant it was faster on data that I measured, which was <=3D1M=
b.
IMHO, read() should be used up to 64Kb.

Dmitry
