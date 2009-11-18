From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ls-tree: migrate to parse-options
Date: Wed, 18 Nov 2009 14:19:15 -0800
Message-ID: <7veinvcw7w.fsf@alter.siamese.dyndns.org>
References: <1258173248-31059-1-git-send-email-bebarino@gmail.com>
 <1258173248-31059-3-git-send-email-bebarino@gmail.com>
 <7vpr7hisc7.fsf@alter.siamese.dyndns.org> <4B024A89.2010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 23:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAssI-0005eI-Q0
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 23:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337AbZKRWTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 17:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756151AbZKRWTR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 17:19:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117AbZKRWTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 17:19:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A184E9F971;
	Wed, 18 Nov 2009 17:19:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=9DLD7RH6ownJEg0Q/4bZB8Tn7N8=; b=ieHPNxHKeoPfQ5KbbOI+0tb
	nI+6L7g3DCNi2l7smCDoQna7LljC0UFiEThUg6QbrJnDJY7g2paCwRe5bahFv6P4
	vsjNZ5YYGC5T5wmthRtmTBzkXqY7jT0mFBbLblclmyX58zvyAnZz02gUmzRtLEOj
	CO10JInndhJ27tbCvmU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Z2GactCrHMgY9bxn6VjVXU8g1RI1SaC85q2wniO6nuhcj2m/N
	vYrceGIbYtKyrnVxIV/s+eo1o52gQwGmKaD7gHtRd93TuIMp/FOUOXFotOekJ8+A
	/NRFDv7H3jw24M35CBahpEwa/kVl98p3cdF7Zzb0fYMHfuyHV8AxxfOcSM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F0FD9F96F;
	Wed, 18 Nov 2009 17:19:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8623C9F96D; Wed, 18 Nov 2009
 17:19:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B16CCDA-D490-11DE-BB1D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133203>

Stephen Boyd <bebarino@gmail.com> writes:

> Junio C Hamano wrote:
>>
>> @@ -24,7 +24,7 @@ static int chomp_prefix;
>>  static const char *ls_tree_prefix;
>>   static const  char * const ls_tree_usage[] = {
>> -	"git ls-tree [-d] [-r] [-t] [-l | --long] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]",
>> +	"git ls-tree <options> <tree-ish> [path...]",
>>  	NULL
>>  };
>>  
>
> Is it [<options>] or [<options>...] or <options> or even
> <options>... though?

Output from "git grep -e '<option' -- '*.c'" indicates that it
should be "[<options>]"; thanks for spotting.
