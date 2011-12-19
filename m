From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: post-receive for web deployment
Date: Mon, 19 Dec 2011 16:05:03 +0530
Message-ID: <CAMK1S_hjncBxdh4+UXAJbtJnsPWZUpWASyixG8eNcpFLMRpLgw@mail.gmail.com>
References: <CALzTOmJUqzO8H5UxyFaodi98DBJtFvsbQsHsYh1U=Ggq3NRO5A@mail.gmail.com>
	<CALzTOm+sJHF_7WzjD7bCqAiAbQSV0A3hEX1KdWfFzV7-ePzX2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stephen Major <smajor@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 11:35:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcaYn-0001PO-Hb
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 11:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab1LSKfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 05:35:05 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48271 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab1LSKfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 05:35:04 -0500
Received: by ggdk6 with SMTP id k6so3861022ggd.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 02:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EeCwKcXChRU18puV9Q8DEp5J5ENutOcJVCW2P+se3uM=;
        b=nN3ci41vqPla/BYpQ8LutT9SFIBKtof33csiXt82ZD5yUnv8WkDXytsmlyGSxQah+8
         eLROe+eSNFDC9kHEhLO4JgMcXz6MHdfb9J3fpWM1NoVatIoa9dWBhV2l2kKcaqMuFHck
         KUEjU71gtyEhSAWIkCjjjZYIuPfj3RmscnCM4=
Received: by 10.182.54.80 with SMTP id h16mr9880213obp.59.1324290903266; Mon,
 19 Dec 2011 02:35:03 -0800 (PST)
Received: by 10.182.50.129 with HTTP; Mon, 19 Dec 2011 02:35:03 -0800 (PST)
In-Reply-To: <CALzTOm+sJHF_7WzjD7bCqAiAbQSV0A3hEX1KdWfFzV7-ePzX2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187446>

On Mon, Dec 19, 2011 at 8:12 AM, Stephen Major <smajor@gmail.com> wrote:
> Hello,
>
> I am having some difficulty understanding what I am doing wrong when
> working with git to deploy a website through the use of a post-receive
> hook on the remote.

The most common issue I have seen in cases like this is that you need
to 'unset GIT_DIR'.  In fact, anytime you play around with running
stuff from *inside* a hook that works fine when you run it from
outside, you need to check what GIT_ variables are present.

I believe 'unset `git rev-parse --local-env-vars`' is a good idea too;
probably much simpler.
