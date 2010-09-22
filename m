From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/37] t6020: Modernize style a bit
Date: Tue, 21 Sep 2010 18:44:20 -0700
Message-ID: <7v7hietuvf.fsf@alter.siamese.dyndns.org>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
 <1284971350-30590-10-git-send-email-newren@gmail.com>
 <4C972839.9050303@viscovery.net>
 <AANLkTin3wXKUJoRtdk4e1KT5Gwo1H1+9H07LU313Ubo1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 03:44:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyEO5-0003I2-P3
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 03:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864Ab0IVBoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 21:44:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab0IVBob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 21:44:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F160D8E53;
	Tue, 21 Sep 2010 21:44:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XX/NkMRegePk0rXnuu4x3EaryAM=; b=bUaHIL
	pHqnxhgLdLTcWQlNAQpnATWBnoR25rJKymacz8QpKn7I8JHJdLH50t8Pfcbfpbom
	GfsWkscSHff9TpwJIQpF5Iv7MkE/GRNFMJCJ5k9jik28no6d/EAuhkvTDVraATFB
	3HodJXPkdYOo+yz+UrqU6KQ6PPwfVkUBJtZ/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnrpTp+AVmVQmdaVGfRGNzilEplKgXmA
	3iRH1wiLmltzAaeyD0tSdf+dqGwE6F1hmE16AXwnwwjPa8B10xlgVffd42UlsbIk
	epLih6tMpNWhnQrfAnn4AFIZO+wyqb9ijDUfdzTqoqHnAmqBhZC2gJ5WXV8H78zT
	pNSHR1ckAEw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A5AAD8E4E;
	Tue, 21 Sep 2010 21:44:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2C5CD8E4D; Tue, 21 Sep
 2010 21:44:22 -0400 (EDT)
In-Reply-To: <AANLkTin3wXKUJoRtdk4e1KT5Gwo1H1+9H07LU313Ubo1@mail.gmail.com>
 (Elijah Newren's message of "Mon\, 20 Sep 2010 10\:03\:25 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EED0BB02-C5EA-11DF-AE63-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156779>

Elijah Newren <newren@gmail.com> writes:

>> The old version requested a particular kind of failure. Are you saying
>> that with modern 'git merge' all non-zero exit codes mean the same kind of
>> failure?
>
> No, I'm saying that I don't think the test meant to try to distinguish
> between exit codes.

The check for status 1 comes from 72d1216 (New test case: merge with
directory/file conflicts, 2005-12-03), and if you read git-merge.sh from
that era, you would notice that at least we do not want to see status 2
(merge wrapper failed in a bad way) from this test.  git-merge was
designed to exit with status 1 when (and only when) the merge request was
reasonable, it did its best effort and left conflict to be resolved in the
working tree.
