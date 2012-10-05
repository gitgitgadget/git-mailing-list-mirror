From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Super long branch names corrupt `.git/config`
Date: Fri, 5 Oct 2012 10:36:52 +1000
Message-ID: <CAH5451=fEDd+EvgEst_G00nQ-yot+2UCbWt_UpduR57bhxHYew@mail.gmail.com>
References: <CAAmo=1BU5N8nbonEb1aZEx=-e8VexwsE74pjm_56dXmCDK+K6g@mail.gmail.com>
 <7v391uyr2w.fsf@alter.siamese.dyndns.org> <20121005002942.GB17586@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Olive <sionide21@gmail.com>, git@vger.kernel.org,
	Ben Walton <bdwalton@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 02:37:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJvuz-0004Kf-33
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 02:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab2JEAhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 20:37:18 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63374 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab2JEAhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 20:37:17 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so706217wey.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 17:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Tt1Fk8LODbUyDemvqduIU4u+jwgc9fcGzNaaldRVIwc=;
        b=Czb341krqNzzwPGhIS0k9YLh0GVxls2bCSnFPpA45nNYhWPoL+G65tdHX1b8n9SpD0
         uT2+XBGSPlTFz0XXWr/NlIU+nPo7KWZ2Pkhf7hLv8265Vv6OtgPIbWxZierhE3fi8yH/
         qLhcPT9gCK1RmNUPnfIgdN+8ZaD66Fj48tnMmtWhXOf8N9XZhGDEndbUatFYGEgHGeFs
         JE6tPuNAfdotw+Q6V5zor0jFzQAJS/waRJ9u19/nFlr3amIBIgduQiAdXDCbhcCXtuDf
         tQAkz/JmNuYgS1bgWA3+nSbFRZFbRP7IYaRv0kJV6qwYUoVkyFXVUBE1sV6a14tH62Ui
         VWMQ==
Received: by 10.180.100.35 with SMTP id ev3mr41830672wib.7.1349397436077; Thu,
 04 Oct 2012 17:37:16 -0700 (PDT)
Received: by 10.216.231.169 with HTTP; Thu, 4 Oct 2012 17:36:52 -0700 (PDT)
In-Reply-To: <20121005002942.GB17586@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207059>

On 5 October 2012 10:29, Jeff King <peff@peff.net> wrote:
>...
>
>but it feels a little fake. Why 200? Because that will test the config
>limit, but will not overflow the NAME_MAX limit (at least not on
>Linux! No clue on other platforms) when we try to create
>refs/heads/foo-$z200.

I can't test this particular case right now, but I recently had an
issue with Windows Server 2008 due to a long filename, that
essentially meant I couldn't move, change owner or change permissions
on the given file. Unless someone has more info I can test a bit
later. Is the idea that we shouldn't allow filenames that will cause
issues with the underlying OS (or other people's OS) or something
else?

Regards,

Andrew Ardill
