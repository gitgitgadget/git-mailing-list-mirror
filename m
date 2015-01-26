From: Junio C Hamano <gitster@pobox.com>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Mon, 26 Jan 2015 13:35:36 -0800
Message-ID: <CAPc5daVu=hjjYwDoCwco=cdg16kib80ZBbArh3z8R+j2vq6C6g@mail.gmail.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
 <CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
 <CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
 <CA+5PVA5RdtLyRiYerG=u--bRZQ87qU0EGf7kGPMiQs9_KB3hRw@mail.gmail.com> <CA+55aFwa1-pudNus+r=5EghpGkm33h--GZNND5UHt=ZKvP15Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 26 22:36:06 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YFrKG-0005Eq-9s
	for glk-linux-kernel-3@plane.gmane.org; Mon, 26 Jan 2015 22:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757094AbbAZVgA (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 26 Jan 2015 16:36:00 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58144 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbbAZVf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2015 16:35:57 -0500
Received: by mail-ob0-f174.google.com with SMTP id gq1so10190566obb.5;
        Mon, 26 Jan 2015 13:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/05psUlvOeeyRUqsin5PWKtlIdCMjD5bReeDFuZk++A=;
        b=mjleD2Ke7oCpnq7aW1X3om1wjfdJ8ufAQBTrY5Fyk9mmNxsNar1knnfDlKoBhYxqDo
         u1edkPl+hjoulj09oDOkkFUKuNVGswiNJxraqIxKIVIzhVfQ8zrCYS9PbCm6UKo7BSov
         unUi6qOfBVrq6d4L/2cW4XnEmvZftdV39wzXs8AZuQYynLlw+Ikct+hKWjD5+PYGtSz7
         fEAwQEa19AGiWape1ory8gehHn8s9CIiNhS/K78Pz242WxNsLrTOdSga+OP8gW41MIPT
         8OMmFG/6podGOYZpJskuVFiwnvlzsbd5aRKLCQIB4vCK37L9jHl/S5HwpqvUko2cNSt8
         adUQ==
X-Received: by 10.202.19.132 with SMTP id 4mr13404903oit.10.1422308156564;
 Mon, 26 Jan 2015 13:35:56 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Mon, 26 Jan 2015 13:35:36 -0800 (PST)
In-Reply-To: <CA+55aFwa1-pudNus+r=5EghpGkm33h--GZNND5UHt=ZKvP15Xw@mail.gmail.com>
X-Google-Sender-Auth: gLsGQSpMyIY1gaEUea4rrPhvLrE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263048>

On Mon, Jan 26, 2015 at 1:30 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jan 26, 2015 at 1:07 PM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
>>
>> Or did I miss a way that git-apply can take a git patch and apply it
>> to a tree that isn't a git repo?
>
> Exactly. "git apply" works as a straight "patch" replacement outside
> of a git repository. It doesn't actually need a git tree to work.

What is your take on CVE-2015-1196, which brought this /regression/ to
GNU patch?
If "git apply" get /fixed/ for that same CVE, would that /break/ your fix?
