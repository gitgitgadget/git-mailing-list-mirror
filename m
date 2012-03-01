From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 16:40:02 +1100
Message-ID: <CAH5451m-Ks+UywfMWfC1TS=5n102VasdgJ0tg-pGym69B2NPQQ@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <rmifwdti2ap.fsf@fnord.ir.bbn.com> <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com>
 <buo399s3nph.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Troxel <gdt@ir.bbn.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 06:40:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2ykt-0003r8-CU
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 06:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392Ab2CAFk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 00:40:28 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37666 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab2CAFkY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 00:40:24 -0500
Received: by wibhm2 with SMTP id hm2so68672wib.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:40:23 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.106.9 as permitted sender) client-ip=10.180.106.9;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.106.9 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.180.106.9])
        by 10.180.106.9 with SMTP id gq9mr6121704wib.17.1330580423003 (num_hops = 1);
        Wed, 29 Feb 2012 21:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NLfev7lU/RltiY+MWhE6CBGttxcRECF5IXqTrJ+BOnA=;
        b=nnEY8+k5MMtajiCALFMp7lz74+kjyvgUcvI3WLDFn94rGjRvxdLEDbxQvKoglwIf2e
         M64tQ++R+dKNGdX1yLbnu6BENFiW6WnvdenkmskH97vlwgQXcqIyftA3ehpz4yGffC49
         qYDtEgMSoK3Ve74rUYWaCqHzL8gIVp1qMptbc=
Received: by 10.180.106.9 with SMTP id gq9mr4906077wib.17.1330580422947; Wed,
 29 Feb 2012 21:40:22 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Wed, 29 Feb 2012 21:40:02 -0800 (PST)
In-Reply-To: <buo399s3nph.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191898>

On 1 March 2012 16:16, Miles Bader <miles@gnu.org> wrote:
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>> Additionally, if we are not prepared to use non-Free tools, we should
>> probably stop using github.
>
> I think the issue isn't "using" non-free tools so much as it's getting
> _locked into_ non-free tools.
>
> So if JIRA makes all its data trivially exportable in a format which
> is easy to use,

JIRA provides the ability to trivially export any 'filter' as XML or
CSV data files. A filter is simply a search, and can contain every
single issue in the database. Some pieces of information are slightly
more difficult to migrate.
- Issue attachments such as screenshots are not stored in the
database, and we would have to request them in order to retrieve them.
- User information and configuration data is only available in a full
site backup (which is available on request).
- CSV export option does not include comments. (XML, and Word formats do)

Additionally, there are quite a number of tools to allow migration
between JIRA and other tools, and in my experience Atlassian are quite
helpful when you try and move off their products.

> and there's some way of isolating references to it so
> that it's possible to switch to something else without undue hardship

JIRA has the capacity to automatically link issues to commits which
mention issue numbers, however this is by no means essential or
necessary functionality. JIRA will be happy completely detached from
the rest of the world, and will provide additional functionality
gradually as it becomes more integrated. Some functionality it can
provide without forming hard links with the outside world (like
polling the repository and providing continuous builds)

The primary thing to look out for would be other sites linking to the
issue tracker. Unfortunately, there is no way at the moment to provide
an alternate URI for the tracker, so it is hard to avoid this from
happening.

Regards,

Andrew Ardill
