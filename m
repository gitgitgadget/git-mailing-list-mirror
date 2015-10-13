From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 02/44] refs: make repack_without_refs and is_branch
 public
Date: Tue, 13 Oct 2015 09:23:52 +0200
Message-ID: <561CB188.2090508@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-3-git-send-email-dturner@twopensource.com> <561C6EE8.3000301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 09:24:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZltwH-0001au-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 09:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbJMHX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 03:23:56 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42427 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751779AbbJMHXz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 03:23:55 -0400
X-AuditID: 1207440e-f79516d0000012b3-71-561cb18ac03d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.4B.04787.A81BC165; Tue, 13 Oct 2015 03:23:54 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D7Nr3Y016810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 03:23:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <561C6EE8.3000301@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqNu1USbMoHG6qcX8TScYLbqudDNZ
	/JtQ48DssWBTqceC5/fZPT5vkgtgjuK2SUosKQvOTM/Tt0vgzni1tp+t4CdXxe69N1gbGFdx
	dDFyckgImEhcv36EFcIWk7hwbz1bFyMXh5DAZUaJJR1T2CGcs0wSz/dtYAOp4hXQltj06x4j
	iM0ioCrRMWUfM4jNJqArsainmQnEFhUIklix/AUjRL2gxMmZT1hAbBEBB4nLu46C1TMLaEps
	2vACbLOwQLDEymmzmCCWLWWU+NH/FizBKaAjcWnjGqgGPYkd13+xQtjyEs1bZzNPYBSYhWTH
	LCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokRErx8Oxjb18sc
	YhTgYFTi4X0RKRMmxJpYVlyZe4hRkoNJSZT39AagEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
	pBagHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgncHyFDBotT01Iq0
	zJwShDQTByfIcC4pkeLUvJTUosTSkox4ULTGFwPjFSTFA7RXB6Sdt7ggMRcoCtF6ilFRSpzX
	GCQhAJLIKM2DGwtLSa8YxYG+FOY1B6niAaYzuO5XQIOZgAYbsUuBDC5JREhJNTCGzHJbkcy8
	c0p8l68sT/m5lGPTvS5oBn34PTt81bb1h8I3GJ5v3ebJrviB8SMjOytHrX5DVJPOmZc5M0sn
	fPsnZHQ6yvavGF/VmweTQswVW9VcUz0qLCc39nzg8M0527yh1+i2rWK0R0b1YxYD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279483>

On 10/13/2015 04:39 AM, Michael Haggerty wrote:
> On 10/12/2015 11:51 PM, David Turner wrote:
>> is_branch was already non-static, but this patch declares it in the
>> header.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> ---
>> [...]
> 
> It seems odd that repack_without_refs() should be made public (and
> ultimately end up in refs.h) given that it intrinsically only has to do
> with file-based references. But I will read on...

I think the reason you needed to do this was because you wanted to move
delete_refs() to the common code. It is true that delete_ref() can be
moved to the common code. And most of the code in delete_refs() is just
a loop calling delete_ref(). But delete_refs() also does the very
files-specific optimization of calling repack_without_refs() before the
loop. *That* call shouldn't be in the common code.

So my suggestion is that you write a common_delete_refs() function that
only includes the loop over delete_ref(), and a files_delete_refs()
function that is basically

    {
            result = repack_without_refs(refnames, &err);
            if (result) {
                    ...report error...
                    return result;
            }
            return common_delete_refs(...);
    }

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
