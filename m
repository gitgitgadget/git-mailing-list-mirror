From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/8] imap-send: change msg_data from storing (char *,
 len) to storing strbuf
Date: Fri, 30 Nov 2012 14:36:47 +0100
Message-ID: <50B8B66F.3090300@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu> <1353841721-16269-7-git-send-email-mhagger@alum.mit.edu> <7vboegp04x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 14:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeQmE-0006U5-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 14:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758227Ab2K3Ngz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 08:36:55 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:57471 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758135Ab2K3Ngy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2012 08:36:54 -0500
X-AuditID: 1207440f-b7f276d0000008b2-62-50b8b67560d1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id FA.3A.02226.576B8B05; Fri, 30 Nov 2012 08:36:53 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAUDanT3005056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 30 Nov 2012 08:36:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vboegp04x.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqFu6bUeAwb6ZBhZdV7qZLBp6rzBb
	9C/vYrO4fHIuo8WPlh5mB1aPL1cbmTw+fIzzeNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M3Y2shVMEa948PQncwPjTKEuRk4OCQETia4LD9khbDGJC/fWs4HYQgKXGSUud9Z1MXIB
	2ceZJGYum84EkuAV0Ja43ryctYuRg4NFQFVi4cJAkDCbgK7Eop5msBJRgQCJxUvOsUOUC0qc
	nPmEBcQWEVCTmNh2iAVkJrPAXEaJ339nMYMkhAWSJD4tP8oIsWw5o0T3od2MIAs4Bcwk9r8P
	A6lhFtCReNf3gBnClpfY/nYO8wRGgVlIdsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJ
	eXmpRbomermZJXqpKaWbGCHhzb+DsWu9zCFGAQ5GJR5ejwXbA4RYE8uKK3MPMUpyMCmJ8mps
	3hEgxJeUn1KZkVicEV9UmpNafIhRgoNZSYT370agHG9KYmVValE+TEqag0VJnFd9ibqfkEB6
	YklqdmpqQWoRTFaGg0NJgnftVqBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCc
	xhcDIxUkxQO0tw+knbe4IDEXKArReorRmGPOzPYnjBwb1gNJIZa8/LxUKXHe6SClAiClGaV5
	cItgie0VozjQ38K8G0GqeIBJEW7eK6BVTECr3izbDrKqJBEhJdXA2H96m39a8NrIFyH/p76c
	KKl14c7VzNqueQx2T4ytmeRljwm7rbDKLt/12XFhgMjJyoibeiv+H+Ooec29QvR4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210925>

On 11/29/2012 10:30 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> struct msg_data stored (char *, len) of the data to be included in a
> 
> That (<type>, <varname>) is a bit funny notation, even though it is
> understandable.

I understand that it is funny, but it seems like the clearest way to
express what is meant in a way that fits in the summary line.  Feel free
to change it if you like.

>> message, kept the character data NUL-terminated, etc., much like a
>> strbuf would do.  So change it to use a struct strbuf.  This makes the
>> code clearer and reduces copying a little bit.
>>
>> A side effect of this change is that the memory for each message is
>> freed after it is used rather than leaked, though that detail is
>> unimportant given that imap-send is a top-level command.
>>
>> --
> 
> ?

If by "?" you are wondering where the memory leak was, it was:

* The while loop in main() called split_msg()

  * split_msg() cleared the msg_data structure using
    memset(msg, 0, sizeof *msg)

  * split_msg() copied the first message out of all_msgs using
    xmemdupz() and stored the result to msg->data

* The msg_data was passed to imap_store_msg().  Its contents were
  copied to cb.data (which will be freed in the imap functions) but
  the original was left unfreed.

* The next time through the loop, split_msg() zeroed the msg_data
  structure again, thus discarding the pointer to the xmemdupz()ed
  memory.

The leak caused more memory than necessary to be allocated (worst case:
nearly the total size of all_msgs).  But (a) all_msgs is already stored
in memory, so the wastage is at most a factor of 2; and (b) this all
happens in main() shortly before program exit erases all sins.

I didn't bother documenting this in the commit message because the patch
changes the code anyway, but feel free to add the above explanation to
the commit message if you think it is useful.

>> For some reason, there is a bunch of infrastructure in this file for
>> dealing with IMAP flags, although there is nothing in the code that
>> actually allows any flags to be set.  If there is no plan to add
>> support for flags in the future, a bunch of code could be ripped out
>> and "struct msg_data" could be completely replaced with strbuf.
> 
> Yeah, after all these years we have kept the unused flags field
> there and nobody needed anything out of it.  I am OK with a removal
> if it is done at the very end of the series.

I don't think the removal of flags needs to be part of the same series.
 I suggest a separate patch series dedicated to deleting *all* the extra
imap infrastructure at once.  That being said, I'm not committing to do
so.  (We could add it to an "straightforward projects for aspiring git
developers" list, if we had such a thing.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
