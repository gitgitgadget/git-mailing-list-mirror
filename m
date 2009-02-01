From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Sun, 01 Feb 2009 15:43:26 -0800
Message-ID: <7vwsc9rae9.fsf@gitster.siamese.dyndns.org>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
 <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
 <20090119172939.GA14053@spearce.org>
 <4ac8254d0902011448t242e7fcek3ae7fda609648ef0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 00:48:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTm32-00009i-VG
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 00:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbZBAXnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 18:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZBAXni
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 18:43:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbZBAXni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 18:43:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 74B59953D6;
	Sun,  1 Feb 2009 18:43:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D8C92953D5; Sun,
  1 Feb 2009 18:43:28 -0500 (EST)
In-Reply-To: <4ac8254d0902011448t242e7fcek3ae7fda609648ef0@mail.gmail.com>
 (Tuncer Ayaz's message of "Sun, 1 Feb 2009 23:48:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23B54C1E-F0BA-11DD-8773-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108025>

Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:

> On Mon, Jan 19, 2009 at 6:29 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Junio C Hamano <gitster@pobox.com> wrote:
>>> Thomas Rast <trast@student.ethz.ch> writes:
>>>
>>> > +           if test ! -z "$GIT_PS1_EXPENSIVE"; then
>>> > +                   git update-index --refresh >/dev/null 2>&1 || w="*"
>>>
>>> This makes the feature unavailable for people who care about the stat
>>> dirtiness and explicitly set diff.autorefreshindex to false, doesn't it?
>>
>> Yup, and I'm one of those people who sets autorefresindex to false
>> in my ~/.gitconfig, usually before I even have user.{name,email} set.
>>
>> I do like the idea of what Thomas is trying to do here, but its
>> so bloody expensive to compute dirty state on every prompt in
>> some repositories that I'd shoot myself.  E.g. WebKit is huge,
>
> I've been thinking about this and wondered
> whether implementing "status --mini" or
> "status --short" which prints "+?*" in wt-status.c
> could be made fast enough.
>
> Should we try to implement and profile this
> or do we know it will be slow beforehand?

I think I've seen a patch to do something like that, soon after Shawn
announced his repo tool.
