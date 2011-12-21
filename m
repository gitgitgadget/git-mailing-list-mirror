From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* How to generate pull-request with info of signed tag
Date: Tue, 20 Dec 2011 23:03:57 -0800
Message-ID: <7vzkemh0de.fsf@alter.siamese.dyndns.org>
References: <874nx1korf.fsf@linux.vnet.ibm.com>
 <7vbor8jw0h.fsf@alter.siamese.dyndns.org> <871us3l45o.fsf@linux.vnet.ibm.com>
 <7viplfdlpb.fsf@alter.siamese.dyndns.org> <87iplch79e.fsf@linux.vnet.ibm.com>
 <7vobv4mj4r.fsf@alter.siamese.dyndns.org>
 <7vk45smilc.fsf@alter.siamese.dyndns.org> <87liq6xwr8.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 08:04:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdGDf-0006h4-HR
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 08:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1LUHEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 02:04:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54632 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab1LUHEA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 02:04:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E16DE7F77;
	Wed, 21 Dec 2011 02:03:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y/SlcADGXXV+tTJkbhCaBx/U8OE=; b=o5Ai4N
	xvjgqcxulIWcaYPdPsSJMEkcSott0tUEiNKtXBMEvkNCyV0t+OsbEGDvwFNI5beh
	JwVzhyvdgNKFO7P3eikBdcUyuUdARETgEdAmkpf0bVDfuvUPmSaBzsQ7xrVIB7Hc
	3E/ZkOAJjA5pHk+KM2m5ceHE2ui2dxRm3hB+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yhm7OqPtU4sB0Dq56eFNcCEK+ol3vDc5
	CKPOF+P1IFtYkDQPPBEDbtnVYgbPVITIxzGCPCAY//cpbDnlEvWdjDJ41QOZCvSV
	K8FK5MqFyIQoUxsBL0BLhOhxFQ5gInYdhLzvEDnbavRlwLB97cszQuUalv5bTai7
	zYrgKP35DR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D92B87F76;
	Wed, 21 Dec 2011 02:03:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 697D97F75; Wed, 21 Dec 2011
 02:03:59 -0500 (EST)
In-Reply-To: <87liq6xwr8.fsf@linux.vnet.ibm.com> (Aneesh Kumar K. V.'s
 message of "Wed, 21 Dec 2011 12:00:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4C9EFC4-2BA1-11E1-85B9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187550>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Also can we make .git/config remote stanza to have something like below
>
>
>      fetch = +refs/tags/*:refs/tags/abc/*
>
> so that one can do
>
>    git fetch t-remote tag-name
>
> and that get stored to abc/tag-name 

You can do whatever you want to your own config file without asking anybody.

Having said that, the point of the recent change to allow you to pull this
way (notice the lack of "tag")

    $ git pull $url $signed_tag_name

is so that you do not have to contaminate your own ref namespace with tags
that are used to leave audit trails in the history graph.
