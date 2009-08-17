From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 05/11] Remove va_copy at MSVC because there are va_copy.
Date: Mon, 17 Aug 2009 19:26:19 +0200
Message-ID: <40aa078e0908171026h4a92d249u4e2b560e01696303@mail.gmail.com>
References: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>
	 <4A898B27.3040507@gnu.org>
	 <40aa078e0908171002j4b610fe4j34a4e7d3081a9efa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Johannes.Schindelin@gmx.de
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5yW-0004DH-3M
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410AbZHQR0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757278AbZHQR0T
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:26:19 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:59078 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbZHQR0S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:26:18 -0400
Received: by qyk34 with SMTP id 34so2278515qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hPydvkqIUu/CDAxRg5HNyoukchJZ44KSC8cgsveew/M=;
        b=EccPALpY5oIETJi9r/QsvwCiRE8046LQXwllTQKhVmk4XA5wG4uDPY6JBg5EzuBVLC
         uCZ7gEp2C262HCOBONF+Hs2rHFQbjzejYxS62l+2Cgk6B1Fh46KmmeF+MTA5Dp4lWrA2
         dUloQaVqlMjVaiKXa5N0vAoUTidhMac7qxIpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UCymPI0r51uXh4LuKHJc0q9ez6MG3qAwTh3K7P2nHPjCqmjwsWLFd7ZK4Ot7vnOdaU
         Zj1SkmSv/qpZR/k/YFyCadH0xzGml12Zqr/GR9L8XrxPl0iNvsYprxEBqiIrlshsxFJf
         zmG3RoSttZx332Gfy5pO7sYL3DHGdwtlrbFt0=
Received: by 10.224.52.170 with SMTP id i42mr4460634qag.285.1250529979300; 
	Mon, 17 Aug 2009 10:26:19 -0700 (PDT)
In-Reply-To: <40aa078e0908171002j4b610fe4j34a4e7d3081a9efa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126241>

On Mon, Aug 17, 2009 at 7:02 PM, Erik Faye-Lund<kusmabite@googlemail.com> wrote:
> Are you sure va_copy is always a preprocessor symbol?

According to the following forum-post we are:
http://www.velocityreviews.com/forums/showpost.php?p=1689162&postcount=2

However, I decided to dig a bit further, so I had a look at the public
draft spec at http://www.open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf,
section 7.15.1:

"The va_start and va_arg macros described in this subclause shall be implemented
as macros, not functions. It is unspecified whether va_copy and va_end
are macros or
identifiers declared with external linkage."

I don't have access (that I know of) to the finalized spec, but it
looks sketchy to me to depend on va_copy being implemented as a macro
given this wording.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
