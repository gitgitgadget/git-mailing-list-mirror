From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 19/44] refs-be-files.c: add a backend method structure
 with transaction functions
Date: Tue, 13 Oct 2015 23:12:36 +0200
Message-ID: <561D73C4.2040403@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>	 <1444686725-27660-21-git-send-email-dturner@twopensource.com>	 <561CB919.8000801@alum.mit.edu> <1444760911.7234.6.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm6sG-0003QE-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 23:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbbJMVMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 17:12:41 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42086 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752934AbbJMVMj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 17:12:39 -0400
X-AuditID: 12074413-f79bd6d000007ac2-07-561d73c5c0f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id AC.DB.31426.5C37D165; Tue, 13 Oct 2015 17:12:37 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9DLCacU026343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 17:12:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444760911.7234.6.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqHu0WDbM4NpHQ4v5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bm/T51iLvjMUjFz10r2BsYPzF2MHBwSAiYS
	65aydTFyApliEhfurQeyuTiEBC4zShz7vJ4VwjnLJPHoyAYmkCpeAW2JKR3L2UFsFgFVib2X
	VoHF2QR0JRb1NIPZogJBEiuWv2CEqBeUODnzCQuILQLUO/tIDyvIYmYBcYn+f2BhYYEsibk/
	r7PALZ46fwPYRZwC5hJfrj0D28UsoC7xZ94lZghbXmL72znMExgFZiFZMQtJ2SwkZQsYmVcx
	yiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihASq8A7GXSflDjEKcDAq8fC+iJQJ
	E2JNLCuuzD3EKMnBpCTK+7tANkyILyk/pTIjsTgjvqg0J7X4EKMEB7OSCK9RKlCONyWxsiq1
	KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB+7QQqFGwKDU9tSItM6cEIc3EwQky
	nEtKpDg1LyW1KLG0JCMeFKnxxcBYBUnxAO29VASyt7ggMRcoCtF6ilGXY8GP22uZhFjy8vNS
	pcR5FUCKBECKMkrz4FbA0tIrRnGgj4V5j4BU8QBTGtykV0BLmECeY5cCWVKSiJCSamDcmFe7
	fdMGA2mHs4Hxtxw+sV2ZW/5nL+MKhVnTr5mwPbjbsdZ/n2Ra/CJV3pf+U3Yar5FY+ZS7/7HR
	+w9+3ree7D0rWHuEf97dl7+OqK9p8/u+cP3c4MNnLj5sTbbVDZT6Zj1z/lbDLuaQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279522>

On 10/13/2015 08:28 PM, David Turner wrote:
> On Tue, 2015-10-13 at 09:56 +0200, Michael Haggerty wrote:
>> On 10/12/2015 11:51 PM, David Turner wrote:
>>> [...]
>>> +extern struct ref_be refs_be_files;
>>
>> I don't think that refs_be_files is needed in the public interface.
> 
> We use refs_be_lmdb in a few other places to set up the lmdb backend, so
> I thought I would put refs_be_files in refs.h too.  But I can remove
> refs_be_files and just stick it in the places it's needed.

It's OK then. It doesn't hurt to leave it for consistency's sake.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
