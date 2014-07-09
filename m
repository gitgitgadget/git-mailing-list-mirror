From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: [PATCH] refs.c: handle REFNAME_REFSPEC_PATTERN at end of page
Date: Wed, 9 Jul 2014 13:48:35 +0200
Message-ID: <CAA787rn-jD_QpeDOxLU2D+_nV0GjFpXr9NaNpZ2L++1sn_gOag@mail.gmail.com>
References: <CAA787rnMonCuON+C0U5FDXKzjTBdpOusCpGLeWytDWaA1torEw@mail.gmail.com>
	<1404586859-24464-1-git-send-email-dturner@twitter.com>
	<xmqq7g3pdoy7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 13:48:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4qMc-000660-5R
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 13:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbaGILsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 07:48:38 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:54545 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbaGILsh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2014 07:48:37 -0400
Received: by mail-la0-f52.google.com with SMTP id ty20so4908886lab.39
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=BL7ejw6cwHkhlR6tLQn1LHZiZ2rDUODgHYxDOxUCK3s=;
        b=WNA+msMa9x9zHAJ4nh+5FbvW+ty+lkH1R2gOcfUlklFJheGfg063nN88v0Q8ObNrpp
         r5kNv/XhGxT0qfJ54zgGgPDZlu7ZYmGsmc0qcJc1hScki5qv+hG91ZDx+bWwDHgKZVe+
         a8gq7PzplxV/5MDylJeKNRNzsXB0tUiygztsQ4DGosoZcjPO6ePzspulNJpBwAgN61c1
         MUesiIbS5zLAMT+6iYRZhymN628hn+qIsPl6Y41YfUggSusiYHgKoUQaCmLK4AyaIC8J
         zjeyA1Bbfqvc8fFwnp1gXVxz6In2lMbonmqa9e2lZLFmVqcUtlWVYl4kHGKr7XR1vVNq
         SzdQ==
X-Received: by 10.152.179.131 with SMTP id dg3mr32318815lac.21.1404906515914;
 Wed, 09 Jul 2014 04:48:35 -0700 (PDT)
Received: by 10.112.142.7 with HTTP; Wed, 9 Jul 2014 04:48:35 -0700 (PDT)
In-Reply-To: <xmqq7g3pdoy7.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: gJZxCIJLWsVOkGglXg6kOisy1II
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253119>

On 7 July 2014 20:05, Junio C Hamano <gitster@pobox.com> wrote:
> David Turner <dturner@twopensource.com> writes:
> > When a ref crosses a memory page boundary, we restart the parsing a=
t
> > the beginning with the bytewise code.  Pass the original flags to
> > that code, rather than the current flags.
>
> Good.

I've run the whole test suite with this patch applied, and it fixes the
problem on 64-bit Debian 7.5.

> I probably should add:
>     Reported-by: =C3=98yvind A. Holm <sunny@sunbase.org>
>
> before your sign-off.

Thanks. :)

Cheers,
=C3=98yvind
