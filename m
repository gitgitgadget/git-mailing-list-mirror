From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 29/30] create_dir_entry(): allow the flag value to be passed as an argument
Date: Wed, 25 Apr 2012 11:52:12 -0700
Message-ID: <xmqq62cnd4pv.fsf@junio.mtv.corp.google.com>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
	<1335307536-26914-30-git-send-email-mhagger@alum.mit.edu>
	<xmqqfwbrd5ny.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Apr 25 20:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN7K8-0006s8-3Z
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 20:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662Ab2DYSwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 14:52:15 -0400
Received: from mail-we0-f202.google.com ([74.125.82.202]:59812 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757549Ab2DYSwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 14:52:14 -0400
Received: by wejx9 with SMTP id x9so18666wej.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 11:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=sJyl9yfWt7fIXr0DV+bfmn+AuaBiq5L/YJ20c7S/Arc=;
        b=QTTt8Mo0fsrsk9xSj1rEgxcD+uSwsxfX+AJ1sjAB1C+XpNWOVUKJ8uCOS+O+P/sfxL
         hqv0pCK80MHio1gqbPbU1j98/N6pUgkW5ul+qGJQCNm29b3pG91QOZQ1MvyJQqLJ4sE1
         ZpI6pdgskPM/zTOYG9jl1sDbNJ/lY6B7dWiHtnhAMqwWcXfW0l3tkafnvw9vjo5a68Um
         aO+75HJsDP2j0ySpdUgfgea3SCvUzt4wwEsz3eqrjWDYiBMtECefJEbq2csDz5y0XcF0
         ZxrD/+GVr8sHLjY7v92A4/8i1HrLbCtGoWIKHTw0cLh2lFNr/L+o3jG4eAFdch/8tGC7
         srnw==
Received: by 10.14.47.80 with SMTP id s56mr1145373eeb.6.1335379933382;
        Wed, 25 Apr 2012 11:52:13 -0700 (PDT)
Received: by 10.14.47.80 with SMTP id s56mr1145342eeb.6.1335379933234;
        Wed, 25 Apr 2012 11:52:13 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si463012eef.2.2012.04.25.11.52.13
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 11:52:13 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 0AE815C0060;
	Wed, 25 Apr 2012 11:52:13 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 600E1E125C; Wed, 25 Apr 2012 11:52:12 -0700 (PDT)
In-Reply-To: <xmqqfwbrd5ny.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 25 Apr 2012 11:31:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmr2FvD5decG7rcIHOXX+LVGo1vPrTGVJJH7mx3gMoLZodHJKOB7n2sP1yu6CvjUTwssogqn6zEhXBypaBjF3uWp3CFKa+10+46V6hArB+xurYPYK4nUI2YBIhJpnAo1O9XQsWVohfWs8iOwzy/HC2MzzdShzqsn96Gy/JeIyjQXB8PwII=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196330>

Junio C Hamano <gitster@pobox.com> writes:

> mhagger@alum.mit.edu writes:
>
>> diff --git a/refs.c b/refs.c
>> index 4eca965..869c9a7 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -231,18 +231,18 @@ static void clear_ref_dir(struct ref_dir *dir)
>>  }
>>  
>>  /*
>> + * Create a struct ref_entry object for the specified dirname and flag.
>>   * dirname is the name of the directory with a trailing slash (e.g.,
>>   * "refs/heads/") or "" for the top-level directory.
>>   */
>>  static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
>> -					  const char *dirname)
>> +					  const char *dirname, int flag)
>>  {
>>  	struct ref_entry *direntry;
>>  	int len = strlen(dirname);
>>  	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
>>  	memcpy(direntry->name, dirname, len + 1);
>> -	direntry->flag = REF_DIR;
>> +	direntry->flag = flag;
>>  	direntry->u.subdir.ref_cache = ref_cache;
>
> As the returned structure will always represent a subdirectory and not a
> leaf node, i.e. you use u.subdir, I do not think it makes any sense to
> make it responsibility for the caller of this function to include
> REF_DIR in the value of the flag.

Forseeing a response "But but but REF_DIR will become OR of two
variants", my complaint is still valid ;-) and it is the bit assignment
you did in the final patch that is wrong.  If you make REF_DIR (or not)
to differenticate between ref_dir vs ref_value, and use another bit
REF_INCOMPLETE to remember that you still need to find out the actual
value of it, the the above can still be

	create_dir_entry(struct ref_cache *ref_cache, const char *dirname, int lazy)
	{
		...
		direntry->flag = REF_DIR | (lazy ? REF_INCOMPLETE : 0);
                ...
	}

I am OK with the following as well:

	create_dir_entry(struct ref_cache *ref_cache,
        		const char *dirname, unsigned extra)
	{
		...
		direntry->flag = REF_DIR | extra;
	}

The suggested bit assignment would also allow you to create ref_value
leaf nodes, whose presence you know about (by iterating over readdir()
results) but not their values yet (because you haven't opened and read
them), by marking them with REF_INCOMPLETE to be extra lazy in the
future, if necessary.  I do not know if that much laziness buys us a
lot, though ;-).
