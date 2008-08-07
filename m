From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] files given on the command line are relative to $cwd
Date: Thu, 07 Aug 2008 02:47:39 -0700
Message-ID: <7v8wv9jgw4.fsf@gitster.siamese.dyndns.org>
References: <48997D2E.9030708@obry.net>
 <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net>
 <7v3alirw6b.fsf@gitster.siamese.dyndns.org> <4899D119.1080403@obry.net>
 <7vy73aqe9m.fsf@gitster.siamese.dyndns.org>
 <7vr692oufw.fsf@gitster.siamese.dyndns.org>
 <2008-08-07-10-45-21+trackit+sam@rfc1149.net>
 <20080807090341.GA6421@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Tardieu <sam@rfc1149.net>, git list <git@vger.kernel.org>,
	pascal@obry.net, Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 14:25:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR4YD-0005qL-6S
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 14:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYHGMXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 08:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbYHGMXM
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 08:23:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbYHGMWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 08:22:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 970644E69E;
	Thu,  7 Aug 2008 05:47:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EA1084E695; Thu,  7 Aug 2008 05:47:43 -0400 (EDT)
In-Reply-To: <20080807090341.GA6421@bit.office.eurotux.com> (Luciano Rocha's
 message of "Thu, 7 Aug 2008 10:03:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6B5204A-6465-11DD-B364-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91569>

Luciano Rocha <luciano@eurotux.com> writes:

> On Thu, Aug 07, 2008 at 10:45:21AM +0200, Samuel Tardieu wrote:
>> >>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
>> 
>> Junio> When running "git commit -F file" and "git tag -F file" from a
>> Junio> subdirectory, we should take it as relative to the directory we
>> Junio> started from, not relative to the top-level directory.
>> 
>> Don't we have the same problem with "git show"? If you go into
>> the "gitweb" directory of the GIT source, "git show HEAD:README" will
>> show you the toplevel "README" instead of the one in the "gitweb"
>> directory.
>
> No, git show has different semantics. It has been discussed often in
> this list.

You are half correct --- it is not show but tree:path syntax.
