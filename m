From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ks/precompute-completion
Date: Fri, 23 Oct 2009 11:59:54 -0700
Message-ID: <7vd44eaqc5.fsf@alter.siamese.dyndns.org>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
 <4AE0190E.8020803@gmail.com>
 <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com>
 <4AE0DAB3.1030103@gmail.com>
 <fabb9a1e0910221555k287b45ebwb15ac97851b845f9@mail.gmail.com>
 <fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com>
 <4AE0E542.8010501@gmail.com>
 <fabb9a1e0910231127i3ab469qebdc17168a58f22a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 21:00:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1PN9-0001FX-Ea
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 21:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbZJWTAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbZJWTAL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 15:00:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbZJWTAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 15:00:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9711983237;
	Fri, 23 Oct 2009 15:00:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Z4GkZOLUSeQxIzRLEjzYQ2+MKIU=; b=h5858X0bsEC4Pydfl7vpBDc
	nia69iwtkOE9V6qP6X4j3HW7wuYhu4LAi6DAi/ywt706lFaGOhUaOBULvBxjjjuJ
	dRrLMi2jKB4gE33zvS/98J84ffGLtOvu8BJf3ye/QLfOdQmGJYtXSKha23OychF+
	EE4Ku0U5c4okxaY4CEwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=I7gc9cY+BumfjJlLTSMr4DBXF3gaivluXYmUXS+rHY9WH5HwH
	APTojKSufi+y6VUYo3HOlUNn4LxrnGr8vnEDG/Cd2rvNOowsjRJAOaq451M0741h
	9jlqbBGaTIcJpaGRwBxtId9NIuI8b8SHBhivJOEr+YyHmOExOTl0fyzqbc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44DE383236;
	Fri, 23 Oct 2009 15:00:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 97DB78322A; Fri, 23 Oct 2009
 14:59:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 484293FE-C006-11DE-8AB6-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131118>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Ah, no, I meant that as part of my semi-regular git update (during
> which I do 'make && make install') I want to have up-to-date bash
> completion, preferably installed somewhere system-wide; currently I am
> forced to have a 'source
> /home/sverre/code/git/contrib/completion/git-completion.bash' in my
> .bashrc,..

If you have enough privilege to run 'make && make install' regularly into
a system-wide place, I presume you can have a system-wide rc that sources
/home/sverre/code/git/contrib/completion/git-completion.bash, no?

I think there are two issues.

 1. The series will break your rc script (either $HOME/.bashrc, or
    system-side) that sources $git/contrib/completion/git-completion.bash
    because it has to be built; having "make" generate it may alleviate
    the issue, but "make clean" will break it again, so it is not
    something you can solve in any way other than changing your setting.

 2. Some people have been expecting "make install" not to install the bash
    completion anywhere.

So perhaps "make && make install-contrib"?
