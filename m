From: Stefan Beller <sbeller@google.com>
Subject: Re: git update-ref --stdin : too many open files
Date: Mon, 29 Dec 2014 14:56:54 -0800
Message-ID: <CAGZ79kZ3xfew4Cfdg8-QFj2rD4zQ1M10NNby--Epr=zoCOh7=w@mail.gmail.com>
References: <54954E44.1080906@dachary.org>
	<xmqqoaqv8jmi.fsf@gitster.dls.corp.google.com>
	<549A20B8.3060805@gmail.com>
	<54A0AE20.4060806@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 30 00:00:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5jIl-0003E3-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 00:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbaL2W44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 17:56:56 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39005 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbaL2W4z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 17:56:55 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so12855698iec.33
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 14:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Dg0J9P3ht909wL3vG9esmtlrJBdXGAqfV7TdfiCMlco=;
        b=L8dxx1sjOE6d5ZTcopC5UEC93ruIL3EWArWdqWtT2U2QFVs0jtPqTud4yvz+DBfp5A
         78qfmY9OCAhue0qqIKsQYaRQTTVTuZVr9ALOHg35bT+DTEll2oo5u4ejYa+XUAx5ckzn
         V1aHU8IS2HPnxjkyKz3KlKFo7U2ScSbJkxs6eyDWkqynlFJFAaxL+TyRvFTWAtNBf3po
         6Kyzcz33bUqXTcBFg+is+Me8smtJc41QkpHkw1fzo9K+Xh9HtXCo54j4XRGSzBtTr5xf
         4ukhkLglwe/4JJ4jOGEL16j+40xp85oe4r2hHH9bjyeTnmwzZTfYsocsCqSlIRI2BiSV
         H93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Dg0J9P3ht909wL3vG9esmtlrJBdXGAqfV7TdfiCMlco=;
        b=XN7BEUJsDjA/Baq7ywsOrc3dWdSTM9+cswqbFWtWemVD5JnOOUkizuBHpSBkoLKvtW
         qaK/GCIChtgm0OeUK2ixvxRvLlp+uJ7TEn3EmS06xbb3d5GW3nrjf18KKzM0MCNJ0M7L
         W/OKJwGVSm6VcD/ctGL2QVX5woo7ZhtZpes/iLTf+/YRAbTOXTeVXZJNibIMBkrYXQKX
         HXos1cf9SHmiu0baLLc/b2PAGxJMdlBVEMLrjFO7LZb13i6xUH56zQg9uAL7MDRKy2dr
         EEzE5vp4Cca67M3TBVoHc9vDZMWrIvlE1mvAk2KXk8k4Gcx99Txt8a9yQWfpmtDSip0j
         9VSQ==
X-Gm-Message-State: ALoCoQlv9VHd64lN6fAn7o20tEMOYq+MhK2aLb8M2gVOv6BB4shmqqko/Wij/sDnNU8uxojeqvjc
X-Received: by 10.50.117.41 with SMTP id kb9mr47540622igb.37.1419893814788;
 Mon, 29 Dec 2014 14:56:54 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 29 Dec 2014 14:56:54 -0800 (PST)
In-Reply-To: <54A0AE20.4060806@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261894>

On Sun, Dec 28, 2014 at 5:28 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> I'm doing some work in this area, so I should be able to work on the
> bugfix in the not-too-distant future. My feeling is that the bug is
> unlikely to affect many current users, though it definitely should be
> fixed before sb/atomic-push is merged.
>

So are you heading for the bug fix?
I'd then drop this off my todo list.

Thanks,
Stefan
