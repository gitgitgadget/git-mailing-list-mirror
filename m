From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v9 3/5] t4205, t6006, t7102: make functions more readable
Date: Fri, 5 Jul 2013 12:51:12 +0400
Message-ID: <20130705085112.GE32072@ashu.dyn1.rarus.ru>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
 <cover.1372719264.git.Alex.Crezoff@gmail.com>
 <cover.1372939482.git.Alex.Crezoff@gmail.com>
 <aeb5182a691105600edc181c08020cfaa350c7df.1372939482.git.Alex.Crezoff@gmail.com>
 <7v61wpbj2y.fsf@alter.siamese.dyndns.org>
 <20130705081307.GC32072@ashu.dyn1.rarus.ru>
 <7vsizt8kh4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 10:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv1jd-0000HK-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168Ab3GEIvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:51:17 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:38565 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757074Ab3GEIvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 04:51:16 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so1851626lbd.4
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ERlOEUwq28e2bJvVO+U1CscRNhfqFDmCIpmN40Hf+Is=;
        b=oiwvrcHqlUkmppIoLjhqJFwe+Irn+S3BUj0oLJobzvDAabDREeg4NlnWAs1IeA4YFK
         sxfAtvAbXlfLvuO6TJEJagaBbR3lzHoTUSHynf9BXPEKdJR+zqokQhWy5Ajt373VE6dA
         OjNXm/ZGpZULwQWckbRnf6l9Eq1ZmAgnp+tSyORn4OmWC+UtuOzIxN0IEkDRP3mihsW0
         b/uUYF3qNryLXmHvJIJ8fMNF81drKF5Y/6sMaAIW1p2h1/1QT9Fj+Ufuf1fNABOOaE7y
         l4XTW7UsZlSYYpek9YnB7MEUBnFh0DDxN03ZfkOyDF00OA0flSVmwXLsWi74pla1aTOx
         qL9g==
X-Received: by 10.152.116.19 with SMTP id js19mr4511557lab.72.1373014275201;
        Fri, 05 Jul 2013 01:51:15 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id n17sm2567740lbv.2.2013.07.05.01.51.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 01:51:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsizt8kh4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229641>

On Fri, Jul 05, 2013 at 01:44:07AM -0700, Junio C Hamano wrote:
> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> >> Perhaps like this.
> >> 
> >>     Function 'test_format' has become harder to read after its
> >>     change in de6029a2 (pretty: Add failing tests: --format output
> >>     should honor logOutputEncoding, 2013-06-26).  Simplify it by
> >>     moving its "should we expect it to fail?" parameter to the end.
> > I'm not sure whether this "last parameter" is needed in that code as far as we
> > already removed expected to fail tests
> 
> Whatever.
> 
> The above is an example of justifying a more vague "simple" ("is
> better" is implied) with a concrete point (i.e. By moving that to
> the end, you removed the need to conditionally shift $@ in the
> function to simplify the codepath), based on my _guess_ of what you
> possibly meant to say, from reading your description that did not
> give much clue for me to guess why you thought the result was "more
> elegant".  If my guess missed what your true justification was,
> please replace it with the more correct one ;-)
Ok
> 
> >> I cannot read why you think the updated commit_msg is "more pretty"
> >> in the message or in the patch.
> >> 
> >> > -commit_msg () {
> >> > -	# String "initial. initial" partly in German (translated with Google Translate),
> >> > +commit_msg() {
> >> 
> >> Style.  Have SP on both sides of () in a shell function definition.
> > Could you point me to the coding style guide, please?
> 
> Documentation/CodingGuidelines::
Oh! :)
thank you
>  
>  - We prefer a space between the function name and the parentheses. The
>    opening "{" should also be on the same line.
>    E.g.: my_function () {
Aha

-- 
Alexey Shumkin
