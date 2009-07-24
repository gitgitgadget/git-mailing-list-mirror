From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] After renaming a section, print any trailing
 variable definitions
Date: Fri, 24 Jul 2009 16:39:28 -0700
Message-ID: <7v1vo5647j.fsf@alter.siamese.dyndns.org>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net>
 <1248470504-16326-2-git-send-email-alex@chmrr.net>
 <1248470504-16326-3-git-send-email-alex@chmrr.net>
 <20090725071105.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Vandiver <alex@chmrr.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 01:39:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUUMc-0007el-2V
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 01:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbZGXXjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 19:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755222AbZGXXjh
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 19:39:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220AbZGXXjh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 19:39:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C62E108E3;
	Fri, 24 Jul 2009 19:39:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E753108E0; Fri, 24 Jul 2009
 19:39:30 -0400 (EDT)
In-Reply-To: <20090725071105.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat\, 25 Jul 2009 07\:11\:05 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FB89A28-78AB-11DE-B7B4-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123978>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Alex Vandiver <alex@chmrr.net>
>
>> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
>> index 43ea283..8c43dcd 100755
>> --- a/t/t1300-repo-config.sh
>> +++ b/t/t1300-repo-config.sh
>> @@ -460,6 +460,28 @@ EOF
>>  test_expect_success "rename succeeded" "test_cmp expect .git/config"
>>  
>>  cat >> .git/config << EOF
>> +[branch "vier"] z = 1
>> +EOF
>
> Isn't this a syntax error?
>
> Documentation/config.txt says this.

Even if it were, I think it would be nice to allow it.  I'll have to
re-read Alex's patch, but I thought it was sane.  Perhaps we can update
the documentation, mildly hinting that it is allowed without encouraging
it too strongly, as I think it is a good style to have these on separate
lines.

Dscho?  Have any suggestions/comments on the patch?
