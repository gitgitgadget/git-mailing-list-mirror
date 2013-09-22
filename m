From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] build: add default configuration
Date: Sun, 22 Sep 2013 00:34:17 -0500
Message-ID: <523e815966074_547c41e7c16566@nysa.mail>
References: <1379764036-3782-1-git-send-email-felipe.contreras@gmail.com>
 <523DEC3F.9080807@kdbg.org>
 <CAMP44s34=HW=C5Fex6xabyQ=Zv4pg7p8RddMEOSVZqudgUkQ_A@mail.gmail.com>
 <46ebee31-2b4f-48c1-952c-99364aeede98@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Sep 22 07:41:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNcQ5-0000IQ-5B
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 07:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab3IVFlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 01:41:02 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48764 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab3IVFlB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 01:41:01 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so2431666obc.32
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 22:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=cfVv4gez+2c9BShr1FW3jILKqRNK5u0saWn3Igga3s4=;
        b=WWLMsSNYriGveEaUhIB5ic3zbVug93DXDJDeMRFpr3+8XqbCVQhZJFo9qTZxXMFv32
         HG9wTcbKgccFHYcY7NBT9OYN2xdh4Ji2EwyMjWSeXfN0HPqWHXQf2F0o+8Hi0AgSu6ks
         bN4gvacchLNUQ9MLxbknA4Ah2cerIOQnu+yuZqKaKL6aCKPugVVKxvN5QNaDRcrjwpEd
         uxu9bb/DUFeOq7uY6xx88TJZRO/leOclnuqmAhJ3QLSe46ZgitIEJSY482muwto7FdPK
         g1yd0+vPJ7F+iFYucxFqrbm18KmFg6pAi29QmifgA+I5G8OhWKJNpxAU7TLzQ0vP8esD
         NC+g==
X-Received: by 10.60.93.67 with SMTP id cs3mr13868905oeb.12.1379828460519;
        Sat, 21 Sep 2013 22:41:00 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm8539206oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 22:40:59 -0700 (PDT)
In-Reply-To: <46ebee31-2b4f-48c1-952c-99364aeede98@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235158>

David Aguilar wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >On Sat, Sep 21, 2013 at 1:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> >> Am 21.09.2013 13:47, schrieb Felipe Contreras:
> >>> diff --git a/Makefile b/Makefile
> >>> index 3588ca1..18081bf 100644
> >>> --- a/Makefile
> >>> +++ b/Makefile
> >>> @@ -1010,7 +1010,7 @@ ifndef sysconfdir
> >>>  ifeq ($(prefix),/usr)
> >>>  sysconfdir = /etc
> >>>  else
> >>> -sysconfdir = etc
> >>> +sysconfdir = $(prefix)/etc
> >>
> >> Not good: There is a reason why this is a relative path. Please dig
> >the
> >> history, it's pretty clear.
> >
> >It's pretty clear it's *not* a relative path.
> >
> >What is relative about 'sysconfdir = /etc'?
> 
> Thanks Johannes. Felipe, the history and this comment from the makefile should shed some light on it:
> 
> # Among the variables below, these:
> #   gitexecdir
> #   template_dir
> #   sysconfdir
> # can be specified as a relative path some/where/else;
> # this is interpreted as relative to $(prefix) and "git" at
> # runtime figures out where they are based on the path to the executable.

They *can* be, but not necessarily so, and in particular sysconfig for probably
99% of the users is not relative, it's /etc.

-- 
Felipe Contreras
