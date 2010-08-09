From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] memory leak reported by valgrind
Date: Mon, 9 Aug 2010 22:29:02 +0200
Message-ID: <AANLkTikg5Hcsz+COYrDtxc01tNay_D97aVHoMP06aO1J@mail.gmail.com>
References: <wes62zknmki.fsf@kanis.fr>
	<7v1va760ip.fsf@alter.siamese.dyndns.org>
	<AANLkTimrNv0VT_Nrmz_R0sFbL8QfMKPQjXhVJD95=KbE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ivan Kanis <expire-by-2010-08-14@kanis.fr>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 09 22:29:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiYy7-0001c0-Kh
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 22:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823Ab0HIU3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 16:29:05 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61655 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab0HIU3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 16:29:03 -0400
Received: by ewy23 with SMTP id 23so3603766ewy.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tKpq0L3jsequdgbeub6NqhcCCmEPYPjM+vLD+aKGrfA=;
        b=bBrrs23CT6vuclLcVC+qK3QzdlKD0XgYAbBJ9OXIq5ufHupOWu27umUrnIEEHlDMZM
         jcBvZlU6+nGEG1CDIymoYVnMXJbfWBFQr5hk+yDU7a5m7hWXJdoX+od3qtYdvUq5uT+z
         QVmJzPNdnPMb++a5CM48dwZh0gSZCmAURodTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R45GVxN6+MVaADD0/6w6U5/mVcW5mDOVYl+rnTfm9uL2DcBNe1g86uMryiLiDUzpFU
         iqu4KoZjkVaPjISU39dVRYtwiLpGgOHZv5yizcvNrULmXPTz3sXu+Gpuh5l+iUTPkLuu
         jqZ249tB1b/I7/5eZyl7bqZQzoEOC8udtU5JI=
Received: by 10.213.89.196 with SMTP id f4mr3404998ebm.3.1281385742543; Mon,
 09 Aug 2010 13:29:02 -0700 (PDT)
Received: by 10.213.30.17 with HTTP; Mon, 9 Aug 2010 13:29:02 -0700 (PDT)
In-Reply-To: <AANLkTimrNv0VT_Nrmz_R0sFbL8QfMKPQjXhVJD95=KbE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153017>

On Mon, Aug 9, 2010 at 22:19, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>
> On Mon, Aug 9, 2010 at 9:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Thanks, but doesn't it essentially sit at the end of main(), only for _exit(2)
> > to clean after us?
>
> I don't know if you consider this relevant, but in Windows 9x (and ME)
> allocated memory isn't returned to the global heap on process
> termination unless explicitly free'd.

...and nothing but DOS, Windows 9x and ME does that.
