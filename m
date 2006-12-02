X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to the index
Date: Sat, 2 Dec 2006 08:28:57 +0000
Message-ID: <200612020828.57989.alan@chandlerfamily.org.uk>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home> <7vpsb36yem.fsf@assigned-by-dhcp.cox.net> <87veku3i0j.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 08:29:16 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <87veku3i0j.wl%cworth@cworth.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33007>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqQFD-0000eN-2O for gcvg-git@gmane.org; Sat, 02 Dec
 2006 09:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162833AbWLBI3H (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 03:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162834AbWLBI3H
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 03:29:07 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:8400 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1162833AbWLBI3E (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2
 Dec 2006 03:29:04 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GqQF4-0004AH-BL; Sat, 02 Dec 2006 08:29:02 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 06:54, Carl Worth wrote:
...
> The proposal in the current thread of using "add" is an improvement on
> the shortness side, and I am _delighted_ to see documentation
> appearing that is focused on what the user wants to achieve and what
> the user should expect to happen. So, Junio, please go ahead with
> Nico's stuff here. It is an improvement over the current
> situation. (And thanks, Nico, for fighting against having technical
> details getting added to user-oriented documentation).
>
> But I do still think it's a mistake to muddle the concepts of "adding"
> a file and "staging edited content" for a file. In index terms, the
> distinction is between adding a new path (and contents, of course) to
> the index vs. just updating the contents for an existing path.
>
> But it's not the index distinction that's interesting. It's that users
> think of those operations differently. An "add" operation takes a
> files out of the "untracked file" state as reported by git
> status. That's a very different thing conceptually than updating the
> contents of a file that is already being tracked by git. And if the
> user thinks of an operation as being different, the command should
> reflect that. There is a sense in which the user is always right here,
> (since if the tool doesn't do what the user wants, the user just goes
> somewhere else).
>
...
 
> 
> Except it does still leave open the user confusion of:
>
> 	git add file1
> 	git commit
> 	"cool, that works"
>
> 	edit file1
> 	git add file2
> 	git commit
> 	"hmm, why didn't file1 get commited that time?!"
>
> And the only answer we can give to the poor user is:
>
> 	Oh, "git add", (and "git commit" for that matter) don't do
> 	what you think they do. Go read the documentation and try
> 	again.
>
...
> If add really were uniquely about _adding_ files to be tracked,
> (rather than just a short synonym for update-index), and if we tweaked
> the default behavior of git-commit, we could fix these things. And
> all the model and power of git would still exist and be ready to be
> learned by anyone that wants it, (rather than only by those who manage
> to get past snags like these).

There is a conceptual difference between thinking that git-add is about adding 
a file and git-add adding the current state of a files content.  If your 
conceptual model is the first of these - then I can see why you see a problem 
with git-add being used to say a files contents have changed. 

However, if you regard the git-add command is "adding the current content of 
the file to a staging area" , and you say this is an SCM which by definition 
keeps the history of things once its been told about them I don't see why 
there is a need for a different name for the operation the first time and for 
the operation later.

Trying to put myself in the shoes of a newbie - if taught to use add in both 
ways up front - is to ask why git isn't clever enough to notice that I have 
changed the content of something it already knows about rather than having it 
to manually add it again.  

So I am with you that we need to effective teach

git add <filename>   #add content of filename to the SCM
#edit <filename>
git commit -a		#commit current state of all tracked content

first, and then move on to teach selective commiting

The benefit of one name rather than two is that its less to remember



-- 
Alan Chandler
