From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [PATCH] git-p4: chdir now properly sets PWD environment
 variable in msysGit
Date: Fri, 15 Aug 2008 22:44:02 -0700
Message-ID: <7vskt5jyzh.fsf@gitster.siamese.dyndns.org>
References: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
 <7v7iaxu7i1.fsf@gitster.siamese.dyndns.org>
 <bad7471c0808040601y10cceb44idcde5a4a8f415769@mail.gmail.com>
 <bad7471c0808040604p6de570f1k35aa4e76757ca6fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Robert Blum" <rob.blum@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 07:45:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUEbF-0002Le-MN
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 07:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYHPFoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 01:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbYHPFoK
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 01:44:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYHPFoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 01:44:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 047EC5A621;
	Sat, 16 Aug 2008 01:44:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C7AD75A61E; Sat, 16 Aug 2008 01:44:04 -0400 (EDT)
In-Reply-To: <bad7471c0808040604p6de570f1k35aa4e76757ca6fd@mail.gmail.com>
 (Robert Blum's message of "Mon, 4 Aug 2008 06:04:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 581473DE-6B56-11DD-B173-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92533>

"Robert Blum" <rob.blum@gmail.com> writes:

> Forgot reply-all - forwarding to list....
>
>> Missing full stop at the end of sentence aside, this comment makes me
>> wonder if there is an optional way to have it set it, as opposed to the
>> inconvenient way it behaves "by defualt".
>
> Not that I'm aware of. My 'by default' comment refers to a default
> Python installation, i.e. unpatched. As far as I know, the real
> culprit in this is p4. I'd argue it's a bug, since they should be
> using getcwd(), not getpwd(). Moot point - I don't want to wait for
> git-p4 until I have convinced perforce to fix this and a new p4 rolls
> around ;)
>
>>  If there is none, I think your
>> patch, even though it looks ugly, is the least evil approach.
>
> Warms the cockles of my heart ;)
>
>> Another way
>> might be to wrap callsites of system() by introducing a "run_p4" function,
>> like:
>>
>>        def run_p4(arg):
>>                os.environ['PWD'] = os.getcwd() if os.name == 'nt'
>>                return system(arg)
>
> Happy to submit a new patch with that, if that's preferred.
>
>> Thanks.  I've been waiting for an Ack from somewhere or success reports
>> from p4 users on Windows.
>
> Han-Wen seems OK with it. (BTW: Who *is* the maintainer of git-p4?)
> But hold off on applying - I'll resubmit with the run_p4 approach
> today.
>
> (Oh, and of course: Works for me ;)

I have been wondering what happened to this thread afterwards.
