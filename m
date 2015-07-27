From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Mon, 27 Jul 2015 17:18:38 +0700
Message-ID: <CACsJy8Dr29B7Lei-jFqgPViZwd6BZcJde0jkcAwySYcY2v8QqA@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-2-git-send-email-Karthik.188@gmail.com> <CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
 <CACsJy8Bq3y25QsQbntpNcVz=TQziiXY-XQ88Y_Cps10YF8zrJA@mail.gmail.com> <CA+P7+xob8eUf=oJHYN3fBB3k+XX+Jj8Vy0fKLtVQUGdsWDyaKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 12:19:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJfV4-000466-4q
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 12:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbbG0KTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 06:19:10 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34877 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbG0KTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 06:19:08 -0400
Received: by igr7 with SMTP id 7so65440726igr.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Bav03eHTgzIxL1FW+Oe7f3/GhtOoRFsrpuDcx0Fqqe0=;
        b=nejjK06VflolhRLrtr2Z/txmspo8lRtowBo6i+w3GkLSaQJ2tN1RHoaP6KRNDPEQhj
         XmD4MTeFXugsIFMOhN6sWxKRg5eR3APIeLlCe/dW2SZ2oW6ql7M7GsRlWSIMsuPbR67m
         1gAlZ4WJcKYPvVLCVvsTYgLz/Cwt+st20nb6Znx+Dcq3e62+OxRW6xZgKmFJ5+aVwiVK
         pPk2fGIbSnwBX4cCE31KkB4XXmPLXOEP1i0+RB4Cfqkw2b0L9TyCh8/WmqeKbpzXP2Tv
         RgJHkBrn1nlpAR29NXIiiHgeRVqPJbr4tCkE64HVDCjdFBVmaL5JwwQgTo7jz8cKBt4W
         Q11g==
X-Received: by 10.50.137.100 with SMTP id qh4mr15568563igb.1.1437992348131;
 Mon, 27 Jul 2015 03:19:08 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 27 Jul 2015 03:18:38 -0700 (PDT)
In-Reply-To: <CA+P7+xob8eUf=oJHYN3fBB3k+XX+Jj8Vy0fKLtVQUGdsWDyaKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274666>

On Mon, Jul 27, 2015 at 2:39 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sun, Jul 26, 2015 at 5:39 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Jul 26, 2015 at 11:08 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> You can generate an interdiff with "git diff branchname-v4
>>> branchname-v5", for instance.
>>
>> Off topic. But what stops me from doing this often is it creates a big
>> mess in "git tag -l". Do we have an option to hide away some
>> "insignificant:" tags? reflog might be an option if we have something
>> like foo@{/v2} to quickly retrieve the reflog entry whose message
>> contains "v2".
>
> You can normally find the previous commit via the reflog. Various
> changes to the settings can make the reflog be maintained for longer
> if you have longer lived patch series. That's how I would suggest it,
> rather than branches, as I tend not to keep old versions around on
> separate tags or branches.
>
> The problem with "foo@{/v2}" is that people don't always keep values
> inside the message it self, but maybe "foo@{/pattern}" would be a
> useful extension?

"reflog message" is different from "commit message". I was referring
to the first one (which is out of user control), perhaps you were
referring to the second one? I don't expect people to add v2 to
manually. If we have something like foo@{/v2} then we can teach
send-email (or format-patch) to add a reflog entry with "v2" in it.
But maybe we're abusing reflog..
-- 
Duy
