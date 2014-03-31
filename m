From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Mar 2014, #07; Fri, 28)
Date: Mon, 31 Mar 2014 22:22:19 +0200
Message-ID: <5339CE7B.2030307@alum.mit.edu>
References: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>	<53360457.1060008@alum.mit.edu> <CAL=YDWnKb7Di3wsw7i1kn0mCGAmqvSY+xQOA5wo2v_EohkHEEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brad King <brad.king@kitware.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 22:22:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUij0-0004X4-3H
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 22:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbaCaUWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 16:22:25 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64245 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751026AbaCaUWX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 16:22:23 -0400
X-AuditID: 1207440e-f79c76d000003e2c-56-5339ce7ede10
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E9.FA.15916.E7EC9335; Mon, 31 Mar 2014 16:22:22 -0400 (EDT)
Received: from [192.168.69.148] (p5B156503.dip0.t-ipconnect.de [91.21.101.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2VKMJu6029073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 31 Mar 2014 16:22:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <CAL=YDWnKb7Di3wsw7i1kn0mCGAmqvSY+xQOA5wo2v_EohkHEEg@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqFt3zjLYoOuhjMXOdRIWXVe6mSwa
	eq8wW/ybUOPA4rFgU6nHx2fL2T0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE749LvdWwFZ7gr
	Lr+fzNLA2MfZxcjBISFgIrGwzaeLkRPIFJO4cG89G4gtJHCZUeLS4oouRi4g+yyTRO/m7Uwg
	CV4BbYnFlz6BFbEIqEpM7vjLAmKzCehKLOppBqsRFQiSOLzhFCtEvaDEyZlPwGpEBDQlbvaf
	BqthFkiX+LH8OjuILSxgL9HfvIoVYtl8RokfJ16ALeAUCJS4cOkrI8Sh4hI9jUEgJrOAusT6
	eUIQY+Qltr+dwzyBUXAWkm2zEKpmIalawMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83
	s0QvNaV0EyMktPl2MLavlznEKMDBqMTDa1FuGSzEmlhWXJl7iFGSg0lJlDf0LFCILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCO/WBUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKY
	rAwHh5IEbx7IUMGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQ7MYXA6MXJMUDtFcZ
	pJ23uCAxFygK0XqK0Zjj1oY1jUwcG7YBSSGWvPy8VClx3v1ngEoFQEozSvPgFsGS2itGcaC/
	hXn/gFTxABMi3LxXQKuYgFa5FZmBrCpJREhJNTDyrheoOvV7QnCl3qoWtn/T6lvV/861f5J6
	dPG0I967pqallu6M9z2fkH73H1tm9YF/GjEfstpEojIfbZjX/Cn//6SjDua74yTV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245522>

On 03/31/2014 07:56 PM, Ronnie Sahlberg wrote:
> I am new to git, so sorry If I overlooked something.
> 
> I think there might be a race in ref_transaction_commit() when
> deleting references.
> 
> 	/* Perform deletes now that updates are safely completed */
> 	for (i = 0; i < n; i++) {
> 		struct ref_update *update = updates[i];
> 
> 		if (update->lock) {
> 			delnames[delnum++] = update->lock->ref_name;
> 			ret |= delete_ref_loose(update->lock, update->type);
> 		}
> 	}
> 
> 	ret |= repack_without_refs(delnames, delnum);
> 	for (i = 0; i < delnum; i++)
> 		unlink_or_warn(git_path("logs/%s", delnames[i]));
> 
> These two blocks should be reordered so that you first delete the
> actual refs first, while holding the lock and then release the lock
> afterward ?

I think what you suggest is what is already being done.  The locks of
references that are being deleted are not released until a few lines
after the code that you quoted:

> 	for (i = 0; i < n; i++)
> 		if (updates[i]->lock)
> 			unlock_ref(updates[i]->lock);

Before the code that you quoted, some locks are released, but only for
references being updated (not those being deleted).

But maybe I misunderstand your critique.

By the way, there *is* a race here, but it is a subtler one involving
the interaction between packed and loose references when references are
deleted.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
