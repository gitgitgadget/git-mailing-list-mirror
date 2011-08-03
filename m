From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: "git check-attr" lists macros as being "set" -- feature or bug?
Date: Wed, 03 Aug 2011 15:19:39 +0200
Message-ID: <4E394AEB.7020006@alum.mit.edu>
References: <4E2EAEA3.8000307@alum.mit.edu> <20110726184756.GA520@sigill.intra.peff.net> <7vvcuoq13i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:19:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QobMZ-0006on-1b
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab1HCNTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 09:19:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36630 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab1HCNTt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 09:19:49 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p73DJeOO006491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Aug 2011 15:19:41 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vvcuoq13i.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178567>

On 07/26/2011 09:43 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>> I don't know the original rationale, but it seems like the only sane
>> behavior to me.

I agree that the behavior is sane (and also convenient).

> When we say "check-attr tells you if the named attribute is set", do we
> say "but macros cannot be examined this way" in the documentation?  If
> not, I do not think we need any cluttering update.

I was confused by the following things:

* The word "macro" in other contexts (e.g., C macros) typically refers
to something that is fully replaced by its substitution text, leaving no
trace of the original macro or its name.

* In gitattributes(5), the following misleading text:

> ------------
> *.jpg -text -diff
> ------------
>
> but that may become cumbersome, when you have many attributes.  Using
> attribute macros, you can specify groups of attributes set or unset at
> the same time.  The system knows a built-in attribute macro, `binary`:
>
> ------------
> *.jpg binary
> ------------
>
> which is equivalent to the above.

It is *not* equivalent to the above, rather it is equivalent to

*.jpg binary -text -diff

(neglecting, of course, the recursive expansion of "binary").

I will soon send a documentation patch.

> It is a separate issue if macros should also be listed as the new feature
> that lists all attributes given to a path. I tend to think the macro
> attributes as well as the other attributes they set should all be shown.

I agree.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
