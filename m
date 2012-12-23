From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Sun, 23 Dec 2012 20:27:58 -0000
Organization: OPDS
Message-ID: <F74DFEF2E8914E76BDA501CA5CD4605F@PhilipOakley>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com> <1356117013-20613-2-git-send-email-martinvonz@gmail.com> <7vr4mhpi0l.fsf@alter.siamese.dyndns.org> <CANiSa6i0-Z=FkPnSJxgT+3ABHTzgOTNNNUb=wHQpm2DKAN_UOw@mail.gmail.com> <CAP8UFD0GsqPSk-WstydjZHXc5WSmDJimfRcx4Mn7Uyw0s3LdpA@mail.gmail.com> <7vzk14o9sk.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Martin von Zweigbergk" <martinvonz@gmail.com>,
	"Git List" <git@vger.kernel.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Christian Couder" <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 21:27:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tms92-0001Kx-Ur
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 21:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620Ab2LWU1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 15:27:19 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:62431 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752573Ab2LWU1R (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Dec 2012 15:27:17 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgIFAP9m11BcHmeG/2dsb2JhbABEi3mxexdzghkFAQEFCAEBLh4BASELAgMFAgEDEQQBAQolFAEECBIGBw8IBgESCAIBAgMBh3ADE6p2DYlVi21qg2JhA4gthVGGOI0NhRGCdA
X-IronPort-AV: E=Sophos;i="4.84,343,1355097600"; 
   d="scan'208";a="403711155"
Received: from host-92-30-103-134.as13285.net (HELO PhilipOakley) ([92.30.103.134])
  by out1.ip05ir2.opaltelecom.net with SMTP; 23 Dec 2012 20:27:15 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212091>

From: "Junio C Hamano" <gitster@pobox.com> Sent: Sunday, December 23,
2012 3:24 AM
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>>>From the user's point of view, it seems natural to think that
>> cherry-picking into an unborn branch should work, so make it work,
>> with or without --ff.
>
> I actually am having a hard time imagining how that could ever be
> natural.
>
> When you are on an unborn branch, you may have some files in your
> working tree, and some of them may even be registered to the index,
> but the index is merely for your convenience to create your first
> commit, and as far as the history is concered, it does not matter.
>
> By definition you do not have any history in such a state.  What
> does it even mean to "cherry-pick" another commit, especially
> without the --no-commit option?  The resulting commit will carry the
> message taken from the original commit, but does what it says match
> what you have done?


From: "Junio C Hamano"  Sent: Sunday, December 23, 2012 7:20 PM
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
> Christian Couder <christian.couder@gmail.com> writes:
>
>> I agree that it would be nice if it worked.
>
> That is not saying anything.
>
> Yes, it would be nice if everything worked.  But the question in the
> thread is "with what definition of 'work'?"
> --

>From the dumb user perspective, I would have thought that the first
commit to be cherry picked for an unborn branch would be the complete
commit, which is then planted as the branch's start commit. We tend to
talk of cherry picking commits, though the documentation does say 'the
changes introduced', which allows such a (mistaken) user perspective for
this particular case.

It is only in retrospect, and a bit of extra thought, that one could see
that the commit's message would not actually describe the new situation
and should have been edited.

That doesn't mean that it would be right to allow such an initilisation
of an unborn branch, it's more an explanation of how the idea may have
developed.

Philip
