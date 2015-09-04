From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] a tale of Git 2.5, ssh transport and GIT_* environment variables
Date: Fri, 4 Sep 2015 23:10:52 +0200
Message-ID: <CAOxFTczPD00rw3nmaYjM=afXez_07p8kM28XY__opLKsVOaWxg@mail.gmail.com>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
 <20150904125448.GA25501@sigill.intra.peff.net> <xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 23:11:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXyGT-0007Yg-1V
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 23:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933900AbbIDVLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 17:11:13 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33889 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932856AbbIDVLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 17:11:12 -0400
Received: by wicfx3 with SMTP id fx3so34307078wic.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9kXL5BPv0j21e57WLZDkH+7AiOPGN8Mbt3XZYRkX68w=;
        b=pLmzlHMckJEJChJSxSOOCBbNgjGkhnjCuPPkTfKUPV5g5jI8tO5ULnCJl6JX2wV/xa
         AdfKnFIvmyCZmQfrl2m1ofTB87qTWURwGa8OlZqAafznUjy9+n6yT1Fyl79yySH/k+ZQ
         xhIWOsKZGRoc1pNgSDmBFp5vCFtEDP94j78ITsbRn1FCWQpc9gzCVtPOEcbOLVxtyCJS
         s4j3c64YgSeNeYuaiG2N9/frlawcHMbTbFQjcsLQFTbMGzJxgy5dzv7JpPgbFaovfXjO
         iOYFht9Y/O8MxQEIxevHIfGrAjNjkf4MMuUwrpgHgGgAcP1JjS+rkMDIHBAhgAiN6w3T
         7PEw==
X-Received: by 10.194.175.200 with SMTP id cc8mr11186676wjc.87.1441401071577;
 Fri, 04 Sep 2015 14:11:11 -0700 (PDT)
Received: by 10.194.101.100 with HTTP; Fri, 4 Sep 2015 14:10:52 -0700 (PDT)
In-Reply-To: <xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277333>

On Fri, Sep 4, 2015 at 8:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> It shouldn't be necessary for $GIT_DIR, but it makes sense for other git
>> variables. E.g., with "AcceptEnv GIT_*", "git -c" config is propagated.
>> E.g.:
>> ...
>
> Just to make sure I got you correctly, you are saying that "we
> propagate, but that is not correct. We should stop doing so", right?

Indeed, we should not propagate them. For what we know so far, at
least GIT_DIR and GIT_WORK_TREE should be removed from the ssh
environment, in case the remote server has AcceptEnv GIT_* and an
older git version.

-- 
Giuseppe "Oblomov" Bilotta
