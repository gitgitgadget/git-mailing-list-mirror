From: Ivo Anjo <ivo.anjo@ist.utl.pt>
Subject: Re: How to prevent empty git commit --amend
Date: Tue, 13 Jan 2015 10:22:02 +0000
Message-ID: <CA+iO_8niTScwtYVRV-5wBNHOzr08k=1Vug0yH3+vQ-Y9GgyJKg@mail.gmail.com>
References: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
	<CACx-yZ12mn-EyR5Mx9rmACLtyeYWRdyef4jDqdFAPzeQDm03ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Daniel Knittl-Frank <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 11:22:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAyc2-0000jh-OS
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 11:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbAMKWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 05:22:09 -0500
Received: from smtp2.ist.utl.pt ([193.136.128.22]:42511 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbbAMKWH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 05:22:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 44C417023680
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 10:22:04 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.6.4 (20090625) (Debian) at ist.utl.pt
Received: from smtp2.ist.utl.pt ([127.0.0.1])
	by localhost (smtp2.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id T42fl2DWVGW1 for <git@vger.kernel.org>;
	Tue, 13 Jan 2015 10:22:04 +0000 (WET)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id F2A4B7023681
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 10:22:03 +0000 (WET)
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com [209.85.192.44])
	(Authenticated sender: ist155460)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 84027200D3AB
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 10:22:03 +0000 (WET)
Received: by mail-qg0-f44.google.com with SMTP id q107so1441876qgd.3
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 02:22:02 -0800 (PST)
X-Received: by 10.229.249.137 with SMTP id mk9mr57693348qcb.4.1421144522507;
 Tue, 13 Jan 2015 02:22:02 -0800 (PST)
Received: by 10.229.159.14 with HTTP; Tue, 13 Jan 2015 02:22:02 -0800 (PST)
In-Reply-To: <CACx-yZ12mn-EyR5Mx9rmACLtyeYWRdyef4jDqdFAPzeQDm03ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262333>

Hello Daniel,

Thanks for your answer!

My issue is not with cancelling the amend commit, is that because the
amend commit already lists changes to the files I am working on (those
changes that already went in the commit I was ammending), I don't
realize that I forgot to add what I changed. For instance:

$ echo "Hello" >> readme.txt
$ git add readme.txt
$ git commit -m "Add readme"

$ echo "World" >> readme.txt
$ git commit --amend

now if I just save and close the editor git will say it committed
successfully (which it did), but in reality nothing at all happened.

Of course I can check the status or some other things before/after the
amend commit, but since end up doing this error sometimes I was hoping
I could set up git to stop me from doing it.

Ivo Anjo

On Tue, Jan 13, 2015 at 8:59 AM, Daniel Knittl-Frank
<knittl89@googlemail.com> wrote:
>
> On Tue, Jan 13, 2015 at 9:56 AM, Ivo Anjo <ivo.anjo@ist.utl.pt> wrote:
> > Hello,
> >
> > I sometimes get a bit distracted when making amends. Once or twice per
> > week I do a commit, then realize I added something I shouldn't, or
> > forgot to add a line here or there, and then I do a git commit --amend
> > to fix it.
> >
> > The thing is, a lot of times I forget to stage the modifications I did.
> > And here is my issue: *git commit* refuses to work when there's
> > nothing to commit, but *git commit --amend* happily pops up the editor
> > and says you have committed something when you did not add/change
> > anything.
> >
> > Is there a way to prevent a *git commit --amend** with nothing to
> > commit from working?
> > If not, I would like to suggest that this feature would be very helpful :)
>
> Hi Ivo,
>
> simply delete all text from the commit editor and exit/save the empty
> file. This will abort the commit.
>
> The same logic applies to git rebase --interactive: deleting
> everything will do nothing.
>
> Regards,
> Daniel
>
> --
> typed with http://neo-layout.org
