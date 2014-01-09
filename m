From: Mathieu Lemoine <mathieu@mlemoine.name>
Subject: [BUG] git symbolic-ref does not recognize @ as the shortcut for HEAD
Date: Thu, 9 Jan 2014 10:05:22 -0500
Message-ID: <CAOBEgJjmoXEDVa4L5LbAGMYR7_+NCf2tDSveieZxtU4bfWyzDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 16:06:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1HBR-0007gV-K1
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 16:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbaAIPGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 10:06:06 -0500
Received: from mail-qe0-f54.google.com ([209.85.128.54]:54250 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbaAIPGD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 10:06:03 -0500
Received: by mail-qe0-f54.google.com with SMTP id cy11so3214004qeb.13
        for <git@vger.kernel.org>; Thu, 09 Jan 2014 07:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mlemoine.name; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Hd4jIHO03+YdbFxGThiDk8rQeHxCzkWIKu+0NPRz6gM=;
        b=hFjLCJkbDzJ81pgAeIOdbFIU6+b6Z7goURUDKUhhLMSdyP1Hj0iv25pkQR5WvWfbD/
         lSJPGpIijeVGKdxTZk1TQftRl+0NWbxR8rbzUo8XVe1eCYv6iYaTc9I6x/mCrXHWSjC4
         LzDABEYUOrhslPONUwphb2KYC/U3+I3Ep4dRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Hd4jIHO03+YdbFxGThiDk8rQeHxCzkWIKu+0NPRz6gM=;
        b=Hqu7wOawNoG3VzAM0iDmSFq4qS/OpF29wF/BO/3Luh13UqGJs//nY1OwIRtMWQqelX
         jAHbnJf8SSPwpwgZck9T+bb+ETCMY0/dlEi/4fNUdppFPdpXNAuT4nfGxNKoUKqmAo7p
         omrds5dHaP+kkNjDfQ1+ceRfk9Z5g1JVe01QFDWqQcl/sGF4sDzLnIT3Bd8K5lpVsJrP
         Fya46qcNxY9CiQLAPQ+Vc+OHxNDfn6840aMgjmVkwqF8LfZx/3J54EOnHlQOLek3Wqje
         eFe0TXR0M6AzPH0euj8+uzzR1w/Rawl0KeN/5QDpi9AgJ6Baph3oF7QfYCSif8Gx3RSw
         55cg==
X-Gm-Message-State: ALoCoQn9XdDjFJsNLFPjYKdSvRgLdwgfw9YkSGFx2IQ+0FkKtRrECR2RIqAJ8dly/dawpVyZ5XV7
X-Received: by 10.49.84.105 with SMTP id x9mr8267889qey.65.1389279962753; Thu,
 09 Jan 2014 07:06:02 -0800 (PST)
Received: by 10.229.230.198 with HTTP; Thu, 9 Jan 2014 07:05:22 -0800 (PST)
X-Originating-IP: [24.203.176.236]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240256>

Hello,

In https://raw.github.com/git/git/master/Documentation/RelNotes/1.8.5.txt
is mentioned:

 * Instead of typing four capital letters "HEAD", you can say "@" now,
e.g. "git log @".

However, `git symbolic-ref @`  gives "fatal: No such ref: @", while
`git symbolic-ref @`  gives "refs/heads/master".

I looked around in the archive and #git, but nobody seemed to be aware
of the behaviour.

I wonder if it's on purpose given the low level of symbolic-ref or if
it's a bug.

Mathieu Lemoine.
