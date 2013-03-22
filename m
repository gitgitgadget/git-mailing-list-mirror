From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Fri, 22 Mar 2013 07:54:06 -0700
Message-ID: <7vip4j8oz5.fsf@alter.siamese.dyndns.org>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 15:54:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3Mc-0004Xu-Fa
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 15:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933160Ab3CVOyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 10:54:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab3CVOyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 10:54:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C52E0B745;
	Fri, 22 Mar 2013 10:54:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DySRLGYlM3jqdlS4oSDJsaFiSjE=; b=Qbkngs
	11H7zKbvi58XeoKyxTfzclAlvrVVrZkjB6XScJ5v/yj/HmDw455kSwQOqQroTE3L
	e4sYRJYI+e8kBdYMGtM1q324fsnDqPdEDogMVvaB1ezO4+PidYFFpCudPWwR9vwh
	piT1Gr1TA8DwCYeAvMV1K4WP7ilqns8cRCYN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xUUhgKolW9uM6qKwnnQx8njCsOsRKXUs
	jT5UFnvv+KmemK8QP2bHuvs+eeAnDd5khm7k+AGlV0OkbP4SgzAEwWfACdijE2gv
	PZJTT0jZ5/XUfzVyzHoeIa4SlcX682ClCcO9p/MfU44lhVnTCsksg0NAi4xiUQUM
	1X7r5HK/opM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B96C2B744;
	Fri, 22 Mar 2013 10:54:08 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BB2BB742; Fri, 22 Mar 2013
 10:54:08 -0400 (EDT)
In-Reply-To: <1363938756-13722-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 22 Mar 2013 13:22:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59545652-9300-11E2-9343-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218806>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  mk_empty () {
> -	rm -fr testrepo &&
> -	mkdir testrepo &&
> +	repo_name="$1"
> +	test -z "$repo_name" && repo_name=testrepo
> +	rm -fr $repo_name &&
> +	mkdir $repo_name &&

Your quoting is sloppy in this entire patch X-<.
