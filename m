From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Wed, 23 Apr 2014 08:56:01 +0100
Message-ID: <20140423075601.GA18585@hashpling.org>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
 <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
 <20140422045951.GA60610@gmail.com>
 <20140422060120.GA10198@hashpling.org>
 <53560b09bbe96_2400128531085@nysa.notmuch>
 <20140422065549.GA11224@hashpling.org>
 <535611fac1b7b_268bd0b308f5@nysa.notmuch>
 <20140422073008.GA11584@hashpling.org>
 <535620a6e8274_3d2216372ec9d@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 09:56:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcs2O-0002NA-21
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 09:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbaDWH4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 03:56:05 -0400
Received: from avasout06.plus.net ([212.159.14.18]:47258 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbaDWH4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 03:56:04 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout06 with smtp
	id tKvz1n0052iA9hg01Kw0a9; Wed, 23 Apr 2014 08:56:02 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=Rp1LLUWK c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=FaVzYAwi6lUA:10 a=mSBy96HJJ2wA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=vv_i2hJjLZvjLQ2YFfkA:9 a=CjuIK1q_8ugA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1Wcs2D-0004tz-2T; Wed, 23 Apr 2014 08:56:01 +0100
Content-Disposition: inline
In-Reply-To: <535620a6e8274_3d2216372ec9d@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246815>

On Tue, Apr 22, 2014 at 02:56:22AM -0500, Felipe Contreras wrote:
> An explicitly set mergetool.prompt = true would override the default. See the
> patch.

I have had a chance to test the patch now and it looks good. I think
when glancing at it before I missed the change that dropped "|| echo
true" from 

prompt=$(git config --bool mergetool.prompt || echo true)

so I wasn't sure where the implicit true / explicit true difference was
handled.

> I looked, the documentation doesn't mention any default. We could add it, but I
> don't think it's necesarily part of this patch.

The bit of documentation that I was thinking of is in
Documentation/git-mergetool.txt where it states that "--prompt" is the
default which is now only partially true.
