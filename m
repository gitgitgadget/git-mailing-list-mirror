From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Wed, 9 Jul 2014 13:44:21 +0200
Message-ID: <CAA787rnpHTiaV3KndmVqiTF_kzpcptbrTfWBnFVh0W_Rzyw8ww@mail.gmail.com>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
	<1404505370.3109.15.camel@stross>
	<CAA787rmf36V1=Sd8TZrc7DboTkeJDYKuEGgCe90mZLLKSp6=tw@mail.gmail.com>
	<1404525502.3109.25.camel@stross>
	<CAA787rnMonCuON+C0U5FDXKzjTBdpOusCpGLeWytDWaA1torEw@mail.gmail.com>
	<CAA787r=Q5B7R1sxiVhRgobPHHPro6D5YyqVO+P_MZC=aGa+ZHw@mail.gmail.com>
	<1404868702.3775.2.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 13:44:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4qIb-0003DM-9w
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 13:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbaGILoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 07:44:25 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:39326 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbaGILoX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2014 07:44:23 -0400
Received: by mail-la0-f42.google.com with SMTP id pn19so4967144lab.15
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 04:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=J2s0RT5tXI4OjUQ9WR0+KWtnls4VxFWFUFXE6I86Q+c=;
        b=wZzUysSaqWeCAlV+CigT7M9rXv9DuoGNxgAQkf9436g6oGfOFHyfl+E6PGepPptTS6
         mgjxxBvT+fME2LN8G3gfcjuB15jG/RDWrdLRuVZ8/pwlROG74lKpOWLKcN0Zm0+HoHNo
         YDcE/soICyfmeJBdGubAIpUhfM6JpdtoCVHPbi8L/h3myngSFhEvIPML5RduU+Zgrz8a
         joeGQaw8v8CyfOHb+pR9RWRMrE+qYzjOLZGathuOWW045G+Mft4ESp2OkmMlZCVnO2JV
         ZrX/HwgccT6icObu8TpwQ2dNSJa+uVzd8Cm4Qkx0t9uix8QZxqiW9X2D1mGkivEQvua1
         k9HQ==
X-Received: by 10.152.25.132 with SMTP id c4mr980318lag.88.1404906262045; Wed,
 09 Jul 2014 04:44:22 -0700 (PDT)
Received: by 10.112.142.7 with HTTP; Wed, 9 Jul 2014 04:44:21 -0700 (PDT)
In-Reply-To: <1404868702.3775.2.camel@stross>
X-Google-Sender-Auth: E00yhTB9zbMmYCXq1sv00-EksNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253118>

On 9 July 2014 03:18, David Turner <dturner@twopensource.com> wrote:
> On Wed, 2014-07-09 at 02:52 +0200, =C3=98yvind A. Holm wrote:
> > On 3 July 2014 23:55, =C3=98yvind A. Holm <sunny@sunbase.org> wrote=
:
> > > When compiling newest master (v2.0.1-472-g6f92e5f) on Debian 7.5
> > > (64-bit), t5150-request-pull.sh fails when compiling with
> > > [snip]
> >
> > FYI, t5150-request-pull.sh passes all tests now on newest master
> > (v2.0.1-474-g72c7794) in Debian. There are two new commits on maste=
r
> > since I wrote this, and the commit that makes things work again is
> > 4602f1a ("diff-tree: call free_commit_list() instead of duplicating
> > its code"). Reverting this commit brings the failure back.
> >
> > The whole thing is still a mystery to me, though. I can't see why
> > this should have anything to do with the use of ./configure
> > --prefix.
>
> The problem only happens when a ref with an allowed wildcard winds up
> on a page boundary (with the wildcard before the page boundary).  Thi=
s
> depends intricately on the details of memory allocation, so pretty
> much anything could make it come and go.

Aha, that makes sense. Sheer luck that the results were that consistent
during testing, then.

> Does the fix I posted work for you?  If not, let me know and I'll loo=
k
> into it more.

Sorry, didn't notice you posted that to the list. Today I learned that
Gmail doesn't put mails adressed to me and the list in the inbox. :(

The commit fixed it, yes. Thanks for the patch. It now works on both
Debian servers. Have run all tests on one of the servers, and will
repeat on other machines, too.

Thanks,
=C3=98yvind
