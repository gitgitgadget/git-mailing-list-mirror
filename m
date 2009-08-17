From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 05/11] Remove va_copy at MSVC because there are va_copy.
Date: Mon, 17 Aug 2009 19:02:18 +0200
Message-ID: <40aa078e0908171002j4b610fe4j34a4e7d3081a9efa@mail.gmail.com>
References: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>
	 <4A898B27.3040507@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Johannes.Schindelin@gmx.de
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:02:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5bG-0002FX-Vi
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618AbZHQRCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 13:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757608AbZHQRCS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:02:18 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:59892 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757516AbZHQRCR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 13:02:17 -0400
Received: by qyk34 with SMTP id 34so2265671qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RDaMYWVW3XA6697LKDkF0/S95CP4pbhbgV/6TaqVM00=;
        b=X9dAhT82AYNfZMwFrFr2BcJSjBgiMXNpCn6Wod8ROrZx8zdLWgQ+A0dMArscu2sqZJ
         /pVEEDeG5PfLDnJQqqffYyC/Ie4Mch9lsJ+v7wN/3RCQKLaIuthk+KIjvEiun5J2tuye
         ad04VkCLbIN+s8gnPPVOqaXO986ZjGI+W3p1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WUPdoqoY77/2cH6CH3YHzqOAalaP4ytfZfSlJZdYrUxHqTeE+JrdkHOsh+baVaeryr
         3lza3OPeyF0PGYNNO33/BxA3NOMQ3X+0Fy5uqW776KOZEK0F5jw4Jlq1MS/5ZRZ8vxI8
         Yp/Zl/qWLF4DQDFY9v2GmgOZIn8uRka3TjgJI=
Received: by 10.224.117.12 with SMTP id o12mr4440172qaq.57.1250528538535; Mon, 
	17 Aug 2009 10:02:18 -0700 (PDT)
In-Reply-To: <4A898B27.3040507@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126233>

On Mon, Aug 17, 2009 at 6:53 PM, Paolo Bonzini<bonzini@gnu.org> wrote:
> #ifndef va_copy
> #define va_copy(dst, src) =A0 =A0 =A0 ((dst) =3D (src))
> #endif

Are you sure va_copy is always a preprocessor symbol? How about

#ifdef _MSC_VER
#define va_copy(dst, src)       ((dst) =3D (src))
#endif

instead? It'd make me sleep slightly better at night, at least ;)

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
