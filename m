From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 16/17] object_array_entry: copy name before storing in name
 field
Date: Mon, 20 May 2013 16:42:38 +0200
Message-ID: <519A365E.6020807@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu> <1368995232-11042-17-git-send-email-mhagger@alum.mit.edu> <CALKQrgeZ3yOogZhumQ6sQ=7B4XoEUDxPNt6Lj7ZAs13oJTOeUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 20 16:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeRIW-0004f3-0x
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 16:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384Ab3ETOmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 10:42:43 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:63969 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755226Ab3ETOmn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 10:42:43 -0400
X-AuditID: 12074414-b7fb86d000000905-13-519a36622f42
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id DC.0E.02309.2663A915; Mon, 20 May 2013 10:42:42 -0400 (EDT)
Received: from [192.168.69.140] (p57A25AF2.dip0.t-ipconnect.de [87.162.90.242])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4KEgcWc005617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 May 2013 10:42:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CALKQrgeZ3yOogZhumQ6sQ=7B4XoEUDxPNt6Lj7ZAs13oJTOeUA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqJtkNivQ4NgNSYuuK91MFg29V5gt
	5t3dxWTxo6WH2YHF49LL72wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xrOtvawF
	uwUrXly8zNjA+I63i5GTQ0LARKJ79y52CFtM4sK99WxdjFwcQgKXGSU+be2Fcs4zSXybvgzI
	4eDgFdCW+HlUE6SBRUBVYuq8JhYQm01AV2JRTzMTiC0qECbxftlUVhCbV0BQ4uTMJ2A1IkD1
	Ox7/YgOxmQXiJWY0fmAFGSksECox77AwxKrDjBLLfv4Gq+cUCJSYfPkoE0gNs4C6xPp5QhCt
	8hLb385hnsAoMAvJhlkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZopea
	UrqJERLKIjsYj5yUO8QowMGoxMO7Q29WoBBrYllxZe4hRkkOJiVR3hZToBBfUn5KZUZicUZ8
	UWlOavEhRgkOZiUR3ujfMwOFeFMSK6tSi/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbBZDU4
	OATWrFt9gVGKJS8/L1VJgvcUyALBotT01Iq0zJwShFImDk6QRVxSIsWpeSmpRYmlJRnxoOiN
	LwbGL0iKB+iGZyDtvMUFiblAUYjWU4zGHJvPT37HyDHjB5AUAtskJc57FqRUAKQ0ozQPbhEs
	ub1iFAeGgTDvU5AqHmBihJv3CmgVE9Cq7ZYg7xaXJCKkpBoYS7cId0mtXB1zYh8Tq/5uey3G
	K9uCk/rCF06bYcnktPdWWROr2Kn0hlsB9a+SXmzXNggTZVcOUUlIyE+4cJply+b/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224958>

On 05/20/2013 12:33 PM, Johan Herland wrote:
> On Sun, May 19, 2013 at 10:27 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> This is the culmination of the last few commits.  Since some callers
>> want to store refnames in the name field of object_array elements, but
>> we don't want those callers to assume that the refnames that they got
>> from for_each_ref() have infinite lifetime, the easiest thing to do is
>> have object_array make a copy of the names before writing them in the
>> entries, and to free the names for entries that are no longer in use.
>> This change fixes the problem, but has some disadvantages:
>>
>> * It requires extra copies to be made of strings that are already
>>   copies, for example when the results of path_name(path, name) are
>>   used as a name in revision.c:add_object().  This might be rare
>>   enough that it can be ignored (though the original result of
>>   path_name() would have to be freed, which this patch doesn't do so
>>   there is a memory leak).
>>
>> * Many callers store the empty string ("") as the name; for example,
>>   most of the entries created during a run of rev-list have "" as
>>   their name.  This means that lots of needless copies of "" are being
>>   made.  I think that the best solution to this problem would be to
>>   store NULL rather than "" for such entries, but I haven't figured
>>   out all of the places where the name is used.
> 
> Use strbufs?
> 
> No allocation (except for the strbuf object itself) is needed for
> empty strings, and string ownership and be transferred to and from it
> to prevent extra copies.

That would cost two extra size_t per object_array_entry.  I have the
feeling that this structure is used often enough that the extra overhead
would be a disadvantage, but I'm not sure.

The obvious alternative would be to teach users to deal with NULL and
either add another constructor alternative that transfers string
ownership or *always* transfer string ownership and change the callers
to call xstrdup() if they don't already own the name string.  I think I
will try that approach first.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
