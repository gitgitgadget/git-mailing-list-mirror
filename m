From: demerphq <demerphq@gmail.com>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 22:59:08 +0100
Message-ID: <9b18b3110903191459q23af2bf9q998de27feb8dae2a@mail.gmail.com>
References: <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com>
	 <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com>
	 <20090319151610.GO23521@spearce.org>
	 <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com>
	 <20090319201405.GD17028@coredump.intra.peff.net>
	 <9b18b3110903191440w20ca9801pfb218cc4b10ea769@mail.gmail.com>
	 <20090319214317.GU23521@spearce.org>
	 <20090319214432.GV23521@spearce.org>
	 <9b18b3110903191451u56bbee7biac3a1fee4a36b71d@mail.gmail.com>
	 <20090319215331.GW23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQId-00029I-HH
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144AbZCSV7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 17:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757157AbZCSV7N
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:59:13 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:43637 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475AbZCSV7K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 17:59:10 -0400
Received: by yx-out-2324.google.com with SMTP id 31so728443yxl.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8FgPQwK8dtzPQk1bqTWkOgX6r1vCmyerDMcAgc2Vz0I=;
        b=WzS+NVr+Ns0K/Js3oSzEceu7shEzxWlFs8M4FameeCCu4s2a9N/3y5qJBXnNCfLp/q
         r6S1qcG+7ARWaSwOOBlxYRvkwY+dW3deWkBgGmftMclbgQT2q6F7uMI0CykCsYHu18PV
         6aRM63q8BSBsrmCaEL9KuzsqkjW+QYIPRpPQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=evxp8ydJTl6heliM7SMUfxSriZmpJHHNaa8crdenhIqnj6q5Cu8TbHrX6dSQskNqRE
         jgJ3h44B0CPyc0+VKdP7tnk7Ns3O/8l5jpqCOctHb6932WKbZFMugTJlZyVLaideYwXe
         Q7VblFIy7iI3BNLkqE/AX8E/mpwMBnRAFrelE=
Received: by 10.231.19.70 with SMTP id z6mr969453iba.29.1237499948283; Thu, 19 
	Mar 2009 14:59:08 -0700 (PDT)
In-Reply-To: <20090319215331.GW23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113842>

2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
> demerphq <demerphq@gmail.com> wrote:
>> 2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
>> > "Shawn O. Pearce" <spearce@spearce.org> wrote:
>> >
>> > git log -g branch@{now}
>>
>> Ah! Much nicer! Thanks.
>>
>> Is there by any chance any way to set the date format it uses to
>> something more suitable for machine processing?
>
> I don't think so. =A0If you want to machine process it, why not
> just read the reflog directly? =A0Its a really simple format.

Mostly my problem with that is that it violates the abstraction. If i
update git and the reflog format changes my script breaks. I dont
necessarily know where it will be located, etc. And while no doubt i
can reverse engineer the format, well, who knows maybe Ill miss
something important, I mean is it documented anywhere?

So i guess if the format were documented (and thus changing it would
break compatibility and be noted in the changes file) then it would be
fine to do so, but it seems to me making a way to access the reflog
data in a structured way via a plumbing level command makes more
sense. (At the very least this abstract the user of having to figure
out where the log is stored).

Yves




--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
