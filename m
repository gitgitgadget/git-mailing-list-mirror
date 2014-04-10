From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add support for commit attributes
Date: Thu, 10 Apr 2014 15:05:06 +0700
Message-ID: <CACsJy8Ddg99Foi89ntNQ7NB=J9qCH4hcXZ0maM7vxigfO8QVTQ@mail.gmail.com>
References: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com>
 <CACsJy8BJw3+=vSHzfBYigoK6ejt-DNHJPTcOWS3Nv=zxpF1f7g@mail.gmail.com> <CAFozjshu92OZbqWzcDZKN4v26Fb-7K=uJRYs4L41csrxfnSTUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Diego_Lago_Gonz=C3=A1lez?= 
	<diego.lago.gonzalez@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 10:05:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WY9zh-0000ft-RJ
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 10:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965505AbaDJIFr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2014 04:05:47 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:42867 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965448AbaDJIFh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2014 04:05:37 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so3511515qaq.24
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=K2P1Q7fBA39UfLbgigRrTVr2rQfM1qV8BS9dK66XWTE=;
        b=c9rOfDXHlTvoa9t4vOMEP8v7Tg6b3gCPxk1h46WDXt0BfK4SbE5PkK14xd7XVCoBYG
         c9MgMqh42RfK5BbQZ+NOfuwbqqG8ZDpX431YGNofutm4yXI4zOICzkEDWvDwpYJNR7HC
         A+Qcoq1+bQ1e5Db69dZCpWOhEHQPxuuGgd67pwrRzdXgR2k7i96Mp4JBivwhtsKF4Zsm
         C0x6qFUc7qJOFoe35OwmtaQ/ym82iboFnT7VbLk8PSQ1inFtSlIt4JuIpzz+5JIzBNqG
         wp86SgDLd8niOkY2kzjj7LiGA1sZ0d4JM8fqVYZpiJAyJBoPWpUK7GCJ1n9jflCOsXuZ
         PwkA==
X-Received: by 10.140.107.229 with SMTP id h92mr17560034qgf.30.1397117136540;
 Thu, 10 Apr 2014 01:05:36 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Thu, 10 Apr 2014 01:05:06 -0700 (PDT)
In-Reply-To: <CAFozjshu92OZbqWzcDZKN4v26Fb-7K=uJRYs4L41csrxfnSTUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246012>

On Thu, Apr 10, 2014 at 1:27 PM, Diego Lago Gonz=C3=A1lez
<diego.lago.gonzalez@gmail.com> wrote:
> Writing this data into the message, the user is forced to write it in=
 the
> correct format (I think is better to write key=3Dvalue pairs as an op=
tion
> instead of writing as message lines with spaces in key, between key a=
nd
> equal sign and value, and other mistakes). And is simpler to parse th=
ese
> attributes than the message itself.

the interpret-trailers series Christian Couder is cooking in 'pu'
should handle this.

> And, what if the log message is seen from the command line instead of=
 our CI
> front-end? Why the CLI user (for example) should see information that=
 does
> not need or does not want to see?

which is why git-log (and all other porcelain commands) should learn
to hide the value part (but not the key part).
--=20
Duy
