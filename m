From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] memory leak reported by valgrind
Date: Mon, 9 Aug 2010 22:19:47 +0200
Message-ID: <AANLkTimrNv0VT_Nrmz_R0sFbL8QfMKPQjXhVJD95=KbE@mail.gmail.com>
References: <wes62zknmki.fsf@kanis.fr>
	<7v1va760ip.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 22:20:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiYpX-0004g9-Bh
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 22:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab0HIUTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 16:19:50 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39464 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558Ab0HIUTs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 16:19:48 -0400
Received: by vws3 with SMTP id 3so7056651vws.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=PvFLKlORZM+XctPM8iZ0p7zfl/Pip7Vb2UlJbdD15ys=;
        b=JJWWxI5t70tmL6z7Nyf15wba3T1yc30UAmVsG98X0DlItjzD9mnOnT4BeMTg/4d182
         AicN0E6pE8bOuLSEVmKlkRy4zPUVYnlNcEAOgRW4wGqC5X3hbM3QbCZmktnYjdodLAw3
         4jUvD4kEjwT1aE4JzH34dLG/MjMDqQc2dhXjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=mRfxuvHQR5Nzb7bk3fUr5Z5L1IDTVLnkHeHtvQ6TlLBtWr1SU9e9NTyQgTW2xrgV82
         oZBKzYp/Wqpfa6Vm6PEx+btBZ55Gw/cVljs2LAdhYqmUpJkSQdpOgHZ6uWWiOzx7i8r+
         gtgsi4+plFz2yf3+qustC0QIqUat78ocsnnnU=
Received: by 10.220.60.204 with SMTP id q12mr9861862vch.185.1281385187870; 
	Mon, 09 Aug 2010 13:19:47 -0700 (PDT)
Received: by 10.220.172.67 with HTTP; Mon, 9 Aug 2010 13:19:47 -0700 (PDT)
In-Reply-To: <7v1va760ip.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153016>

On Mon, Aug 9, 2010 at 9:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks, but doesn't it essentially sit at the end of main(), only for _exit(2)
> to clean after us?

I don't know if you consider this relevant, but in Windows 9x (and ME)
allocated memory isn't returned to the global heap on process
termination unless explicitly free'd.
