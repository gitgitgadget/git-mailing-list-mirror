From: Phil Hord <phil.hord@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Thu, 4 Oct 2012 09:24:19 -0400
Message-ID: <CABURp0pgE=J9yCa+nUa7J0MZ-O-6bUHrj58zLQZ9mToh6YcOFw@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
 <506AA51E.9010209@viscovery.net> <7vzk449449.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
 <7vhaqc7in6.fsf@alter.siamese.dyndns.org> <CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
 <90464C79DA97415C9D66846A77ECAA4A@PhilipOakley> <CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
 <vpq626s6kwu.fsf@grenoble-inp.fr> <CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
 <vpqvcer4xvo.fsf@grenoble-inp.fr> <CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
 <A75F75C4DE3C47C7AF43D39355C873F7@PhilipOakley> <CAB9Jk9C4Y2LSzZW5Nkz=4f===8_gk4uAG4EKDxT17kUHu4VX1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:18:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtYH-0001w8-Pj
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740Ab2JDNYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 09:24:43 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:42225 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab2JDNYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 09:24:40 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so213702lag.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6T8WKzH4+gyAI1UIZdt47aFyp/dx2NS4/DoZBpShxWs=;
        b=frszBl85Wju8POJhB1ppdybMlWHccQZZH7dBIIbB4N+ds8IpuN/+jsktbrtsiP4I2o
         agmPofR0P0yvsjI8lPYITK5xoqXfFSVJAcjV1REUDQyoTnCwOAfUon1crKBmFBR8msbz
         3+L/91dyucVuCJ9Rb/ySCn1AQD4gBMIzhyDE6feeOsyz2GDNxWlSDShPskN4qRL8Ft54
         lZsewh6Sp0U8HrpjaNw+3vCGQ54ft2oNtWrciCs/TBUBs7mJZHWEUpiXyuEPF/31yejf
         8LCHu9FIVhb8AC03gVVTagb9Ybv0pQXNQtPtrwhTmADAjOHd1DTfAttSrhlSlKk+iBIM
         DCEA==
Received: by 10.152.110.229 with SMTP id id5mr4111171lab.36.1349357079197;
 Thu, 04 Oct 2012 06:24:39 -0700 (PDT)
Received: by 10.114.17.225 with HTTP; Thu, 4 Oct 2012 06:24:19 -0700 (PDT)
In-Reply-To: <CAB9Jk9C4Y2LSzZW5Nkz=4f===8_gk4uAG4EKDxT17kUHu4VX1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206985>

On Thu, Oct 4, 2012 at 3:07 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
...
> The operation that caused problems was nr. 4. In all the cases
> enlisted above, a git commit creates a brand new and unique commit
> because either it has a parent that is different from that of any
> other commit, or because its tree is different. All, except case nr 3
> when there are no binaries:
>
>      source branch         A'
>                                    :
>      topic branch        A
>
> In this case the parent is the same as that of A, i.e. none, and also
> the tree is the same.

And why is this a problem?

Is there a process or person watching the server for a new commit?

Is it not enough to notice that the pushed-to branch has a new HEAD?

Phil
