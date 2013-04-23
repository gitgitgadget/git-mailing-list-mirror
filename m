From: Joel Jacobson <joel@trustly.com>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Tue, 23 Apr 2013 01:00:50 +0100
Message-ID: <CAASwCXcfCNqiMXD5JasTRKWZgCNsxnUY7k9E=f86xsTZjk37CA@mail.gmail.com>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com>
	<7vip3em8rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 02:00:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUQfI-0003ye-FC
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 02:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab3DWAAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 20:00:52 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58923 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab3DWAAv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 20:00:51 -0400
Received: by mail-vc0-f174.google.com with SMTP id kw10so41654vcb.33
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 17:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type:x-gm-message-state;
        bh=UekncZNyr9r9IppLSxfNRKFn0wJxq/2Pt1kbeBFWSQA=;
        b=TQX1cN3+QVX3eGVBV9HF3t+Sc9o9RYvyODR4jhnxXDg1cYX3B+/8dTEFzrvb/z5KV9
         yzsQkZXzi7Xgk8arM3sJm6cVtiAfHpGDxfFOtAE8DqevbjufTz5be2j6wnynv9AFJtuv
         MUJBE8gpgfw/as7Bg+QDmih4FhmYUESTFW/8F99E5KCv4HwDsYjm3ax4SdrI2mOWvNoE
         6UHH65A6T65eT1nIqf47SV36e6+fVwGMlSlPTvyrsbS96uPbzeFDcMM8yMkNo0iUsH41
         AqQdGDC/zNFXdrLQ4Qpt1y3wCKvecae1BqPzR3ng8pMld/274scrT8PlbfC2gIK+4+X5
         Gpow==
X-Received: by 10.52.111.100 with SMTP id ih4mr17392655vdb.98.1366675250621;
 Mon, 22 Apr 2013 17:00:50 -0700 (PDT)
Received: by 10.59.11.169 with HTTP; Mon, 22 Apr 2013 17:00:50 -0700 (PDT)
In-Reply-To: <7vip3em8rs.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnqXUNu9AHvp9WsbGOKv7CA/RG1+SeyCgNtyKZ2nQJyQYul+QFfTk6hWTCEx7afRO995Zyl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222132>

On Tue, Apr 23, 2013 at 12:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> No docs?  No tests?

Maybe simply adding this text to git-commit.txt,

The default can be changed by the 'commit.gpg-sign' configuration
variable (see linkgit:git-config[1]).

after,

-S[<keyid>]::
--gpg-sign[=<keyid>]::
GPG-sign commit.

would be sufficient?

Not sure what the proper way to test this,
could you please suggest any other unit test I could look at for inspiration?

> As to the design, any regular configuration variable settings must
> be overridable from the command line for a single invocation. Please
> design an escape hatch in, for somebody who has this configuration
> variable set, but does not want to sign this commit he is about to
> make.

Something like --no-gpg-sign?

> Also do we generally use dash in the configuration variable names?
> I thought the norm was section.CamelCase.

Since the command line long option is "gpg-sign", I thought it was best
to use exactly the same term in the configuration variable name to
avoid confusion. Is there any problem with dashes in variable names?
