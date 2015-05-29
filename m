From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: Wrong error message when access to .git directory denied
Date: Fri, 29 May 2015 10:06:27 -0700
Message-ID: <xmqqwpzrcnzg.fsf@gitster.dls.corp.google.com>
References: <20150529104743.6220a11f@outerspace.dyndns.org>
	<xmqq1thzfll9.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZPTpJjLsKSd6E8vQ0HFuSeCH5Hr_LBhSjx9=SQdQhOBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonas Berlin <xkr47@outerspace.dyndns.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 29 19:06:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyNjv-0002AI-3Y
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 19:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513AbbE2RGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 13:06:30 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38078 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368AbbE2RG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 13:06:29 -0400
Received: by igbjd9 with SMTP id jd9so19256842igb.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=I8Y3zEJyS5kzbUMlRFt3SmGHMcOwpipC31huAMeebW8=;
        b=vhLYm6AhNjslwDr6EhJpXxslckaTY+5tDrNx9gy6ziGN0cFkFtvH3EzCdsmjCeO5th
         bSkbB4VTlwDhH/nRt3yniSKZBTDcPE+Vh/rYxv/FzRQIsYWtIVaAk+qGy+VgE7vFX6Yh
         TBXfv7X/egyrftw7V/6Z7m9WBCTQ2Yni7awZgdGWkkYahyU5wdDffQ6SWxHV6hyTiI7S
         K9hyK1zyRgLUBIIzPsrIMZQ2xMMZIRANUkWMKHensivkFAU+K2bPrz9NtKfeaBhubkyz
         zR+gkBOYMrligKTx5kJEp6C3tzbnwy6AF+pVq6d6TiOUaZRxqctwEkeXtnJW+cV5prHY
         vwwA==
X-Received: by 10.107.162.147 with SMTP id l141mr11402003ioe.77.1432919188750;
        Fri, 29 May 2015 10:06:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id v3sm1922633igk.1.2015.05.29.10.06.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 10:06:28 -0700 (PDT)
In-Reply-To: <CAGZ79kZPTpJjLsKSd6E8vQ0HFuSeCH5Hr_LBhSjx9=SQdQhOBQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 29 May 2015 09:45:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270258>

Stefan Beller <sbeller@google.com> writes:

>> So "Not a git repository" is the best Git can say.
>
> fatal: Permission denied while accessing .git directory
>
> does not imply we're having a git repository here at all, but rather
> sounds like "We wanted to check for you if this is a git repository,
> but we cannot do that as we lack permissions to do so.
>
> So git doesn't know if it is inside a repo or not, so the actual error message
> "Not a git repository" is wrong. It's just that the current permissions cannot
> tell if we're in a repository or not.

Fair enough.  Patches ;-)?
