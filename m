From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/16] grep portability fix: don't use "-e" or "-q"
Date: Wed, 12 Mar 2008 15:45:43 -0700
Message-ID: <7v63vr4l48.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312213217.GE26286@coredump.intra.peff.net>
 <7vr6ef4mqa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:47:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZit-0001po-I8
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 23:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbYCLWp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYCLWp5
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:45:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYCLWp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:45:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DD3D122FF;
	Wed, 12 Mar 2008 18:45:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2A73422FA; Wed, 12 Mar 2008 18:45:51 -0400 (EDT)
In-Reply-To: <7vr6ef4mqa.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 12 Mar 2008 15:10:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77017>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> System V versions of grep (such as Solaris /usr/bin/grep)
>> don't understand either of these options. git's usage of
>
> It might be fair for other System V people to qualify the above statement
> with "Historic System V" (personally I felt that Solaris without xpg4 was
> unusable, and I wish you luck tackling it).
>
> More seriously, you would need to disable "when grepping work-tree,
> running the native grep is faster and just as capable" optimization in
> builtin-grep.c::grep_cache().  Treat these problematic System V platforms
> as if they are not __unix__.
>
> I am surprised that you did not have issues with "tail -n$number".
> Historic way to spell it was "tail -$number" wasn't it?

Heh, I notice you had to deal with these issues in the later patches ;-)
