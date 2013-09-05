From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Thu, 5 Sep 2013 12:04:00 +0700
Message-ID: <CACsJy8CX=4Oz_h2NtS3FRdK6_zdFksa+JR5C6Z-z3Y70PLAsyQ@mail.gmail.com>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
 <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg> <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
 <CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com>
 <alpine.LFD.2.03.1309042350560.14472@syhkavp.arg> <CACsJy8BeU_01c0f5RJExcYo7xGETnduKOw-_shszHd0ZFgZDXw@mail.gmail.com>
 <alpine.LFD.2.03.1309050024090.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 07:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHRkB-0002Pg-H5
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 07:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732Ab3IEFEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 01:04:31 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:63215 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab3IEFEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 01:04:31 -0400
Received: by mail-oa0-f44.google.com with SMTP id l17so1668609oag.31
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 22:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WIfXDDA12+7KKItzWTJAyZY2mMX+EwWCxrb3Qvx+y7E=;
        b=ePeDu8tPrGpgTND8i8THphe5M31y2+mLqgdtqImOfeHjfF7JleSJasGOkCA6b68ulG
         ECBEQLPZN+vZ+arwtyjEdG7GVsf7GlDsI4vzFtYKat5QyJIX5M/lHrM9Tqb/qMGvVy0s
         I4TP7lXiv2dJwVuYqm3NXZRuiGvLaIbCNMYxHnyww8ROCCHgbR+1OXkhs6SfjvS43bwW
         0U7img4Gcsp0CfBMx9E5a1+rqyjidQYNlMcuS3v2CNgAOwLwK6ejm3KjnLgNStnr5co6
         Tdx4YyFAR+oNRRA0ibn9BOsk7B1jY2cbDwSNcYdZoQT+ydjpM6FWeTLt0yy+FJQDqHML
         4PxA==
X-Received: by 10.182.98.162 with SMTP id ej2mr5051558obb.61.1378357470589;
 Wed, 04 Sep 2013 22:04:30 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 4 Sep 2013 22:04:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309050024090.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233892>

On Thu, Sep 5, 2013 at 11:40 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 5 Sep 2013, Duy Nguyen wrote:
>
>> On Thu, Sep 5, 2013 at 11:12 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > Many other bugs have now been fixed.  A git.git repository with packs
>> > version 4 appears to be functional and passes git-fsck --full --strict.
>>
>> Yeah I was looking at the diff some minutes ago, saw changes in
>> pack-check.c and wondering if fsck was working. I'll add v4 support to
>> index-pack.
>
> Beware that the tree delta encoding has changed a little.  This saved up
> to 2% on some repos.

Thanks for the heads up.

> I'll probably change the encoding to incorporate the escape hatch
> for path and name references as discussed previously.
>
>> Waiting to see the new, v4-aware tree walker interface
>> with good "rev-list --all --objects" numbers from you.
>
> Well, unfortunately I've put more time than I really had available into
> this project lately.  I'm about to call for other people to take over it
> and pursue this work further.
>
> I really wanted to set the pack format direction since I've been toying
> with this for so many years.  Now the tool to convert a pack is there,
> and the read side is also there, proving that the format does work and
> the encoding and decoding code is functional and may serve as reference.
> So that's about the extent of what I can contribute at this point.
>
> I'll be happy to provide design assistance and code review comments of
> course.  But I won't be able to put the time to do the actual coding
> myself much longer.

You've done a great job in designing v4 and getting basic support in
place. I think you'll need to post your series again so Junio can pick
it up. Then we (at least I) will try to continue from there. I have
high hopes that this will not drop out like the spit-blob series.
-- 
Duy
