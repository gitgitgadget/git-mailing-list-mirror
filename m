From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 5/5] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 11:08:05 -0700
Message-ID: <xmqq1tgyuyuy.fsf@gitster.dls.corp.google.com>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqk2urwjmq.fsf@gitster.dls.corp.google.com>
	<xmqqfv5fwib3.fsf@gitster.dls.corp.google.com>
	<vpqegkyyj7z.fsf@anie.imag.fr>
	<xmqqtwtuv2jr.fsf@gitster.dls.corp.google.com>
	<vpq8ub6s8hc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 20:08:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Y2v-0005ya-Lo
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 20:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbbFZSIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 14:08:09 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35681 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbFZSIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 14:08:07 -0400
Received: by igblr2 with SMTP id lr2so18422241igb.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=22+qFdZwmfG4L2gzAziGF/KXcZXzljGhd+W7zkc9t70=;
        b=KWWL7cK8NIZ545s/o0FPsMZMdkstdS+AmV9K+j9HUoCuIuGAqUn9FSqXjaBmrrA5YH
         L0QpJJIYc7Pyzs3bcyQR+h/NcH+xC1LHaHd8xX695dSIl5EE7osXVI2r2OWGQu4JUMy4
         DBlKtnuGa1ONGBUrmbASPC2PgS9qMyLvhc0dcrBAPOILiF9Ne6fjv5RhsYw8v4IbpyGD
         Ulluq4g/JOTU1ZdueMs7iSR+gVtStRqD6db3+iGaia+ylgmMtkb2JVa7O6E5AxugDsaa
         ooFJSIT8ppvfwm7RTUcD0l0teexyLOwll4svU1FTkDoca6wLiSScm2JHBSOIdS5Z3kGB
         nANA==
X-Received: by 10.42.166.200 with SMTP id p8mr4558895icy.25.1435342087182;
        Fri, 26 Jun 2015 11:08:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id s28sm20701298ioi.31.2015.06.26.11.08.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 11:08:06 -0700 (PDT)
In-Reply-To: <vpq8ub6s8hc.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	26 Jun 2015 19:08:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272808>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> This is currently how it's implemented. You need to say
>
> $ git bisect terms foo bar
> $ git bisect start

Ahh, it means everything including the description (i.e. "you start
bisection") is consistent and perfectly fine.

I misread the patch, it seems.  Sorry for the noise.

Thanks.

> And indeed "git bisect terms foo bar" errors out. I think the reason it
> is this way is to allow
>
> $ git bisect terms foo bar
> $ git bisect start <sha1> <sha1>
>
> But actually, we can allow "git bisect terms" until BISECT_TERMS is
> created, which is your intuition and makes more sense IMHO. I'll try to
> do that.

I am not sure if it is a good idea, though.  Matching the intuition
of those who (think they) know how it is implemented is much less
important than providing a behaviour that is simple to explain to
casual users.
