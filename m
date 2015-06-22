From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/19] parse-option: rename parse_opt_with_commit()
Date: Mon, 22 Jun 2015 09:27:02 -0700
Message-ID: <CAPc5daUWFx0YDHfRJynCiw7cBwDrDzyrY_TNDDBaDCVCDJb3ag@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-8-git-send-email-karthik.188@gmail.com>
 <CAPc5daVpqDC4K6ne=E_cdzG0NhfEYLucWdxVwKMf9WtDxzPUnA@mail.gmail.com> <CAOLa=ZQZ763F9AFpkGZ-ay2_q_3YCYXMuf_gYg-sQd=N-kyebA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 18:27:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z74ZD-0005AE-T6
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 18:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbbFVQ1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 12:27:24 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35164 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbbFVQ1W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 12:27:22 -0400
Received: by obbop1 with SMTP id op1so23079754obb.2
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 09:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=x8dlLcrqEJhcYxighVJ9MPqwxKHCT3OhDSv6/S/GuJA=;
        b=THvhQMuwMerwVToIiH8DVRrvI3zisY27j7BqEedhANKU8wI/cQG0rZSKv2FOoNO91u
         2e6UvrWcIZLMMPoaYaA+b9gua9Rrbr/Gwntp/m0qJbleEGNiEA4dpKv4SdFTGZgbi3Oj
         Jb1p06e56+cyWymtYqQJel5mhimuQEX1+NEjQ1jxfiFB2o72cRNiNi61F2pbIQV3KAhC
         XWVIjDe6IOQVbqVrSbLsGJlsv+RmZ37vuytZPiOBgrLpGYto6Z/rq5g8tdVnBqu0zZYQ
         4mkzFLYj2XLmxtD8wS3+6814rXlnnulwdQnJNMw5nm5Jyp3I+XRTVDTetgDCqCxGHEbt
         S2Jw==
X-Received: by 10.202.4.212 with SMTP id 203mr19266874oie.93.1434990441582;
 Mon, 22 Jun 2015 09:27:21 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Mon, 22 Jun 2015 09:27:02 -0700 (PDT)
In-Reply-To: <CAOLa=ZQZ763F9AFpkGZ-ay2_q_3YCYXMuf_gYg-sQd=N-kyebA@mail.gmail.com>
X-Google-Sender-Auth: H2whR2CIWDCOdR1P-EMwtbWCW5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272396>

On Mon, Jun 22, 2015 at 8:38 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Mon, Jun 22, 2015 at 6:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Sun, Jun 21, 2015 at 1:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> Rename parse_opt_with_commit() to parse_opt_commit_object_name()
>>> to show that it can be used to obtain a list of commits and is
>>> not constricted to usage of '--contains' option.
>>
>> I think that is a brilliant idea, but unlike the other function you
>> added earlier
>> that can do only one object and adopts "last one wins" rule, this is cumulative,
>> and that fact should be made clear to the developers in some way, no?
>
> Will add a comment

I didn't mean that. Can't we indicate this with plural somewhere in the name?
parse_opt_commits(), parse_opt_commit_into_list(), etc.?
