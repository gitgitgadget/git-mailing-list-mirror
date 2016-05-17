From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 12:58:08 -0400
Message-ID: <CAPig+cSFD+4zhvxpqjGWomq1uW3JxCNi6pQP3f_bp4Tr1Kg5aA@mail.gmail.com>
References: <20160517131635.GA5299@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Vasily Titskiy <qehgt0@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 18:58:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2iJy-0006Io-Su
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 18:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbcEQQ6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 12:58:10 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36847 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcEQQ6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 12:58:09 -0400
Received: by mail-io0-f174.google.com with SMTP id i75so31434783ioa.3
        for <git@vger.kernel.org>; Tue, 17 May 2016 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=ejZaBDcmDlx4xel31XI9OE6v4NDt6+WBKhvehgH0TLk=;
        b=N3M+FafEhYLRM/AId80b8QlewKYJA7wq+MwLovXxZt6uZtkzkwMMbdUHLToblAy801
         FH4IIYOq2dHRuBIJLLzGmEEgetpwjvedZav8W55lsy+N4UbXuBM7osG3DtzWERHYinxX
         CV+FQQ0hFAnuxmM+IHGb8Bumw7zY8bDSpWO66HooRBtHlLhcyTgLBP8QNP4Su1alX4X4
         qMYOATXb9Xqt1YdeFNtizEbxm+CDgLYnG1SxafWt1Jqo01reOtm2pCgeI2N9CxhQL4wg
         /UTHixYDP0FrUTJ8Zf7wUbwuIq2pM4K7XlIN4Z+S0rriz81SIQZodN7TRwaovoB+ZM6A
         /zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ejZaBDcmDlx4xel31XI9OE6v4NDt6+WBKhvehgH0TLk=;
        b=aQTsj5k0hlVy0CAz8sHai3Pb1acWOCZ+FYQQ1c9ozLxfo2VezjLSqsa6ykx5ETWlip
         LR8QLNFq5ph5g1XaX7a5uu8Trz4mD95WjehzLE8EOpX5xyL3RtedYcegXJ462ZJWb1nl
         GyI2QXpb3IgjL1YabpCaNzk1dOaEbamIDq/A4Oql4zpqJOqRMc5J36WUCxvCCBpljN3L
         f/bDvpiRUbG/W5uTPZ9I+KSfFv/rV9x8AD32HD7tth5Ltjat4qIDs1XT2v4wR2oxDhn9
         ZLxRZm4wFGl52tb5b1BLzb42Yg690oKsZ0mqN37Lgg6FIainDciTbebVLm3mBYiCjB/Y
         llwg==
X-Gm-Message-State: AOPr4FWkHRE4XLuBpB3X9WtmIc0ZPmaFge/sv/0sgYaM2PbYJrjyTci9RZBztChrWwmxf6KcMX3VUbJr9AT4Gg==
X-Received: by 10.107.132.66 with SMTP id g63mr2029600iod.34.1463504288189;
 Tue, 17 May 2016 09:58:08 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Tue, 17 May 2016 09:58:08 -0700 (PDT)
In-Reply-To: <20160517131635.GA5299@gmail.com>
X-Google-Sender-Auth: O57mPkI-i5RTS_OrXY8k9YH9g5U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294875>

On Tue, May 17, 2016 at 9:16 AM, Vasily Titskiy <qehgt0@gmail.com> wrote:
> As stash does not know how to deal with submodules,
> it should not try to save/restore their states
> as it leads to redundant merge conflicts.
>
> Added test checks if 'stash pop' does not trigger merge conflics

/conflics/conflicts/

> in submodules.
>
> Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
