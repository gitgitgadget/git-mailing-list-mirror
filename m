From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Wed, 15 Aug 2007 17:11:02 +0200
Message-ID: <1b46aba20708150811o3a6fa14ew72e925c93d158ec4@mail.gmail.com>
References: <20070814164453.400b9c55@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Wed Aug 15 17:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILKWf-0002CD-EF
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 17:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760346AbXHOPLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 11:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760146AbXHOPLE
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 11:11:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24065 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760346AbXHOPLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 11:11:03 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2539173wah
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 08:11:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d/qJ4RpNGuiKN1K9RhhTirkgOvlktzY+LKHPKycuoO2QupioaXeJqidHizljAilqlHiUat7h++yQ3jeZOZ0Tku50L0Gjd6q+JyoNKPoDp+EWJQxh04euHDpHwmtMkcSlJrtpAZ5TN3bH7Cxh1RU3FhlAlLbsKFd/VBgrpzPTHMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sRI6NAqhOnZnzga5f7ye4GiB+IwX+RGjUHKaJ8oquCfxkzn917mypJ1Gm8Je7DnGcWfctoT8UPiRSaTz/Mo3sy57dW5kNcfkzWN4mP1AUnuWwHC3JlFOCpXaZfuQ4EPFrFcmceD/sbTOMxxDGFX2zDvR17SDdNJf8mfLM6vlMbM=
Received: by 10.114.95.1 with SMTP id s1mr618280wab.1187190662655;
        Wed, 15 Aug 2007 08:11:02 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Wed, 15 Aug 2007 08:11:02 -0700 (PDT)
In-Reply-To: <20070814164453.400b9c55@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55911>

Hi Luiz:

2007/8/14, Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>:
>
> This is a wrapper for mkstemp() that performs error checking and
> calls die() when an error occur.

I think that it is related with the git_mkstemp() function in path.c.
Perhaps we should use xmkstemp inside that function too, since
it is only used in diff.c and after the call it also dies when fd<0.

--Carlos
