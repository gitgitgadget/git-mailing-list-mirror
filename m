From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 18:12:31 -0700
Message-ID: <7vab4d2ayo.fsf@alter.siamese.dyndns.org>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	<7vprdaarka.fsf@alter.siamese.dyndns.org>
	<ca433830906121613y68e5bdax5778867c41b00339@mail.gmail.com>
	<7vocst3s8n.fsf@alter.siamese.dyndns.org>
	<ca433830906121733w7c88dfd4w1025b7b936e48e95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 03:12:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFHnV-0000o2-IT
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 03:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbZFMBMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 21:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbZFMBMa
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 21:12:30 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:63419 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbZFMBMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 21:12:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090613011232.KQDB2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jun 2009 21:12:32 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3DCY1c0014aMwMQ03DCYpQ; Fri, 12 Jun 2009 21:12:32 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=ZkqYN0c8iNwA:10 a=Z2nhhV3jvI0A:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=NtENlSM7bWwDVAXlarUA:9
 a=LfkEXcsev_VVtS6iGTsA:7 a=k6OIDz5i5B8d3RsHHZ2gU2-B6csA:4 a=MSl-tDqOz04A:10
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <ca433830906121733w7c88dfd4w1025b7b936e48e95@mail.gmail.com> (Mark Lodato's message of "Fri\, 12 Jun 2009 20\:33\:23 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121478>

Mark Lodato <lodatom@gmail.com> writes:

> On Fri, Jun 12, 2009 at 8:14 PM, Junio C Hamano<gitster@pobox.com> wrote:
>> Mark Lodato <lodatom@gmail.com> writes:
>>
>>> If this patch series is accepted, I
>>> will make a cleaner version that includes this change.
>>
>> Sorry, but I do not understand this part of your message.
>
> Sorry about that.  I meant that I have cleaned up the code as you
> suggested (see diff below), and that if you decide to include the
> patch series into git.git (I see now you included it in pu), I can
> either submit an additional patch to perform the cleanup, or submit a
> new "v2" patch series incorporating these changes.  Is one preferred
> over the other?

Ah, I see.

Here is how we do things around here.

Reviewers are usually faster to comment and offer improvement suggestions
than I pick up patches and apply them to my tree (in any branches).  While
a patch is under active discussion with suggestions that make the code
obviously better with simple changes, the submitter is expected to send
new "v$n" (n>=1) patches incorporating suggested improvements.  It often
is simpler and cleaner if such "replacement" patches are sent for anything
that hasn't landed on 'next' (or 'master/maint' for that matter), and I
make sure not to merge something that still has iffiness to 'next' (iow,
keeping it on 'pu') to help this process.

After the initial dust settles and reviewers agree that the patch is in a
good testable state, it lands in 'next', and if there are further
improvements and bugfixes, they are expected to be sent as incremental
patches.  That way, we do not have to record obvious shortcomings that
tend to appear in the initial submission in our history, while keeping the
record of incremental updates on top of what has been judged as "basically
sound" (aka "advances to 'next'").

So in this case, v2 is very much preferred.  There is no point recording
"Mark originally sent a code with #ifdef sprinkled heavily and then later
realized that the code becomes easier to read if #ifdef part is separated
out to only define the constants used in the code" as part of our official
history.

By the way, I forgot to say this even though I noticed you are new:
welcome to git development community.
