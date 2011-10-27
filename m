From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Thu, 27 Oct 2011 12:22:08 +0100
Message-ID: <CAOpHH-W30umoP6CuvrXgiSPBC2NjLvNWUX0uxhU4SU3kBB4H-A@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
 <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
 <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com>
 <CAGdFq_heamPfKpK2sQ1RUvceaeGRVAwkv=KAn-ByPyPkNtoZBA@mail.gmail.com>
 <CAOpHH-VEhtOg6ai5p9VxWBKA3AFpG3meiJVGrWR4j68ffyQ6Bg@mail.gmail.com> <CAGdFq_iY92Gc=WLFVVMpi8w5JNZMo5bSk5=wjHyCmjXmP4RXrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 13:22:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJO2n-0007ab-EQ
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 13:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab1J0LWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 07:22:40 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37456 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab1J0LWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 07:22:40 -0400
Received: by qyk4 with SMTP id 4so598290qyk.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LvC2oP/igL45hjvjCndh6NvSjGfev2RvGMSYIXErwnU=;
        b=N/Tz4piPEBCYj13j4YsENeVtpqT+VeEPm+VCjnoJMFR8shxGNsWI6zRx7m5aIH7+qU
         kZiNutE5aZwZ5S9omnaqsZDEecyzMTcl2FgJcfTqG+btaqx0QURGjm+4yjdY3Reg8dSs
         pqcGIyyx3ekK+bsYXvhcV74IBoD4QZu45BRtk=
Received: by 10.68.74.4 with SMTP id p4mr73254567pbv.47.1319714559084; Thu, 27
 Oct 2011 04:22:39 -0700 (PDT)
Received: by 10.68.54.3 with HTTP; Thu, 27 Oct 2011 04:22:08 -0700 (PDT)
In-Reply-To: <CAGdFq_iY92Gc=WLFVVMpi8w5JNZMo5bSk5=wjHyCmjXmP4RXrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184294>

On Thu, Oct 27, 2011 at 12:06 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> I'm afraid I don't understand why it's a bad thing that fast-import
> will find the old tree on disk, won't it just be gc-ed if it is no
> longer used?

No, because fast-import actively checks this to make sure the frontend
script did not do anything wrong during the import. I think the check
makes sense and may help debugging a corner case the frontend script
does not support. So, using "--force" is also not a solution because it
ignores everything and not only the specific commits I want to leave
behind.

Vitor
