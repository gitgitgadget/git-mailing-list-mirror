From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Wed, 7 May 2008 09:15:35 +0800
Message-ID: <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
	 <alpine.DEB.1.00.0805041040560.30431@racer>
	 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
	 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
	 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
	 <alpine.DEB.1.00.0805060954470.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 07 03:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtYGi-0003R1-Om
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 03:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbYEGBPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 21:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbYEGBPk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 21:15:40 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:61416 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbYEGBPi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 21:15:38 -0400
Received: by an-out-0708.google.com with SMTP id d40so14199and.103
        for <git@vger.kernel.org>; Tue, 06 May 2008 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=i94+LnPy4J6UPRmDJz8PEF2Tp3U2NOvsUM8bmZ4JShc=;
        b=sC37D8mDL9hGa91wNDgbGkPLpGq73fEOn8WplR63nvj8TXtYd9v3grS8VldgW8EWZ9xa6lj7wKQS8vY80LaJkKowZIQtnk1IDHiAUkEBoiUP73LuYMgNuIBmNREM/LSmor/jqgGM3jA+uVbMiotA6RjQI57jWYQ6pOtTy2FRoFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YlS9HmaExWxN7yHxY37BIEP9Q8M3uynU4iBmDYCQdUljgnbj9txAz5ARmYVri74Q8xTVinHJwRigj9Wp5Ls7w1Kj8pAh5wpmmcgJSJQZgNXJd0mRtRogjNmcxhzI2Hees6WLSfMMh99Zq2MGuX+65ZL3GP5TkIfjIuURio8IV6s=
Received: by 10.101.68.10 with SMTP id v10mr1927866ank.45.1210122935713;
        Tue, 06 May 2008 18:15:35 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 6 May 2008 18:15:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805060954470.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81397>

On Tue, May 6, 2008 at 4:55 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> > I will come up with an implementation still using diff.nonwordchars few
>  > days later.
>
>  If I did not like the unnecessary negative approach "nonwordchars" (as
>  opposed to "wordchars"), it seems even less appropriate now, when you
>  actually want to discern between "spaceCharacters",
>  "punctuationCharacters" and "wordCharacters".
>

Hmm, punctchars should be a better word than nonwordchars.

So how about this

--color-words={char,punct,word}

  - char: one char one token
  - punct/word: a token can be either a run of word characters or a
single punct character.  diff.punctchars is used for punct, and
diff.wordchars is used for word.

We leave the choice to the user.


-- 
Ping Yin
