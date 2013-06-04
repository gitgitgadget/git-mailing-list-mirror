From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Re: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Tue, 4 Jun 2013 18:57:34 -0400
Message-ID: <CABURp0qPt8S4WWhjb22qEJwnUOoT7SFr9=cZBv3Syp-uEX-ycg@mail.gmail.com>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org> <51A7A73C.6070103@web.de>
 <20130531194051.GC1072@serenity.lan> <51AD0EEB.4020106@web.de>
 <20130603222341.GL1072@serenity.lan> <20130604052950.GA2943@book.hvoigt.net>
 <20130604081045.GM1072@serenity.lan> <20130604111717.GA306@book.hvoigt.net> <20130604124826.GN1072@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jun 05 00:58:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk0B3-0004vV-J5
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 00:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab3FDW56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 18:57:58 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:64449 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab3FDW54 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 18:57:56 -0400
Received: by mail-vc0-f171.google.com with SMTP id m16so663104vca.2
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MosSxBikDnftruNqq2d5EJ92wq01BbB7g+e5q00DM9Q=;
        b=H5FCYL/qtp2qxYdrKCX+cO36uxkuf3BFp1h1LlU0U97MoLwJghYcZ0lAavXaGwlMO8
         5up0ceE8sKDInaXOblsNltEUZo0llX/zZDhEZ7kVBUqb0QMKBJ4SacWQjn7/aA9VXCvt
         cchc74tsX39snqjZ477zrQ2uKJNjB5NYmTBFjPr/+04POwfmmlXF7U3s0M3/3jPWZeJ8
         0oxGJ7VBIyAj6rHoLUIJNdo4wQ0GATjOIHYcPrKMcCCq7HSPC87M5G0KibI9zqsKYXSo
         QRMkijvWdmh+NVK/fM91gXNABNhuDdEoFg7a5ssTFRbGK6sLkLzLYJ89Bjy7RFcsgZaF
         4WDA==
X-Received: by 10.52.66.229 with SMTP id i5mr16510616vdt.131.1370386674812;
 Tue, 04 Jun 2013 15:57:54 -0700 (PDT)
Received: by 10.59.5.138 with HTTP; Tue, 4 Jun 2013 15:57:34 -0700 (PDT)
In-Reply-To: <20130604124826.GN1072@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226421>

On Tue, Jun 4, 2013 at 8:48 AM, John Keeping <john@keeping.me.uk> wrote=
:
> On Tue, Jun 04, 2013 at 09:17:17PM +1000, Heiko Voigt wrote:
>> On Tue, Jun 04, 2013 at 09:10:45AM +0100, John Keeping wrote:
>> > On Tue, Jun 04, 2013 at 03:29:51PM +1000, Heiko Voigt wrote:
>> > > On Mon, Jun 03, 2013 at 11:23:41PM +0100, John Keeping wrote:
>> > > > > Sorry, I should have been more specific here. I saw that you=
 did some
>> > > > > changes to make "submodule add" do the right thing with rela=
tive paths,
>> > > > > but the following change to t7406 does not work like I belie=
ve it
>> > > > > should but instead makes the test fail:
>> > > > > -------------------8<---------------------
>> > > > > diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule=
-update.sh
>> > > > > index a4ffea0..9766b9e 100755
>> > > > > --- a/t/t7406-submodule-update.sh
>> > > > > +++ b/t/t7406-submodule-update.sh
>> > > > > @@ -559,7 +559,9 @@ test_expect_success 'add different submo=
dules to the same pa
>> > > > >  test_expect_success 'submodule add places git-dir in superp=
rojects git-dir' '
>> > > > >         (cd super &&
>> > > > >          mkdir deeper &&
>> > > > > -        git submodule add ../submodule deeper/submodule &&
>> > > > > +        (cd deeper &&
>> > > > > +         git submodule add ../../submodule submodule
>> > > > > +        ) &&
>> > > > >          (cd deeper/submodule &&
>> > > > >           git log > ../../expected
>> > > > >          ) &&
>> > > > > -------------------8<---------------------
>> > > >
>> > > > Ah, ok.  I think this case is problematic because the reposito=
ry
>> > > > argument is either relative to "remote.origin.url" or to the t=
op of the
>> > > > working tree if there is no "origin" remote.  I wonder if we s=
hould just
>> > > > die when a relative path is given for the repository and we're=
 not at
>> > > > the top of the working tree.
>> > >
>> > > Why not behave as if we are at the top of the working tree for r=
elative
>> > > paths? If there is an origin remote thats fine. If there is no o=
rigin
>> > > remote you could warn that the path used is taken relative from =
the root
>> > > of the superproject during add. What do you think?
>> >
>> > That's what the patch currently queued on "pu" does, which Jens wa=
nts to
>> > change, isn't it?
>>
>> True I did not realize this when reading it the first time. But I th=
ink
>> we should still not die when in a subdirectory. After all this serie=
s is
>> trying to archive that the submodule command works in subdirectories
>> seamlessly right? So you probably want to translate a relative path
>> without "origin" remote given from a subdirectory to the superprojec=
t
>> level and use that. Then you do not have to die.
>
> The problem is that sometimes you do want to adjust the path and
> sometimes you don't.  Reading git-submodule(1), it says:
>
>      This may be either an absolute URL, or (if it begins with ./ or
>      ../), the location relative to the superproject=92s origin
>      repository.
>      [snip]
>      If the superproject doesn=92t have an origin configured the
>      superproject is its own authoritative upstream and the current
>      working directory is used instead.
>
> So I think it's quite reasonable to have a server layout that looks l=
ike
> this:
>
>     project
>     |- libs
>     |  |- libA
>     |  `- libB
>     |- core.git
>
> and with only core.git on your local system do:
>
>     cd core/libs
>     git submodule add ../libs/libB
>
> expecting that to point to libB.  But if we adjust the path then the
> user has to do:
>
>     git submodule add ../../libs/libB
>
> However, it is also perfectly reasonable to have no remote configured
> and the library next to the repository itself.  In which case we do w=
ant
> to specify the additional "../" so that shell completion works in the
> natural way.

In submodule add, the leading '../' prefix on the repository url has
always meant that the url is relative to the url of the current repo.
The given repo-url is precisely what ends up in .gitmodules'
submodule.$name.url.  It works this way whether there is a remote
configured or not.

It does seem like we need to be cautious around this change.

> The only way I can see to resolve the ambiguity is to die when we hit
> this particular case.  This should be acceptable because people
> shouldn't be adding new submodules anywhere near as often as they
> perform other submodule operations and it doesn't affect absolute URL=
s.

I don't think I like that.  But I don't know if I like anything I
dreamed up, either.

P
