From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Thu, 14 May 2015 14:40:59 -0700
Message-ID: <xmqqoalmj0r8.fsf@gitster.dls.corp.google.com>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
	<xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
	<20150513021556.GA4160@peff.net> <20150513045650.GA6070@peff.net>
	<20150513224131.GC425227@vauxhall.crustytoothpaste.net>
	<20150514042544.GA9351@peff.net>
	<9350a00074264bb847210410a6f6c340@www.dscho.org>
	<20150514173828.GA7966@peff.net>
	<c2fd3e038c821ec340c085a825baabc7@www.dscho.org>
	<xmqqwq0aj25e.fsf@gitster.dls.corp.google.com>
	<20150514211727.GA15528@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 23:41:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0sM-0002af-FN
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbbENVlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:41:04 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35818 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422786AbbENVlC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:41:02 -0400
Received: by iebpz10 with SMTP id pz10so72755926ieb.2
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KZ5dOufFAN4lCOWY1FDi4hTPy1roOkeRdl3hQwNpnnA=;
        b=Gk0iBmu+wELzNG9Cgz0zjtfF5Svoa7cZBHK1xeFBYXBSta0L+7Aow4q3o731rh4VWv
         i4K0j8VbUZZKpfRGd8mod42CzIgBxPkm53iMI1YSCLsG8WaacDNn4REMJf4Yoz2xy4Wy
         SDQnTX16i+a01Y70GRnUpJxlS9UFaFD0p/LjknX/MSTZQMTzADT4frd087zDzkfekCJE
         7Y/XznpKT+JeFNS5xCAmv5hdJ1kOR0/IdrGKwc/aSZCrDOCDqnGEvH88+g1zoHrmwkwt
         drk01rd1plJhKGI7lWw2DcWXJkWXe7Rx+QbssEZEY/g8N240fh3z7bUyj8bvsY2XcNvN
         9pSQ==
X-Received: by 10.42.63.80 with SMTP id b16mr16488833ici.64.1431639660900;
        Thu, 14 May 2015 14:41:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id r4sm122600igh.9.2015.05.14.14.41.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 14:41:00 -0700 (PDT)
In-Reply-To: <20150514211727.GA15528@peff.net> (Jeff King's message of "Thu,
	14 May 2015 17:17:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269102>

Jeff King <peff@peff.net> writes:

> On Thu, May 14, 2015 at 02:10:53PM -0700, Junio C Hamano wrote:
>> 
>> What I'll be pushing out today will have some "interesting" mark-up
>> in Documentation/git-cat-file.txt (on 'jch' or 'pu') from David's
>> '--follow-symlinks' topic.  I think AsciiDoc formatting looks OK,
>> but can you check it with both older (peff) and newer (dscho)
>> asciidoctor to see how well it shows?  Look for --follow-symlinks
>> in the output.
>
> What's in 366bc15e9 (your SQUASH) looks terrible with older asciidoctor.
> The "[normal]" bumps us out of the list item, left-aligning all of the
> other paragraphs, and then the "+" continuation is treated literally
> (probably because we are not inside a block).
>
> I don't see any reason we cannot use normal "+" continuation here (but
> the hanging paragraphs need to be left-aligned, then).

The use of [normal] with indented subsequent paragraphs is what
David's patch changed from my earlier suggestion, which used the
ugly bog-standard "+ with unindented paragraphs"; I was afraid that
it may lead to a fallout like this X-<.

Thanks for checking.  David, I think we need a v12 after all.
