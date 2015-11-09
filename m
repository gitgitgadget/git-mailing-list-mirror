From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 01/11] refs: make is_branch public
Date: Mon, 09 Nov 2015 16:22:55 -0500
Organization: Twitter
Message-ID: <1447104175.20147.0.camel@twopensource.com>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
	 <39e0a2a708fb1a42b69e45bc5c0b17d565d3662e.1447085798.git.mhagger@alum.mit.edu>
	 <5640EBD3.8040505@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 22:23:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvtu3-0006YF-0w
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 22:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbbKIVW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 16:22:58 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35557 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbbKIVW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 16:22:57 -0500
Received: by qgec40 with SMTP id c40so95013290qge.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=rdO2WM8CJ+eURlHvLnMkpPkCbudj8tzAzUjmrOc0FCM=;
        b=BkCi9lFaZrAoSi/1lw/twU9mmlSIo5xSApTEkirPbatB5jDHK6a12yXpwb8/6KctoA
         +oYibJ4nQG1aukwkkh99NVIN6yvmt6CxNZ68XclnN7ms1uS2jZexhZo0e7hLCE8E6j7y
         NWuVj40046jR1zQpmoxQS5vzRr3RuMpRv8UjA785+l6qvgzZ2jR396001hmVkKodWUOq
         T7jyPpndA55EcHGbb9X3sJhWAWxD0Y0QrfvNRJXpZDivcVxGrQftVRQPxBBYzvB+Lpiv
         EQ9gDopkFg949MwYcjjuMrnR0KM6YGi/PwkYasb+YSl/hAz0LIQYeiL0j6f2k2GZq4kO
         m8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=rdO2WM8CJ+eURlHvLnMkpPkCbudj8tzAzUjmrOc0FCM=;
        b=hVPsFyZngvE4TmDkFfE/SGm9CR/nUv7TPN2HNAnTfyjqyfE8bOKt8zDUdPLfifh+xN
         oW+j3kHPs9QfXfMsEXthbKPuKstytOd7jPAStRPFqS/wYaca5pVqDbMbBnT1jqE6geBn
         pIX9u/vdnkyOZ83qL9gKiH+stZ/DQA2E3GXzONkU5jOUZj9mcZmYTvR094SVZpqkc4hS
         a599u0Bz9RfIP6QBJ3ycULH0r1OJDoIVIt7T0HXKbSWZjOCZlLpd1LQlJLy53RKcvd/w
         3YL417RfRaSw6hNResgChtLEoX4wbPxHI3BmLTDhEetzFp9wY1VpE/G2j1GBwEgjMqcW
         EBNw==
X-Gm-Message-State: ALoCoQnUZ2ZgfxkkXVrvcnMqlQTIrsfCuqXFDZqrSKUQ1FQuEsC0dMzhtU5jrzc+8R3WqUJYKzJt
X-Received: by 10.140.34.83 with SMTP id k77mr33542246qgk.23.1447104177081;
        Mon, 09 Nov 2015 13:22:57 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l84sm5690980qki.21.2015.11.09.13.22.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2015 13:22:56 -0800 (PST)
In-Reply-To: <5640EBD3.8040505@ramsayjones.plus.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281082>

On Mon, 2015-11-09 at 18:54 +0000, Ramsay Jones wrote:
> 
> On 09/11/15 17:03, Michael Haggerty wrote:
> > From: David Turner <dturner@twopensource.com>
> > 
> > is_branch was already non-static, but this patch declares it in the
> > header.
> > 
> > Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> > ---
> >  refs.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/refs.h b/refs.h
> > index 6d30c98..39b8edc 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -217,6 +217,8 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
> >   */
> >  int pack_refs(unsigned int flags);
> >  
> > +int is_branch(const char *refname);
> > +
> >  /*
> >   * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
> >   * REF_NODEREF: act on the ref directly, instead of dereferencing
> > 
> 
> I don't understand, is_branch() is already declared in refs.h, see line 67.
> 
> This is true in master, next and pu now appears to have two declarations.

Agreed.  This was necessary at the time I started on this work, but this
patch apparently stuck around past the time it was needed.   Please
drop.
