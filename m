From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: bzr to git syncing
Date: Fri, 28 Aug 2009 10:49:39 -0700
Message-ID: <fabb9a1e0908281049t64f06a2r5efa114c7bcdc468@mail.gmail.com>
References: <F84D4C0F-1CEF-4853-84DB-B7927CBE62B3@gmail.com> 
	<b2cdc9f30908280902m22d594bam3c70259d4c296e52@mail.gmail.com> 
	<fabb9a1e0908280919o412baeb1ka69968a93297ca59@mail.gmail.com> 
	<b2cdc9f30908281047p76c12029u21b100ae6d88fe93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, David Reitter <david.reitter@gmail.com>,
	vcs-fast-import-devs@lists.launchpad.net
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:50:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh5aU-0003Zs-Tm
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 19:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbZH1RuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbZH1RuA
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 13:50:00 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:58461 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbZH1RuA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 13:50:00 -0400
Received: by ewy2 with SMTP id 2so2344134ewy.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=f83pa9FeQn0dfofzezmcQ+H55rzCWUbt6hE+mOK5noM=;
        b=tJw0sIo5G3knRq1Tfb/EhPQSOnWr5N+mcXfpZ98Ky2SXdkcykBzqgZ60jyzT3/yuNW
         oX7eDs0fXjOLaTFshXD/xzdwwttuEg8V7k3GPWPV4xftGPoRaS4Xdwza7ZS9yN1pPndp
         EIb4owqDwX3afIY2gBpMvl3oesbDgpsHjhGgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PEf4y4cNx/pPEwDmAs0fZhiKU6ygguaGs4RDdmGPXMxv+F2b6wbKCR/wJcRfA0nh7U
         tPGyJ4CTQ6n4MqVnr9+ph3W0MpfpUNIRd9eqvoUGM+9pjqUEBtoGlI3bHO5L8zoGqM6S
         kBe8dFb6lctyDgv2lwJ9AknHw3LIGp68Kb1qQ=
Received: by 10.216.36.79 with SMTP id v57mr329091wea.19.1251481799269; Fri, 
	28 Aug 2009 10:49:59 -0700 (PDT)
In-Reply-To: <b2cdc9f30908281047p76c12029u21b100ae6d88fe93@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127319>

Heya,

[+vcs-fast-import-devs]

On Fri, Aug 28, 2009 at 10:47, Alex Bennee<kernel-hacker@bennee.com> wrote:
> 2009/8/28 Sverre Rabbelier <srabbelier@gmail.com>:
>> On Fri, Aug 28, 2009 at 09:02, Alex Bennee<kernel-hacker@bennee.com> wrote:
>>> I've attached the fast-import crash I'm seeing. Are you seeing the
>>> same sort of failure?
>>
>> The program you used to generate the stream (I assume git-bzr?) is
>> generating an invalid mode, git understands '100644', '100755',
>> '120000', and '160000'; the mode in the stream, '040000', is not
>> something we understand.
>
> Yeah, it seems in bzr land it mean new directory which we don't care
> about. The following patch makes it work. Apologies for failure to
> inline but Gmail would just corrupt it if I tried.
>
> I also had to patch the ref check code to accept bzr style branch
> names but I suspect that patch should be kept out of the repo.

This seems like a fine case for the new 'feature' command on bzr's export side.

-- 
Cheers,

Sverre Rabbelier
