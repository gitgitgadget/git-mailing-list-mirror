From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg.sh: Check for read permissions of help files
Date: Sat, 9 Aug 2008 09:35:19 +0200
Message-ID: <36ca99e90808090035r6331a118k5a26486de1acf002@mail.gmail.com>
References: <1218009771-30358-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Bert Wesarg" <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Aug 09 09:36:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRizz-0005bn-KU
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 09:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbYHIHfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 03:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753766AbYHIHfV
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 03:35:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:38932 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbYHIHfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 03:35:20 -0400
Received: by wx-out-0506.google.com with SMTP id h29so644886wxd.4
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Mpt1MkMg9VUzPBjo4qHp9yCkjYV1duJti7QCe3U+0+8=;
        b=I80Y7nNB8oPp8417isMt1A9gPVsXc7yKBAk84U6IB0McgSlEKDxcdXVT2JevM9ZBoa
         9eVAXmz2pRZSKYKl1jZKMuNOj+WP7kTB4c/66quVvoG9DO9HFuFthknjLGsnkKDWsMJz
         Tdx7oULFQHhwjiGNIJyQAcoLzACUQeY1+Kbuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T+wqtW9BjzoXjzpwmJVY0Rksvgnovtt+C+OBD6FIOZSARpvLjR2DpxmEyMG+lAgJWn
         JPm4pDSoH8ETys7mYdEQHaeoRtHwdE+t6JhBr9Ajb2HWcEeRIXs3lJlkKrqsUaVHYg/S
         XSm6kM8wMui8+/3XpxD+4+D8AlzXm2mGxShp4=
Received: by 10.70.34.13 with SMTP id h13mr7254240wxh.81.1218267319163;
        Sat, 09 Aug 2008 00:35:19 -0700 (PDT)
Received: by 10.70.28.18 with HTTP; Sat, 9 Aug 2008 00:35:19 -0700 (PDT)
In-Reply-To: <1218009771-30358-1-git-send-email-bert.wesarg@googlemail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91748>

Petr,

On Wed, Aug 6, 2008 at 10:02, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> -       elif [ -f "@sharedir@/tg-$1.txt" ] ; then
> +       elif [ -f "@sharedir@/tg-$1.txt" -a -r "@sharedir@/tg-$1.txt" ] ; then
I saw your simplified commit for this, but you should know, that '-r'
tests only for read permissions, not for a regular file, so this test
succeed also for a pipe/socket for which do you have read permissions.

Bert

>                cat "@sharedir@/tg-$1.txt"
>        else
>                echo "`basename $0`: no help for $1" 1>&2
> --
> tg: (e311d15..) t/check-read-permissions-of-help-files (depends on: master)
>
