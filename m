From: greened@obbligato.org
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Tue, 01 Jan 2013 16:29:33 -0600
Message-ID: <87wqvwfsfm.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-2-git-send-email-greened@obbligato.org>
	<7va9ssa94l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:30:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqALu-0007QY-VM
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab3AAWaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:30:12 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48592 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750716Ab3AAWaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:30:10 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TqASh-0001FG-TR; Tue, 01 Jan 2013 16:37:32 -0600
In-Reply-To: <7va9ssa94l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Jan 2013 13:25:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > "David A. Greene"
    <greened@obbligato.org> writes: > >> Subject: Re: [PATCH 1/8] Use %B for
   Split Subject/Body > > This needs to say "contrib/subtree" somewhere (applies
    to all > patches in this series). [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BOD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212463>

Junio C Hamano <gitster@pobox.com> writes:

> "David A. Greene" <greened@obbligato.org> writes:
>
>> Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
>
> This needs to say "contrib/subtree" somewhere (applies to all
> patches in this series).

Ok.  Shall I re-send everything?

>> From: Techlive Zheng <techlivezheng@gmail.com>
>>
>> Use %B to format the commit message and body to avoid an extra newline
>> if a commit only has a subject line.
>>
>> Author:    Techlive Zheng <techlivezheng@gmail.com>
>
> This needs to be a S-o-b instead; is it a real name, by the way?

Ok.  No idea about the name but his online presence seems consistent at
least.

>> +# Save this hash for testing later.
>> +
>> +subdir_hash=`git rev-parse HEAD`
>> +
>
> We prefer $() over ``; much more readable.

Ack, of course.  I don't know how I missed that.

>>  # 15
>>  test_expect_success 'add main6' '
>>          create main6 &&
>
> Why?

It was in the original testsuite from Avery.  I didn't add or remove any
tests when I first integrated git-subtree.

>> @@ -235,7 +238,19 @@ test_expect_success 'check split with --branch' '
>>          check_equal ''"$(git rev-parse splitbr1)"'' "$spl1"
>
> Is quoting screwed up around here (and in many other places in this
> patch)?  What are these no-op '' doing?

I assumed they are there to get the double-quotes around the command.
I'll see about removing them.

>> -# 25
>> +#25
>
> Why the lossage of a SP?

I think this got fixed later in the series.

> It may make sense to lose these "# num" that will have to be touched
> every time somebody inserts new test pieces in the middle, as a
> preparatory step before any of these patches, by the way.  That will
> reduce noise in the patches for real changes.

Yeah, I know, but it makes it really easy to find a test when something
goes wrong.

                            -David
