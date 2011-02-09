From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Updating a submodule with a compatible version from
	another submodule version using the parent meta-repository
Date: Wed, 9 Feb 2011 20:36:11 +0100
Message-ID: <20110209193610.GA67890@book.hvoigt.net>
References: <4D407099.4010805@web.de> <AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com> <4D407875.7080607@web.de> <AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com> <7v7hdrl7nw.fsf@alter.siamese.dyndns.org> <AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com> <7v1v3zjp6w.fsf@alter.siamese.dyndns.org> <20110129110807.GA21864@book.hvoigt.net> <AANLkTimBCeSnR270eWMcrgCVj6rmiRkJizOxQPAPOAnn@mail.gmail.com> <AANLkTim2G0kF+omPZ1_fk0P6oGDaKDWd79XNR5GXUkWG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Julian Ibarz <julian.ibarz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 20:36:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnFpt-0005x6-Jl
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 20:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab1BITgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 14:36:14 -0500
Received: from darksea.de ([83.133.111.250]:55538 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750973Ab1BITgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 14:36:13 -0500
Received: (qmail 26017 invoked from network); 9 Feb 2011 20:36:11 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 9 Feb 2011 20:36:11 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTim2G0kF+omPZ1_fk0P6oGDaKDWd79XNR5GXUkWG@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166437>

Hi Julian,

On Wed, Feb 02, 2011 at 11:31:40PM -0500, Julian Ibarz wrote:
> So now my two questions that could save me some time are:
> - is there a function that gives the distance between two commits? I'm
> sure there is something like this coded somewhere but I didn't find it
> yet

One thing which now came to my mind is that you might be interested in
is to use merge bases to find the earliest commit that contains a
certain revision.

Have a look at how I implemented the submodule merge strategy that might
help you. You can find it in commit 68d03e4a. I basically do a search
for the earliest commit that contains the commits from both sides. You
could use a similar strategy but limit the possible candidates to a
restricted list of commits which are contained in the supermodule.

Cheers Heiko
