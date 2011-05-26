From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Thu, 26 May 2011 11:39:21 -0500
Message-ID: <20110526163921.GD24931@elie>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
 <1306332924-28587-3-git-send-email-mduft@gentoo.org>
 <20110526022045.GA8172@elie>
 <7vhb8hzcm8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mduft@gentoo.org, git@vger.kernel.org,
	Tor Arntsen <tor@spacetec.no>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPdav-0000f3-3r
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778Ab1EZQj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:39:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45510 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627Ab1EZQj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:39:26 -0400
Received: by iyb14 with SMTP id 14so753916iyb.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JQNmEHHHu17KoBQ6qytWOGseW8EffIjgEr1B020oAv4=;
        b=fXYd1WYtXgzbk7PJIcuvO3yz3o++F0hmjyDvboMJCEuoiIQVOajL5oRt3RABAAN/DL
         gLjxOnjR9cHx3+z6Qw+hdw1WE6vXfORv5kR0PZwoR4njLuJyvLxdZN1Sa6B46qeu+XrI
         ANFAvyIplpjulUB4soAXvtmqUd5SObXtd+k40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CMWuTHfoO0siByJN4VvxwP7A0+STAZWmgP6fKGJZAxbh+OucNRrZLYlqRQ/RQa3ePd
         ktHXq2TxFgCKSOpx5kvZ94MvTKzXJBWnGNsQ7IEOCsYVgRHJPe1Km1vPd4Io8EoczEwc
         Vu23xLZtznFBHBU/IYAeWs8x0mSTeS9fx8Pv0=
Received: by 10.42.203.132 with SMTP id fi4mr1858010icb.280.1306427965994;
        Thu, 26 May 2011 09:39:25 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id q15sm287768ibb.14.2011.05.26.09.39.24
        (version=SSLv3 cipher=OTHER);
        Thu, 26 May 2011 09:39:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhb8hzcm8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174546>

Junio C Hamano wrote:

> --- a/compat/fnmatch/fnmatch.c
> +++ b/compat/fnmatch/fnmatch.c
> @@ -127,6 +127,10 @@ extern char *getenv ();
>  extern int errno;
>  # endif
> +
> +# ifndef NULL
> +#  define NULL 0
> +# endif

Makes a lot of sense.  This fits well with the style of the rest of
the file and other projects using glibc fnmatch could reuse the fix
even if targeting ancient platforms.
