From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Tue, 16 Jul 2013 18:52:48 -0400
Message-ID: <51E5CEC0.4090605@gmail.com>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com> <7vppuja9ip.fsf@alter.siamese.dyndns.org> <51E4AABD.9010701@web.de> <51E4C400.6000009@gmail.com> <CAHkcotjV6BgFP9Z9eeFSU_X2vPiKV=2_D_fnk-jA48d_OCO33Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 00:52:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzE76-000669-KE
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 00:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933782Ab3GPWwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 18:52:53 -0400
Received: from mail-qe0-f43.google.com ([209.85.128.43]:56606 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933479Ab3GPWww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 18:52:52 -0400
Received: by mail-qe0-f43.google.com with SMTP id q19so760759qeb.2
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 15:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=t7TjInWuNkAqlDtPNob2H0X6/L3VORJ5rSv4bdC9Jvo=;
        b=d8CRGLKtBAnR4rIUfeRJE4TnskUYskheRZgVzalMejYipM3tHG8jGC726+5Ym0SQwQ
         XlcWpbQpizH4uBLOJY1rVJTdCv+b+GMNN6bGHHvkOSzdnL6aBb63R+pTlF6edMAMdcsi
         24b9oFpsfwPtP+jIjki5X1xD99f45GgF+bNYEvyv0NKQtuIomOpc6wagmfSebzUKfQxS
         /FZI1gd7PpIyqb0ssb3VyRV57++xBkNZ4OONG7pw1ktxJI+b2Lihap4drUQO6OlLtWrB
         XwW0EOfne/fgjKJhmWxS3Vl37Rvols5nZfZTlCPY9KGJV0xIVpJrW3uwtJsJKbrhqwQZ
         6Qxg==
X-Received: by 10.224.172.72 with SMTP id k8mr6251058qaz.100.1374015171473;
        Tue, 16 Jul 2013 15:52:51 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id t18sm7892188qam.12.2013.07.16.15.52.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 15:52:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <CAHkcotjV6BgFP9Z9eeFSU_X2vPiKV=2_D_fnk-jA48d_OCO33Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230593>

On 07/16/2013 11:42 AM, Dmitry Potapov wrote:
> On Tue, Jul 16, 2013 at 7:54 AM, Mark Levedahl <mlevedahl@gmail.com> wrote:
>> I see no difference in the above. (Yes, I checked multiple times that I was
>> using different executables).
> Are you sure that you set core.filemode to false before testing?
>
>
yes.
