From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Thu, 9 Feb 2012 09:38:00 +0000
Message-ID: <CAHkRjk6dr=5wxm+iSC2_CSB-q3k2WG_Um+X7dwsy-H8tL508EA@mail.gmail.com>
References: <4F3120D4.1050604@warmcat.com> <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
 <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	=?UTF-8?B?QW5keSBHcmVlbiAo5p6X5a6J5bu4KQ==?= <andy@warmcat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 10:38:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvQSS-0004Qw-KX
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 10:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163Ab2BIJiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 04:38:24 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42437 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2BIJiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 04:38:22 -0500
Received: by qcqw6 with SMTP id w6so878083qcq.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 01:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NFVT5JfaLsT6pyJ6SI2IzM2vaTDBph6dliPKkg8Rn8s=;
        b=rka/tSWr2GvIB58pT8YHOiPuCXXLo9osAi2eP3tnFkwb1mDWPeCFUhdW0/4T23AqG8
         bJkUmqQEJ2AdNQxaWw80Cd7icUsKoOnMTEjM4lyASXHLLDrQ3Suo2BYOQ6UqhTGstPDK
         s6Bd+pHSIb3f8sA7kUo72LCLqU7r40awhjegc=
Received: by 10.229.77.72 with SMTP id f8mr765179qck.34.1328780302160; Thu, 09
 Feb 2012 01:38:22 -0800 (PST)
Received: by 10.229.91.9 with HTTP; Thu, 9 Feb 2012 01:38:00 -0800 (PST)
In-Reply-To: <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190282>

Hi Junio,

On 8 February 2012 07:33, Junio C Hamano <gitster@pobox.com> wrote:
> To allow parsing the header produced by versions of Git newer than th=
e
> code written to parse it, all commit parsers are expected to skip unk=
nown
> header lines, so that newer types of header lines can be added safely=
=2E
> The only three things that are promised are:
>
> =A0(1) the header ends with an empty line (just an LF, not "a blank l=
ine"),
> =A0(2) unknown lines can be skipped, and
> =A0(3) a header "field" begins with the field name, followed by a sin=
gle SP
> =A0 =A0 followed by the value.

Thanks for looking into this. Is this the same as an email header? If
yes, we could just use the python's email.Header.decode_header()
function (I haven't tried yet).

BTW, does Git allow custom headers to be inserted by tools like StGit?

--=20
Catalin
