From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/3] revisions.txt: structure with a labelled list
Date: Sun, 03 Apr 2011 12:01:35 -0700
Message-ID: <7vvcyvcg6o.fsf@alter.siamese.dyndns.org>
References: <cover.1301569271.git.git@drmicha.warpmail.net>
 <cover.1301649867.git.git@drmicha.warpmail.net>
 <b37095f8802face1fc7920359cf2db3536a5d3a2.1301649867.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:01:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6SYe-0003ID-RT
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab1DCTBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 15:01:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab1DCTBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 15:01:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A95644103;
	Sun,  3 Apr 2011 15:03:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=bxHc8Ch+PDUshwwcsPq17j3J368=; b=g3hFA9XgbiaOv9mcOSuk
	M0jAgafh2fOCnoThBOwhFC1O0m0Y8WOkxu1EPqaY9qocK/ytnC4GOHuVv/idFUYi
	EmEETVFr0Si2A0vMheoe6T1qzvBDL66mVDuz/o/wgJjho+1EfWxIKP4xArvt0aXs
	KaByMNzTUEcU0CKrmDBydPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hdMTnh3so6vXGK34iJpaPrH+QUIrgJrjXY0DO1uxOWsIvH
	Jeto26IQfbc8CKughUDqaN8mmOK7xd30YC1qwjskRhioHl2L7oQo3rbiBt+s2XMk
	WSHRlJQaMf133cv24Xxx60eHPvhuCa2nFsLvRgc7oi23kVf8tEf6HeiDqBUvQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 671004102;
	Sun,  3 Apr 2011 15:03:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2CC5D40FF; Sun,  3 Apr 2011
 15:03:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14982CA8-5E25-11E0-8227-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170769>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> -* The special construct '@\{-<n>\}' means the <n>th branch checked out
> +'@\{-<n>\}', e.g. '@\{-1\}'::
> +  The special construct '@\{-<n>\}' means the <n>th branch checked out
>    before the current one.

This is outside the scope of this patch, but there is nothing _special_
about @{-<n>} at all.  When it appeared it might have been special but not
anymore.  We should reserve the word "special" only for "special" cases.

e.g. this one is perfectly fine:

> +'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
> +  A suffix '{caret}' to a revision parameter means the first parent of
>    that commit object.  '{caret}<n>' means the <n>th parent (i.e.
> +  '<rev>{caret}'
> +  is equivalent to '<rev>{caret}1').  As a special rule,
> +  '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
>    object name of a tag object that refers to a commit object.

A^1, A^2,..., A^$n all all parents of A; A^0 is not a parent of A but we
still accept it as a special rule.
