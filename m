From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sat, 08 Sep 2007 08:36:44 +0200
Message-ID: <85zlzxzmrn.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
	<loom.20070908T025508-792@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John 'Z-Bo' Zabroski <johnzabroski@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 08:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITtwC-0000yq-Qt
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 08:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbXIHGgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 02:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbXIHGgz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 02:36:55 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:47209 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751153AbXIHGgz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 02:36:55 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id A04072CAC22;
	Sat,  8 Sep 2007 08:36:53 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 9367928EBD3;
	Sat,  8 Sep 2007 08:36:53 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-010.pools.arcor-ip.net [84.61.13.10])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 2A61336E869;
	Sat,  8 Sep 2007 08:36:45 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A70A31CAD71D; Sat,  8 Sep 2007 08:36:44 +0200 (CEST)
In-Reply-To: <loom.20070908T025508-792@post.gmane.org> (John Zabroski's message of "Sat\, 8 Sep 2007 00\:56\:54 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58105>

John 'Z-Bo' Zabroski <johnzabroski@yahoo.com> writes:

> Linus Torvalds <torvalds <at> linux-foundation.org> writes:
>
>> IOW, C++ is in that inconvenient spot where it doesn't help make
>> things simple enough to be truly usable for prototyping or simple
>> GUI programming, and yet isn't the lean system programming language
>> that C is that actively encourags you to use simple and direct
>> constructs.
>
> I want code that is Correct, Explicit, Fast, and in that order.

One beef I have with C++ is its automatic conversion rules.  They were
obviously designed with two goals:

a) behave as C when not using user-defined types.  That's ok.

b) behave like Fortran in mixed-type expressions involving "complex"
   when using C++ (with any arbitrary user-defined type taking the
   role of "complex").

And b is just madness.  Not every user-defined arithmetic type is
complex.  I did some work using modular arithmetic (GF(65521) and
similar) and it was some hard work to keep values going through the
wrong arithmetic conversions.  Basically trial and error and reading
the generated assembly code and head scratching and standard-reading.

In short: the automatic conversions made it hard to express what one
wanted to get done, both for compiler as well as programmer.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
