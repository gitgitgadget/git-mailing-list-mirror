From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 12:35:48 +0100
Message-ID: <54DC9014.1010200@alum.mit.edu>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com> <20150212092824.GA19626@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: Jeff King <peff@peff.net>, David Glasser <glasser@davidglasser.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:36:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLs40-0006qn-J5
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbbBLLgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:36:03 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50506 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755202AbbBLLgC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:36:02 -0500
X-AuditID: 1207440f-f792a6d000001284-27-54dc9017676d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DB.21.04740.7109CD45; Thu, 12 Feb 2015 06:35:51 -0500 (EST)
Received: from [192.168.69.130] (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBZmfW004005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:35:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <20150212092824.GA19626@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqCs+4U6Iwb3z7BaH5t5jt+i60s1k
	sXDDfDaLHy09zA4sHg0LfjF57Jx1l93jWe8eRo/Pm+QCWKK4bZISS8qCM9Pz9O0SuDP6txcX
	LOGp6Pji1MB4k7OLkZNDQsBE4vLnmcwQtpjEhXvr2UBsIYHLjBJ311Z2MXIB2eeZJG48aAMr
	4hXQlti89QQ7iM0ioCoxp/UxI4jNJqArsainmQnEFhUIkjh0+jELRL2gxMmZT8BsEQF3iRVN
	D8F6mQXMJe7NOgU2U1jASuJxRyszxOIiiStrV4DZnAJ6Eo/uvmCCqFeX+DPvEjOELS/RvHU2
	8wRGgVlIVsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCHB
	zL+DsWu9zCFGAQ5GJR7eFaZ3QoRYE8uKK3MPMUpyMCmJ8nK1AoX4kvJTKjMSizPii0pzUosP
	MUpwMCuJ8Po2AeV4UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8q/qA
	GgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBURpfDIxTkBQP0N7dIO28xQWJuUBR
	iNZTjIpS4rxXQBICIImM0jy4sbAU9YpRHOhLYV7OfqAqHmB6g+t+BTSYCWjwxBm3QQaXJCKk
	pBoYHSJa02fu/p61NTJy7b85sjWrV9g+8ZAru6dlbSGyea6d444lHDsXfD9TJqx8mFGb4dka
	FQ3p5z4emndZmH5/mb5eVFio4e28+hXvm8TeL2++/uNLat36f27ugev+r+NKZHm2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263729>

On 02/12/2015 10:28 AM, Jeff King wrote:
> On Wed, Feb 11, 2015 at 09:21:04AM -0800, David Glasser wrote:
> 
>> (I'm not sure if this should be a flag to --squash or to commit.
>> Maybe `git merge --squash`; `git commit --use-squashed-author`?  Seems
>> like it should be not too hard to implement; SQUASH_MSG is pretty
>> parseable.  Or just a config value.)
> 
> It sounds like "git commit -c" is close to what you want, which will
> pull the author and commit message from a particular commit. But I don't
> think there is a convenient way to name the commit in your case (it is
> likely to be the first commit on the branch you are squash-merging, but
> there isn't a shorthand for that).
> 
> I assume you are already munging in your editor the template provided by
> "git commit" after the squash? What would be really nice, IMHO, is if
> there was a way to set the author during that edit (e.g., by moving one
> of the "Author:" lines to the top of the file). That would cover your
> use case, I think, and would also be useful in general.

If only Git supported options on todo list lines [1], this could be
implemented via a "--use-author" option:

    pick --use-author 1234556 blah
    squash 84392ab etc
    fixup 49106a5 another

Happily, this would work with fixup, too, without forcing the user to go
into the editor. Also, it wouldn't require metadata to be read in-band
from the commit message.

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/255410

-- 
Michael Haggerty
mhagger@alum.mit.edu
