From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Wed, 24 Jul 2013 08:38:55 +0100
Organization: OPDS
Message-ID: <3E185895A3E14127A858979373F76766@PhilipOakley>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com> <1374314290-5976-1-git-send-email-pclouds@gmail.com> <79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley> <CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com> <8BDFF5EEBDC8422681F1AB2C0A153CC6@PhilipOakley> <CACsJy8AzFogspTih4mJoog6MGEWgmuae2KmFysQ0-siCvfH2yA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 09:39:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1tf2-00067j-6p
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 09:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab3GXHiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 03:38:54 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:58034 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843Ab3GXHix (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 03:38:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArsNALSD71FOl3BG/2dsb2JhbABbgwaEDoU+uC4EAQMBgRMXdIIfBQEBBAEIAQEZFR4BASELAgMFAgEDDgcBAgICBQ8SAgIUAQQIEgYHCQENBhMIAgECAwGHbQMJCqcDiF8NiF6BKItqgTRCch+CRzNuA45/hneOEIUmgxU7gS0
X-IPAS-Result: ArsNALSD71FOl3BG/2dsb2JhbABbgwaEDoU+uC4EAQMBgRMXdIIfBQEBBAEIAQEZFR4BASELAgMFAgEDDgcBAgICBQ8SAgIUAQQIEgYHCQENBhMIAgECAwGHbQMJCqcDiF8NiF6BKItqgTRCch+CRzNuA45/hneOEIUmgxU7gS0
X-IronPort-AV: E=Sophos;i="4.89,733,1367967600"; 
   d="scan'208";a="436445164"
Received: from host-78-151-112-70.as13285.net (HELO PhilipOakley) ([78.151.112.70])
  by out1.ip01ir2.opaltelecom.net with SMTP; 24 Jul 2013 08:38:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231082>

From: "Duy Nguyen" <pclouds@gmail.com>
Sent: Wednesday, July 24, 2013 2:57 AM
> On Wed, Jul 24, 2013 at 5:33 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> In some sense a project with a sub-module is a narrow clone, split at 
>> a
>> 'commit' object.
>
> Yes, except narrow clone is more flexible. You have to decide the
> split boundary at commit time for sub-module, while you decide the
> same at clone time for narrow clone.
>

True. It was the thought experiment part I was referring to.

>> There have been comments on the git-user list about the
>> problem of accidental adding of large files which then make the 
>> repo's foot
>> print pretty large as one use case [Git is consuming very much RAM]. 
>> The
>> bigFileThreshold being one way of spotting such files as separate 
>> objects,
>> and 'trimming' them.
>
> I think rewriting history to remove those accidents is better than
> working around it (the same for accidentally committing password). We
> might be able to spot problems early, maybe warn user at commit time
> that they have added an exceptionally large blob, maybe before push
> time..

Again, it was a thought experiment which related to a recent git-user 
list comment.
I'd expect a real use case could be a team where one member who is 
preparing documentation adds a [large] video to his branch and others 
then get a bit concerned when they try to track it / pull it as they 
really don't want it yet. The guy may have many versions on the central 
repo before a final rebase has a single compressed version. Colleagues 
may want to review the text surrounding it but not pull the video 
itself. (remembering 50 % of 'idiots' are twice as dumb as the 
average... ;-)

>
> The "Git is consuming very much RAM" part is not right. We try to keep
> memory usage under a limit regardless of the size of a blob. There may
> be some cases we haven't fixed yet. Reports are welcome.

I think this was a Windows user, but reports do pop up every now and 
again. Some times its disc pressure, or just perceived slowness (from 
others)


> -- 
> Duy

Philip
