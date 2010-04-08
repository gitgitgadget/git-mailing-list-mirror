From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2010, #03; Wed, 07)
Date: Thu, 8 Apr 2010 11:01:05 +0200
Message-ID: <o2u4c8ef71004080201pdbdc7aa8j99500d7643c278c9@mail.gmail.com>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
	 <4BBD7228.8080403@viscovery.net>
	 <7vwrwi78t7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 11:01:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nznbw-0003Iv-K0
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 11:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab0DHJBJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 05:01:09 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:41767 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab0DHJBH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 05:01:07 -0400
Received: by fxm23 with SMTP id 23so1848827fxm.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RkPc/02cm6z2W0sRZSAdBSVD8hVOJCWHq22UEgvsXfo=;
        b=PPNPIIYc8TlJ9CMyixuK6m1w1A1MqNHICaxzC7ZFyAp4q27BpddIPFCr9tLedb2Lz/
         w5USmjM2L1n9WEhrz6iZqaIfgX/1FuqCakuolOvOScoOk7e9lSukUP/ROp7Qcjrp2AwJ
         S7J0c1MaRj0qJDZdoYs00LN3PiOSQemBoR70k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LiNsWoM1nygIRvm6Ds+5DSrabukncO+K1LyiJK5Z5l/MoFBG3HeYF/GSCEL2N3hdqf
         Af9Lkc3gi+AkgXuoxvX96xfqCNaaWAiG7eiaSQ4zE01UqCpOdgdml+w/BSENG3JFTt1D
         BscEL2DvAd/uf/ejTW+qkcX2jaOPmTMD+IwlI=
Received: by 10.239.140.138 with HTTP; Thu, 8 Apr 2010 02:01:05 -0700 (PDT)
In-Reply-To: <7vwrwi78t7.fsf@alter.siamese.dyndns.org>
Received: by 10.239.153.71 with SMTP id y7mr1013926hbb.99.1270717265786; Thu, 
	08 Apr 2010 02:01:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144346>

On Thu, Apr 8, 2010 at 08:33, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> BTW, are there Unices that do not have a recursive mutex?
>
> PTHREAD_MUTEX_RECURSIVE is not marked as optional in any way, so I wo=
uld
> imagine an implementation that lacks it would say NO_PTHREADS in the
> Makefile.
>
> Cf.
>
> =A0http://www.opengroup.org/onlinepubs/9699919799/basedefs/pthread.h.=
html

=46or some reason I looked at Issue 6 of the standard (a previous
version, released in 2004). In that version pthread_mutexattr_settype
and PTHREAD_MUTEX_RECURSIVE are optional. See
http://www.opengroup.org/onlinepubs/009695399/basedefs/pthread.h.html

However, it is probably best to just ignore the issue for now until
some platform appears where pthreads is available but not recursive
mutexes.

- Fredrik
