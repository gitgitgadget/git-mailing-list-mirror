From: Stefan Beller <sbeller@google.com>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 13:57:45 -0700
Message-ID: <CAGZ79kY7wg1JjshwZOtWhm_0qP=CBQqvhqayZpvhu35WuMhxWQ@mail.gmail.com>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
	<vpq382rkvzf.fsf@anie.imag.fr>
	<d21002e0fa92b03c3d417c8996328563@www.dscho.org>
	<CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
	<20150520182218.GD14561@peff.net>
	<20150520183115.GB7142@peff.net>
	<xmqqlhgjm19z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 22:57:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvB3n-00043V-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 22:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbbETU5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 16:57:48 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:34478 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbbETU5q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 16:57:46 -0400
Received: by qctt3 with SMTP id t3so29852034qct.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+VDFdETvTLfcqACDyBNHhcUrXeqnE/5tzt+76llWUS8=;
        b=ofW4ke5xwCxM2dc9xVjYhk7R1ZwE8rmp2j0VcFUeuOMgHVCGgE78zE42mADvwR7U7S
         /6JTRbky/MHWGccITipkLiY3VzNmS+Xj13h4vKPLKR/rFbN5JyzjExNWgdRIS7Shpp4r
         YwIr+MsUuYkeXjw78EpQ9P6/kHsAOZ2CEJMgc0qeD+OVIwbGxKdWzbYpvGdHvW9oPgsJ
         vD/svKIIScS8rMRY5GG3CTvlt9bXIika4ITbm9e0sOMT/TFCZP33e31n85/XZ1Qzqaum
         2X6EShRWJD9ura7sLhatlGpeRfHfEDipo1vXGOinOD5yXN85AY+g8OGlxGaAEzLchy1w
         ptxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+VDFdETvTLfcqACDyBNHhcUrXeqnE/5tzt+76llWUS8=;
        b=ZgjEkjPQtJYwsYrILllhS5JRnbcoUcur9sOQWruOhzuvApRRfsb0LfVXUfRb7fUVgW
         lPr87UXSzdMHFRNph3KiFLw6m56q7qO9ynN4T5k+nYVmI9xjBWW5qL7SWpnPyKCB7KSd
         bEJx4Dq/9ZrbOcRw/eFpMiUZr6kAUQ3RObOB9+ijoQenuMBedjp/TkklnoGKlZwn139r
         tELwsN3qwFJyNRioUhOILaNRmWqyKCiudkM+SHRENWxE/o1T9Fygjssyq1T7LF5m0ULK
         tn44Ax7WLiXl5AQh3j1mFkQY6tSjUhJLVANcROLHyZ95IzbpfAH5rWpY23W4F0DBENLg
         uoLQ==
X-Gm-Message-State: ALoCoQlv8HIeyHGD8qduIpKyjMfeqlbdbS9NMH1CananhyatWnsaFcVtsWpvESMRiXrxfCp8dFbG
X-Received: by 10.55.19.197 with SMTP id 66mr76446398qkt.24.1432155465878;
 Wed, 20 May 2015 13:57:45 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 20 May 2015 13:57:45 -0700 (PDT)
In-Reply-To: <xmqqlhgjm19z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269521>

On Wed, May 20, 2015 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> So...

maybe we need a command:

Given this SHA1, tell me anything you know about it,
Is it a {blob,tree,commit,tag}?
Is it referenced from anywhere else in this repository and if so, which type?
And if it is not referenced, nor an object, tell me so explicitely.


This would have helped a lot for this confusion:

    $ git frotz 280c12...
     No object exists with such a substring (either as prefix, postfix
or in between)
     No other object is referencing any object containing this
substring as pre/post-fix

and this issue would have been resolved in a heartbeat.

Specially the verbose feature is contradicting the terse unix style though
and this command is tailored to this issue, so I don't know if it's any useful
outside this specific problem.
