From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
	configurable
Date: Thu, 8 May 2008 13:34:36 +0300
Message-ID: <20080508103436.GB3300@mithlond.arda.local>
References: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com> <7v63ttq0y8.fsf@gitster.siamese.dyndns.org> <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com> <7vprs1ny5e.fsf@gitster.siamese.dyndns.org> <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com> <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com> <alpine.DEB.1.00.0805060954470.30431@racer> <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com> <alpine.DEB.1.00.0805071223450.30431@racer> <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 12:35:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju3TP-0002SR-Nw
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 12:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760037AbYEHKeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 06:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760217AbYEHKeu
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 06:34:50 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:42352 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752538AbYEHKet (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 06:34:49 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.0.013.9)
        id 481AE2A7004D03A0; Thu, 8 May 2008 13:34:44 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Ju3SO-0003tf-5B; Thu, 08 May 2008 13:34:36 +0300
Content-Disposition: inline
In-Reply-To: <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81522>

Junio C Hamano wrote (2008-05-07 12:13 -0700):

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I am rather interested in the semantics, i.e. if you can punch holes
> > into this 3-class approach.
> 
> This is not the 3-class thing, but was done as a lunchtime hack.  It
> removes more lines than it adds, with real comments ;-).

I tested your lunchtime hack from the "pu" branch. I'm perfectly happy
with the colored output itself but I noticed some different line feed
behaviour that you might want to know. Look at the example below. The
first is normal line diff. The second is the same text with the old
--color-words behaviour and the last is with the lunchtime hack version.
There are only three words added to the text; additions are written as
{+word} in the --color-words output.


Normal line diff
----------------

-OpenOffice.org has user setting for defining the minimum length for
+OpenOffice.org has a user setting for defining the minimum length for
 words to be hyphenated. By default the word length is counted from the
-whole word - even for compound words. For example the word
-'elokuvalippu' is 12 characters long. The word will be hyphenated like
-'elo-ku-va-lip-pu' in all cases when the minimum word length is set to
-12 or less. If the minimum length is set to 13 or more the word is not
-hyphenated at all.
+whole word - even for compound words. For example the compound word
+'elokuvalippu' is considered 12 characters long. The word will be
+hyphenated like 'elo-ku-va-lip-pu' in all cases when the minimum word
+length is set to 12 or less. If the minimum length is set to 13 or more
+the word is not hyphenated at all.

With the old --color-words
--------------------------

OpenOffice.org has {+a }user setting for defining the minimum length for
words to be hyphenated. By default the word length is counted from the
whole word - even for compound words. For example the {+compound }word
'elokuvalippu' is {+considered }12 characters long. The word will be
hyphenated like 'elo-ku-va-lip-pu' in all cases when the minimum word
length is set to 12 or less. If the minimum length is set to 13 or more
the word is not hyphenated at all.

With the lunchtime hack --color-words
-------------------------------------

OpenOffice.org has {+a }user setting for defining the minimum length for
words to be hyphenated. By default the word length is counted from the
whole word - even for compound words. For example the {+compound }word
'elokuvalippu' is {+considered }12 characters long. The word will be 
hyphenated like
 'elo-ku-va-lip-pu' in all cases when the minimum word 
length is set to
 12 or less. If the minimum length is set to 13 or more 
the word is not
 hyphenated at all.
