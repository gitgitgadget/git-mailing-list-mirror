From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 02/16] refs: add methods for misc ref operations
Date: Fri, 11 Dec 2015 18:49:57 -0500
Organization: Twitter
Message-ID: <1449877797.1678.3.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-3-git-send-email-dturner@twopensource.com>
	 <xmqqr3isd0hj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 00:50:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7XRw-0004ZQ-Rl
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 00:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbbLKXuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 18:50:02 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34846 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbbLKXuA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 18:50:00 -0500
Received: by qgew101 with SMTP id w101so5747962qge.2
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 15:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=kJ7nVhiT5+09zQW8ZKS+Z11UtJW1tctFNP+uUtzuY9s=;
        b=EmcMQ0B4eQQHW4HB8t9mFCTBFPPLnRrFL7e4i1b6+TMru6ruCdm127++Zbpp0wWU+w
         /42ynRNOyeT7tB2cOvITselhaJ3w6q1vpy5xfW6gmy4t5Ue9sNhuGgYHh0LY46dBG0nG
         lM1k4oOAJZbciLQybSSaQxo06U24vN3udbpp7EYZq/ZGfIkH8cuopMhM7Ps+Ad5hsSS7
         NayblqkAT/wKTRSDL4JV6o3mc0aIuDMidlgZfjy3f4ikplEI4+dSY79VI2pF+M8i5VSl
         lQlTjF/V0pCgdhNzaoUAPsY9dOBsWuOoZaB74eve+a7VFEO7oan/cFS3YcQSAJ/o23ng
         X/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=kJ7nVhiT5+09zQW8ZKS+Z11UtJW1tctFNP+uUtzuY9s=;
        b=Ptu5ALKlH2IWeV5tbsJVu2Unq/m96LYuzbiTkcEaU4QLsoJZTOkvDB9bE8iqPCanQo
         mmaNX9KXC7Paj64Sph59AA0ZZGuLG8frW8Tjet5RKW9B8DXckMsy9ZeLAyO/8vJTrEGA
         QbyErbplllZQadl8EAy6r3u3pRJ9nq0PRkslfzFjuk1GbcawDS00R6z5lNKaANRNqv/o
         6o30xfoAQcHrr6G9YJtzpceeM3oxxCQoX9kj18bXYv7i04v5oTUrpJGwbef7PNncqUEJ
         YgieYYnklVzgtz7mb1TIf0R/CgWzak4k/dEKnEh5sugEROuC3Ye/Tm2GRh65HZowCk0f
         YOow==
X-Gm-Message-State: ALoCoQn0wDSIs6zqukk6lXLnciLiXx3GqANXiDZDrYuGbRFIlxUZhSgEAKLfal7tUOWJYfbgWDGNIwib7RTbwGSRE16mWbi9UA==
X-Received: by 10.140.94.201 with SMTP id g67mr27163434qge.43.1449877799981;
        Fri, 11 Dec 2015 15:49:59 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 17sm9097681qhk.42.2015.12.11.15.49.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Dec 2015 15:49:59 -0800 (PST)
In-Reply-To: <xmqqr3isd0hj.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282289>

On Fri, 2015-12-11 at 15:33 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > diff --git a/cache.h b/cache.h
> > index 51c35c3..707455a 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1111,6 +1111,13 @@ extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as s
> >  extern int interpret_branch_name(const char *str, int len, struct strbuf *);
> >  extern int get_sha1_mb(const char *str, unsigned char *sha1);
> >  
> > +/*
> > + * Return true iff abbrev_name is a possible abbreviation for
> > + * full_name according to the rules defined by ref_rev_parse_rules in
> > + * refs.c.
> > + */
> > +extern int refname_match(const char *abbrev_name, const char *full_name);
> > +
> >  extern int validate_headref(const char *ref);
> 
> This hunk is strange.  It duplicates what is in refs.h, risking the
> two copies to drift away from each other over time.
> 
> As the only callsites are in remote.c that includes refs.h, this
> probably should be dropped.

Will fix, thanks.
