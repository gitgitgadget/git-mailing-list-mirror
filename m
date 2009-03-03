From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Wed, 4 Mar 2009 00:02:40 +0300
Message-ID: <37fcd2780903031302m5f98fe71u8bdb23f90a8df82a@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F077AC@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 22:04:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lebmf-00021W-3m
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 22:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbZCCVCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 16:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbZCCVCo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 16:02:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:49882 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZCCVCn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 16:02:43 -0500
Received: by fg-out-1718.google.com with SMTP id 16so133012fgg.17
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 13:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JiKeQQprw8nNH3HPtu+kLe4/RVWBlvUFIeaT+WebOMI=;
        b=ujUDeiB+7iVfDcY5PNYksKFUh5R0m88D57EoWkex1/FKIfD3/mG6mcXBlQgGklVeVn
         g72130+eWBsMRn5Vw1FwbyNpamLc7wny64vbY28NCpgRemWHOG6mpxSKLnj/r1hydCez
         OHlUn+ATbDHzFddV3iKyC1gh93vyIFjIezlxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TebfTxiwuSie6GNQ9tmPXRaP1NAHzeNAMjvRAe8VzuI6nIwHoGnkG5FES3xhEn/GH5
         rgVlUF0sXKZ79bGdOk96GzZxsH+R63D8LubbOnl+E54nfTDARlVjCnnIKuMH6cGbfR+Y
         p+BuqLh1tWNoqNLCrbqvdExl44o7LeE2JBYmc=
Received: by 10.86.60.14 with SMTP id i14mr3689417fga.69.1236114161078; Tue, 
	03 Mar 2009 13:02:41 -0800 (PST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F077AC@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112167>

On Tue, Mar 3, 2009 at 11:39 PM, John Dlugosz <JDlugosz@tradestation.com> wrote:
>
> Now, the default when a program starts is to use the "C" locale.  The
> locale argument to setlocale can take a form ".code_page", so calling
>
>        setlocale (LC_CTYPE, ".65001");
>
> should do the trick.  Assuming, that is, that you don't hit macros that
> assume that characters are never multibyte.  So define the preprocessor
> symbol _MBCS when you compile.

If Microsoft fixed the problem with UTF-8 support in C runtime, it is
a really good
news, because setlocale did not work not so long time ago:

http://blogs.msdn.com/michkap/archive/2006/03/13/550191.aspx

As to Win32 API, it has always worked correctly with UTF-8... In fact, the
documentation of GetOEMCP function goes as far as recommending
to use UTF-8 or UTF-16: "For the most consistent results, applications should
use Unicode, such as UTF-8 or UTF-16, instead of a specific code page.

So it would be great if Git supported UTF-8 on Windows (as an option), but it
is not my itch right now....

Dmitry
