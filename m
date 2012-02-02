From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] vcs-svn: rename check_overflow arguments for clarity
Date: Thu, 2 Feb 2012 05:16:28 -0600
Message-ID: <20120202111628.GN3823@burratino>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino>
 <7vipjpzxav.fsf@alter.siamese.dyndns.org>
 <20120202104128.GG3823@burratino>
 <20120202105923.GJ3823@burratino>
 <CA+gfSn9Exv3T0UCB-bFShmSvRCMgygVuWraiToR6ZjgOA_sZ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Barr <davidbarr@google.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsuep-00084s-NH
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab2BBLQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 06:16:47 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60672 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab2BBLQq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 06:16:46 -0500
Received: by iacb35 with SMTP id b35so3000708iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 03:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4HK214AyyaygKdFH03RlhZbNx8OTDe5V5wU2IG4QRsQ=;
        b=n5oKEyA/FlA9IFs5T18BTY9p2VedS4t3Wg1hjKxFiNIPe0K6HNGY4HkTAQXMOShth4
         l+lrRCw1iT+1BC77qIiNgvAXIaqkGWy2hIXhnNn8yrfOGIwyeHH6xuIPCPDtXW+mFETK
         Ww6Z85YzRiRCubExas+pbASD/zlrSDUPyw6Bs=
Received: by 10.50.6.227 with SMTP id e3mr11693308iga.20.1328181406111;
        Thu, 02 Feb 2012 03:16:46 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ba5sm19178858igb.6.2012.02.02.03.16.45
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 03:16:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+gfSn9Exv3T0UCB-bFShmSvRCMgygVuWraiToR6ZjgOA_sZ8A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189628>

Dmitry Ivankov wrote:
> On Thu, Feb 2, 2012 at 4:59 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:

>> From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>
>> Code using the argument names a and b just doesn't look right (not
>> sure why!). =C2=A0Use more explicit names "offset" and "len" to make=
 their
>> type and function clearer.
>
> Well, it's still not clear. Given off_t a, size_t b, check that a+b
> fits into type... which type?
> "offset" and "length" don't imply that it's "type of offset" or maybe
> "type of length".

Hmm... in vector arithmetic, position (i.e., file offset) + displacemen=
t
(i.e., size of chunk) =3D position (i.e., new file offset).  Any ideas
for making this clearer?
