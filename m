From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Wed, 31 Oct 2012 10:05:27 +0100
Message-ID: <5090E9D7.1010706@gmail.com>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com> <CA+EOSB=Rr8czjVJfA+F6DmHjDUBy0QQ-wd4t-3Uwb1Ksoadr0Q@mail.gmail.com> <20121030070152.GA13324@elie.Belkin> <CA+EOSBmTjwmf+dO-dgU+rGQaVEKDZw7u9ujrh5jYZkPM2zisOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 10:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTUFN-0001kO-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 10:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935238Ab2JaJFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 05:05:41 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49852 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935230Ab2JaJFc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 05:05:32 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so512354bkc.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=xEbIWsKr5BdWZD2ZY63kwBKL8vSvGNetBKuCJr/EKU8=;
        b=KyXjxlJThV3N1slMie01mAboFFEs+rT1HSnQe6bWPGYcAT3quPobM5tu8S4hqTKyYF
         Ak8cYZVATh6TIZwnct6x3/JmO9CICcHg560AJZRZaz12Q8UoVWHHrfSI7xkf8a3DxSj9
         JE7V+yeXT/SuLsc0Nuk9gKtyHjYEwqZjA4GgeNT0aYCnUcp0lOfPS4Fl2Idp8WKz9Eqx
         cjUj7m339oZSfHFTBP86zRVDxvfjg1glI5PF//X0ltVk4/BPkZCnnXpGPVQ0rHuXPDaM
         0GLLyBG9Nc19VguOedoCtot58T/Rh05ux0q3Yt8gI0fTaF2OBEUB2RMmzMeN3xgM6Ay0
         qD4g==
Received: by 10.204.11.133 with SMTP id t5mr11282385bkt.14.1351674331282;
        Wed, 31 Oct 2012 02:05:31 -0700 (PDT)
Received: from [192.168.178.21] (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id g8sm2543924bkv.6.2012.10.31.02.05.29
        (version=SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 02:05:30 -0700 (PDT)
In-Reply-To: <CA+EOSBmTjwmf+dO-dgU+rGQaVEKDZw7u9ujrh5jYZkPM2zisOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208801>

On 10/30/2012 11:17 PM, Elia Pinto wrote:
> Thanks. I know that posix support these usages, but exists some
> traditional shell that not support it.
>
True, but those shells are not POSIX shells -- the major example that
comes to mind is the accursed Solaris /bin/sh.

Since Git assumes a POSIX shell in its scripts and testsuite, use of
any POSIX feature should be fine -- until someone can show a real-world
POSIX shell that (likely due to a bug) fails to grasp such feature, in
which case a "pragmatic" workaround is needed.

Oh, and BTW, there are talks (and mostly consensus) among the Autotools
developers to start requiring a POSIX shell in the configure scripts
and Makefile recipes in the near future:

  <http://lists.gnu.org/archive/html/bug-autoconf/2012-06/msg00009.html>

And also, related:

  <http://lists.gnu.org/archive/html/automake/2012-08/msg00046.html>
  <http://lists.gnu.org/archive/html/coreutils/2012-10/msg00127.html>

>These are described in the
> autoconf manual, last time i have checked. As the construct ; export
> var = x should be portable, but it is not.
>
I don't think POSIX requires that to be portable.

> If this is important these days i don't know.
>
I hope the above helps to clarify the matter a little.

Regards,
  Stefano
