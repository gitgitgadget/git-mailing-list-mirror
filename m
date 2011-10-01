From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Show patch for initial commit
Date: Sat, 01 Oct 2011 13:20:44 -0700
Message-ID: <7vaa9kmpk3.fsf@alter.siamese.dyndns.org>
References: <20110930215021.GA3005@kennedy.acc.umu.se>
 <4E86E343.5070704@in.waw.pl> <20111001184216.GA5796@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew J??drzejewski-Szmek <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Sat Oct 01 22:21:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA63R-00072z-94
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 22:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab1JAUUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 16:20:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab1JAUUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 16:20:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A77926301;
	Sat,  1 Oct 2011 16:20:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w8SBTI7CUKNeLiNZ/bTMxOqSu/Y=; b=BJ5+Am
	j/iLIj2zmgJOMqDuN/s/GtoSVJRADRS9IIxLzcxj64Mjm0JGj6W++KoM6bE9BA54
	Jj+aevbWayqPwLhFbXjiuHKikyEr3P3CRNbUrV2jwzuj+Odw1fUT/IZz3qOWo8Hj
	p1BodGZeZwOd9HSCdirAzKs8ykw1xZ6zEgrNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vcxrdUuxCnWU0XrdRAu9KPeoSFsk0Bkh
	9KbF2EzDD5+QUX8q7iu+0BaU6bg1XAWsOzCeQr0NTotjasdS4uk4J09YAfrGlzc6
	j9sWD8VSEuCGHGxgUfg8JCdT1tiunlI+c8whQtPRbyN4dEzaYlRHFX1SIT3BYqOP
	VcbSL9bjUvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EE9C6300;
	Sat,  1 Oct 2011 16:20:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30BB662FF; Sat,  1 Oct 2011
 16:20:46 -0400 (EDT)
In-Reply-To: <20111001184216.GA5796@kennedy.acc.umu.se> (Marcus Karlsson's
 message of "Sat, 1 Oct 2011 20:42:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D861F532-EC6A-11E0-AD20-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182573>

Marcus Karlsson <mk@acc.umu.se> writes:

>> >diff --git a/gitk-git/gitk b/gitk-git/gitk
>> >index 4cde0c4..20aeae6 100755
>> >--- a/gitk-git/gitk
>> >+++ b/gitk-git/gitk
>> >@@ -7436,7 +7436,7 @@ proc diffcmd {ids flags} {
>> >  	    lappend cmd HEAD
>> >  	}
>> >      } else {
>> >-	set cmd [concat | git diff-tree -r $flags $ids]
>> >+	set cmd [concat | git diff-tree -r --root $flags $ids]
>> >      }
>> >      return $cmd
>> >  }
>> Cool, this works for me! But I think I would be really nice if gitk
>> respected the configuration value of log.showroot. This would give
>> nice consistency amongst the various tools.
>
> I agree, that would be reasonable. I'll prepare a new patch with that
> behavior.

That would be good, but whatever you do please keep the maintainer of
gitk, Paul Mackerras <paulus@samba.org>, in the loop.
