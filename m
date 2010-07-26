From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/2] Allow detached forms (--option arg) for git
 log options.
Date: Mon, 26 Jul 2010 14:31:09 -0500
Message-ID: <20100726193109.GA1043@burratino>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 26 21:32:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdTPV-0000Wn-SW
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 21:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab0GZTcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 15:32:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44031 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab0GZTcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 15:32:19 -0400
Received: by pwi5 with SMTP id 5so210882pwi.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8TUorpKGmjnvAkNu5w/GqUaliyUI+IRLehLMm+68j0c=;
        b=l2BzWPAJKSQU+V4UIN4DiKQ5mFoEy1wURvc/71/yMiIliB+C8cjiCwx51ZgdL8u6fk
         b+Y3L0BKRH8UqUky31G10u/OiHSDU1U3nYWYIETc36S+68p3GP1Na9T1EN+9vqNrnBQ8
         zJCX9Ug5mY/htyRd5RUKjsAs6ta9EfrGzFcqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MTvb8VRmlOFo7dKI19Aqwa4TVc5xkhhynFO9+HKvPN2N3hw7AXYtpcqStUg8jAAbdn
         w2Ia4Ad5aKEtPf/P3jB8LmZB7qs6Nn/KwEtRl2Hv6xSYklMF790DRrOD42XEOwP+yHB0
         I2uMDdUzOn4c+LrNdNllyVrgZgaojtQVCPuaM=
Received: by 10.142.172.1 with SMTP id u1mr9192294wfe.322.1280172738252;
        Mon, 26 Jul 2010 12:32:18 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id m11sm957751vcg.30.2010.07.26.12.32.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 12:32:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151886>

Hi Matthieu,

Matthieu Moy wrote:

>                    is there any reason why "git log" hasn't been
> migrated to parse-option? Or is it only that nobody did it yet?

Please go ahead. :)

The difficult piece is that the diff and revision handling options are
shared by a large number of commands.

I think my favorite idea is to provide macros to include the
appropriate entries in option tables[1].  Plus side: very easy for
callers to use.  Downside: bloats the option tables, though I think
that can be worked around.

Junio seemed to suggest that adapting the current multi-pass procedure
might be easier[2].

That said, in the meantime, something like this series (just for -S
it would be a big improvement already) would make sense to me.

Thanks.
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/85354/focus=85391
[2] http://thread.gmane.org/gmane.comp.version-control.git/85354/focus=85362
