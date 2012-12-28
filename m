From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/8] wildmatch: advance faster in <asterisk> + <literal> patterns
Date: Fri, 28 Dec 2012 13:56:56 +0700
Message-ID: <CACsJy8A5PqVpn4SihSdDv6w5xusr1ac4MBETJ0mzvvguZ2YwnQ@mail.gmail.com>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
 <1356163028-29967-9-git-send-email-pclouds@gmail.com> <7vpq1uk82q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 08:07:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToU2V-0006eM-VD
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 08:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab2L1G52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 01:57:28 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:59074 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab2L1G51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 01:57:27 -0500
Received: by mail-oa0-f41.google.com with SMTP id k14so9552527oag.28
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 22:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SQCVxbGwVakh1i8k7pAhlgObOuZyGBcLu6P1PzMz0nY=;
        b=iFVnFnKPkeXnLzXw4WQUcGI/M63r+tjOT+BhnPm7mlfkj2NP+9/7/BNQC6Ln/SbDW5
         zZgjTYybVaLd2+FR9h5MDrgc5Is3lIeJms88HWpljG3bqXIzVjFnxJ0ZN32jc4BtOqAv
         xr/nbGHRndg8NQdhobXBlTAwfgQ9e+8uVk3ubri+hhtpI8OtwIRPOGsxfulP3tPZlsld
         cOpTFsaNQXDNX1pzc7wOFLVJWWKeCx2mPHv1+wL5a2DtifWWM5YMxaQVBwulwyPybsZd
         w2jJXspvIZbn4/RTuk1SSrkGe4JvYdGPZq/So5Z43e+AzmpTTEQCf+TlSoOsNRln1Mbp
         o7vg==
Received: by 10.60.12.74 with SMTP id w10mr15135868oeb.100.1356677846842; Thu,
 27 Dec 2012 22:57:26 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Thu, 27 Dec 2012 22:56:56 -0800 (PST)
In-Reply-To: <7vpq1uk82q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212237>

On Fri, Dec 28, 2012 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +                                     while ((t_ch = *text) != '\0' &&
>> +                                            (!(flags & WM_PATHNAME) || t_ch != '/')) {
>
> Why do we look at (flags & WM_PATHMAME) and not "special" here?

Because I was careless. Thanks for spotting it. I'll fix it and add
some more tests about **<literal> with WM_PATHNAME.
-- 
Duy
