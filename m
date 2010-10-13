From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5 v2] t7607: use test-lib functions and check
 MERGE_HEAD
Date: Wed, 13 Oct 2010 14:59:40 -0700
Message-ID: <7v62x5iwj7.fsf@alter.siamese.dyndns.org>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-2-git-send-email-drizzd@aon.at>
 <20101010063527.GC23100@burratino> <20101010083543.GA12186@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:00:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69N0-00016s-Oq
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab0JMV7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:59:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0JMV7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:59:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84FEEDEAF4;
	Wed, 13 Oct 2010 17:59:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ijTbDIMCYgy50alutU3pohMe53Q=; b=nuL1iO71PoXOJH38amlpcYv
	+Z+5ZehWn3U4+NrFVxYqv7OXcTGr0MOdzvlXVZ9x3v+Lo6lvKDz8ZiHWQQZI1OU6
	CrnCNVPJWPN0TSkUZhSRqoRw6fu9cX/Dzih00mcTebRU5C7i7LJonNueCAlKNxOn
	7s4WddIVDyiWU13+EBT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=n4Ntz9SfVvJBdSR4ntbTp+spkqiB44l0R+yRjRxrrLptSYre9
	KnBbqLL8xVXpP5YRE+9OEB62Ti59wVtOn1gi8xy2E5ggYrSMOCLV/ICMbgSlfONC
	69JjsaD2AjaF1OfeTdPukEzA0L8NE1WrjCx+K6N/n0b58dBne6NLRxitnQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E35CDEAF3;
	Wed, 13 Oct 2010 17:59:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 723DEDEAF2; Wed, 13 Oct
 2010 17:59:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3120CACA-D715-11DF-BBBE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158990>

Clemens Buchacher <drizzd@aon.at> writes:

>  test_expect_success 'will not overwrite untracked file' '
>  	git reset --hard c1 &&
> -	cat important > c2.c &&
> +	cp important c2.c &&
>  	test_must_fail git merge c2 &&
> +	test_path_is_missing .git/MERGE_HEAD &&
>  	test_cmp important c2.c
>  '
>  
>  test_expect_success 'will not overwrite new file' '
>  	git reset --hard c1 &&
> -	cat important > c2.c &&
> +	cp important c2.c &&

Why?
