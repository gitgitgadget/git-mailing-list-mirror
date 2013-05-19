From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH/WIP 0/9] for-each-ref format improvements
Date: Sun, 19 May 2013 18:37:49 +0530
Message-ID: <CALkWK0=B+WrXgNq_m_-nk=WYDDbXb1GU15MGNFiDr87ZQAUihw@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
 <CALkWK0=7z91A54jSzc2yZU3g50u8H_f8su1Y+i=D+KxYtqor5g@mail.gmail.com>
 <CACsJy8DMF3NzvMRUO56H+EwpXSjmY9qzdNdv9cGJ9XxUO=ekJA@mail.gmail.com>
 <CALkWK0kYDB+cCsD7Fsymf9ETR2Ymyaf072gCUu6Uh8yFVFJV2Q@mail.gmail.com> <CACsJy8DhdR-jWQmL1aYSnH=6w9RKGp0_pRnAzvZEPbJ7MSdMtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 15:08:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue3M1-0003YQ-Cl
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 15:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925Ab3ESNIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 09:08:34 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:60839 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3ESNId (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 09:08:33 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so12285188iec.36
        for <git@vger.kernel.org>; Sun, 19 May 2013 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=abT/GHHBsbpkvVL9NukgsdRB198CO6LQ23vbziLmB84=;
        b=zaQsy+YlxrKkTapmeft9YJ80FVJjNWuxhS9mJkTzRdKethzy/GidN4fdJkb91KEHb6
         2m1pLVpZ9XmhgmAQXSNqzMpUBTdNIGol/svwXczRd4RFbwqtOyqX8z7mEAxrGfHxpOv0
         8useIGyAeShgPG38YXKq8FduCPI9wSkL3TdCKdzpK8lZB3H/sV/oSWole7h9FGUBMw+b
         G/YL/7v/tkkbxzSOtqkNMt3QptgzNJYf7fqnvAUchEFyUNh86zve6TCXJz5URhymAWWt
         GbWyMUOw5LvwdNIlEvhHylp7/U+Ko7s/x77E8grigcExGh09V3hBuHdZMMf0iCwwjmTQ
         EBYw==
X-Received: by 10.50.73.65 with SMTP id j1mr3018117igv.49.1368968910009; Sun,
 19 May 2013 06:08:30 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 06:07:49 -0700 (PDT)
In-Reply-To: <CACsJy8DhdR-jWQmL1aYSnH=6w9RKGp0_pRnAzvZEPbJ7MSdMtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224885>

Duy Nguyen wrote:
> I don't think you can easily borrow parsing code from pretty-formats
> (but I may be wrong). Anyway new stuff with new syntax would look
> alien in for-each-ref format lines. Either we bring --pretty to
> for-each-ref, leaving all for-each-ref atoms behind in --format, or we
> should follow %(..) convention if we add new stuff to --format.

Why so extremist?  pretty-formats has %(...), %C(...) as well as %...,
so why shouldn't we?  Our format is undocumented, and I doubt anyone
even uses it; we're not breaking anyone's expectations.  I'm just
saying that our format can be a little reminiscent of pretty-formats,
nothing more.  There's no need to borrow parsing code: we can do it
ourselves, I think.  There is no need to go to the other extreme and
throw out the existing --format and start out with a --pretty from
scratch either: the current code isn't so bad that we can't build on
top of it.  Sure, we can eventually deprecate --format and move to
--pretty for consistency (but that's a long-term goal).
