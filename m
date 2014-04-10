From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 8/9] sha1_name: simplify track finding
Date: Thu, 10 Apr 2014 17:44:21 -0400
Message-ID: <CALkWK0kRAYpZxDkZ6nVPcfo4pqJuTLNFekpQ+tLPPRFJZKUMuw@mail.gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com> <1397156686-31349-9-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 23:45:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYMmV-00060k-P7
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 23:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759128AbaDJVpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 17:45:04 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:43077 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbaDJVpC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 17:45:02 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so5234636oag.3
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 14:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XM/ks1D6lz8DWV/qq1MzgfgSro04rnYsrgTzuw+2+KQ=;
        b=qp/JdVWEqVUm1DZbg8NrZ4Uewn37oHz2iHc/sRA/vpEdT6Xq4NtRtZAuTi5fJycgge
         W/1yLYi6m0DadDa621kDQaXdrGdfeP98WB09g3aDFJkieaJsuZYWpXc9o5gY7xJ0uxLG
         Y79TwM4Qe8XjYA7P+c/C2kPeC1adkaGmxb/QTXNICobdcXeqOA0/fQCAW7kDQXghxsvj
         xwlnToE+sKaxm/iRUC2SW8auxEjneL6To2PTb9IyqM8JiUO1BLXDFZHpmyKHpIEmkAMI
         7e851/uEKJdy1rauytkA/WZllChvgVu5lyeDNBFnUfIF6W0j/Padew9AtuFPfsipOWB0
         vQ2g==
X-Received: by 10.60.176.39 with SMTP id cf7mr16085929oec.45.1397166301884;
 Thu, 10 Apr 2014 14:45:01 -0700 (PDT)
Received: by 10.182.151.43 with HTTP; Thu, 10 Apr 2014 14:44:21 -0700 (PDT)
In-Reply-To: <1397156686-31349-9-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246056>

Felipe Contreras wrote:
> It's more efficient to check for the braces first.

Why is it more efficient? So you can error out quickly in the case of
a malformed string? I'm personally not thrilled about this change.
