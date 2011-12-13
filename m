From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: Git blame only current branch
Date: Tue, 13 Dec 2011 19:39:56 +0530
Message-ID: <87y5ugsguj.fsf@gmail.com>
References: <e9e35956-a091-4143-8fd4-3516b54263a6@mail>
	<d615954f-bed8-482d-a2e3-e1e741d6dd23@mail>
	<20111212165542.GA4802@sigill.intra.peff.net> <8739cpteat.fsf@gmail.com>
	<7vobvdvx9c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stephen Bash <bash@genarts.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 15:10:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaT3Z-0007od-7L
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 15:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab1LMOKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 09:10:03 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41263 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab1LMOKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 09:10:01 -0500
Received: by iaeh11 with SMTP id h11so4826483iae.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qT8H04nITWkpnJwjA0IvctJJcy/zGBsshehcvWGVDog=;
        b=he6Xe6qg7mikEYEvTBUapy4PFKUchhRQ46EnBXXCZzfvMZfRPPoONwO2cK/CS2hymi
         9ug2T5TGOWmqR/pit/a4LJ+mPehNAv1YsjWOTavSF+vS6TdZe3exXetBvWu62N9CpdJ+
         A15E9QaDRG1+r/TdifgEtlB1tNDmEOJXN0F5U=
Received: by 10.42.151.195 with SMTP id f3mr11259665icw.19.1323785400784;
        Tue, 13 Dec 2011 06:10:00 -0800 (PST)
Received: from BALROG ([59.92.86.102])
        by mx.google.com with ESMTPS id wp7sm44330137igc.6.2011.12.13.06.09.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 06:09:59 -0800 (PST)
In-Reply-To: <7vobvdvx9c.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 12 Dec 2011 21:47:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187020>

Junio C Hamano <gitster@pobox.com> writes:

> Vijay Lakshminarayanan <laksvij@gmail.com> writes:
>
>> The code reads fine when there's no numeral 1 around but now it doesn't
>> read well.  I think refactoring
>>
>>     struct commit_list *l
>>
>> to 
>>
>>     struct commit_list *lst
>>
>> is justified.  Thoughts?
>
> Not justified at all.
>
> What is "lst" and why is it not spelled "list"?  It is a disease to drop
> vowels when you do not have to.

lst is better than l in this particular context.  I think fried_chicken
is better than l in this particular context ;-)

> If I were to name a new variable that points at one element of a linked
> list and is used to walk the list (surprise!) "element" or perhaps "elem"
> for short, but in the context of that short function I honestly do not see
> much need for such a naming. The variable is extremely short-lived and
> there is no room for confusion.

Before the introduction of the numeral 1, I am in complete agreement
with you for the exact reasons you've mentioned above.  Post
introduction of "l ? 1 : 0" it warrants a refactoring.  It's possible
you're using a different font so you never encounter the issue, but this
definitely isn't a problem I alone face.  For instance, it is a
sufficiently common problem that it's one of the "Java Puzzlers" in Josh
Bloch's book of the same name.  (Yes, elem is better than lst.)

My $0.02.

-- 
Cheers
~vijay

Gnus should be more complicated.
