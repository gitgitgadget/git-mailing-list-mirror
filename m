From: r.ductor@gmail.com
Subject: Re: On the behavior of checkout <branch> with uncommitted local changes
Date: Tue, 24 Sep 2013 11:25:23 +0200
Message-ID: <1753009.aAamh0ufex@ipht-ia-004976>
References: <8904036.vOg3y5OkbU@ipht-ia-004976> <2132571.7BXlKkKRkA@ipht-ia-004976> <xmqq1u4jp0bw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 11:22:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOOpG-0008Ik-PU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 11:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab3IXJWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 05:22:30 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51427 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3IXJW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 05:22:29 -0400
Received: by mail-wi0-f181.google.com with SMTP id ex4so3528251wid.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=9KpYjnbUIP/ge1BVsN/3UZ58JDXzOuraC2FxxZsKsBM=;
        b=xNe3Zv6YyRUeYzW4ejo2E7F6jHehmZwSGF0cB1TM9ZglMU2wA+SbWQ9SCeUEM7cO/8
         IZh7qk0kSEgk8CdrZ/SUVtDSFXCP1OfwVNIiylzvUCnxgyC+m3WcyyurCCQyrE0nRIDP
         HkaRg190q8ajTumCCgpMxOWMAkOxm8fpJozlRgWCw23rSpyjJXiWwA6NMp3se8QnAZc9
         ZiBgEFAYIvOWdmfvYzVJyMxW2IbufHHMysCZOddvc6LS1mTha68T92HZTwqQN+CKtryR
         subY1JDzUavdibAeye5BHg+Ded2in7wiZawBlN9ltrWKcf5tO/9t5qjUaMOA/iZmzVFu
         s0ZA==
X-Received: by 10.181.12.112 with SMTP id ep16mr17370277wid.59.1380014548341;
        Tue, 24 Sep 2013 02:22:28 -0700 (PDT)
Received: from ipht-ia-004976.localnet (ipht-ia-004976.extra.cea.fr. [132.166.22.90])
        by mx.google.com with ESMTPSA id c4sm5597764wiz.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 02:22:27 -0700 (PDT)
User-Agent: KMail/4.10.5 (Linux/3.10-2-amd64; KDE/4.10.5; x86_64; ; )
In-Reply-To: <xmqq1u4jp0bw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235289>

Dear Juno

Thanks for your answer.

My fair criticism in my previous emails (and below) is just to try to convince you that with a few short sentences you risk to transmit only vague ideas, while a serious user is interested to understand the behavior of git in any occurrence, with no ambiguity. Once more, in my view a short pseudo code -- or its equivalent in words -- would be a useful compromise among simplicity and accuracy.

I'm attacking git checkout but I guess that what I say is a general problem of the git official documentation (i.e git stash in my experience has problems).

Each undocumented feature (simulated by my dumb questions) enforces the loss of a significant percentage of the users.

Lacking details, a hurried user will not use the feature, or if they are brave enough, they will use it without understanding (i.e. risking data loss one day or the other)...

Lacking details, a serious user will have to waste their time in trials or in studing the sources.

Do not fear that giving details in a man page would scare newbyes: as a git newbye I can say that what scares me is the lack of information, not the complexity(=power) of a program (*)

Do not waste your precious time in explaining me/us general ideas, we can find them in the tens of pedagogic tutorials/books out there, please give us those details that nobody out there seems to know and that man (un)intentionally hides!

I would be happy to submit a patch for the man git-checkout but I'm not sure that my understanding of git checkout (as encoded in the pseudocode I submitted) is correct.

My friendly regards,

ric

(*) of course you're allowed to discard my suggestions pretending that I'm not a representative user ;)

On Friday 20 September 2013 15:58:27 Junio C Hamano wrote:
> The principle is that we allow you to check out a different branch
> when you have local changes to the working tree and/or to the index,
> as long as we can make the index and the working tree pretend as if
> you reached that locally modified state, starting from a clean state
> of the branch you are checking out.

Of course I understand the idea, but if I try to grasp the details I'm in trouble: the problem in this statement is the ambiguity of "change" and "pretend as".

In plain english I can start from any content and change it to any other content, so in this semantics your statement is empty, or worse.

If I assume that change means "differences with N lines of unchanged context" I must still guess differences with respect to what? head-index, index-work, head-work ???? ... and how much is N? 3, 4, 1028?

Then, in order to understand I (a user) make the trials below, and concludes that also the nice principle stated above is somewhat incomplete....

git-test15$ echo -e 'a\n1\n2\n3\n4\n5\nb\n6\n7\n8\n9\n10\n'>f; cat f;git init; git add f; git commit -a -m 'ab'; git checkout -b dev; echo -e 'A\n1\n2\n3\n4\n5\nb\n6\n7\n8\n9\n10\n'>f;cat f;git commit -a -m 'Ab'; echo -e 'A\n1\n2\n3\n4\n5\nB\n6\n7\n8\n9\n10\n'>f;cat f;git add f; git checkout master                                                                            
a                                                                                                                                      
1                                                                                                                                      
2                                                                                                                                      
3                                                                                                                                      
4                                                                                                                                      
5                                                                                                                                      
b                                                                                                                                      
6                                                                                                                                      
7                                                                                                                                      
8                                                                                                                                      
9                                                                                                                                      
10                                                                                                                                     
                                                                                                                                       
Initialized empty Git repository in /home/git-test15/.git/                                                                 
[master (root-commit) 46d19ab] ab                                                                                                      
 1 file changed, 13 insertions(+)                                                                                                      
 create mode 100644 f                                                                                                                  
Switched to a new branch 'dev'                                                                                                         
A                                                                                                                                      
1
2
3
4
5
b
6
7
8
9
10

[dev bb852db] Ab
 1 file changed, 1 insertion(+), 1 deletion(-)
A
1
2
3
4
5
B
6
7
8
9
10

error: Your local changes to the following files would be overwritten by checkout:
        f
Please, commit your changes or stash them before you can switch branches.
Aborting

#####################################################################################
#### why abort the change w.r.t. dev was just b -> B and that patch was admissible in master ... I start questioning the principle ####
#####################################################################################

git-test15$ mkdir ../gittest16
git-test15$ cd ../gittest16
gittest16$ echo -e 'a\n1\n2\n3\n4\n5\nb\n6\n7\n8\n9\n10\n'>f; cat f;git init; git add f; git commit -a -m 'ab'; git checkout -b dev; echo -e 'A\n1\n2\n3\n4\n5\nb\n6\n7\n8\n9\n10\n'>f;cat f;git commit -a -m 'Ab'; echo -e 'a\n1\n2\n3\n4\n5\nB\n6\n7\n8\n9\n10\n'>f;cat f;git add f; git checkout master
a
1
2
3
4
5
b
6
7
8
9
10

Initialized empty Git repository in /home/gittest16/.git/
[master (root-commit) 7d7febe] ab
 1 file changed, 13 insertions(+)
 create mode 100644 f
Switched to a new branch 'dev'
A
1
2
3
4
5
b
6
7
8
9
10

[dev 143db1d] Ab
 1 file changed, 1 insertion(+), 1 deletion(-)
a
1
2
3
4
5
B
6
7
8
9
10

error: Your local changes to the following files would be overwritten by checkout:
        f
Please, commit your changes or stash them before you can switch branches.
Aborting
gittest16$

#####################################################################################
#### why abort? the change w.r.t. master was just b -> B and that patch was admissible in master ... I start questioning the principle ####
#####################################################################################
