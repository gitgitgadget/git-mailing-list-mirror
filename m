From: Gustavo Narea <gnarea@tech.2degreesnetwork.com>
Subject: Re: Multiple checkouts active for the same repository
Date: Fri, 24 Sep 2010 12:55:11 +0100
Organization: 2degrees Limited
Message-ID: <4C9C919F.3040005@tech.2degreesnetwork.com>
References: <4C9C6F8B.3090806@tech.2degreesnetwork.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 13:55:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz6s7-0004KN-LZ
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 13:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab0IXLzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 07:55:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40845 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab0IXLzP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 07:55:15 -0400
Received: by wwd20 with SMTP id 20so192494wwd.1
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 04:55:14 -0700 (PDT)
Received: by 10.227.37.212 with SMTP id y20mr2726592wbd.101.1285329314057;
        Fri, 24 Sep 2010 04:55:14 -0700 (PDT)
Received: from [192.168.0.69] (mail.2degreesnetwork.com [62.172.190.17])
        by mx.google.com with ESMTPS id v44sm1256027weq.28.2010.09.24.04.55.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 04:55:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9pre) Gecko/20100217 Lightning/1.0b1 Shredder/3.0.3pre
In-Reply-To: <4C9C6F8B.3090806@tech.2degreesnetwork.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156979>

I guess it all comes down to one thing: How can I avoid Git's feature of
making only one branch/checkout active at a time under the same path?

I need to have the branches and their checkouts on different
directories, and it seems like the only way to do it is having one
repository per branch/checkout, which doesn't look like the ideal way of
doing things in Git.

Apart from the situation I describe in the initial email, there's
another limitation in the development environment: Our IDE, Eclipse +
Pydev, assumes each project (i.e., branch/checkout) to be on different
directories and each project should have different settings (e.g., paths
to dependencies, which could be different), but with GIt everything
would be a single project because it's all on the same path.

Thanks in advance.

 - Gustavo.

On 24/09/10 10:29, Gustavo Narea wrote:
> Hello.
> 
> We're currently migrating from another DVCS, which allows us to have
> working copies of each branch in separate directories, so that their
> code can be used simultaneously. However, I haven't found a way to do
> this with Git, at least not an easy way. Can you please help me?
> 
> We are a team of Web developers and testers working on an application.
> There are always a few development branches and a stable branch, and
> testers need all the branches with the very latest code available at all
> times.
> 
> The way we handle it at the moment is very simple because the server
> hosting the remote repository is the same that hosts the deployed
> instances of each branch, so when we push to the remote repository, the
> code for each site is automatically updated.
> 
> We use the following structure:
> /srv/repositories/project/branch1
> /srv/repositories/project/branch2
> /srv/repositories/project/branch3
> 
> Is there any simple way to do this with Git? I can only think of two
> options that involve hooks:
> 
>     * Have a hook that exports each branch to a directory like
>       /srv/repositories/project/branchN
>     * Have one Git repository per branch, so that each repository have a
>       different checkout active. Then the main remote repository will
>       have post-receive hooks that trigger a pull on each individual
> 
> I'm not particularly happy with either way. Is there a better solution?
> 


-- 
Gustavo Narea.
Software Developer.
2degrees, Ltd. <http://dev.2degreesnetwork.com/>.
