From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recovering from "unordered stage entries in index" error
Date: Thu, 21 May 2015 09:49:56 -0700
Message-ID: <xmqqwq01kh8r.fsf@gitster.dls.corp.google.com>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
	<CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "McHenry\, Matt" <mmchenry@carnegielearning.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 18:50:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvTfX-0002SS-Sp
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 18:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbbEUQt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 12:49:59 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35537 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbbEUQt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 12:49:59 -0400
Received: by iesa3 with SMTP id a3so12737349ies.2
        for <git@vger.kernel.org>; Thu, 21 May 2015 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RJOqKRYAXIz6F3wUo6xmHu8tLcLO26yZrNTe8LpCDas=;
        b=QYGwBjhAISVr+7BBjnBqOeclh00lTHv8vLdAf2ICgGE5U0alVmckUN9hdi9+2QfIcu
         7/5Fh2f6JOiMY9tsVDZwJAWlU3fympMySXtxQ1cFd0szfcOtEY+ygh0B1C1U3ohILKYo
         W6oCzyZuVidBCABAAtsdj5JnWUQXr1MvxwwJrRYWdHEAdYe2T+Kt3or84jjFqKsTFxKJ
         FMDCVLHM5PZqoLlLTRnIXzijA0KMJKkr20HzFa+a80KK1uHwcnRV0nf4hG7Us6Fg4mLK
         bqBi9MC+64CTEtOpPt7Mf9Bn+yWRyD6uYQT+J33jkQkSmr0aYEJfmgkVpDRcwm15CGPA
         90Qg==
X-Received: by 10.43.169.137 with SMTP id nm9mr4196145icc.82.1432226998419;
        Thu, 21 May 2015 09:49:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id qh1sm1546690igb.17.2015.05.21.09.49.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 09:49:57 -0700 (PDT)
In-Reply-To: <CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 21 May 2015 16:56:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269610>

Duy Nguyen <pclouds@gmail.com> writes:

> This message can be improved to show what entries have this problem.
> But then I don't see any way to recover the index manually. ls-files
> will die too.

Isn't this failure coming from git-svn that tries to write out a
tree after it prepared whatever it wants to record in its (possibly
temporary) index?  I have a feeling that the index held by the end
user is not broken.
