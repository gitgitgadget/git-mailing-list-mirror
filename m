From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] update README and #include in git.txt
Date: Fri, 13 May 2005 23:29:24 +0100
Message-ID: <42852A44.7010806@dgreaves.com>
References: <4283CB19.3050208@dgreaves.com> <20050513221306.GB32232@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 00:31:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWigb-0002fJ-OZ
	for gcvg-git@gmane.org; Sat, 14 May 2005 00:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVEMWa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 18:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVEMWa4
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 18:30:56 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:3031 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262600AbVEMW3l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 18:29:41 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 34364E6E39; Fri, 13 May 2005 23:28:08 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07768-20; Fri, 13 May 2005 23:28:08 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.133.155])
	by mail.ukfsn.org (Postfix) with ESMTP
	id B914CE6E2F; Fri, 13 May 2005 23:28:06 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWieq-0006uK-Sm; Fri, 13 May 2005 23:29:24 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513221306.GB32232@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Dear diary, on Thu, May 12, 2005 at 11:31:05PM CEST, I got a letter
>where David Greaves <david@dgreaves.com> told me that...
>  
>
>>Makefile understands the includes git.txt #includes README
>>README reformatted to asciidoc to allow inclusion in git.txt
>>
>>Signed-off-by: David Greaves <david@dgreaves.com>
>>    
>>
>
>Is it just me or this commit message is really weird? :-)
>  
>
I know, I saw it when I pushed send. Somehow a \n became a space... I
blame vi. Should be:

Makefile understands the includes
git.txt #includes README
README reformatted to asciidoc to allow inclusion in git.txt

>  
>
>>Index: README
>>===================================================================
>>--- 3c79088f1832d78012ccdb63e5da1ab88fcf408e/README  (mode:100644)
>>+++ e0e578bb02a7d8db1c105fddf5b5168ad0c79088/README  (mode:100644)
>>@@ -1,9 +1,13 @@
>>+////////////////////////////////////////////////////////////////
>>+	GIT - the stupid content tracker
>>
>>
>>-
>>-	GIT - the stupid content tracker
>>+Note that this README is written in asciidoc format and is #include'd
>>+in the git.txt docs
>>
>>
>>+The rest of this README is #included in the git.txt file
>>+////////////////////////////////////////////////////////////////
>> "git" can mean anything, depending on your mood.
>>
>>  - random three-letter combination that is pronounceable, and not
>>    
>>
>
>I'd probably prefer this being much less prominent. Can it be rather at
>the bottom of the file?
>  
>
If you mean the header in the ///'s?
yes - but I wanted editors to realise it is asciidoc so kept it at the top.
It could also be toned down by using fewer ////s - but that looked a bit
odd.
(the /// /// lines act as comment block markers so asciidoc ignores the
header

Or the "git can mean anything" speech?
That's how it was originally.

>  
>
>>-the object (i.e. how it is used, and how it can refer to other objects).
>>-There are currently three different object types: "blob", "tree" and
>>-"commit".
>>+the object (ie how it is used, and how it can refer to other objects).
>>+There are currently four different object types: "blob", "tree",
>>+"commit" and "tag".
>>    
>>
>
>You're reintroducing the "typos" fixed before, apparently.
>  
>
I didn't notice the i.e. vs ie - I'm not that bothered ;)

>  
>
>> A "blob" object cannot refer to any other object, and is, like the tag
>> implies, a pure storage object containing some user data.  It is used to
>>@@ -48,7 +50,7 @@
>> directory structure. In addition, a tree object can refer to other tree
>> objects, thus creating a directory hierarchy.
>>
>>-Finally, a "commit" object ties such directory hierarchies together into
>>+A "commit" object ties such directory hierarchies together into
>> a DAG of revisions - each "commit" is associated with exactly one tree
>> (the directory hierarchy at the time of the commit). In addition, a
>> "commit" refers to one or more "parent" commit objects that describe the
>>@@ -62,12 +64,17 @@
>> just going to confuse people.  So aim for the notion of "one root object
>> per project", even if git itself does not enforce that.
>>
>>+A "tag" object symbolically identifies and can be used to sign other
>>+objects. It contains the identifier and type of another object, a
>>+symbolic name (of course!) and, optionally, a signature.
>>+
>>    
>>
>
>I think those changes should be either sent as a separate patch or noted
>as being done in the commit message.
>  
>
makes sense.
I'd rather note them in the message if that's OK

>  
>
>>@@ -245,216 +274,209 @@
>>
>>
>>
>>-	The Workflow
>>-
>>-
>>+The Workflow
>>+------------
>>    
>>
>
>
>Cannot at least the newlines be preserved?
>  
>
Yes - I must have been in an anti-whitespace mood.

Will see to this in the am...

David

-- 

