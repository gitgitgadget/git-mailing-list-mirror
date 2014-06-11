From: Maxime Coste <frrrwww@gmail.com>
Subject: Re: [PATCH] Fix git-p4 submit in non --prepare-p4-only mode
Date: Wed, 11 Jun 2014 14:06:58 +0100
Message-ID: <20140611130658.GA29245@nekage>
References: <20140110181807.GA29164@nekage>
 <20140112222946.GA13519@padd.com>
 <20140113121011.GA9711@nekage>
 <20140114000613.GA11594@padd.com>
 <20140524013942.GA29751@nekage>
 <20140524135215.GA9386@padd.com>
 <20140524174034.GA7560@nekage>
 <20140610121446.GA25634@nekage>
 <20140610223958.GA10049@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 15:03:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuiBJ-0001vd-C5
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 15:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbaFKNDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 09:03:04 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:56321 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbaFKNDC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 09:03:02 -0400
Received: by mail-we0-f169.google.com with SMTP id t60so3850819wes.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eWD3ROSm+B+IMll9FVnaSMuyAOfmEasjArmRfX4DwHY=;
        b=hmwN2Hoc77/En3KUig45UozDObGluB4zWSED0gxTnPgRy5f8EhW4sVEwrV8DecKFay
         2XcrpYBNaZdfUt8KRXK3uXQIWO7BHxquv8xxhxHns1b1kdK74Zeq0yU/qDKT7ckfgKJ1
         01WAmPOxhmLM0MpCmg90LRDA9GVkjbCT4ZwpqGB0pDnauAoPXOT+E38+7387aUoWRED1
         Hwu4pSdIvQF9XnVOWLaGflsd52u0OwkLufDttGZ9boSS9bqiju0WCvTwNJSX0u9rBxRs
         2wOa/JCTlwDQ0n5JA1iBmY0GD0HPsOq3e63fe9j5QMpu8Uv6oiXbVRGYkFdnwojNzh0A
         7XXA==
X-Received: by 10.180.84.7 with SMTP id u7mr38695657wiy.31.1402491780320;
        Wed, 11 Jun 2014 06:03:00 -0700 (PDT)
Received: from localhost ([46.7.115.253])
        by mx.google.com with ESMTPSA id u1sm27072162wia.16.2014.06.11.06.02.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jun 2014 06:02:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140610223958.GA10049@padd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251366>

On Tue, Jun 10, 2014 at 06:39:58PM -0400, Pete Wyckoff wrote:
> frrrwww@gmail.com wrote on Tue, 10 Jun 2014 13:14 +0100:
> > b4073bb387ef303c9ac3c044f46d6a8ae6e190f0 broke git p4 submit, here
> > is a proper fix, including proper handling for windows end of lines.
> 
> I guess we don't have test coverage for these cases?  Is this
> something that should get put into a maintenance release, quickly?

We have test cases for that, however we need to create a link to git-p4.py
named git-p4 in order for them to work. I did not run the first patch through
the tests (see my previous email) because of that. Sorry about that.

> The fix looks good.  It's surprising that none of the tests
> managed to add a file and trigger the failure.
> 
> I'll ack this again, as it looks okay, but hope you ran all the
> unit tests successfully on your machine.

It works, only one test fail (detect copy), but this test already fails
with my two patches reverted.

This should be applied soon (or alternatively
b4073bb387ef303c9ac3c044f46d6a8ae6e190f0 should be reverted) in master,
as in the current state git p4 submit will fail most of the time.

I'll send that with your ack to Junio.

Cheers,

Maxime Coste.
