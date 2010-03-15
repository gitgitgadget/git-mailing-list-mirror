From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH 3/4] convert: Inhibit contraction of foreign $Id$ during
 stats.
Date: Mon, 15 Mar 2010 19:32:06 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1003151923290.1164@shipon.roxen.com>
References: <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
  <cover.1268664693.git.grubba@grubba.org> 
 <cff48594f97960444a3cd642dafd7fd4905e6891.1268664693.git.grubba@grubba.org>
  <baa3d958d4885348d3d5a4c30305fce0f026d85c.1268664693.git.grubba@grubba.org>
 <36ca99e91003150842q6a39a48dl2e88254fd636556d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-326116574-1268677926=:1164"
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 19:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrF5L-00029s-KV
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 19:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001Ab0COScL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 14:32:11 -0400
Received: from mail.roxen.com ([212.247.29.220]:36165 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab0COScJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 14:32:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 061226281B1;
	Mon, 15 Mar 2010 19:32:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hqs8QhztZQii; Mon, 15 Mar 2010 19:32:06 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 45CD462819A;
	Mon, 15 Mar 2010 19:32:06 +0100 (CET)
In-Reply-To: <36ca99e91003150842q6a39a48dl2e88254fd636556d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142241>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-326116574-1268677926=:1164
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 15 Mar 2010, Bert Wesarg wrote:

> 2010/3/15 Henrik Grubbström (Grubba) <grubba@grubba.org>:
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index 3af4ae0..25adef8 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
[...]
>> -               convert_to_git(path, buf->buf, buf->len, buf, 0);
>> +               convert_to_git(path, buf->buf, buf->len, buf, 0, 0);
>
> So this new 0 should be ...
>
[...]
>> @@ -556,6 +556,11 @@ enum safe_crlf {
>>        SAFE_CRLF_WARN = 2,
>>  };
>>
>> +enum ident_mode {
>> +       IDENT_MODE_FALSE = 0,
>
> ... this?

Correct. I followed the style for the preceeding parameter (ie the other 
zero), which maps to enum safe_crlf SAFE_CRLF_FALSE. I agree that using 
the enum constants here instead of the plain zeros could perhaps be more 
readable, but that should be a separate patch.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-326116574-1268677926=:1164--
