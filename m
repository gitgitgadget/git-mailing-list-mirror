From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 12:29:50 -0500
Message-ID: <20100706172950.GA2671@burratino>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
 <20100705192201.GI25518@thunk.org>
 <20100706080322.GA2856@burratino>
 <DD1E6EE4-1196-4FCA-87DA-EB9EBCA3AC83@mit.edu>
 <20100706150917.GA1558@burratino>
 <20100706171231.GL25518@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jeffpc@josefsipek.net, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 06 19:30:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWByi-0008Jq-5q
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628Ab0GFRaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 13:30:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57455 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab0GFRae (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 13:30:34 -0400
Received: by iwn7 with SMTP id 7so6881924iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6d+dhiAnM3q+dVJBGNTGAWUMwKD78UGVzLRzec/kcb8=;
        b=VadwWgnvTuKiXiIp08m6FY6pTvHbTkVKgJF3q49qSkL7nriq7r65tW/Rzt70PeUBJP
         xWCcK1pw5gcKZiYjhirs80JFXvutUDr/PAkzyjbhuuCAZ+YQ9LU9l0/rcN/NfLTK7bJR
         aoxExR+Wa3DUK/yIE1bItIr5BXP3PmPcmjx78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=szkKCikB02ImACjUqEzwGKvpxkXUzPBlAbUj/CvgtuB0GFjaxX16VSFMU/1GGE+qxz
         kSzmqhlxSmaQDQPNecQB0U+ttuppkMehU+kcsqEmdgTrfBnxQjb2NGPrGFq09nzMKkji
         qUrWZFyhpCpSsf0OTQGRRg36jjPiwQTyjlzWw=
Received: by 10.231.149.80 with SMTP id s16mr3454827ibv.81.1278437433904;
        Tue, 06 Jul 2010 10:30:33 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm15317380ibe.17.2010.07.06.10.30.33
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 10:30:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100706171231.GL25518@thunk.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150373>

tytso@mit.edu wrote:
> On Tue, Jul 06, 2010 at 10:09:17AM -0500, Jonathan Nieder wrote:

>> I have never heard of any version of Git copying poorly with #1
>> (commits with the same timestamp).  Avoiding it artificially leads
>> inevitably to timestamps in the future when you somehow try to assign
>> 100 timestamps for the series you have rebased on top of a patch
>> committed a few seconds ago.
>> 
>> Incrementing the timestamp to ensure strictly monotonic commits seems
>> like a recipe for trouble to me.
>
> Um, I'm guessing you spent a lot of time typing your note, but not a
> lot of time looking at my most recent patch?  My most recent patch for
> guilt simply will set the time of the patch to the current time to
> avoid setting it into the future.

I read it, and I did not like that specific part.  I even responded to it.

I guess "leads inevitably to timestamps in the future" was a poor
choice of words, though.
