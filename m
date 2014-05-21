From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 28/44] refs.c: make write_ref_sha1 static
Date: Wed, 21 May 2014 07:46:39 -0700
Message-ID: <CAL=YDWnyrL7L6gQKg87tj25Gh6NDp867HfJX_4j85f5wDRGh6w@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-29-git-send-email-sahlberg@google.com>
	<20140521005134.GY12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 16:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn7n2-0003Az-S5
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 16:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbaEUOql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 10:46:41 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:43923 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaEUOqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 10:46:40 -0400
Received: by mail-vc0-f169.google.com with SMTP id ij19so2675819vcb.0
        for <git@vger.kernel.org>; Wed, 21 May 2014 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vRb1RLbt1jgTG2epM5FiXFrHVhtx0VEe5I9lMs+SQX0=;
        b=Qo+Cmr9he+pGPfwWZfXhS08YbdiGuCFuJv9pLBhSYbZl8ZY3a2mSArL4YMzqSxaHhT
         AtbXbR+UgCsgSJUMICnOzpFzDOgGCYBEDT33B8pJ/jXgrk0oHMxP5BSDazX4lxyphwGP
         1BzJCbC8NpMhgpWlkb5VSAS4mvIcrLYO9XccqaxsFjhwjK6yId1LpvjvCg4o9JIAiC7x
         zeLoRgaRPLlvZmzSO0hyKV6hLLDKBHipg/bweQxsmdwys8wGRtnMwtwLN6H/j6OuvrW1
         9HvBGI/Qlgs3jhCaYiHGPPGIf58aM6IgKpkT1sdo8tiEw+xU7LiS+D+HZTrz5l8mcRdB
         RuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vRb1RLbt1jgTG2epM5FiXFrHVhtx0VEe5I9lMs+SQX0=;
        b=CkhZxpZ1pevfRFm5rZQ5hXBb4wpeBUuIovflLTNq5JvHEcf/QGDISyjwtFevzoMhCF
         FqCuKkUtLCalUBCaLSJTuVt0bp5BjOmeBjo1MaFl4ptDmRqkgwTLJnxJtar6vM4I2Zcz
         obuz/4wV+tb5pNsc/+Gw1rS0MCjAYOEZIqGdrZHE675FSKiV4ja7guzqnzfGuFARCPTa
         6qryut92p3kiHHH335RYXoOrb6GbO4MckEE+3znv6C3GgAA5bYy7WO1C4dpFnozIx/xc
         OvpTj87mEGHTt81cGDrpfNcKhAnEoHVY5kh904qGGG7O1x3oCQQLf6m0gUOsF6LHbMO8
         TyEg==
X-Gm-Message-State: ALoCoQmVDjWDtBbcj+kvFH5/ojkQ1qcAXqEZVogZU1cQhhBI+N+ssnBk1SH7CYcWTDiJLqGRgwcU
X-Received: by 10.52.171.80 with SMTP id as16mr680835vdc.68.1400683599449;
 Wed, 21 May 2014 07:46:39 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 21 May 2014 07:46:39 -0700 (PDT)
In-Reply-To: <20140521005134.GY12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249801>

Thanks!

On Tue, May 20, 2014 at 5:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> No external users call write_ref_sha1 any more so lets declare it static.
>
> Yay!
>
> [...]
>> +++ b/refs.c
>> @@ -251,6 +251,8 @@ struct ref_entry {
> [...]
>>  static void read_loose_refs(const char *dirname, struct ref_dir *dir);
>> +static int write_ref_sha1(struct ref_lock *lock,
>> +                       const unsigned char *sha1, const char *logmsg);
>
> Is this forward declaration needed?
>

No. Removed.
(I could have sworn I had a patch to remove this forward declaration.)

> [...]
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -150,9 +150,6 @@ extern int commit_ref(struct ref_lock *lock);
>>  /** Release any lock taken but not written. **/
>>  extern void unlock_ref(struct ref_lock *lock);
>>
>> -/** Writes sha1 into the ref specified by the lock. **/
>> -extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
>
> (nit) Would be nice to keep the documentation comment.

Moved this comment to refs.c

Please see ref-transactions branch
Thanks!

>
> Thanks,
> Jonathan
