From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Fri, 2 Nov 2012 16:34:38 +0100
Message-ID: <CAMP44s2s-XjOqQQr4qvzeOhVDazKsLZ94p4QDz+2XJ9m_8A15A@mail.gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
	<1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
	<20121031003721.GV15167@elie.Belkin>
	<20121102131255.GB2598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:34:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJGn-0008Up-GK
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab2KBPek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 11:34:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34951 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab2KBPek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:34:40 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3716439obb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RxMsV0wqO2YoSbdHPQhmCaoIisrPFuNPZ7GQQCP1+yw=;
        b=CNN3V0Qv3SXBj+1SVKl84lANdpbyfxbsAOafz/XnNsAYmlr+sRzvRt3d2xdzOhDQf7
         1YeDl5fC65WGL6qGPQ2e54SS9+ep5KLqtcRbNTlVuCWoOye24UzTzOKVOmD7cU+lupq5
         icQR4VME47V8gsv+I6+bSyi4IlBgT88iTfePXQzWWBmawfDaoCYSAERbgzbNWzn8q6xv
         vH36LASI416Ubk09tGEVzDX94qpJQOWCM0ZLvqKrUP6EaVSe6r647wf6S/EuKySKkNRV
         RbMLX8SxBHODxWH0DbNUYX9XseEZREJXP3R3XCxJNJYNtZZPf4SHyizg4sbIWjTibYiB
         3z5A==
Received: by 10.182.52.105 with SMTP id s9mr1672632obo.25.1351870478139; Fri,
 02 Nov 2012 08:34:38 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 08:34:38 -0700 (PDT)
In-Reply-To: <20121102131255.GB2598@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208951>

On Fri, Nov 2, 2012 at 2:12 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 30, 2012 at 05:37:21PM -0700, Jonathan Nieder wrote:
>
>> If the commit does not have the SHOWN or UNINTERESTING flag set but it
>> is going to get the UNINTERESTING flag set during the walk because of
>> a negative commit listed on the command line, this patch won't help.
>
> Right, so my understanding of the situation is that doing this:
>
>   $ git branch foo master~1
>   $ git fast-export foo master~1..master
>
> won't show "foo", which seems wrong to me. _But_ we currently get that
> wrong already, so Felipe's patches are not making anything worse, but
> are fixing some situations (namely when master~1 is not mentioned on the
> command-line, but rather in a marks file).
>
> Is that correct?

Yes, that's correct. But my patch ("make sure refs are updated
properly") does _not_ change in any shape or form what happens with
what you specify in the command line, only what happens with marks.

Cheers.

-- 
Felipe Contreras
