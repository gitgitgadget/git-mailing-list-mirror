From: demerphq <demerphq@gmail.com>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 18:16:39 +0200
Message-ID: <9b18b3110910180916s2a2ac751i7520e64294037817@mail.gmail.com>
References: <20091018144158.GA9789@gandalf.dynalias.org>
	 <4ADB3452.6030508@gmail.com>
	 <9b18b3110910180837h18e15f74g74626847b6ce4da3@mail.gmail.com>
	 <20091018154528.GA5688@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: alexandrul <alexandrul.ct@gmail.com>, git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Sun Oct 18 18:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzYR5-0001FB-WB
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 18:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbZJRQQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 12:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbZJRQQh
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 12:16:37 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:61260 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbZJRQQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 12:16:36 -0400
Received: by ewy4 with SMTP id 4so798296ewy.37
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=lsCLlla/XUWWrneU2xQJQB7M0uNFRurlDz2/y+jQV1c=;
        b=jfw0Q8+cUwf45iyy+J6PW7bUVXLvd579EPIcJ5KOEjA/E3NNiknnF9rPFfpbDZJOqB
         ZMDl8qFo+EwQHYmCVzwXRvzRmialP1UFkdRZfmT1dhsu+1KXs8sm6+J0V8KU/svXZY2Z
         uJc+gZ2RwOkuI0RPmbvgHrsglzfzTOox1sUhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wHwe8cN0Buk9uGjI39lukomWmiwOPzDj+Q921OzpRxnmMVJ9pdbP5bh5rf/TsdVzwB
         L05M2330edNjA97/KVIq63JxZproVjzzl3aALk8jTy50D7x51zLMl2ycyd6jiXpbaS5b
         Wn7ND2KR8+QDhqiGB/TOe7TxnDsUIwsJkIyEg=
Received: by 10.216.87.131 with SMTP id y3mr1353802wee.9.1255882599944; Sun, 
	18 Oct 2009 09:16:39 -0700 (PDT)
In-Reply-To: <20091018154528.GA5688@gamma.logic.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130602>

2009/10/18 Norbert Preining <preining@logic.at>:
> On So, 18 Okt 2009, demerphq wrote:
>> > Being a DVCS, this kind of versioning can only be trusted on a single repo,
>> > but if you set it on the "main" repo, it should work.
>> >
>> > The only drawback could be the ever growing number of tags,
>> > I don't know how it will work with thousands of tags or more.
>>
>> I think the other drawback is that the number would essentially be
>> meaningless and more or less would just be a substitute sha1.
>
> Well, it would be increasing for that repository. And if we always
> update our packages from that repository the packages will be guaranteed
> to have increasing version number, too.
>
> That is the *only* thing I care about. The numbers don't need to have
> a meaning, nothing else but that in our workflow we guarantee
> that at the end each package progresses in version numbers.
>
>> Consider when a remote adds commits and then merges and pushes. What
>> number should those commits have?
>
> When using a central repository to which he pushes within that central
> repository it would give a specific number.

Consider you have A-B-C-D-E in your master repo. So presumably numbered 1..5.

If i then make a trivial comment fix to A and then merge and push we
end up with:

A-B-C-D-E-G
 \        /
  F------+

If i understand you right you will set F to 6 and G to 7. Thus youll
end up with the problem that F is a descendent of A yet has a higher
"version number" than E. You can repeat this process for ever.

If this suits your needs then great.

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
