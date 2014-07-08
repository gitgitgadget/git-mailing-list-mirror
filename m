From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 41/48] refs.c: pass the ref log message to _create/delete/update
 instead of _commit
Date: Tue, 08 Jul 2014 16:39:47 +0200
Message-ID: <53BC02B3.5000808@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-42-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 16:46:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4WfY-0006ph-5X
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 16:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbaGHOqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 10:46:51 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57569 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752859AbaGHOqv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 10:46:51 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jul 2014 10:46:51 EDT
X-AuditID: 12074411-f79d86d000006a97-ad-53bc02b564df
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 86.D8.27287.5B20CB35; Tue,  8 Jul 2014 10:39:49 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68EdlQ3003828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 10:39:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-42-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLuVaU+wwfzz7BZdV7qZLP5NqHFg
	8liwqdTj8ya5AKYobpukxJKy4Mz0PH27BO6Mx6daGQs2iVVM3vOerYHxkGAXIyeHhICJxNuv
	H5ggbDGJC/fWs3UxcnEICVxmlDj99gEThHOeSeL4nhZGkCpeAW2JM8ufMoPYLAKqEt1vprOC
	2GwCuhKLeprBJokKBEnM/jyPHaJeUOLkzCcsILaIgJ3E+lsLwXqFBXIlpizaDBYXEqiROP92
	M9BmDg5OAVeJfxPyQUwJAXGJnsYgkApmAR2Jd30PmCFseYntb+cwT2AUmIVkwSwkZbOQlC1g
	ZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERKigjsYZ5yUO8QowMGoxMO7
	4uCuYCHWxLLiytxDjJIcTEqivH/+7w4W4kvKT6nMSCzOiC8qzUktPsQowcGsJML75RRQjjcl
	sbIqtSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwasBjEUhwaLU9NSKtMycEoQ0
	EwcnyHAuKZHi1LyU1KLE0pKMeFCcxhcDIxUkxQO0VxOknbe4IDEXKArReopRl+PUnWNtTEIs
	efl5qVLivEsZgYoEQIoySvPgVsAS0itGcaCPhXnNQEbxAJMZ3KRXQEuYgJZ8fr8DZElJIkJK
	qoFxZbXVVM4fCb2l0XzT7nXluN1tyuxv33Tx2V+1GYWbZyiXxwdOPtV+9TfDTN/cl3s1Y7IE
	fetc/3t6bNxesV3icVGw4wSN1JTrd9jvRT1xWz99Y8iMHYf+NzSs3h7l36v8pu+9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253027>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Change the reference transactions so that we pass the reflog message
> through to the create/delete/update function instead of the commit message.
> This allows for individual messages for each change in a multi ref
> transaction.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
> [...]
> diff --git a/refs.h b/refs.h
> index 3b321c2..f24b2c1 100644
> --- a/refs.h
> +++ b/refs.h

Would you please document the msg parameter in the block comment that
precedes these three declarations?  Especially important is the fact
that the functions make internal copies of msg, so the caller retains
ownership of its copy.  You might also mention what happens if msg is
NULL (which, as far as I can see, is that a reflog entry is created
anyway (except in the case of a delete) but that the entry doesn't
contain an explanation).

> @@ -297,7 +297,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const unsigned char *new_sha1,
>  			   const unsigned char *old_sha1,
> -			   int flags, int have_old,
> +			   int flags, int have_old, const char *msg,
>  			   struct strbuf *err);
>  
>  /*
> @@ -312,7 +312,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  int ref_transaction_create(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const unsigned char *new_sha1,
> -			   int flags,
> +			   int flags, const char *msg,
>  			   struct strbuf *err);

It is noteworthy that ref_transaction_delete() accepts a msg parameter,
even though we currently delete a reference's entire reflog when the
reference is deleted.  I prefer to think of this as a shortcoming of the
current reference backend, from which future backends hopefully will not
suffer.  So I like this design choice.

However, I think it is worth noting this dichotomy in the commit message
and perhaps also in the function documentation.

>  /*
> @@ -326,7 +326,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
>  int ref_transaction_delete(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const unsigned char *old_sha1,
> -			   int flags, int have_old,
> +			   int flags, int have_old, const char *msg,
>  			   struct strbuf *err);
>  
>  /*
> @@ -335,7 +335,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>   * problem.
>   */
>  int ref_transaction_commit(struct ref_transaction *transaction,
> -			   const char *msg, struct strbuf *err);
> +			   struct strbuf *err);
>  
>  /*
>   * Free an existing transaction and all associated data.
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
