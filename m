From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH] perl shebangs: Use /usr/bin/env, not /usr/bin/perl
Date: Fri, 21 May 2010 17:26:34 +0200
Message-ID: <AANLkTikGS4vjsjTj_hIClT_KEWhH1zaacyKhBM70Qgb6@mail.gmail.com>
References: <1274453455-1941-1-git-send-email-avarab@gmail.com>
	 <1274454086-2312-1-git-send-email-avarab@gmail.com>
	 <A612847CFE53224C91B23E3A5B48BAC74483234EEB@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Fri May 21 17:26:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFU7X-0008M6-F1
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab0EUP0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 11:26:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:45262 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab0EUP0g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 11:26:36 -0400
Received: by fg-out-1718.google.com with SMTP id 22so457286fge.1
        for <git@vger.kernel.org>; Fri, 21 May 2010 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=qDi5+GNbxI6r6yHCdfOj+YrTNHtd7kSJ+ezwMKBb5cU=;
        b=CWK46IHvCozLpPLvV+5gxjCSmiaHFmJyHuEFXl+0CCWCfVlN95OD9/YDoP9tYYBZPr
         oagvUWPpehH2KJ6/ZGQdA1roM8NkkEbNyvFF8wbZwp79PWGX4NM/r23wnCCJFaCj5AwN
         CdgHfn3HYQc5wbZHDmbCraqzS2a8hdTj220C0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=sVXelUzlnhRs9ko1pRPc11Y8Ax4lBGMSIOa922WB161zMTK8TVTXW4rZaiPig6Zqqb
         pwNpZqAcPGhXHy9pU6q3BvfAnMBZmB6EoIoE8APrJ3Yk/AqsCiHEEYBhYi8fQMfQSKR+
         bgZuPb40+nP8/mmfmSnlMgxukFyDSQYZUM8Hk=
Received: by 10.239.165.138 with SMTP id x10mr166574hbd.43.1274455594770; Fri, 
	21 May 2010 08:26:34 -0700 (PDT)
Received: by 10.239.179.197 with HTTP; Fri, 21 May 2010 08:26:34 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483234EEB@xmail3.se.axis.com>
X-Google-Sender-Auth: HW_X92G-nSfPlHs9YlOaDo8nOj0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147467>

On Fri, May 21, 2010 at 17:15, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> This does not work. You cannot give arguments to an application
> started via /usr/bin/env; it will interprete everything after
> /usr/bin/env as the application name and fail with:
>
> /usr/bin/env: perl -w: No such file or directory

Yep. It would have to be changed to
/usr/bin/env perl
and add
BEGIN {$^W = 1;}
to the script.

That been said, I've used /usr/bin/env perl for customer applications
for years and years, without problems.  Things wouldn't have worked
otherwise, because on e.g. IRIX systems the /usr/bin/perl version
would be 5.005 and the /usr/freeware version would be 5.6.1.BUt the
caveat is that you'll need to change -w to the above.

-Tor
