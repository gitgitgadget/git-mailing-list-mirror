From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 02/16] refs: add methods for misc ref operations
Date: Fri, 11 Dec 2015 18:49:25 -0500
Organization: Twitter
Message-ID: <1449877765.1678.2.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-3-git-send-email-dturner@twopensource.com>
	 <xmqqmvtgd06p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 00:49:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7XRe-0003rP-JR
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 00:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbbLKXta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 18:49:30 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35597 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbbLKXt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 18:49:29 -0500
Received: by qgew101 with SMTP id w101so5740733qge.2
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 15:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=nMmj1DB8WR7omAHufuBjPkyDJKFyQ4hxi4EcTUv0X2c=;
        b=OYE42bya8RXJMJi/s00/TTBnmifd9SgJYCw1ZtnVVw6sTPx+j5W5m+R82YRcwbyruR
         9/OUlFGEprzdFKZNzidqAySCmoEQjGUzHL8bFt7BZvvmUtSXbKrgOoQ3tmUy9Kg5VG+U
         WKoWGNK7K0gOQy5xsx9L19jku6cEe/Bn/nLji9W9Hw444QHSfDdR4oFSK8d+Q4jQlF5c
         CM49q0SbSSNBdgXrAKuC1oiqH915JJ9KvFREooVciNi/J9PxXy1KQO4NLIUw/zy+yCOm
         m8Ud/hZSOPUljAj2/vL03EWeqvg64J8ELZXY6NSSr9LUBRJ+7MU+4Po78w5qPTptfpQG
         OIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=nMmj1DB8WR7omAHufuBjPkyDJKFyQ4hxi4EcTUv0X2c=;
        b=Gb+bSShJTFB35zYVhrSyBhKwc6iALruK1WsqOs1J8jFGdN1h2carCZ485iZIgkl84s
         cc5nmMt/4TqSV0a/8KZKbZWE2rUp8l5I5djrCth6v2nZwqIR9SpP+nGmQTPUWesngGZN
         v/fu1EWFRLyAyOjIe1kGsloxsucK4Iws0TIjySO+zdiW6tw+2RYstJnOTjnKnNuzQPGK
         EPiPeEJ9oHklmQFRsbrvlEqk/L3yBoX1kmsiCVOEbVAsYdo0wMGDMAtNDxON3zFJGrdJ
         vtWB+L/JcBpJDTLFgaMo1fmATiBdHfOsYhiQSI06iRpH5LW7m5XYeshbNK8lzK+ONjxf
         lp1A==
X-Gm-Message-State: ALoCoQmgITrsRG9zdRc0ItAwX81jH5R1KZ9jq3kdJeD0AHKAca9y9berox1P2iLTSa7aKgd1Zi/iGF6j2TO9UjYe7EVOwEYVaA==
X-Received: by 10.140.42.164 with SMTP id c33mr27219895qga.66.1449877768386;
        Fri, 11 Dec 2015 15:49:28 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id w78sm3534169qka.25.2015.12.11.15.49.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Dec 2015 15:49:27 -0800 (PST)
In-Reply-To: <xmqqmvtgd06p.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282288>

On Fri, 2015-12-11 at 15:39 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> >  struct ref_be {
> >  	struct ref_be *next;
> >  	const char *name;
> >  	ref_transaction_commit_fn *transaction_commit;
> > +
> > +	pack_refs_fn *pack_refs;
> > +	peel_ref_fn *peel_ref;
> > +	create_symref_fn *create_symref;
> > +
> > +	resolve_ref_unsafe_fn *resolve_ref_unsafe;
> > +	verify_refname_available_fn *verify_refname_available;
> > +	resolve_gitlink_ref_fn *resolve_gitlink_ref;
> >  };
> 
> This may have been pointed out in the previous reviews by somebody
> else, but I think it is more customary to declare a struct member
> that is a pointer to a customization function without leading '*',
> i.e.
> 
> 	typedef TYPE (*customize_fn)(ARGS);
> 
>         struct vtable {
> 		...
>         	cutomize_fn fn;
> 		...
> 	};
> 
> in our codebase (cf. string_list::cmp, prio_queue::compare).

The previous review was here:
http://permalink.gmane.org/gmane.comp.version-control.git/279062

Michael wrote:
> Hmmm, I thought our convention was to define typedefs for functions
> themselves, not for the pointer-to-function; e.g.,
>
>     typedef struct ref_transaction *ref_transaction_begin_fn(struct
> strbuf *err);
>
> (which would require `struct ref_be` to be changed to
>
>         ref_transaction_begin_fn *transaction_begin;

And you agreed.  So I changed it.  Do you want me to change it back?  
