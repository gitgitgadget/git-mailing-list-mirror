From: David <wizzardx@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 12:02:13 +0200
Message-ID: <18c1e6480806040302k74156d47p4e878fef62d21b87@mail.gmail.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
	 <7vmym1zny4.fsf@gitster.siamese.dyndns.org>
	 <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com>
	 <m3mym1zkus.fsf@localhost.localdomain>
	 <18c1e6480806040130k3851a89an3fcf986feb661226@mail.gmail.com>
	 <D11EAC1A-B59E-4857-A31F-809809310E40@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 12:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ppj-0007FU-Pf
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 12:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbYFDKCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2008 06:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbYFDKCP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 06:02:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:8469 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYFDKCO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 06:02:14 -0400
Received: by rv-out-0506.google.com with SMTP id l9so26103rvb.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=20OjOGy5UPAKPXND6JqytZPh/Bh8fL0HOZPkvucHHI0=;
        b=EubV5ILtaFPzBpoxr84HkyJ33jBvYMrEvoiy3kf45K+2WA/OaoM+gUS3AjCDFUbI8/
         f8qJHh2uejeBbxfCVc9s52ePAnvyPp6bm/BqMsU1DBgepPiGyW0t7qe2o9IynzXjHIXb
         SoNvWhymkEvEolQGgd4+KwnS5+4lxUp4EWI6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=w2iz7+oUmZtECOWvJyAOOqOi2L6UTxCylqVWfBSSvT7L5Jul0S6u2is4dU0y34qron
         vsVEirkuEUSMGcJWoDYhV8+InTopALy/jL0NTkSQa4f6oapmEvA+wb6XztsnkohGGScp
         /QlSedjaPlq+GC4YbRNByTtn5yyqufnCBpNPA=
Received: by 10.141.122.20 with SMTP id z20mr6513752rvm.93.1212573733714;
        Wed, 04 Jun 2008 03:02:13 -0700 (PDT)
Received: by 10.140.194.15 with HTTP; Wed, 4 Jun 2008 03:02:13 -0700 (PDT)
In-Reply-To: <D11EAC1A-B59E-4857-A31F-809809310E40@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83768>

On Wed, Jun 4, 2008 at 11:39 AM, Wincent Colaiuta <win@wincent.com> wro=
te:
> El 4/6/2008, a las 10:30, David escribi=F3:
>
>> Thanks :-) This still isn't what I had in mind (see my earlier post
>> with examples), but I realise now, thanks to your post, that I can
>> probably do it like this:

[snip]

>
> Sounds like it would definitely work but it also sounds like a lot of
> repetitive "busy work"[1] which could be avoided by using finer-grain=
ed
> topic branches in the first place.
>

I see where you're coming from, and I am learning to work more in this
way. Using git has made a big difference to how I develop. Not just as
a SCM, but also for improved work-flow. eg trying out things in code,
and storing failed attempts for later reference/retries/etc if it
doesn't work out.

My problem with your post is, even if you take this to the extreme
(topic branches for every fix that you want to make), there will still
be cases where while working on one fix (maybe disruptive to the main
branch), you uncover problems with master and start fixing it in your
topic branch.

It isn't always easy to fix the problems in master (that you're seeing
in topic) by changing back to master and making another topic. Maybe
you can only (easily) find & detect the problems in master because of
other changes in topic (eg: WIP unit tests) that you aren't ready to
merge yet.

So you would probably have to jump back and forth between your topic,
and your new 'fix problems in master' branch a lot to track down the
issues and get the fixes into master. This sounds like a lot more
'busy work' than simply cherry-picking (multiple) those fixes out of
your topic branch into master, and then rebasing your topic branch :-)

David.
