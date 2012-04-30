From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Mon, 30 Apr 2012 14:43:57 -0500
Message-ID: <nngd36pxawy.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com>
	<CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
	<nnghaw93v8n.fsf@transit.us.cray.com>
	<CAE1pOi2KgeLPg7UVRP7dbqLFJErsKUx22Mi5aSkphy7KMJhoUQ@mail.gmail.com>
	<nngd36w1z9n.fsf@transit.us.cray.com>
	<CABURp0pHcZfUw8p5F=7W3BipGHdc2Q0QQ7WuaPPVWOYdG1S=BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 21:46:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOwXv-0003cr-2R
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571Ab2D3TqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 15:46:01 -0400
Received: from exprod6og115.obsmtp.com ([64.18.1.35]:49241 "EHLO
	exprod6og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab2D3TqA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 15:46:00 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob115.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT57r9pKJPn2epSUhSnZgTEmpj1nTleyi@postini.com; Mon, 30 Apr 2012 12:46:00 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Apr
 2012 14:44:00 -0500
In-Reply-To: <CABURp0pHcZfUw8p5F=7W3BipGHdc2Q0QQ7WuaPPVWOYdG1S=BQ@mail.gmail.com>
	(Phil Hord's message of "Mon, 30 Apr 2012 15:25:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196601>

Phil Hord <phil.hord@gmail.com> writes:

>> I can't think of a situation where I would need to implement the same
>> or similar features in multiple components where those components are
>> not tightly coupled in some way.
>
> I tend to agree.  However, I have a use case that I suffer on a daily basis.
>
> We have code that runs on multiple platforms (embedded SoCs).  I have
> a superproject that has a common library and some vendor-specific code
> for each supported platform broken out into submodules.
>
>   super-all
>     +-- CommonAPI
>     +-- VendorA
>     +-- VendorB
>     +-- VendorC
>
> The code in the Vendor submodules contains the proprietary
> implementations for specific vendor's systems of the CommonAPI
> library.  When the CommonAPI gets a new feature, it often gets
> implemented in all the vendor submodules as well.

Ah yes, that's a good example.

> We could easily do this without submodules, of course.  But this setup
> allows us to define alternative super-projects that we can then share
> with subcontractors and original vendors without exposing proprietary
> third-party code.
>
>   super-B
>     +-- CommonAPI
>     +-- VendorB
>
>   super-C
>     +-- CommonAPI
>     +-- VendorC
>
> We could still handle this with git-subtree.  But we don't.

Yes, I agree that this is a very important use case.  This is the case
where subprojects exist because of vendor barriers, not necessarily due
to software engineering concerns.

                                  -Dave
