From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation: reworded the "Description" section of
 git-bisect.txt.
Date: Thu, 19 Mar 2009 11:12:50 +0100
Message-ID: <49C21AA2.204@drmicha.warpmail.net>
References: <1237446012-4533-1-git-send-email-dmellor@whistlingcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "David J. Mellor" <dmellor@whistlingcat.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:14:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFGt-0003rq-Sa
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbZCSKNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZCSKNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:13:09 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:37562 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751633AbZCSKNI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 06:13:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id ED1622F69F3;
	Thu, 19 Mar 2009 06:13:04 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 19 Mar 2009 06:13:05 -0400
X-Sasl-enc: kBHcXsjn50WhoKx0EjghsPXyfy0BRMpm5LPgWQ0eJo3s 1237457584
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4218A2CCC7;
	Thu, 19 Mar 2009 06:13:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090319 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1237446012-4533-1-git-send-email-dmellor@whistlingcat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113743>

David J. Mellor venit, vidit, dixit 19.03.2009 08:00:
> Added fixes missing from 2364259.
> 
> Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
> ---
>  Documentation/git-bisect.txt |   17 +++++++++--------
>  1 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index 51d06c1..1a4a527 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -114,21 +114,22 @@ $ git bisect view --stat
>  Bisect log and bisect replay
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -The good/bad input is logged, and:
> +After having marked revisions as good or bad, then:
>  
>  ------------
>  $ git bisect log
>  ------------
>  
> -shows what you have done so far. You can truncate its output somewhere
> -and save it in a file, and run:
> +shows what you have done so far. If you discover that you made a mistake
> +in specifying the status of a revision, you can save the output of this
> +command to a file, edit it to remove the incorrect entries, and then issue
> +the following commands to return to a corrected state:
>  

I guess his tells me that I should not have taken the following
(http://article.gmane.org/gmane.comp.version-control.git/113568) literally:

David J. Mellor venit, vidit, dixit 18.03.2009 03:54:
> On 03/17/2009 02:18 AM, Michael J Gruber wrote:
>> One minor reoccurring issue is the following type of construct:
>>
>> ###
>> The good/bad input is logged, and:
>>
>> ------------
>> $ git bisect log
>> ------------
>>
>> shows what you have done so far.
>> ###
>>
>> The first line is not a complete sentence.
>
> I agree. I will send a revised patch (patch 2 in this sequence) that
> corrects this.

Again, I think the patch improves the documentation nicely, I just don't
think that construct is helpful.

>  ------------
> +$ git bisect reset
>  $ git bisect replay that-file
>  ------------
>  
> -if you find later that you made a mistake specifying revisions as good/bad.
> -
>  Avoiding testing a commit
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> @@ -141,7 +142,7 @@ want to find a nearby commit and try that instead.
>  For example:
>  
>  ------------
> -$ git bisect good/bad			# previous round was good/bad.
> +$ git bisect good/bad			# previous round was good or bad.
>  Bisecting: 337 revisions left to test after this
>  $ git bisect visualize			# oops, that is uninteresting.
>  $ git reset --hard HEAD~3		# try 3 revisions before what
> @@ -149,7 +150,7 @@ $ git reset --hard HEAD~3		# try 3 revisions before what
>  ------------
>  
>  Then compile and test the chosen revision. Afterwards the revision
> -is marked as good/bad in the usual manner.
> +is marked as good or bad in the usual manner.
>  
>  Bisect skip
>  ~~~~~~~~~~~~
> @@ -240,7 +241,7 @@ before compiling, run the real test, and afterwards decide if the
>  revision (possibly with the needed patch) passed the test and then
>  rewind the tree to the pristine state.  Finally the script should exit
>  with the status of the real test to let the "git bisect run" command loop
> -to determine the eventual outcome of the bisect session.
> +determine the eventual outcome of the bisect session.
>  
>  EXAMPLES
>  --------
