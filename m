From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 13:41:10 +0100
Message-ID: <CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>
	<20121108200919.GP15560@sigill.intra.peff.net>
	<509CCCBC.8010102@drmicha.warpmail.net>
	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
	<509E8EB2.7040509@drmicha.warpmail.net>
	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
	<509EAA45.8020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sun Nov 11 13:41:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXWqr-0005LN-05
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 13:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab2KKMlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 07:41:12 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45814 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2KKMlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 07:41:11 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5440029oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 04:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wnMxropOIm9BdZ+iyWNUf+wCX2LFz819poMhlKO3qGw=;
        b=TZkG3xOMJ/Z8Zv3nwdSkriu7jN0iQK90VU5ffetXiJK0/BedjjTvqhDzSqwgPlid+J
         YuLfavXIOQlo/9DJqbBgkOJl5tqwP/Llg5bfPiByFyock+28MfOCRQIzdeb4lX/4VJKq
         UfXVp+XpdAf4RVQFru0GPY22sFhNusPQvMQIxFr08zcC8h9Ep/UfxWvdzkzp/UFxgGc9
         CVdviWJSz+w+u77qAJ3SjDIzvT26im97yvn3tihv23PUUSHc6aFUz8UT+2loxpIvqHl0
         Km0wmPimfhGBJH2EwiIKv601b7av5l2qpSckpyokmMH+X9qJhXg0/X0AxL3hxLgWKxTf
         yRWQ==
Received: by 10.182.38.101 with SMTP id f5mr13051336obk.80.1352637670689; Sun,
 11 Nov 2012 04:41:10 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 04:41:10 -0800 (PST)
In-Reply-To: <509EAA45.8020005@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209348>

On Sat, Nov 10, 2012 at 8:25 PM, A Large Angry SCM <gitzilla@gmail.com> wrote:
> On 11/10/2012 01:43 PM, Felipe Contreras wrote:

>> So, the options are:
>>
>> a) Leave the name conversion to the export tools, and when they miss
>> some weird corner case, like 'Author<email', let the user face the
>> consequences, perhaps after an hour of the process.
>>
>> We know there are sources of data that don't have git-formatted author
>> names, so we know every tool out there must do this checking.
>>
>> In addition to that, let the export tool decide what to do when one of
>> these bad names appear, which in many cases probably means do nothing,
>> so the user would not even see that such a bad name was there, which
>> might not be what they want.
>>
>> b) Do the name conversion in fast-import itself, perhaps optionally,
>> so if a tool missed some weird corner case, the user does not have to
>> face the consequences.
>>
>> The tool writers don't have to worry about this, so we would not have
>> tools out there doing a half-assed job of this.
>>
>> And what happens when such bad names end up being consistent: warning,
>> a scaffold mapping of bad names, etc.
>>
>>
>> One is bad for the users, and the tools writers, only disadvantages,
>> the other is good for the users and the tools writers, only
>> advantages.
>>
>
> c) Do the name conversion, and whatever other cleanup and manipulations
> you're interesting in, in a filter between the exporter and git-fast-import.

Such a filter would probably be quite complicated, and would decrease
performance.

-- 
Felipe Contreras
