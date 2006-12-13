X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: svn versus git
Date: Wed, 13 Dec 2006 22:51:15 +0000
Message-ID: <200612132251.17202.andyparkins@gmail.com>
References: <200612132200.41420.andyparkins@gmail.com> <elpun9$qp1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 22:54:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WD3shfR/hIv1T2w7C430CynWshz5rMBpflaXnAb25nkP0G1VjbcwJsmnIqghu7NpdZES7M+tpj9XgaV1rexDqv5/a6MlWehUPvcuCMC04N7qN+gD8DFzGNhrDUURJ/DETxC2El/SZmAKsx/5d2AUFqdlEupPzMOt3zvNO0gWAP0=
User-Agent: KMail/1.9.5
In-Reply-To: <elpun9$qp1$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34246>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuczF-00054c-G2 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751784AbWLMWyB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWLMWyB
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:54:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:63145 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751785AbWLMWx7 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 17:53:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so315795uga for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 14:53:59 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr262525ugh.1166050438703; Wed, 13
 Dec 2006 14:53:58 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id q1sm1563959uge.2006.12.13.14.53.57; Wed, 13 Dec
 2006 14:53:58 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


> You can use extended sha1 syntax, described in git-rev-parse(1) (although
> it would be nice to have relevant parts of documentation repeated in
> git-cat-file(1)), namely
>   git cat-file -p REV:file
> (and you can use "git cat-file -p ::file" to get index/staging area
> version)

Yes; I didn't remember that one.  However, it's still not friendly.

> git-fsck-objects is needed only if something doesn't work when
> it should. "git repack" is safe, "git repack -a -d" is almost safe,
> while "git prune" is not.

Yes - /I/ know that; bear in mind though that this is intended as a comparison 
against subversion for a user who doesn't want to know how it works.  How is 
that sort of user meant to know when they should run each of these commands?  
Git doesn't tell them, it doesn't even give hints.  As you say, "git-prune" 
is not necessarilly safe - how does a new user know that?  It's in the output 
of "git".

> Perhaps git-archive should support "tree" format, i.e. writing
> unversioned copy of a tree to filesystem.

I think git is pretty good in the archive department.  git-archive does 
exactly what it says on the tin, which is exactly what you would want.

> There was discussion about adding thin wrapper around git-update-index
> to specifically mark resolved merge conflicts. The option to pick up
> ours, theirs, ancestor version is another argument for having such command.

I think it's definitely a good idea.  If you introduce git-update-index as a 
command a normal user will type, you've got a lot of explaining to do as to 
what else it does and why it does it.

> It can be done without pipes: "git cat-file -p REV:file".
> You can use aliases to have shorter name for that.

This is the problem though.  I realise that git can technically do an awful 
lot of these things, how many new users are going to stick around when you 
tell them that they have to learn about the config file and aliases before 
they can use the command they want?

> Hmmm... I thought that some progress indicator of download/upload was
> added... guess I was wrong.

You're not wrong, there is a progress indicator, but it's measured 
in "objects" not megabytes.  It's got a percentage as well.  Neither of these 
things is a whole lot of use if I want to know how much data (in megabytes) 
has been transferred, how much is there left to go and how long is it going 
to take.



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
