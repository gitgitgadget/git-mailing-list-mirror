From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: Why isn't hook file cloned to bared repository ?
Date: Wed, 4 Mar 2009 01:13:01 -0500
Message-ID: <3e8340490903032213u56734301o39c9d00633410fd5@mail.gmail.com>
References: <856bfe0e0903032140w4d8a9415l9f7b9a0678b492cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 07:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LekNG-00037s-FR
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 07:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbZCDGNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 01:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbZCDGNF
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 01:13:05 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:34883 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbZCDGND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 01:13:03 -0500
Received: by gxk22 with SMTP id 22so6241330gxk.13
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 22:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=udGZWVqT/H927rCYIdxAR+L10qMaz90cSMG4gB3be3M=;
        b=ITcUd3UqdXByCpIeeWx9d8B55/7jn2ELjxwbVCOJrwLxfBgSoT4PE+KtQPZPszZyF9
         9RRDYG/7FIZxueCnVikeGavALB2zdqPDXxYQlvPJ1S476xw7FlOnPeN3cEKzAFQPYv38
         PMbFeRFuAMQWE9KDSnogZYEV8JQRHwg7mbG5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZlX6sEAe5oljyHw/ePukH/K5t4xKnOodTngItz3wvYKxfytmZLZ6pMCYiVP8pjK5Hq
         SpBdpUJ2JscuVPr3mvX/Bj8rWaWy6ZWrW3OVitUI+ehRySx4YdbHDkh2RQ3/Ju6Dxv/9
         7WQjkI7zmX9MbgdXLtA8dXBnewDrRP8PHWtVQ=
Received: by 10.220.75.19 with SMTP id w19mr2665929vcj.110.1236147181084; Tue, 
	03 Mar 2009 22:13:01 -0800 (PST)
In-Reply-To: <856bfe0e0903032140w4d8a9415l9f7b9a0678b492cc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112182>

On Wed, Mar 4, 2009 at 12:40 AM, Emily Ren <lingyan.ren@gmail.com> wrot=
e:
> Hi,
>
> I added file "update" in my git repository my_repo/.git/hooks/, =A0th=
en
> I run command "git clone --bare my_repo" to generate a bared
> repository my_repo.git. But there's no update in my_repo.git/hooks.
>
> Do you know why ?

Because allowing code from an untrusted third-party repository to be
executed automatically without giving a chance to examine it is not a
very good idea from a security standpoint. In addition, hooks are
often not of interest to the person cloning the repository. Because of
these reasons, git clone will not copy hooks from the source
repository (for consistency, this is the case even when the source is
local).
