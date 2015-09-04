From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: determine name of tag used for checkout when multiple tags exist?
Date: Thu, 3 Sep 2015 21:59:53 -0700
Message-ID: <CA+P7+xo8BM1hCnkh3pa65eF=qne3yybTBCoBY3mqm8FfzwdShg@mail.gmail.com>
References: <CAL3By-8odLE53iBiNATgiCcnK4Ef5uBeH7E6EMB1K7P-oX0oAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jesse Hopkins <jesse.hops@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 07:00:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXj6q-0006cI-Um
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 07:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbbIDFAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 01:00:14 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33365 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbIDFAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 01:00:13 -0400
Received: by igbkq10 with SMTP id kq10so8740857igb.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 22:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KO2f1U1c8Ueah8WlFsl1sFxciyn872DBLW7ebcFKKnY=;
        b=CNmgtZI/08YgBd8v3jBUiBzqEQe3QYCKjD86PzVQSvk4t4eaxXjocehSGRM+nO0fbD
         c4NK3Sn/6T3OJixRZ3BE88IEz03Ta1ZMgA4EBlyxsxF9IrsDjEDzwSuRgFwy2+bJcGBA
         HfoXd7c60vCEN5NO3hqFSDIPArZ5NPoqDmfD3ApxL/6+qBgG9pveLcX5FAEuwUKGBtAD
         0sFCPccSkBWUe8yk3RjpXJRcJl6OMgyQLdA4lLzEh8H0gnlDh6oW4k9OqVj99ROf/sri
         ba41hi6qE8rKmwycZnRW3BiWQeMIzJUBC65djw1rwaGcDqKTiDSeK/GcN3DuQdbja7ZW
         yg1Q==
X-Received: by 10.50.178.145 with SMTP id cy17mr3571611igc.92.1441342812699;
 Thu, 03 Sep 2015 22:00:12 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Thu, 3 Sep 2015 21:59:53 -0700 (PDT)
In-Reply-To: <CAL3By-8odLE53iBiNATgiCcnK4Ef5uBeH7E6EMB1K7P-oX0oAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277286>

On Thu, Sep 3, 2015 at 7:53 PM, Jesse Hopkins <jesse.hops@gmail.com> wrote:

>
> It seems to me that when checking out to a tag, Git does not record the
> *name* of the tag anywhere, but rather sets HEAD to the de-referenced
> commit SHA-1.  As far as I can tell, it is not possible to recover the
> original name of the tag in the case of multiple tags on the same commit.
> Is my conclusion correct?
>

I believe you are correct unless you check out to a branch named after
the tag? I don't believe it will actually store the tag as part of its
checkout.

Ie:

git checkout <tag>

may show "checked out at <tag>" via status, but that is only because
status uses describe to find that out..

I don't believe we store the information. You could recover it if you
know something about the format so as to distinquish them, ie: if you
only cared about annotated tags vs lightweight tags, for example.

Regards,
Jake
