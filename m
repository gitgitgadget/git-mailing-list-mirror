From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] attr: allow pattern escape using backslash
Date: Sat, 6 Oct 2012 15:02:53 +0700
Message-ID: <CACsJy8BtfeJF=tov7nPMSjXuKjisJfNfHQ_eLjwYC=GTJP12rQ@mail.gmail.com>
References: <1349508125-24775-1-git-send-email-pclouds@gmail.com> <7vzk40qbm1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 10:03:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKPML-0000PV-LF
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 10:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab2JFIDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 04:03:31 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41107 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2JFIDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 04:03:25 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5765338iea.19
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xtMafNLqx/wByX9EjaCZb/+b1+YdilqROMzGtr3HM3s=;
        b=pH2/P0o2ZcGKaiFfUCHuAc6ZpYYXXpjbLuDiCIo8V2i+m9pMWTZjE9y/m6ETsyC01U
         fnB0wkeO7ad503ERwdQES08jdvQiZObfPXuQ4LgVdjHrQEqSyyp73J6xEhE6qbY/5wSA
         Iy9ZLkHdQDw/oPADH/iCUgpbPhSXtN+kU0/FzKMvbyrBjnt7kARkD45Ei6pNzCP2YMwm
         vngeSiIAOHd3X/6kv17nqsmXf5GQAFzMdYlnqdFWPhWnprsAE+EJqjCKzxFT+kuoHblv
         beoIlSXVE/OyXW6eqpEZ1MjhWsY39pejD0+gN5YWMgCBcDFcI+V6ADbVGPqw2Q+Bez2g
         GcIA==
Received: by 10.50.236.39 with SMTP id ur7mr3230990igc.26.1349510603889; Sat,
 06 Oct 2012 01:03:23 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Sat, 6 Oct 2012 01:02:53 -0700 (PDT)
In-Reply-To: <7vzk40qbm1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207137>

On Sat, Oct 6, 2012 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shouldn't we do the same for quoting fnmatch(3) metacharacters?  To
> match a path component 'a' followed by an asterisk followed by 'b',
> you could then write 'a\*b'.  Same for quoting the backslash itself.

I think my patch does that too. The thing it does not do is optimize
this case so that we can do strcmp() instead of fnmatch() if the
entire pattern does not contain any metacharacters but backslashes. I
don't think it'll become popular enough to deserve an optimization.
-- 
Duy
