From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Wed, 6 Jun 2012 15:27:03 -0500
Message-ID: <20120606202703.GA13641@burratino>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino>
 <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <20120511103122.GA19573@burratino>
 <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 22:27:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScMp4-0005I0-P5
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 22:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274Ab2FFU1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 16:27:15 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:60099 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab2FFU1O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 16:27:14 -0400
Received: by ghrr11 with SMTP id r11so5694516ghr.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7Le1nbbqLldJcaRMzi6JN2DMimT+J9I/ns6mx4CApdI=;
        b=lZoTmGvtX9s3HvYkUpDLgbiCAabIWUk7LDPxexJayiacKSpyYe1c+yPimBYg/b8jqb
         IWJ34+Jsd2ZGu/U8IUeCPGZyjqtYBiG2k/Z9b9+4PrbeDzZOOgX9CCXnfFlQZuh9zLj2
         gR5DzaDHTg/lhveFqO4kawSS8l3u8tta2SRp+MNQcsrycjFMT1raJ0Lm0vWhPaLLs8Aq
         +/mNzyOAQ1f0J37aEg5bqYdeLKCBc3DjMmKoWAyhgXLS9cYm4TUOdttmuEBnW/f4NLUZ
         cQDUMVoEYsK5xp7mGYPeDJyakh2pJQLccvZJwuEt0yLJCLSjevM7Arp2o0duIJMU3ZQl
         uf2g==
Received: by 10.50.100.169 with SMTP id ez9mr7942216igb.44.1339014432908;
        Wed, 06 Jun 2012 13:27:12 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id iw6sm1710990igc.15.2012.06.06.13.27.08
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 13:27:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199351>

Hi again,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>                                                           I still like
>> the idea and still am distracted by the spacing.  After the small
>> patch below, the log seems peaceful again and I am totally fine with
>> it.
>>
>> 	Merge branch for-upstream of git://git.example.com/subsystem
>>
>> 	By Fred the Clown
>>
>> 	* for-upstream: (51 commits)
>> 	  foo: bar baz
>
> Two possible factors that may not be visible in the above example are
>
>  (1) hand-written description of the merge itself by the integrator; and
>  (2) octopus merges.

I've had way less time than I would like recently, but since a release
seems to be approaching and nothing has happened, let's revisit this.

To summarize the previous discussion:

 * Hannes prefers not to see the By and Via info in the merge message
   at all.

 * Linus always reformats and paraphrases so the exact format is not
   too important for him.  He has concerns about the accuracy of the
   Via line.

 * Jonathan thinks the By info is ok as part of a merge message but
   finds it jarring when pressed up against the --log summary.

 * Junio mentioned what sounds like anothing infelicity in the current
   format: for octopus merges, there is not just one list of authors
   and submaintiners summarizing what the merge commit does, but
   separate By and Via lines for each branch being merged.

Since everyone seems to agree that it is best when the integrator
sanity-checks the author info and rearranges it to taste, why not make
it commented by default, for example like this?

	Merge branch for-upstream of git://git.example.com/subsystem

	Foo, bar, baz.

	#
	# By Fred the Clown
	#
	* for-upstream: (51 commits)
	  qux: quux

Jonathan
