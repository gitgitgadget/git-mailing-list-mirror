From: Phil Hord <phil.hord@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Mon, 30 Apr 2012 15:25:54 -0400
Message-ID: <CABURp0pHcZfUw8p5F=7W3BipGHdc2Q0QQ7WuaPPVWOYdG1S=BQ@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
 <m3hawjagw9.fsf@localhost.localdomain> <nng3983phhc.fsf@transit.us.cray.com>
 <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
 <201204171837.q3HIbbcW013784@no.baka.org> <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
 <nng1unmnksx.fsf@transit.us.cray.com> <CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
 <nnghaw93v8n.fsf@transit.us.cray.com> <CAE1pOi2KgeLPg7UVRP7dbqLFJErsKUx22Mi5aSkphy7KMJhoUQ@mail.gmail.com>
 <nngd36w1z9n.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: dag@cray.com
X-From: git-owner@vger.kernel.org Mon Apr 30 21:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOwEo-0007wp-Eu
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574Ab2D3T0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 15:26:17 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55005 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363Ab2D3T0Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 15:26:16 -0400
Received: by yenl12 with SMTP id l12so1646745yen.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6oVe7Bkw3jYKgaYxyFVnaf0BgPgPlCpG4TzheU9stVY=;
        b=xHCLSIWiGbeblc6mYWDsrigTvegiwNuTX45L/c2+XHtBUqvLZVCt8BXkzgNJUmI8Wd
         46ELVOrUmW3NWsETo6h6IVQAzrdGoOI7SJvVmvKRekjIEc4dnspCQDzbiNLR0Tp+kFvo
         vSoBhCC7qG/Xw5/nO/XL3qzoutIIhYLgz6YdEJkztOpSdGTW2rbi5jAGr8qXulBVcQnD
         hPdEmIo3XAcsRPhoJGZ8fZAetwURb28pp9fNPfUynFaDnVJ5HykHf3Ito6Nk5+jPNeUd
         fEvMAKAIJjPH/v9BJAqL+v5wWJckBin+eg1AeKxV3fJa+aRHHVr0rLuXVGKQkg/20WT4
         TbAA==
Received: by 10.236.79.40 with SMTP id h28mr2163253yhe.50.1335813976173; Mon,
 30 Apr 2012 12:26:16 -0700 (PDT)
Received: by 10.146.122.15 with HTTP; Mon, 30 Apr 2012 12:25:54 -0700 (PDT)
In-Reply-To: <nngd36w1z9n.fsf@transit.us.cray.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196598>

On Tue, Apr 24, 2012 at 7:33 PM,  <dag@cray.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>> No, I think that is actually very rare. =A0If topic branches really=
 should
>>> be mirrored then U and S should be one repository. =A0They are too =
closely
>>> coupled to be separated. =A0But see the but about git-subtree and t=
opic
>>> branches below.
>>
>> Too closely coupled? I do not think breaking up a project into a set
>> of libraries makes everything tightly coupled. I would argue the
>> opposite. :-) Anyway, you answer my concern below.
>
> If you need the same topic branch for each component they would indee=
d
> seem to be very tightly coupled, even if the code is "physically"
> separated. =A0I can't think of a situation where I would need to impl=
ement
> the same or similar features in multiple components where those
> components are not tightly coupled in some way.

I tend to agree.  However, I have a use case that I suffer on a daily b=
asis.

We have code that runs on multiple platforms (embedded SoCs).  I have
a superproject that has a common library and some vendor-specific code
for each supported platform broken out into submodules.

  super-all
    +-- CommonAPI
    +-- VendorA
    +-- VendorB
    +-- VendorC

The code in the Vendor submodules contains the proprietary
implementations for specific vendor's systems of the CommonAPI
library.  When the CommonAPI gets a new feature, it often gets
implemented in all the vendor submodules as well.

We could easily do this without submodules, of course.  But this setup
allows us to define alternative super-projects that we can then share
with subcontractors and original vendors without exposing proprietary
third-party code.

  super-B
    +-- CommonAPI
    +-- VendorB

  super-C
    +-- CommonAPI
    +-- VendorC

We could still handle this with git-subtree.  But we don't.

Phil
