From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: How to exclude files from "git diff"
Date: Wed, 6 Jan 2010 01:31:24 +0700
Message-ID: <fcaeb9bf1001051031j6723dc14v8d43944e3b8baa90@mail.gmail.com>
References: <6dc9ffc80912180909q2e9cbe30r7c802a2152c5954@mail.gmail.com>
	 <20100105064509.GC19025@coredump.intra.peff.net>
	 <6dc9ffc81001050620q55c23072p93f58c8685d77f9d@mail.gmail.com>
	 <37fcd2781001050954y778ba661n7cee6cda699968c2@mail.gmail.com>
	 <6dc9ffc81001051015x3bebc994r3d475bdb59e12d39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dmitry Potapov <dpotapov@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:31:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSEBx-0003wy-UE
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 19:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262Ab0AESb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 13:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889Ab0AESb1
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 13:31:27 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60388 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab0AESb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 13:31:26 -0500
Received: by pwj9 with SMTP id 9so10411720pwj.21
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=icq0XttM9qvrfOPUj9G0ag96R8z8RScqbQQrlvjqZv8=;
        b=nEkmCNkMYmYeYsvjC5RxO0BSswIv1dEUsV6gUGs+G7ebpUpsA9iHwBJrFeGGFK5tO+
         ra9GbpyJX9iUEmyT6IIq1CNNaRpPXrPVjRNcliRCLQI4piDCppifF1u4KSFl8zR2YxRJ
         FpBW0htGCypXJ704gU0Ksf0eXQbyqi4faWGrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=u1ygw07drWm369ngvE/42/QDPY4sx51G5v1h3aoUSkc2KzhUX5ueDNuY1bJL9KpfMG
         xRAl2zy3wPbt2yrHKNXJ/v/NtV/6kO6NC19sqI37GHm38jysH2hnjYtkJcSHK9V4UST2
         WIC2yuzgJcpzSE4p6PuKVFvEMFT+XIr5AQzhM=
Received: by 10.115.133.7 with SMTP id k7mr3410961wan.96.1262716284391; Tue, 
	05 Jan 2010 10:31:24 -0800 (PST)
In-Reply-To: <6dc9ffc81001051015x3bebc994r3d475bdb59e12d39@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136199>

On 1/6/10, H.J. Lu <hjl.tools@gmail.com> wrote:
> On Tue, Jan 5, 2010 at 9:54 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
>  > On Tue, Jan 5, 2010 at 5:20 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>  >>
>  >> Yes, I want those files in repository. They are for my personal use only.
>  >
>  > If you modified some file locally and do not want to see and commit
>  > those modifications, you may want to use:
>  >
>  > git update-index --assume-unchanged foo
>  >
>
>
> I added those files into my repository for bookkeeping purpose. It
>  shouldn't go out at all.

That could be a way to simulate git diff --exclude="foo*.bar*":

git ls-files -- 'foo*bar*'|xargs git update-index --assume-unchanged
git diff
git ls-files -- 'foo*bar*'|xargs git update-index --no-assume-unchanged

assume that you don't use assume-unchanged for any other purposes
-- 
Duy
