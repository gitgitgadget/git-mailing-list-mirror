From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: restructure format_config() for better control flow
Date: Thu, 20 Aug 2015 13:19:46 -0700
Message-ID: <xmqq1tex7lwd.fsf@gitster.dls.corp.google.com>
References: <xmqqa8twj7b8.fsf@gitster.dls.corp.google.com>
	<1440080062-26811-1-git-send-email-szeder@ira.uka.de>
	<20150820144504.GA22935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 20 22:19:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSWJW-0007eh-1d
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 22:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbbHTUTt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 16:19:49 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34060 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbbHTUTs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 16:19:48 -0400
Received: by pdbfa8 with SMTP id fa8so17907904pdb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=hbhLZsk+4ssEndZPOG9zI80x0e6GLNFNv52xwf1p6hs=;
        b=GJyEb8sVL7gA0KYQrIfAR3NWx+QUi5udUbX1s/gRo8inUanxPDDBt3hrRGwbf4o2YH
         fJqHqVX8EHc+xKXpTPfwNDQnWrnXfGOpyIt9xas1Jn7uzRdl5gUMGRReNnpWHmcuYp2w
         sfDzV4azkqD878oJgYJlb06qzBS4pJQjuwMpyIV6X1AgmbJTYfUxjtb0kJRvTPHE6ATt
         Ao2zks07D3cn3SEmNm4AC/GawYvSKoClioy/U8A1cdaOANdz83ukIyrigBGRZFF7HDHu
         PFixb0r7WhbARb6v3WeLhalfk/Ia6xhzV4S8LTgsls/iPL+qmLSwDaCxZNmNHcc2Mn3v
         r/uQ==
X-Received: by 10.70.125.169 with SMTP id mr9mr10075597pdb.22.1440101987759;
        Thu, 20 Aug 2015 13:19:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id gu2sm5309112pbc.1.2015.08.20.13.19.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 13:19:46 -0700 (PDT)
In-Reply-To: <20150820144504.GA22935@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Aug 2015 10:45:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276263>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 20, 2015 at 04:14:22PM +0200, SZEDER G=C3=A1bor wrote:
>
>> Commit 578625fa91 (config: add '--name-only' option to list only
>> variable names, 2015-08-10) modified format_config() such that it
>> returned from the middle of the function when showing only keys,
>> resulting in ugly code structure.
>>=20
>> Reorganize the if statements and dealing with the key-value delimite=
r to
>> make the function easier to read.
>
> This looks good to me. What do you think of these on top?
>
>   [1/3]: format_config: don't init strbuf
>   [2/3]: format_config: simplify buffer handling
>   [3/3]: get_urlmatch: avoid useless strbuf write

All four including the thread-starter by SZEDER look good to me.
Thanks.
