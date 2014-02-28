From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/11] Use ALLOC_GROW() instead of inline code
Date: Fri, 28 Feb 2014 15:38:48 +0100
Message-ID: <53109F78.2060203@alum.mit.edu>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:46:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOhJ-0007R9-6L
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbaB1Opx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:45:53 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45345 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751586AbaB1Opx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 09:45:53 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2014 09:45:52 EST
X-AuditID: 12074412-f79d46d000002e58-ec-53109f7a8024
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B4.AB.11864.A7F90135; Fri, 28 Feb 2014 09:38:50 -0500 (EST)
Received: from [192.168.69.148] (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1SEcmpS001309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 09:38:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqFs1XyDYoLVD2eLg1tPsFl1Xupkc
	mDw+b5LzONzQzxLAFMVtk5RYUhacmZ6nb5fAnfHt8RLWgq08FQtmzmJpYFzI2cXIySEhYCLx
	9fBZNghbTOLCvfVANheHkMBlRomeuZuZIJxzTBLnL51hB6niFdCWaNtxhQnEZhFQlei5eBCs
	m01AV2JRTzNYXFQgWGL15QcsEPWCEidnPgGzRQTMJZq/zgaaw8HBLCAu0f8PLCws4Cqx4ugk
	sPFCQPa2he1gIzkFNCW2LW1iBCmXACrvaQwCCTML6Ei863vADGHLS2x/O4d5AqPgLCTLZiEp
	m4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkPAV2sG4/qTcIUYB
	DkYlHt4JnvzBQqyJZcWVuYcYJTmYlER5veYJBAvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4X3S
	BJTjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLgXQ0yVLAoNT21Ii0z
	pwQhzcTBCTKcS0qkODUvJbUosbQkIx4Uv/HFwAgGSfEA7Z0M0s5bXJCYCxSFaD3FqMtxu+3X
	J0Yhlrz8vFQpcd55c4GKBECKMkrz4FbAktUrRnGgj4V5V4GM4gEmOrhJr4CWMAEt4fQEW1KS
	iJCSamDcYXntvI1vYM/9VeGVJoefzK0QtO3W+JCkUWs+8yUH3x7V9mPvji1z3FutGTmZwVZo
	QobQtq2i17xfmGZZrhO+Gdzjqjl5TcLRBqXT5mYKPC5t6b+FGKzapNs+f9uidfbm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242971>

On 02/28/2014 10:29 AM, Dmitry S. Dolzhenko wrote:
> Thank you for your remarks. In this patch I tried to take them into account.
> 
> Dmitry S. Dolzhenko (11):
>   builtin/pack-objects.c: change check_pbase_path() to use ALLOC_GROW()
>   bundle.c: change add_to_ref_list() to use ALLOC_GROW()
>   cache-tree.c: change find_subtree() to use ALLOC_GROW()
>   commit.c: change register_commit_graft() to use ALLOC_GROW()
>   diff.c: use ALLOC_GROW() instead of inline code
>   diffcore-rename.c: use ALLOC_GROW() instead of inline code
>   patch-ids.c: change add_commit() to use ALLOC_GROW()
>   replace_object.c: change register_replace_object() to use ALLOC_GROW()
>   reflog-walk.c: use ALLOC_GROW() instead of inline code
>   dir.c: change create_simplify() to use ALLOC_GROW()
>   attr.c: change handle_attr_line() to use ALLOC_GROW()
> 
>  attr.c                 |  7 +------
>  builtin/pack-objects.c |  7 +------
>  bundle.c               |  6 +-----
>  cache-tree.c           |  6 +-----
>  commit.c               |  8 ++------
>  diff.c                 | 12 ++----------
>  diffcore-rename.c      | 12 ++----------
>  dir.c                  |  5 +----
>  patch-ids.c            |  5 +----
>  reflog-walk.c          | 13 +++----------
>  replace_object.c       |  8 ++------
>  11 files changed, 17 insertions(+), 72 deletions(-)

Everything looks fine to me.  Assuming the test suite ran 100%,

Acked-by: Michael Haggerty <mhagger@alum.mit.edu>

Thanks!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
