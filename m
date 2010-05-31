From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Mac OS 9 (Lamp) port
Date: Mon, 31 May 2010 00:49:48 -0500
Message-ID: <20100531054947.GB3328@progeny.tock>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
 <1274948384-167-2-git-send-email-abcd@gentoo.org>
 <20100527101043.GA4390@progeny.tock>
 <AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
 <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
 <20100530003718.GA27024@progeny.tock>
 <67A778DE-DB7E-40A3-9BE8-4D17F09B847F@gmail.com>
 <20100531031906.GA465@progeny.tock>
 <2776E3E5-234F-4A94-B06A-F4D83D87A414@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 07:49:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIxs8-0000Zu-Fq
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 07:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab0EaFtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 01:49:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47339 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab0EaFtF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 01:49:05 -0400
Received: by iwn6 with SMTP id 6so419987iwn.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/0fE7+SQASsg0tJFg0L4bncAi6OpMIHsNmhehWIdcIc=;
        b=iXnIwRin/BfrJcLXGH0rRLmpkTivpq/TqYwSlQ79QofFRF0cYgNsbTx4b/ofafO6RK
         ZfibsZrNPk4XDLrgvPP3cVlutqCqYb9sy/Es5DQn2HG8hJCJ0ey3KcL+zrDmKgL1eUzD
         iw5pv6u4kO6wa54DnR5g9CJOB1/sGFq9eOIw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nvDrykM3cfJD+DLgPeiTFGpexw9Ilxu/p9Q346RclWoT+dBFmdtsG4/r2Um8G0yUAD
         QHExYNo4D9RlwITrTISS5UQxx4O4SgoSGLIGTYYPPbZuNGJmLmQc7HTZ2X2pQ8HDyy47
         c4fdfrdrii4q2R7Z+8vmW3kUMYb75FWh1aNQM=
Received: by 10.231.148.130 with SMTP id p2mr5200270ibv.11.1275284942799;
        Sun, 30 May 2010 22:49:02 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm24674499ibf.1.2010.05.30.22.49.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 22:49:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2776E3E5-234F-4A94-B06A-F4D83D87A414@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148033>

Joshua Juran wrote:

> diff --git a/server-info.c b/server-info.c
> index 4098ca2..a9a0188 100644
> --- a/server-info.c
> +++ b/server-info.c
> @@ -132,8 +132,8 @@ static int read_pack_info_file(const char *infofile)
> 
>  static int compare_info(const void *a_, const void *b_)
>  {
> -       struct pack_info *const *a = a_;
> -       struct pack_info *const *b = b_;
> +       const struct pack_info *const *a = a_;
> +       const struct pack_info *const *b = b_;
> 
>         if (0 <= (*a)->old_num && 0 <= (*b)->old_num)
>                 /* Keep the order in the original */
> 
> I certainly won't defend Metrowerks C 2.4.1, but the patch is
> harmless enough.

Yes, it is even a good change.

It just emphasized for me that Metrowerks is a little confused
about type qualifiers.

> 	#define alloc_n(type, n)  ((type*)xmalloc(sizeof (type) * n))
> 
> to factor the multiplication out of the calling code.

Maybe, imitating the signature of calloc:

 #define malloc_n(n, type) ((type *)xmalloc((n) * sizeof(type)))

For structs with variable-length arrays at the end:

 #define malloc_plus(type, extra) ((type *)xmalloc(sizeof(type) + (extra)))

That should cover most of the calls in git.

> I just want git to work on Lamp, and if
> there's community interest in C++ compatibility then I can assist
> with that.

There probably is not much direct interest.  But if in the process we
gain a little type-safety and portability, that would be nice. :)

Thanks for your hard work,
Jonathan
