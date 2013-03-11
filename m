From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Rewriting references to existing commits in commit messages with
 filter-branch
Date: Mon, 11 Mar 2013 14:53:44 +0100
Message-ID: <513DE1E8.7010302@alum.mit.edu>
References: <E1UF1Ag-0006m3-5k@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vadim Zeitlin <vz-git@zeitlins.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 14:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF3BD-0003xX-3w
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 14:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab3CKNxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 09:53:50 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:49182 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750921Ab3CKNxs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Mar 2013 09:53:48 -0400
X-AuditID: 12074411-b7f286d0000008e8-dd-513de1ebc2a2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 10.58.02280.BE1ED315; Mon, 11 Mar 2013 09:53:47 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2BDriQO013909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 11 Mar 2013 09:53:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <E1UF1Ag-0006m3-5k@smtp.tt-solutions.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqPv6oW2gwaUp0hZdV7qZLLb1vGJz
	YPL4vEnO4+j8Q0wBTFHcNkmJJWXBmel5+nYJ3BmbJy9nLmhjq9i77wVTA+Mnli5GTg4JAROJ
	TT/uMUPYYhIX7q1nA7GFBC4zSryfadvFyAVkH2eSuHvjHXsXIwcHr4C2xJPbOSA1LAKqEk8f
	bGIHsdkEdCUW9TQzgdiiAmESL5fsAJvDKyAocXLmExaQVhEBdYl7E5lATGYBcYn+f2AXCAvE
	SrScPs0MsdVUYuGZq2A2p4CZRP/5R2ATmQV0JN71PWCGsOUltr+dwzyBUWAWkgWzkJTNQlK2
	gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIiAruYJxxUu4QowAHoxIP
	70Qd20Ah1sSy4srcQ4ySHExKorzi94FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHhXbrIJFOJN
	SaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfD+eQA0VLAoNT21Ii0zpwQh
	zcTBCTKcS0qkODUvJbUosbQkIx4Uo/HFwCgFSfEA7U0GJgIh3uKCxFygKETrKUZdjt3vHr1g
	FGLJy89LlRLnTQcpEgApyijNg1sBS0ivGMWBPhbm1QKp4gEmM7hJr4CWMAEt0XMCea64JBEh
	JdXAqCIv+1PlzMXPGrcMH6d3xJypmFo17f3CeTudlv6wY3CdysktlHN8Uq5QymzuTZLMqkKb
	93rx7vu1qqp9oV1Y7eOXTQv+Bq7bmP4qrldItCM9d7/Js0UXP7ub3N4l9+fqW+W0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217875>

On 03/11/2013 12:45 PM, Vadim Zeitlin wrote:
> [...]
>  The first thing I'd like to do is to replace all references to subversion
> revision numbers in the commit messages with the corresponding git commit
> SHA1s. [...] I have a couple of dozens of errors which happen
> because the file .git-rewrite/map/$commit doesn't exist yet when I'm trying
> to look it up.

The quick and dirty solution would be to rewrite your script such that
if the commit is still unknown to Git, it emits a warning and leaves the
commit message unchanged (i.e., leaves the Subversion revision number
untouched).  Then simply run the filter-branch a few times until it
emits no warnings.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
