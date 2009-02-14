From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] teach the new "@{-1} syntax to "git branch"
Date: Fri, 13 Feb 2009 23:21:19 -0800
Message-ID: <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 08:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYEtC-00051z-K3
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 08:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbZBNHVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 02:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbZBNHVZ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 02:21:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZBNHVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 02:21:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E01572B18C;
	Sat, 14 Feb 2009 02:21:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 12C132B189; Sat,
 14 Feb 2009 02:21:20 -0500 (EST)
In-Reply-To: <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 (Jay Soffian's message of "Sat, 14 Feb 2009 02:11:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15B2E7C2-FA68-11DD-A03A-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109838>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Sat, Feb 14, 2009 at 2:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> This teaches the new "@{-1} syntax to refer to the previous branch to "git
>> branch".  After looking at somebody's faulty patch series on a topic
>> branch too long, if you decide it is not worth merging, you can just say:
>>
>>    $ git checkout master
>>    $ git branch -D @{-1}
>>
>> to get rid of it without having to type the name of the topic you now hate
>> so much for wasting a lot of your time.
>
> I hope I'm not the person who motivated this new syntax. :-)

Don't worry.

The @{-1} syntax was added long before you started getting hyperactive
this round, but it will be in 1.6.2 and has been advertised as "usable
anywhere you can use a branch name", but in reality it is not.

I have been fixing up various places to match the reality with the claim.
I am making "git merge @{-1}" work now.
