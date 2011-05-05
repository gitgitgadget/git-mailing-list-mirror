From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 05 May 2011 14:53:10 -0700
Message-ID: <7vhb986chl.fsf@alter.siamese.dyndns.org>
References: <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net>
 <7vwrif5q93.fsf@alter.siamese.dyndns.org> <20110427220748.GA19578@elie>
 <7vsjt35l84.fsf@alter.siamese.dyndns.org> <20110427234224.GA26854@elie>
 <7viptz5j82.fsf@alter.siamese.dyndns.org>
 <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
 <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
 <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
 <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
 <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
 <4DB9329E.7000703@op5.se> <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david\@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:53:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI6UM-0006dD-6C
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 23:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948Ab1EEVxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 17:53:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab1EEVxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 17:53:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 749915739;
	Thu,  5 May 2011 17:55:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=USrPGT06kBxJK/I7TuqehcmK7Fw=; b=NJRm/o
	ivQi4M8Pzuvwf3B/8xfRd0Jbng+kJBQuaYjzNtFmB7O65KSCQOeP+wm6MOEYDwit
	WHo+ibZGX4j3PP/CKSDnSCu5WDyMc3STHsyRUEZjJ8J2lHqPtByWk0K0SjS7Hv2F
	3G3tW538Kdh4K4YkNgoKjr6YJ08F0T22g2bYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G4ShvAXgWgxPp8Wu+KOmyfwNSXKrkmQE
	HWBnDmMuUbGdkv5zgMg6qUqMhQC7JeGK1rzkC5TOQ2OHAazjrU+PQ1lQToIvkMxD
	nd0ok7qZ0AUZp2vN75Xmmqhhz+t2G7D6BFFSPp9JK/s3RSs/G/TbmU2wRkangiQj
	9O3yID71Fqo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E96575737;
	Thu,  5 May 2011 17:55:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B3DEE572A; Thu,  5 May 2011
 17:55:15 -0400 (EDT)
In-Reply-To: <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com> (David
 Aguilar's message of "Thu, 5 May 2011 14:41:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 622D60E0-7762-11E0-B89E-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172918>

David Aguilar <davvid@gmail.com> writes:

> On Apr 28, 2011, at 3:56 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> 
>> What is so hard about the concept of an application providing a
>> facility that allows it to request, merely request, the installation
>> of a plugin for itself by what ever happens to be the users choice of
>> package manager or distribution.
>
> It's not hard.  We simply don't need it. 
>
> Why do I need to activate my "plugin"?  That seems like a needless
> feature. If I don't want "git gui" I apt-get uninstall git-gui.

I mostly agree with you that what Jon has wrote so far is overengineering
to solve a problem that does not exist [*1*].

But here is one thought.

Imagine this "git gui" is not "git gui" but "git superadd" package that
changes the behaviour of "git add" slightly.

    Side note: Of course, for this kind of usage, the "git potty" needs to
    be extended to look for things in different places, and also it needs
    to be made easy for the implementation of "superadd" to call the
    underlying "git add", bypassing itself, when necessary.

You do not want that new interface, you are old timer and you like the old
way of doing things like me ;-).  But your wife wants to use it.  You two
share a computer.

Do you or do you not run "apt-get install git-superadd"?

One possible answer may be to run "apt-get install git-superadd", and then
the users who want "git add" to behave in a new way to opt-in to use the
"plug-in".  I think that is what Jon is getting at.


[Footnote]

*1* I admit that I didn't read all of them carefully, as I was repelled by
them as soon as I saw phrases like "for people who can grok this concept".
