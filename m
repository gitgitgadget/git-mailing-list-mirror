From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Tue, 28 Apr 2015 17:33:27 +0530
Message-ID: <553F770F.9030106@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117174-4968-1-git-send-email-karthik.188@gmail.com> <20150419002807.GA11634@hashpling.org> <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com> <20150420074433.GA30422@hashpling.org> <8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com> <20150420091920.GA31279@hashpling.org> <553520CF.6070304@gmail.com> <20150421101641.GA13202@hashpling.org> <CAPig+cRmPv5u_OCtUPNoYOUcOoa9xn++Xw-rkD6EP6_eq0YvEQ@mail.gmail.com> <xmqqh9s9gqw9.fsf@gitster.dls.corp.google.com> <553B78E2.5070608@gmail.com> <xmqqsiboyw90.fsf@gitster.dls.corp.google.com> <553E2427.4090700@gmail.com> <CAPig+cTcAq_p3QXqcG+o1saWZyvDHCW=_JWYn6s7B1L4X5X1cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 14:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn4Ek-0000R1-2z
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 14:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965418AbbD1MDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 08:03:33 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34780 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965406AbbD1MDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 08:03:32 -0400
Received: by pacyx8 with SMTP id yx8so162617722pac.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sezs3EBEM2XzEszacC57qoRKEIEuyDuYYdWy5p3O4Nk=;
        b=Xi4Bpa7n89bgIeyjKD2Y+FL5cV14n5SAf7rZo53hIHrZ9qAnR+ip7TQmaCc+d9SBYI
         4SVJzPcCfaPrsjnL082lZjOnjqtRKn6xvbwhMQQH6sdxTuFDALLXEbJVY4MeEPqsj5eX
         XWi5nVVplSrxZMmoYJqs9TeoSlFvx88OZm4A+YQVy4zFpv4G/nOvU1tnKnOXztjF7HJp
         6ulm1nvCczQteOK8Eew171ZckKKIU1gnlsfMaxPIZRXMqy0HnA46ZqRqH3pRNsgkFDjR
         XbTUE4/PXa31FzH6iwlUTnH2IEfOjeaZj0qJAdOv8oNPuqztzLXab4AV+SZkueKDZIPA
         rK/Q==
X-Received: by 10.68.197.161 with SMTP id iv1mr31717535pbc.0.1430222612440;
        Tue, 28 Apr 2015 05:03:32 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id al13sm22427831pac.23.2015.04.28.05.03.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 05:03:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cTcAq_p3QXqcG+o1saWZyvDHCW=_JWYn6s7B1L4X5X1cQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267921>


On 04/28/2015 12:08 AM, Eric Sunshine wrote:
> On Mon, Apr 27, 2015 at 7:57 AM, karthik nayak <karthik.188@gmail.com> wrote:
> > On 04/25/2015 10:34 PM, Junio C Hamano wrote:
> >> karthik nayak <karthik.188@gmail.com> writes:
> >>> Yes this gives the best description, but its large, while we could use
> >>> something like --no-strict instead.
> >>
> >> We could, if you answered my first question with "no".
> >>
> >> By naming this "--no-strict", the first bug report you will receive
> >> may be that "cat-file --no-strict" should parse a zlib deflate that
> >> begins with "blob 1234\n\0" (notice that there are two SPs instead
> >> of the usual one, and length is followed by LF that should not be
> >> there before the NUL) but it does not.
> >>
> >> As your option name "--no-strict" signals that you will make the
> >> best effort to parse such nonsense, that would be a valid bug
> >> report, against which you would need to update the code to make it
> >> work.  But is it worth the effort to make such a thing work?  I
> >> dunno.
> >>
> > Nice point, I don't see the need to parse such objects at the moment.
> > That rules out "--no-strict" and everything similar.
> >
> > I still find "--allow-unkown-type" a bit too big, what about something like
> >
> > * --any-type
> > * --arbitrary-type
>
> As a diagnostic aid when encountering a (hopefully rare) broken or
> corrupt object, this option is not likely to be used often. The
> "allow" in --allow-unknown-type conveys the intended purpose more
> accurately than either of the shorter names suggested above; and
> considering how infrequently it is likely to be used, the extra six
> characters should not be a significant burden.
>
You do have a point, thanks for putting it out. Will stick to "--allow-unkown-type".
