From: Andreas Ericsson <ae@op5.se>
Subject: Re: can't use gitk
Date: Wed, 20 Aug 2008 11:31:28 +0200
Message-ID: <48ABE470.7070002@op5.se>
References: <b8d0e50d0808200145l7ec88fb1p3e551c25f045bed4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Xin Yang <sissia.yangxin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 11:33:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVk3v-0000yE-7L
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 11:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbYHTJbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 05:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbYHTJbc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 05:31:32 -0400
Received: from mail.op5.se ([193.201.96.20]:36551 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbYHTJba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 05:31:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5DC6D1B803DB;
	Wed, 20 Aug 2008 11:35:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKTbRzYK38UJ; Wed, 20 Aug 2008 11:35:27 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.184])
	by mail.op5.se (Postfix) with ESMTP id D2EA71B800B0;
	Wed, 20 Aug 2008 11:35:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <b8d0e50d0808200145l7ec88fb1p3e551c25f045bed4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92974>

Xin Yang wrote:
> Hi Andreas Ericsson,
> 

Hi Sissia. I forwarded your email to the git list (git@vger.kernel.org)
where you can hope someone will have the time and knowledge to help you.
I'm no gitk or TCL expert, so I wouldn't even know where to start.

For future reference though:
When you want help with an opensource tool you should look for its
mailing list before firing off mails to individual contributors. Mostly
all of us work with opensource on our spare time and we, as individuals,
hardly ever have neither time nor inclination to answer questions in
private. When you ask to the mailing list, the question and the answer
gets stored for all the world to see in the mailing list archives, so
that people in the future with the same problems you have can find it
without anyone having to actually spend time on answering it again.

For a more exhaustive read on that topic, see
http://catb.org/~esr/faqs/smart-questions.html. It holds an abundance
of information valuable to those who need answers for free and gratis.


> I got your name from git archives but I still can't sue gitk. I guess
> there are some environment setup issues.
> Could you give me some clues?
> 
> The GIT version I installed is:
> git-1.5.3.2.tar.bz2<http://download.chinaunix.net/download.php?id=25039&ResourceID=3744>
> 
> The error info I got after running gitk is:
> Error in startup script: syntax error in expression "$i >= [llength $argv]
> && $revtreeargs ne {}"
>     while executing
> "if {$i >= [llength $argv] && $revtreeargs ne {}} {
>     # no -- on command line, but some arguments (other than -d)
>     if {[catch {
>         set f [eval exec ..."
>     (file "/apps/mds_lrt/git/bin/gitk" line 7912)
> 
> Here is code beginning from line 7912:
> if {$i >= [llength $argv] && $revtreeargs ne {}} {
>     # no -- on command line, but some arguments (other than -d)
>     if {[catch {
>         set f [eval exec git rev-parse --no-revs --no-flags $revtreeargs]
>         set cmdline_files [split $f "\n"]
>         set n [llength $cmdline_files]
>         set revtreeargs [lrange $revtreeargs 0 end-$n]
>         # Unfortunately git rev-parse doesn't produce an error when
>         # something is both a revision and a filename.  To be consistent
>         # with git log and git rev-list, check revtreeargs for filenames.
>         foreach arg $revtreeargs {
>             if {[file exists $arg]} {
>                 show_error {} . "Ambiguous argument '$arg': both revision\
>                                  and filename"
>                 exit 1
>             }
>         }
>     } err]} {
>         # unfortunately we get both stdout and stderr in $err,
>         # so look for "fatal:".
>         set i [string first "fatal:" $err]
>         if {$i > 0} {
>             set err [string range $err [expr {$i + 6}] end]
>         }
>         show_error {} . "Bad arguments to gitk:\n$err"
>         exit 1
>     }
> }
> 
> 
> 
> 
> I am looking forward to your reply. :) Thanks a lot.
> 
> Sissia
> 


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
