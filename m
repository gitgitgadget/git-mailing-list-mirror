From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Teach git diff-tree --stdin to diff trees
Date: Sat, 09 Aug 2008 13:07:50 -0700
Message-ID: <7viqua54vd.fsf@gitster.siamese.dyndns.org>
References: <20080808204348.7744.46006.stgit@yoghurt>
 <20080808204829.7744.11661.stgit@yoghurt>
 <7vk5erb3ru.fsf@gitster.siamese.dyndns.org>
 <20080809095605.GA10804@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 22:09:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRukF-0004SI-Nl
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 22:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbYHIUH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 16:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbYHIUH5
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 16:07:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbYHIUH4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Aug 2008 16:07:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E801954FCC;
	Sat,  9 Aug 2008 16:07:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4AC1D54FCA; Sat,  9 Aug 2008 16:07:53 -0400 (EDT)
In-Reply-To: <20080809095605.GA10804@diana.vm.bytemark.co.uk> (Karl
 =?utf-8?Q?Hasselstr=C3=B6m's?= message of "Sat, 9 Aug 2008 11:56:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB0A21CE-664E-11DD-80D7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91778>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-08-08 14:22:45 -0700, Junio C Hamano wrote:
> ...
>> But the following two sentences are a bit confusing, especially it
>> is unclear what "This" refers to in the last sentence.
>>
>> > When diffing trees, the -m, -s, -v, --pretty, --abbrev-commit,
>> > --encoding, --no-commit-id, -c, --cc, and --always options are
>> > ignored, since they do not apply to trees. This is the same
>> > behavior you get when specifying two trees on the command line
>> > instead of with --stdin.
>>
>> Perhaps swap the sentences in the log message like this?
>>
>>   When feeding trees on the command line, you can give exactly two
>>   trees, not three nor one; --stdin now supports this "two tree"
>>   form on its input, in addition to accepting lines with one or more
>>   commits.
>>
>>   When diffing trees (either specified on the command line or from
>>   the standard input), the -m, -s, -v, --pretty, --abbrev-commit,
>>   --encoding, --no-commit-id, -c, --cc, and --always options are
>>   ignored, since they do not apply to trees.
>
> Will do. Thanks.

Thinking about it a bit more, -m, -c and --cc are not about commits at
all.  Your excuse not to support them is because these three are about
diffing more than two trees (and I'd say that is still a good rationale=
).
