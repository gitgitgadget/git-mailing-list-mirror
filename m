From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [Bug] for-each-ref: %(object) and %(type) unimplemented
Date: Wed, 25 Jun 2008 22:36:33 +0200
Message-ID: <237967ef0806251336r67bdc13w5886dd1a42fa01e6@mail.gmail.com>
References: <48625DAD.5040404@gmail.com>
	 <20080625160814.GA3321@sigill.intra.peff.net>
	 <20080625161433.GA6612@sigill.intra.peff.net>
	 <237967ef0806251208u65c17652gc6091da98294f807@mail.gmail.com>
	 <7v63rx1ezw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Lea Wiemann" <lewiemann@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbkB-00058g-CZ
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYFYUgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYFYUge
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:36:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:1551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbYFYUge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:36:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so8369855rvb.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zfa+XvQs9Gvv/MlSJ7+wEzE8GHM5wEQVOAfgczvuHco=;
        b=V9JUiCQN8cY0IRqy+jkOItjvuaF3jXSEA4hsMdnelu23HLe9/qAwULy6E6mPMuQWD7
         YKp3b8qQ+1n3G7Qg9NwYQRubLFvaIrKLjMZ2v+PyAPrrAEp1QK/y7YSQ3lszA6boO9TU
         Su9PiBWKY3P6Y5VAh4YW+TN0FPdyIIbHIKrdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=geQ+8f8M0vWoCifaMiaTjZnctYEOHb0yxkANGirxayWMHI0TL38uhiB4+f7bHVdO97
         btrUlqdgcHIN4TosWmVOqgeuKfSqmKEffMmcaqCegLi0Av3ov8BBfzRiBtGnyAo55+K8
         YINXxXDEKPFFJ31OnFaNIlSwEgtXLGqxGgxCs=
Received: by 10.141.20.7 with SMTP id x7mr16773922rvi.61.1214426193442;
        Wed, 25 Jun 2008 13:36:33 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Wed, 25 Jun 2008 13:36:33 -0700 (PDT)
In-Reply-To: <7v63rx1ezw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86340>

2008/6/25 Junio C Hamano <gitster@pobox.com>:
> "Mikael Magnusson" <mikachu@gmail.com> writes:
>
>> 2008/6/25 Jeff King <peff@peff.net>:
>>> On Wed, Jun 25, 2008 at 12:08:15PM -0400, Jeff King wrote:
>>>
>>>> Since you seem to be testing for-each-ref, maybe it would make sense to
>>>> put together a test script that exercises each of the atoms?
>>>
>>> Hmm. Actually, there is a test in t6300 that runs with each atom name.
>>> Unfortunately, it doesn't bother actually checking the output for
>>> sanity, so the fact that these atoms returned the empty string was
>>> missed.
>>
>> The documentation also says "tree" and "parent" should work (which they
>> also don't).
>
> The doc does not say any such thing.  A tag object does not have 'parent'
> nor 'tree' header fields.
>
> Neither a commit have 'object' nor 'type' header fields and you cannot ask
> for them when showing a commit object.

Ah, sorry, I read this paragraph:
              In addition to the above, for commit and tag objects,
the header field
              names (tree, parent, object, type, and tag) can be used
to specify the
              value in the header field.

But not this one (which perhaps should be right after the
                  above instead of 3 paragraphs down):
              In any case, a field name that refers to a field
inapplicable to the
              object referred by the ref does not cause an error. It
returns an empty
              string instead.


-- 
Mikael Magnusson
